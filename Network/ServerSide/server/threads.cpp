#include "threads.h"
#include <QTime>
#include <QDir>
#include <QtWidgets>
#include "serverside.h"
#include<QVector>
#include "Photon.h"
#include <QDebug>
int Detected;
int Terminated;
int counter=0;
threads::threads(int ID, QObject *parent):
    QThread(parent)
{
    this->socketDescriptor = ID;
    dataSize=0;
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
    dataSize=0;
    connect(socket, SIGNAL(readyRead()),this, SLOT(readPhotonsVector()),Qt::DirectConnection);
    //  connect(socket, SIGNAL(disconnected()),this, SLOT(disconnected()),Qt::DirectConnection);
    qDebug() << socketDescriptor << "Client Connected!";
    exec();
}





void threads::readyRead()
{
    /*ReadyRead signal is emitted when the thread had received some data and Now it's
    Ready to Read it, then we handle Reading this data using readyReady slot*/
    qDebug()<<"Ready Read";
    readPhotonsVector();
}




void threads::readPhotonsVector(){
     qDebug()<<"Bytes available"<<socket->bytesAvailable();
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

    QByteArray array = socket->readAll();
    qDebug()<<"Ready Read emitting counter"<<counter;
    qDebug()<<"Total Size"<<dataSize;
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
    qDebug()<<"Recieved Result";
    qDebug()<<"Xs Size"<<X[0].size()<<"Ys Size "<<Y[0].size();
    qDebug()<<"Zs Size"<<Z[0].size()<<"Ws Size "<<W[0].size()<<"States Size"<<ST[0].size();
    qDebug()<<"Random Point";
    qDebug()<<X[0][50];
    qDebug()<<Y[0][50];
    qDebug()<<Z[0][50];
    qDebug()<<W[0][50];
    qDebug()<<ST[0]50];

    /*
        QVector<Photon> inComingResults;
        array= socket->readAll();
        qDebug()<<"Capacity"<<socket->readBufferSize();
        int arrsize=array.size();
        qDebug()<<"array Size"<<array.size();
        QDataStream in(&array,QIODevice::ReadOnly);
        in.setVersion(QDataStream::Qt_4_8);
        QDataStream &operator>>(QDataStream &in, QVector<Photon>  &inComingResults);
        in>>inComingResults;
        qDebug()<<"inComing Vector Size"<<inComingResults.size();
        //qDebug()<<inComingResults[0].getPosition().x()<<inComingResults[0].getPosition().y();
        emitSignalReady();
        qDebug()<<"Emitting signal";
*/
    counter++;

}

QDataStream &operator>>(QDataStream &in,  QVector<Photon> &inComingResults) {

    int size=0,s=0;
    float x=0.0,y=0.0,z=0.0,w=0.0;


    for(int i=0; i<16000;i++){
        Photon ph;
        Point P;
        in >> x>>y>>z>>w>>s;
        P.setCoordinates(x,y,z);
        ph.setPosition(P);
        ph.setWeight(w);
        ph.setState(s);
        inComingResults.push_back(ph);
        if(s==-1){
            Terminated++;
        }
        else if(s==1){
            Detected++;
        }
    }
    qDebug()<<"from inside the stream";
    qDebug()<<"Terminated"<<Terminated;
    qDebug()<<"Detected"<<Detected;

    return in;
}

void threads::streamOut(QVector<Photon> V, int size)
{
    FILE *output;
    output = fopen("output.csv", "w");
    std::string state;
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");
    for (int i = 0; i < size; i++)
    {
        switch (V[i].getState())
        {
        case (-1):
            state = "TERMINATED";
            break;
        case (0):
            state = "ROAMING";
            break;
        case (1):
            state = "DETECTED";
            break;
        case (2):
            state = "ESCAPED";
            break;
        }
        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", V[i].getPosition().x(), V[i].getPosition().y(), V[i].getPosition().z(), V[i].getWeight(), state.c_str());


    }
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
