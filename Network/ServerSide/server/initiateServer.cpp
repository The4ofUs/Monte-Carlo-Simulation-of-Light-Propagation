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
        serverTotalPhotons=50;
        photonsPerPatch = 5;
    }

}

void initiateServer::incomingConnection(qintptr socketDescriptor)
{
    qDebug() <<"client with socket ="<< socketDescriptor << "is trying to connect ...";
    //qDebug() << "batches"<< batchPhotons;
    thread = new threads(socketDescriptor,this);
    thread->start();
    thread->getBatchremainingPhotons(serverTotalPhotons);
    thread->getNumberOfPhotons(photonsPerPatch);
    connect(thread,SIGNAL(emitSignalReady()),SLOT(readIsReady()));
    Descriptor= socketDescriptor;
    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));
    connect(thread,SIGNAL(newBatchSignal()),this,SLOT(decrementBatch()));

}


void initiateServer::decrementBatch(){
    if(serverTotalPhotons==0){
        qDebug()<<"there are no more batches to be sent";
        qDebug()<< "Server is closed";
        this->close();
    }
    else{
        serverTotalPhotons = serverTotalPhotons-photonsPerPatch;
        qDebug()<<"decrement batch"<<serverTotalPhotons;
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
