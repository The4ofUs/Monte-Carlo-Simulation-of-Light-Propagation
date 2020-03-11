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

threads::threads(int ID, QObject *parent):
    QThread(parent)
{  //the Descriptor is an index of that socket in an array of sockets from the underlying OS (more or less).
    this->socketDescriptor = ID;
    dataSize=0;

}


/*
 *
 *
 * run
 * readPhotonVector
 * overridding Operator >>
 */

void  threads::run()
{
    qDebug() << socketDescriptor << " Starting Thread";
    socket = new QTcpSocket();

    if (!socket->setSocketDescriptor(this->socketDescriptor))
    {
        emit error(socket->error());
        return;
    }

    connect(socket, SIGNAL(readyRead()),this, SLOT(readPhotonsVector()),Qt::DirectConnection);
    connect(socket, SIGNAL(disconnected()),this, SLOT(disconnected()),Qt::DirectConnection);
    qDebug() << socketDescriptor << " Client Connected!";
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
    QVector<Photon> inComingResults;
    QByteArray array = socket->readAll();
    QDataStream in(&array,QIODevice::ReadOnly);
    in.setVersion(QDataStream::Qt_4_8);
    QDataStream &operator>>(QDataStream &in, QVector<Photon>  &inComingResults);
    in>>inComingResults;
    qDebug()<<" inComing Vector Size"<<inComingResults.size();
    //qDebug()<<inComingResults[0].getPosition().x()<<inComingResults[0].getPosition().y();
    emitSignalReady();
    qDebug()<<"Emitting signal";

}

QDataStream &operator>>(QDataStream &in,  QVector<Photon> &inComingResults) {

    int size,s;
    float x,y,z,w;
    in>>size;
    qDebug("SiZE OF SIZE STREAM");
    qDebug()<<size;

    for(int i=0; i<size;i++){
        //qDebug()<<i;

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
    qDebug()<<Terminated;
    qDebug()<<Detected;

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
    // closing thread
    exit(0);
}


int threads::DetectedCounter(){
    return Detected;
}


int threads::terminatedCounter()
{
    return Terminated;
}
