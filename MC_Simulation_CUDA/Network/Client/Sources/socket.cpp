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
socket::socket(QObject *parent) : QObject(parent)
{

}

void socket::createSocket()
{
    newSocket = new QTcpSocket(this);

    if(this->queryType.compare("requestParameters")==0){
        connect(newSocket,SIGNAL(connected()),this,SLOT(requestParameters()));
    }
    else if(this->queryType.compare("prepareForReceiving")==0){
        connect(newSocket,SIGNAL(connected()),this,SLOT(sendResults()));
    }
    else if(this->queryType.compare("requestBatch")==0) {
        connect(newSocket,SIGNAL(connected()),this,SLOT(requestBatch()));
    }

    connect(newSocket,SIGNAL(disconnected()),this,SLOT(disconnected()));
    connect(newSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(newSocket,SIGNAL(bytesWritten(qint64)),this,SLOT(bytesWritten(qint64)));
    newSocket->abort();
    newSocket->connectToHost(QHostAddress::LocalHost, 4567);
    //newSocket->connectToHost("192.168.1.12", 4567);

    if(!newSocket->waitForConnected(1000))
    {
//        qDebug() <<"Error: " << newSocket->errorString();
    }
}

void socket::setQueryType(std::string querytype){
    this->queryType = querytype;
}

void socket::requestBatch(){
    newSocket->write("requestBatch");
    newSocket->waitForReadyRead();
    newSocket->disconnectFromHost();
}

void socket::requestParameters(){
    newSocket->write("requestParameters");
    newSocket->waitForReadyRead();
    newSocket->disconnectFromHost();
}


void socket::sendResults()
{
    newSocket->write("prepareForReceiving");
    newSocket->waitForReadyRead();
}

void socket::startSerialization(){
    //qDebug() <<"serialization has just started";
    QVector<MC_Photon> V=getVectorofPhotons();
    qDebug()<<V.size();
    QVector<float> X;
    QVector<float> Y;
    QVector<float> Z;
    QVector<float> W;
    QVector<float> ST;
    for(int i=0;i<=V.size()-1;i++){
        X.append(V[i].position().x());
        Y.append(V[i].position().y());
        Z.append(V[i].position().z());
        W.append(V[i].weight());
        ST.append(V[i].state());
    }
    /*
    qDebug()<<"Total Size of photons final state to be sent is"<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    qDebug()<<"Random Point";
    qDebug()<<X[5];
*/

    QByteArray sendArray;
    QDataStream streamTest(&sendArray, QIODevice::WriteOnly);
    streamTest<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    streamTest<<X;
    streamTest<<Y;
    streamTest<<Z;
    streamTest<<W;
    streamTest<<ST;


    newSocket->write(sendArray);
    qDebug()<<"results to be sent array size is"<<sendArray.size();
    // newSocket->waitForBytesWritten();
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
}

void socket::setVectorOfPhotons(QVector<MC_Photon> V){
    this->incomingVector=V;
}

QVector<MC_Photon> socket::getVectorofPhotons(){
    return this->incomingVector;
}

void socket::disconnected()
{
    qDebug() <<"Disconnected!";

}
void socket::readyRead()
{
    if(this->queryType.compare("requestParameters")==0){
        getServerParameters();
    }
    else if(this->queryType.compare("requestBatch")==0) {
        qDebug()<<"received new Batch";
        getNewBatchPhotons();
    }
    else if(this->queryType.compare("prepareForReceiving")==0) {
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

void socket::getNewBatchPhotons(){
    QByteArray newBatchByteArr = newSocket->readAll();
    QDataStream serverNewBatch(&newBatchByteArr, QIODevice::ReadOnly);
    serverNewBatch.setVersion(QDataStream::Qt_4_8);
    serverNewBatch >> numberOfPhotons;
    //qDebug()<<"New batch size is is"<< numberOfPhotons<<"photons";
    setBatchPhotons(numberOfPhotons);
}

void socket::setBatchPhotons(int photons){
    this->batchPhotons = photons;
}

int socket::batchPhoton(){
    return this->batchPhotons;
}
void socket::bytesWritten(qint64 bytes)
{
    qDebug() << bytes<<"bytes are written";

}

