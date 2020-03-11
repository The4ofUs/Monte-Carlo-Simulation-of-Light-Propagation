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
/*
struct photon
{
    float x;
    float y;
    float z;
    float w;
    int n;
};
*/

/*
 *
 *
 * CreateSocket
 */

void socket::createSocket()
{
    newSocket = new QTcpSocket(this);
    connect(newSocket,SIGNAL(connected()),this,SLOT(connected()));
    connect(newSocket,SIGNAL(disconnected()),this,SLOT(disconnected()));
    connect(newSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(newSocket,SIGNAL(bytesWritten(qint64)),this,SLOT(bytesWritten(qint64)));
    qDebug ()<< "Connecting .....";
    newSocket->abort();
    newSocket->connectToHost("172.28.132.95", 4567);

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




/*
 *
 *
 * startSerialization
 *overridding operator <<
 */


void socket::startSerialization(){
    QVector<Photon> V=getVectorToBeSend();
    QByteArray sendArray;
    QDataStream out(&sendArray,QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_8);
    QDataStream &operator<<(QDataStream &out, const QVector<Photon> &V);
    out<<V;
    newSocket->write(sendArray);
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
}



QDataStream &operator<<(QDataStream &out, const  QVector<Photon> &V) {
   int size=V.size();
    out<<size;
    for(int i=0; i<V.size();i++){
        out <<V[i].getPosition().x()<<V[i].getPosition().y()<<V[i].getPosition().z()<<V[i].getWeight()<<V[i].getState();
    }
    qDebug()<<"Vector Streaming"<<V.size();
    return out;
}





/*   //Encoding, Sanity-check
   QVector<photon> A;
   QDataStream &operator>>(QDataStream &in, QVector<photon> &A);
   photon d;
   QDataStream in(&sendArray,QIODevice::ReadOnly);
   in.setVersion(QDataStream::Qt_4_8);
   in>>A;
   qDebug()<<"Vector Size after Decoding"<<A.size();

  for(int i=0; i<A.size();i++){
       qDebug()<<"Vector copy "<<A[i].n<<" "<<A[i].x;

   }*/
QDataStream &operator>>(QDataStream &in, QVector<Photon> &A) {
    int size;
    in>>size;
    qDebug()<<"SIZE"<<size;
    for(int i=0; i<size-1;i++){
        Photon s;
    //    in >>A[i].getPosition().x()>>A[i].getPosition().y()>>A[i].getPosition().z()>>A[i].getWeight()>>A[i].getState();
        A.push_back(s);
        //qDebug()<<"Vector COPPY"<<A.size();
    }
    return in;
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

