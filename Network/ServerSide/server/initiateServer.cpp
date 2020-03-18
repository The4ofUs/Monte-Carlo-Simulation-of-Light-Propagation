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

    }

}

void initiateServer::incomingConnection(qintptr socketDescriptor)
{
    qDebug() << socketDescriptor << "connecting ...";
    thread = new threads(socketDescriptor,this);
    thread->start();
    connect(thread,SIGNAL(emitSignalReady()),SLOT(readIsReady()));
    Descriptor= socketDescriptor;
    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));

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
