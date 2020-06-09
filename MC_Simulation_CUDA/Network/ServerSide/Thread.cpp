#include <stdio.h>

#include "Thread.h"
#include <iostream>
#include <vector>
/**
 * user inputs
 */
int numberOfPhotons;
float detectorRadius = 10;
float tissueRadius = 100;
float tissueAbsCoeff = 1;
float tissueScatCoeff = 100 ;
std::vector<float> coefficients1 = {1.f, 6.f, 4.f,15.f};

std::vector<float> coefficients2 = {100.f, 30.f, 12.f, 44.f};
Point *detectorPosition = new Point(0,0,10);
Point *tissueFirstCenter = new Point(0,0,10);
Point *tissueSecondCenter = new Point(0,0,-10);
QVector<Photon> receivedResults;
Thread::Thread(int ID, QObject *parent):
    QThread(parent)
{
    this->socketDescriptor = ID;
}

void Thread::run()
{
    //qDebug() << "Starting new thread";
    socket = new QTcpSocket();
    if (!socket->setSocketDescriptor(this->socketDescriptor))
    {
        emit error(socket->error());
        return;
    }
    //Connects Qthread signal readyRead to the class slot read
    connect(socket, SIGNAL(readyRead()),this, SLOT(readQuery()),Qt::DirectConnection);
    //Connects Qthread signal disconnect to the class slot disconnect
    connect(socket, SIGNAL(disconnected()),this, SLOT(disconnected()),Qt::DirectConnection);
    //qDebug() <<"client with socket ="<< socketDescriptor << "is Connected!";
    dataSize=0;
    exec();
}


void Thread::readQuery(){
    //Read data from the socket
    QByteArray queryTypeByteArr = socket->readAll();
    //Convert the data from bytes to readable String
    queryType = queryTypeByteArr.toStdString();
    if(queryType.compare("requestParameters")==0){
       // qDebug()<<"client with socket ="<<socketDescriptor<< "is requesting parameters";
        sendParameters();
    }
    else if(queryType.compare("requestBatch")==0){
       // qDebug()<<"client with socket ="<<socketDescriptor<<"is requesting new batch";
        sendNewBatch();
    }
    /**
     * In this case the client is telling the server to prepare for receiving the results
     * As a result the QThread signal readyRead is disconnected from readQuery and
     * connected to readResults
     */
    else if(queryType.compare("prepareForReceiving")==0){
        //qDebug() <<"client with socket ="<< socketDescriptor<<"is sending results";
        disconnect(socket, SIGNAL(readyRead()),this, SLOT(readQuery()));
        connect(socket,SIGNAL(readyRead()),this,SLOT(readResults()),Qt::DirectConnection);
        //Informs the client that the server is ready to recieve data
        socket->write("readyToReceive");
    }
}


void Thread::sendNewBatch(){
    QByteArray newBatchByteArray;
    QDataStream newBatch(&newBatchByteArray,QIODevice::WriteOnly);
    newBatch.setVersion(QDataStream::Qt_4_8);
    if(bucketRemainingPhotons==0){
        photonsPerPatch=0;
        //abort connection, close server and average results
        qDebug()<<"Server has no more batches";
    }
    newBatch<< photonsPerPatch;
    socket->write(newBatchByteArray);
    /*Signal emitted by the thread class to inform the server class that it should
     *decrement serverPhotonsBucket*/
    newBatchSignal();
}


void Thread::getBucketRemainingPhotons(int remainingPhotons){
    bucketRemainingPhotons = remainingPhotons;
}

void Thread::getNumberOfPhotons(int numPhotons)
{
    photonsPerPatch = numPhotons;
}


void Thread::sendParameters(){
    QVector<float> userParameters;
    QByteArray parametersByteArray;
    QDataStream paramtersTobeSend(&parametersByteArray,QIODevice::WriteOnly);
    paramtersTobeSend.setVersion(QDataStream::Qt_4_8);
    userParameters.append((float)photonsPerPatch);
    userParameters.append(detectorRadius);
    userParameters.append((float)detectorPosition->x());
    userParameters.append((float)detectorPosition->y());
    userParameters.append((float)detectorPosition->z());
    userParameters.append(tissueRadius);
    userParameters.append((float)tissueFirstCenter->x());
    userParameters.append((float)tissueFirstCenter->y());
    userParameters.append((float)tissueFirstCenter->z());
    userParameters.append((float)tissueSecondCenter->x());
    userParameters.append((float)tissueSecondCenter->y());
    userParameters.append((float)tissueSecondCenter->z());
    for(int i = 0; i<=coefficients1.size()-1;i++)
    {
        userParameters.append(coefficients1[i]);
    }
    for(int i = 0;i<=coefficients2.size()-1;i++)
    {
        userParameters.append(coefficients2[i]);
    }
    paramtersTobeSend << userParameters;
    socket->write(parametersByteArray);
    qDebug()<<"Parameters are sent";
    /*Signal emitted by the thread class to inform the server class that it should
     *decrement serverPhotonsBucket*/
    newBatchSignal();

}


QByteArray array ;
void Thread::readResults(){
    socket->waitForReadyRead();
    qDebug()<<"Bytes Available"<< socket->bytesAvailable();
    if( dataSize == 0 )
    {
        QDataStream stream(socket);
        stream.setVersion(QDataStream::Qt_4_8);
        if( socket->bytesAvailable() < sizeof(quint32) )
            return;
        stream >> dataSize;
    }
    if( dataSize > socket->bytesAvailable() )
        return;
    do{
        array += socket->readAll();
    }
    while(array.size()<dataSize);
    QVector<float> X;
    QVector<float> Y;
    QVector<float> Z;
    QVector<float> W;
    QVector<float> ST;
    // qDebug()<<"Recived Array"<<array.size();
    QDataStream streamm(&array, QIODevice::ReadOnly);
    streamm.setVersion(QDataStream::Qt_4_8);
    //Makes sure that the received array size is equal to expected size
    if (array.size()==dataSize*8+20){
//        qDebug()<<"Recived Array total size"<<array.size();
        streamm >> X>>Y>>Z>>W>>ST;
  //      //qDebug()<<X.size() <<Y.size()<< Z.size()<<W.size()<<ST.size();
        qDebug()<<"Results are recived";
        qDebug()<<ST[1];
        array.clear();
    }
    //recondition the float vectors to one vector of photons
    reconditionResultsToPhotons(X,Y,Z,W,ST);
    //emits signal to append the received results to the previous received ones
    appendNewReceivedResultsSignal();
}


QVector<Photon> Thread::returnRecievedPhotons()
{
    //qDebug()<<"at return"<<receivedResults.size();
    return receivedResults;
}


void Thread::reconditionResultsToPhotons(QVector<float> x,QVector<float> y, QVector<float> z, QVector<float> w, QVector<float> s){
    receivedResults.clear();
    for(int i=0; i<x.size();i++){
        Photon ph;
        Point P;
        P.setCoordinates(x[i],y[i],z[i]);
        ph.setPosition(P);
        ph.setWeight(w[i]);
        ph.setState(s[i]);
        receivedResults.push_back(ph);
    }
    //qDebug()<<"Recevied results reconditioned to array of photons size is "<<receivedResults.size();
}


void Thread::disconnected()
{

    qDebug() <<"client with socket ="<< socketDescriptor << "Disconnected";
    socket->deleteLater();
    exit(0);
}






