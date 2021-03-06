#include <stdio.h>
#include "../headers/Thread.h"
#include <iostream>
#include <vector>
#include <QTcpSocket>
#include<QHostAddress>

/**
 * user inputs
 */
int numberOfPhotons;
float detectorRadius = 1;
float tissueRadius = 100;
float tissueAbsCoeff = 1;
float tissueScatCoeff = 100 ;
std::vector<float> coefficients1 = {0.04f, 0.16f, 0.18f,0.66f};
std::vector<float> coefficients2 = {2.4f, 16.f, 19.f, 110.5f};
std::vector<float> refractive_indices = {1.331f, 1.4f, 1.42f, 1.450f};
Point *detectorPosition = new Point(0,0,1);
Point *tissueFirstCenter = new Point(0,0,1);
Point *tissueSecondCenter = new Point(0,0,0);
QVector<Photon> receivedResults;
Thread::Thread(int ID, QObject *parent):QThread(parent)
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
    array.clear();
    exec();
}


void Thread::readQuery(){
    //Read data from the socket
    QByteArray queryTypeByteArr = socket->readAll();
    //Convert the data from bytes to readable String
    queryType = queryTypeByteArr.toStdString();
    if(queryType.compare("requestParameters")==0){
        qDebug() <<"Client with IP ="<< socket->peerAddress().toString()<<"is requesting parameters";
        sendParameters();
    }
    else if(queryType.compare("requestBatch")==0){
        qDebug() <<"Client with IP ="<< socket->peerAddress().toString()<<"is requesting batch";

        sendNewBatch();
    }
    /**
     * In this case the client is telling the server to prepare for receiving the results
     * As a result the QThread signal readyRead is disconnected from readQuery and
     * connected to readResults
     */
    else if(queryType.compare("prepareForReceiving")==0){
        qDebug() <<"client with IP ="<< socket->peerAddress().toString()<<"is sending results";
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
        photonsPerBatch=0;
        //abort connection, close server and average results
    }
    newBatch<< photonsPerBatch;
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
    photonsPerBatch = numPhotons;
}


void Thread::sendParameters(){
    QVector<float> userParameters;
    QByteArray parametersByteArray;
    QDataStream paramtersTobeSend(&parametersByteArray,QIODevice::WriteOnly);
    paramtersTobeSend.setVersion(QDataStream::Qt_4_8);
    userParameters.append((float)photonsPerBatch);
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
    for(int i = 0;i<=refractive_indices.size()-1;i++)
    {
        userParameters.append(refractive_indices[i]);
    }
    paramtersTobeSend << userParameters;
    socket->write(parametersByteArray);
    /*Signal emitted by the thread class to inform the server class that it should
     *decrement serverPhotonsBucket*/
    newBatchSignal();

}



QByteArray temp;
void Thread::readResults(){
    socket->waitForReadyRead();
   // qDebug()<<"Bytes Available"<<socketDescriptor<< socket->bytesAvailable();
    if( dataSize == 0 )
    {
        QDataStream stream(socket);
        stream.setVersion(QDataStream::Qt_4_8);
        if( socket->bytesAvailable() < sizeof(quint32) )
            return;
        stream >> dataSize;
    }
    /* if( dataSize > socket->bytesAvailable() )
        return;*/

    do{
        array += socket->readAll();
    }
    while(socket->bytesAvailable());


    QVector<float> X;
    QVector<float> Y;
    QVector<float> Z;
    QVector<float> W;
    QVector<float> ST;
    //qDebug()<<"Recived Array"<<socketDescriptor<<array.size();
    QDataStream streamm(&array, QIODevice::ReadOnly);
    streamm.setVersion(QDataStream::Qt_4_8);
    //Makes sure that the received array size is equal to expected size
    if (array.size()==dataSize*8+20){
        streamm >> X>>Y>>Z>>W>>ST;
        array.clear();
        reconditionResultsToPhotons(X,Y,Z,W,ST);
        appendNewReceivedResultsSignal();
    }


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
    streamOut(receivedResults);
}


void Thread::disconnected()
{

    qDebug() <<"client with socket ="<< socketDescriptor << "Disconnected";
    socket->deleteLater();
    exit(0);
}






void Thread::streamOut(QVector<Photon> results){
    FILE *output;
    output = fopen("threadReceivedResults.csv", "a");
    std::string state;
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");

    for (int i = 0; i < results.size(); i++)
    {
        switch (results[i].getState())
        {
        case (0):
            state ="ROAMING" ;
            break;
        case (1):
            state ="TERMINATED";
            break;
        case (2):
            state = "DETECTED";
            break;
        case (3):
            state = "ESCAPED";
            break;
        }

        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", results[i].getPosition().x(), results[i].getPosition().y(), results[i].getPosition().z(), results[i].getWeight(), state.c_str());
    }
    //qDebug()<<results[1].getPosition().x()<< results[1].getPosition().y()<< results[1].getPosition().z()<< results[1].getWeight()<< state.c_str();
    fclose(output);
}
