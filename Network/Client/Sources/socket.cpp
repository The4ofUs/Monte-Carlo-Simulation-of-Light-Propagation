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
    connect(newSocket,SIGNAL(connected()),this,SLOT(connected()));
    connect(newSocket,SIGNAL(disconnected()),this,SLOT(disconnected()));
    connect(newSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(newSocket,SIGNAL(bytesWritten(qint64)),this,SLOT(bytesWritten(qint64)));
    qDebug ()<< "Connecting .....";
    newSocket->abort();
    newSocket->connectToHost(QHostAddress::LocalHost, 4567);

    if(!newSocket->waitForConnected(1000))
    {
        qDebug() <<"Error: " << newSocket->errorString();
    }
    dataSize=0;
}
void socket::connected()
{
    qDebug() <<"Connected!";
    startSerialization();
    state=true;
}




bool socket::isConnected(){
    return state;
}



void socket::startSerialization(){
    QVector<Photon> V=getVectorToBeSend();
    qDebug()<<"Vevtor of photons size"<<V.size();
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

    /* SIZE IN BYTES
    qDebug()<<"XSIZE"<<sizeof(std::vector<float>) + (sizeof(float) * X.size());
    qDebug()<<"YSIZE"<<sizeof(std::vector<float>) + (sizeof(float) * Y.size());
    qDebug()<<"WSIZE"<<sizeof(std::vector<float>) + (sizeof(float) * W.size());
    qDebug()<<"ZSIZE"<<sizeof(std::vector<float>) + (sizeof(float) * Z.size());
    qDebug()<<"STSIZE"<<sizeof(std::vector<int>) + (sizeof(int) * ST.size());*/

    qDebug()<<"Total Size"<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    qDebug()<<"Random Point";
    qDebug()<<X[50];
    qDebug()<<Y[50];
    qDebug()<<Z[50];
    qDebug()<<W[50];
    qDebug()<<ST[50];

    QByteArray sendArrayTest;
    QDataStream streamTest(&sendArrayTest, QIODevice::WriteOnly);
    streamTest<<X.size()+Y.size()+Z.size()+W.size()+ST.size();
    streamTest <<X;
    streamTest<<Y;
    streamTest<<Z;
    streamTest<<W;
    streamTest<<ST;
    QDataStream out(&sendArray,QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_8);
    QDataStream &operator<<(QDataStream &out, const QVector<Photon> &V);
    out<<V;

    newSocket->write(sendArrayTest);
    //newSocket->write(sendArray);

    qDebug()<<"send array size"<<sendArray.size();
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
}



QDataStream &operator<<(QDataStream &out, const  QVector<Photon> &V) {
   int size=V.size();
   int Detected=0;
   int Terminated=0;
   for(int i=0; i<V.size();i++){
        out <<V[i].getPosition().x()<<V[i].getPosition().y()<<V[i].getPosition().z()<<V[i].getWeight()<<V[i].getState();
        if(V[i].getState()==-1){
            Terminated++;
        }
        else if(V[i].getState()==1){
            Detected++;
        }
    }
    qDebug()<<"Vector Streaming"<<V.size();
    qDebug()<<"Detec"<<Detected<<"ter"<<Terminated;
    return out;
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
    qDebug() << "Reading ...";
}



void socket::bytesWritten(qint64 bytes)
{
    qDebug() <<"We wrote" << bytes;

}

