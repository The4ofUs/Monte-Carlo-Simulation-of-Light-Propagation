#include "threads.h"
#include <QTime>
#include <iostream>
#include <QDir>
#include <QtWidgets>
#include "serverside.h"
#include<QVector>
#include "Photon.h"
#include <QDebug>
int Detected;
int Terminated;
int counter=0;
int numberOfPhotons = 1000;
float detectorRadius = 10;
float tissueRadius = 10;
float tissueAbsCoeff = 1;
float tissueScatCoeff = 100 ;
Point *detectorPosition = new Point(0,0,50);
Point *tissueFirstCenter = new Point(0,0,50);
Point *tissueSecondCenter = new Point(0,0,-50);

threads::threads(int ID, QObject *parent):
    QThread(parent)
{
    this->socketDescriptor = ID;
}


void  threads::run()
{
    qDebug() << "Starting Thread";
    socket = new QTcpSocket();
    if (!socket->setSocketDescriptor(this->socketDescriptor))
    {
        emit error(socket->error());
        return;
    }
    connect(socket, SIGNAL(readyRead()),this, SLOT(read()),Qt::DirectConnection);
    connect(socket, SIGNAL(disconnected()),this, SLOT(disconnected()),Qt::DirectConnection);
    qDebug() << socketDescriptor << "Client Connected!";
    dataSize=0;

    exec();

}


void threads::read(){
    QByteArray queryTypeByteArr = socket->readAll();
    queryType = queryTypeByteArr.toStdString();
    if(queryType.compare("requestParameters")==0){
        sendParameters();
    }
    else if(queryType.compare("requestBatch")==0){
        sendNewBatch();
    }
    else{
        readPhotonsVector(queryTypeByteArr);
    }
}

void threads::sendNewBatch(){
    QByteArray newBatchByteArray;
    QDataStream newBatch(&newBatchByteArray,QIODevice::WriteOnly);
    newBatch.setVersion(QDataStream::Qt_4_8);
    if(batchPhotons==0){
        numberOfPhotons=0;
        //abort connection, close server and average results
        qDebug()<<"There is no more batches";
    }
    newBatch<< numberOfPhotons;
    socket->write(newBatchByteArray);
    newBatchSignal();
}


void threads::getBatchremainingPhotons(int batches){
    batchPhotons = batches;
}

void threads::sendParameters(){
    QVector<float> userParameters;
    QByteArray parametersByteArray;
    QDataStream paramtersTobeSend(&parametersByteArray,QIODevice::WriteOnly);
    paramtersTobeSend.setVersion(QDataStream::Qt_4_8);
    userParameters.append((float)numberOfPhotons);
    userParameters.append(detectorRadius);
    userParameters.append((float)detectorPosition->x());
    userParameters.append((float)detectorPosition->y());
    userParameters.append((float)detectorPosition->z());
    userParameters.append(tissueRadius);
    userParameters.append(tissueAbsCoeff);
    userParameters.append(tissueScatCoeff);
    userParameters.append((float)tissueFirstCenter->x());
    userParameters.append((float)tissueFirstCenter->y());
    userParameters.append((float)tissueFirstCenter->z());
    userParameters.append((float)tissueSecondCenter->x());
    userParameters.append((float)tissueSecondCenter->y());
    userParameters.append((float)tissueSecondCenter->z());
    paramtersTobeSend << userParameters;
    socket->write(parametersByteArray);
    qDebug()<<"Parameters are sent";
}


void threads::readPhotonsVector(QByteArray data){
    //qDebug()<<"Bytes available"<<socket->bytesAvailable();
    /*if( dataSize == 0 )
    {
        QDataStream stream(socket);
        stream.setVersion(QDataStream::Qt_4_8);
        if( socket->bytesAvailable() < sizeof(quint32) )
            return;
        stream >> dataSize;
    }
    if( dataSize > socket->bytesAvailable() )
        return;
*/
    //qDebug()<<"Ready Read emitting counter"<<counter;

    //qDebug()<<"Total Size"<<dataSize;

    QByteArray array = data;
    QVector<float> X[1];
    QVector<float> Y[1];
    QVector<float> Z[1];
    QVector<float> W[1];
    QVector<float> ST[1];
    QVector<float> TotalX;
    qDebug()<<"Recived Array Bytes"<<array.size();

    QDataStream streamm(&array, QIODevice::ReadOnly);
    streamm.setVersion(QDataStream::Qt_4_8);
    streamm >> X[0]>>Y[0]>>Z[0]>>W[0]>>ST[0];
    /*qDebug()<<"Recieved Result";
    qDebug()<<"Xs Size"<<X[0].size()<<"Ys Size "<<Y[0].size();
    qDebug()<<"Zs Size"<<Z[0].size()<<"Ws Size "<<W[0].size()<<"States Size"<<ST[0].size();
    qDebug()<<"Random Point";
    qDebug()<<X[0][50];
    qDebug()<<Y[0][50];
    qDebug()<<Z[0][50];
    qDebug()<<W[0][50];
    qDebug()<<ST[0][50];*/


    counter++;
    qDebug()<<"Results are recived";
    //socket->waitForReadyRead();
}


void threads::disconnected()
{

    qDebug() << socketDescriptor << "Disconnected";
    socket->deleteLater();
    exit(0);
}


int threads::DetectedCounter(){
    return Detected;
}


int threads::terminatedCounter()
{
    return Terminated;
}
