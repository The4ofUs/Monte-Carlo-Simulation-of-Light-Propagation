#include "Network/Client/Headers/socket.h"
#include <QBuffer>
#include <QDataStream>
#include <QTcpSocket>
#include <QImageReader>
#include <QWidget>
#include <QImageWriter>
#include <QTime>
#include <QDir>
#include <string>
#include <iostream>
#include <QVector>
#include <time.h>
socket::socket(QObject *parent) : QObject(parent)
{

}

void socket::createSocket()
{
    newSocket = new QTcpSocket(this);
    qDebug ()<< "Connecting .....";

    if(queryType.compare("requestParameters")==0){
        connect(newSocket,SIGNAL(connected()),this,SLOT(requestParameters()));
    }
    else if(queryType.compare("prepareForReceiving")==0){
        connect(newSocket,SIGNAL(connected()),this,SLOT(sendResults()));
    }
    else if(queryType.compare("requestBatch")==0) {
        connect(newSocket,SIGNAL(connected()),this,SLOT(requestBatch()));
    }

    connect(newSocket,SIGNAL(disconnected()),this,SLOT(disconnected()));
    connect(newSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(newSocket,SIGNAL(bytesWritten(qint64)),this,SLOT(bytesWritten(qint64)));
    newSocket->abort();
    newSocket->connectToHost(QHostAddress::LocalHost, 4567);
    if(!newSocket->waitForConnected(1000))
    {
        qDebug() <<"Error: " << newSocket->errorString();
    }

}

void socket::requestBatch(){
    qDebug()<<"requesting new batch from the server";
    newSocket->write("requestBatch");
    newSocket->waitForReadyRead();
    newSocket->disconnectFromHost();
}

void socket::requestParameters(){
    newSocket->write("requestParameters");
    qDebug()<<"requesting parameters from server";
    newSocket->waitForReadyRead();
    newSocket->disconnectFromHost();
}


void socket::sendResults()
{
    newSocket->write("prepareForReceiving");
    newSocket->waitForReadyRead();
    state=true;
}


bool socket::isConnected(){
    return state;
}



void socket::startSerialization(){
    qDebug() <<"serialization has just started";
    QVector<Photon> V=getVectorToBeSend();
    //qDebug()<<"Vevtor of photons size"<<V.size();
    QByteArray sendArray;
    QVector<float> X;
    QVector<float>Y;
    QVector<float>Z;
    QVector<float>W;
    QVector<float> ST;
    for(int i=0;i<=V.size()-1;i++){
        X.append(V[i].getPosition().x());
        Y.append(V[i].getPosition().y());
        Z.append(V[i].getPosition().z());
        W.append(V[i].getWeight());
        ST.append(V[i].getState());
    }

    qDebug()<<"Total Size of photons final state to be sent is"<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    qDebug()<<"Random Point";
    qDebug()<<X[5];
    /*qDebug()<<Y[50];
    qDebug()<<Z[50];
    qDebug()<<W[50];
    qDebug()<<ST[50];*/

    QByteArray sendArrayTest;
    QDataStream streamTest(&sendArrayTest, QIODevice::WriteOnly);
    //qDebug()<<"I SENT" <<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    streamTest<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    streamTest<<X;
    streamTest<<Y;
    streamTest<<Z;
    streamTest<<W;
    streamTest<<ST;


    newSocket->write(sendArrayTest);
    qDebug()<<"results to be sent array size is"<<sendArrayTest.size();
   // newSocket->waitForBytesWritten();
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
    qDebug()<<"results are sent";
}




void socket::getVectorOfPhotons(QVector<Photon> V){
    this->incomingVector=V;
}



QVector<Photon> socket::getVectorToBeSend(){
    return this->incomingVector;
}

void socket::disconnected()
{
    qDebug() <<"Disconnected!";

}
void socket::readyRead()
{
    if(queryType.compare("requestParameters")==0){
        getServerParameters();
    }
    else if(queryType.compare("requestBatch")==0) {
        qDebug()<<"received new Batch";
        getNewBatch();
    }
    else if(queryType.compare("prepareForReceiving")==0) {
        if(serverIsReadytoReceive()){
            //qDebug()<<"server is ready to receive";
            startSerialization();
        }
    }

}

void socket::getServerParameters(){
    QByteArray serverParamBytaArr = newSocket->readAll();
    QDataStream serverParameters(&serverParamBytaArr, QIODevice::ReadOnly);
    serverParameters.setVersion(QDataStream::Qt_4_8);
    serverParameters >> parameters;
    //qDebug()<<parameters;
}

QVector<float> socket::getParameters(){
    return parameters;
}

bool socket::serverIsReadytoReceive(){
    QByteArray serverResponseByteArr = newSocket->readAll();
    std::string serverResponse = serverResponseByteArr.toStdString();
    if(serverResponse.compare("readyToReceive")==0){
        return true;
    }
  return false;
}
void socket::getNewBatch(){
    QByteArray newBatchByteArr = newSocket->readAll();
    QDataStream serverNewBatch(&newBatchByteArr, QIODevice::ReadOnly);
    serverNewBatch.setVersion(QDataStream::Qt_4_8);
    serverNewBatch >> numberOfPhotons;
    qDebug()<<"New batch size is"<< numberOfPhotons<<"photons";
}

void socket::bytesWritten(qint64 bytes)
{
    qDebug() << bytes<<"bytes are written";

}

