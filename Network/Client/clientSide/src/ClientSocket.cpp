#include "clientSide/headers/ClientSocket.h"
QVector<MC_Photon> vectorOfPhotons;
ClientSocket::ClientSocket()
{

}

void ClientSocket::sendResults(MC_Photon *_cpuPhotons)
{   vectorOfPhotons.clear();
    for (int i = 0; i < this->batchPhotons; i++)
    {
        vectorOfPhotons.push_back(_cpuPhotons[i]);
    }
    socket *newSocket =new socket();
    newSocket->setQueryType("prepareForReceiving");
    newSocket->socket::setVectorOfPhotons(vectorOfPhotons);
    newSocket->createSocket();
   // appendToVectors(vectorOfPhotons);
}

void ClientSocket::setBatchPhotons(int photons){
    this->batchPhotons = photons;
}

QVector<MC_Photon> ClientSocket::getSentPhotons(){
    return  vectorOfPhotons;
}
void ClientSocket::setBatchAvailability(bool state){
    this->newBatchAvailable=state;
}
bool ClientSocket::getBatchAvailability()
{
    return this->newBatchAvailable;
}
QVector<float> ClientSocket::requestParameters(){
        socket *newSocket =new socket();
        newSocket->setQueryType("requestParameters");
        newSocket->createSocket();
        QVector<float> parameters = newSocket->getParameters();
        if(parameters.size()>0){
            setBatchAvailability(true);
        }
        else {
            setBatchAvailability(false);
        }
        return parameters;
}

int ClientSocket::requestNewBatch(){
    socket *newSocket =new socket();
    newSocket->setQueryType("requestBatch");
    newSocket->createSocket();
    int batchPhotons = newSocket->batchPhoton();
    if (batchPhotons > 0){
        setBatchAvailability(true);
    }

    //qDebug()<<"Batch photons in client side"<<batchPhotons;
    if (batchPhotons==0){
        qDebug()<<"THERE IS NO MORE BATCHES";
        setBatchAvailability(false);
    }
    return batchPhotons;
}
