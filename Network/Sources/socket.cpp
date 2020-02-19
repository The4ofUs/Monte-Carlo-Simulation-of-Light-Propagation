#include "Network/Headers/socket.h"
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

struct photon
{
    QString n;
    float x;
};


void socket::createSocket()
{

    newSocket = new QTcpSocket(this);
    connect(newSocket,SIGNAL(connected()),this,SLOT(connected()));
    connect(newSocket,SIGNAL(disconnected()),this,SLOT(disconnected()));
    connect(newSocket,SIGNAL(readyRead()),this,SLOT(readyRead()));
    connect(newSocket,SIGNAL(bytesWritten(qint64)),this,SLOT(bytesWritten(qint64)));
    qDebug ()<< "Connecting .....";
    //establish connection
    newSocket->abort();
    newSocket->connectToHost(QHostAddress::LocalHost, 4567);
    //check if it's really connected
    if(!newSocket->waitForConnected(1000))
    {
        qDebug() <<"Error: " << newSocket->errorString();
    }
    dataSize=0;


}
void socket::connected()
{
    qDebug() <<"Connected!";
    //sendData();
    //sendArray();
    sendStruct();
    state=true;
}
bool socket::isConnected(){
    return state;
}

void socket::sendStruct(){
    photon P;
    P.n="here";
    P.x=1.2;
    photon p1;
    photon p2;
    photon p3;
    photon p4;
    p1.n="first photon";
    p2.n="second photon";
    p4.n="fourth photon";
    p3.n="third photon";
    p1.x=1.01;
    p2.x=2.02;
    p3.x=3.03;
    p4.x=4.04;
    QVector<photon> V;
    V.push_back(P);
    V.push_back(p1);
    V.push_back(p2);
    V.push_back(p3);
    V.push_back(p4);

    QByteArray sendArray;
    QDataStream out(&sendArray,QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_8);
    qDebug()<< sizeof(P);
    QDataStream &operator<<(QDataStream &out, const QVector<photon> &V);
    out<<V;
    qDebug() <<"data;;"<< sendArray;
    qDebug()<<sendArray.size();
    float w;
    w = *reinterpret_cast<const float*>(sendArray.data());
    qDebug()<<"float"<<w;
    std::string s=sendArray.toStdString();
    QString qstr = QString::fromStdString(s);
    qDebug("READING STRUCT VALUES");
    qDebug()<<qstr;
    QVector<photon> A;
    QDataStream &operator>>(QDataStream &in, QVector<photon> &A);
    photon d;
    QDataStream in(&sendArray,QIODevice::ReadOnly);
    in.setVersion(QDataStream::Qt_4_8);
    in>>A;
    qDebug()<<"Vector Size"<<A.size();
    qDebug()<<"YAAHAAAA";
    for(int i=0; i<A.size();i++){
        qDebug()<<"Vector copy"<<A[i].n<<" "<<A[i].x;

    }
    newSocket->write(sendArray);
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
}

QDataStream &operator<<(QDataStream &out, const QVector<photon> &V) {
    out<<V.size();
    for(int i=0; i<V.size();i++){
        qDebug()<<"Vector Streaming"<<V.size()<<V[i].n<<" "<<V[i].x;
        out <<V[i].n<<V[i].x;

    }
    return out;
}
QDataStream &operator>>(QDataStream &in, QVector<photon> &A) {
int size;
    in>>size;
    qDebug()<<"SIZE"<<size;
    for(int i=0; i<size-1;i++){
        photon s;
        in >>s.n>>s.x;
        A.push_back(s);
        qDebug()<<"Vector COPPY"<<A[i].n<<" "<<A[i].x;
    }
    return in;
}
void socket::sendArray(){
    //Creating a Buffer to hold my data
    QByteArray array;
    QBuffer buffer(&array);
    buffer.open(QIODevice::WriteOnly);
    float y=5.32;
    array.append(reinterpret_cast<const char*>(&y),sizeof(y));

    //array.push_back((char *)&y);

    qDebug()<<array.size();
    /*
    float x=17.1689;

    for(int i=0;i<2;i++){
    x=x+i;
    array.append(reinterpret_cast<const char*>(&x),sizeof(x));

    }
*/
    float w;


    QVector<float>v;
    w = *reinterpret_cast<const float*>(array.data());
    qDebug()<<"float"<<w;


    /*-------------------
    //Encoding goes as follows
   //Converting my numbers to QString as append can handle QString and Char only
   //then append the results to QBytearray,Hint:: BinaryData
    float x=17.1689;
    for(int i=0;i<10;i++){
    x=x+i;
    QString tempp=QString::number(x);
    array.append(tempp);}
    qDebug()<<"Buffer bytes "<<buffer.bytesAvailable();
    //Checking the values
    /*std::string temp=array.toStdString();
    float y=std::stof(temp);
    qDebug()<<"y"<<y;*/


    qDebug()<<"array size"<< array.size();
    qDebug()<<"buffer size"<<buffer.size();
    buffer.close();
    //Loading the results to a stream
    QByteArray data;
    QDataStream stream( &data, QIODevice::WriteOnly );
    stream.setVersion( QDataStream::Qt_4_0 );
    //Telling the receiver how much of a data is coming
    stream << (quint32)buffer.data().size();
    data.append( buffer.data() );
    newSocket->write( data );
    qDebug() <<"data;;"<< data;
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();

}


void socket::sendData(){
    //new Buffer to carry the image to the
    QBuffer buffer;
    QImageWriter writer(&buffer, "PNG");
    writer.write( randomImage() );
    //the data been sent has to be a byteArray, so na "BA7ml" el data mn el buffer lel stream ele hwa data no3ha byteArray
    QByteArray data;
    QDataStream stream( &data, QIODevice::WriteOnly );
    stream.setVersion( QDataStream::Qt_4_0 );
    stream << (quint32)buffer.data().size();
    qDebug()<<(quint32)buffer.data().size();
    data.append( buffer.data() );

    newSocket->write( data );
    //qDebug() <<"data;;"<< data;
    newSocket->disconnectFromHost();
    newSocket->waitForDisconnected();
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
    qDebug() <<"We wrote" << bytes; // tells number of bites we wrote

}

//Returns a Random Image
QImage socket::randomImage()
{

    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));

    QDir dir("/home/eman/Client-Server-C-/GP/ServerSide/server/images");
    if(dir.exists()){
        qDebug("dir is found");
    }
    else
    {
        qDebug("dir is not found");

    }
    dir.setFilter( QDir::Files );
    QFileInfoList entries = dir.entryInfoList();

    if( entries.size() == 0 )
    {
        qDebug( "No images to show!" );
        return QImage();
    }
    else{
        qDebug("there is image");
    }

    return QImage( entries.at( qrand() % entries.size() ).absoluteFilePath() );

}
