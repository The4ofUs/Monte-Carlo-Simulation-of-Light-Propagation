#include "initiateServer.h"
#include "Photon.h"
initiateServer::initiateServer(QObject *parent) :  QTcpServer(parent)
{
}

void initiateServer::StartServer()
{

    if(!this->listen(QHostAddress::Any, 4567))
    {
        qDebug() << "Couldn't Start Server";

    }
    else
    {
        qDebug() << "Listening .....";
        batchPhotons=5000;
        numberOFphotons = 1000;
    }

}

void initiateServer::incomingConnection(qintptr socketDescriptor)
{
    qDebug() << socketDescriptor << "connecting ...";
    //qDebug() << "batches"<< batchPhotons;
    thread = new threads(socketDescriptor,this);
    thread->start();
    thread->getBatchremainingPhotons(batchPhotons);
    connect(thread,SIGNAL(emitSignalReady()),SLOT(readIsReady()));
    Descriptor= socketDescriptor;
    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));
    connect(thread,SIGNAL(newBatchSignal()),this,SLOT(decrementBatch()));

}


void initiateServer::decrementBatch(){
    if(batchPhotons==0){
        qDebug()<<"no more batches";
    }
    else{
        batchPhotons = batchPhotons-numberOFphotons;
        qDebug()<<"decrement batch"<<batchPhotons;
    }
}
int initiateServer::sendDescriptor(){
    return Descriptor;
}


void initiateServer::readIsReady(){
    qDebug()<<"Read signal to emit another signal to notify the ui displaying slot";
    readyISREAD();
}
int initiateServer::DetectedCounter(){
    return thread->DetectedCounter();

}
int initiateServer::terminatedCounter(){
    return thread->terminatedCounter();

}
