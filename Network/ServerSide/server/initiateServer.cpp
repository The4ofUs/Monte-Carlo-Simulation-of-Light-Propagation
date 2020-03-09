#include "initiateServer.h"
#include "Photon.h"
initiateServer::initiateServer(QObject *parent) :  QTcpServer(parent)
{
}

/*
 *
 *
 * startServer
 * incomingConnection
 *
 */
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
    Photon p;
    p.setState(0);
    qDebug()<<"photon state"<<p.getState();

}

void initiateServer::incomingConnection(qintptr socketDescriptor)
{
    qDebug() << socketDescriptor << "connecting ...";
    thread = new threads(socketDescriptor,this);
    thread->start();
    connect(thread,SIGNAL(emitSignalReady()),SLOT(readIsReady()));
    qDebug()<<socketDescriptor;
    Descriptor= socketDescriptor;
   connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));


}



int initiateServer::sendDescriptor(){
    return Descriptor;
}


void initiateServer::readIsReady(){
    qDebug()<<"ready is read";
    readyISREAD();
}
int initiateServer::DetectedCounter(){
  return thread->DetectedCounter();

}
int initiateServer::terminatedCounter(){
    return thread->terminatedCounter();

}
