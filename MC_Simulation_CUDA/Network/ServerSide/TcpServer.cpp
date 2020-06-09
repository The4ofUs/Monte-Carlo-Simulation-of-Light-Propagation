#include "TcpServer.h"
#include "Photon.h"
#include <unistd.h>


TcpServer::TcpServer(QObject *parent) :  QTcpServer(parent)
{
}

void TcpServer::startListening()
{

    if(!this->listen(QHostAddress::Any, 4567))
    {
        qDebug() << "Couldn't Start Server";

    }
    else
    {
        qDebug() << "Listening .....";

        serverBucketOfPhotons=100000;
        photonsToBeReceived =100000;
        photonsPerPatch = 50000;
        currentlyReceivedPhotons = 0;
    }

}

void TcpServer::incomingConnection(qintptr socketDescriptor)
{
    //qDebug() <<"client with socket ="<< socketDescriptor << "is trying to connect ...";
    //qDebug() << "batches"<< batchPhotons;
    thread = new Thread(socketDescriptor,this);
    thread->start();
    qDebug()<<"Bucket photons"<<serverBucketOfPhotons;
    thread->getBucketRemainingPhotons(serverBucketOfPhotons);
    thread->getNumberOfPhotons(photonsPerPatch);
    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));
    connect(thread,SIGNAL(newBatchSignal()),this,SLOT(decrementBatch()));
    connect(thread,SIGNAL(appendNewReceivedResultsSignal()),this,SLOT(appendReceivedResults()));
}


void TcpServer::decrementBatch(){
    if( serverBucketOfPhotons==0){
     //   qDebug()<<"there are no more batches to be sent";
        this->close();
      //  qDebug()<< "Server is closed";
    }
    else{
         serverBucketOfPhotons =  serverBucketOfPhotons-photonsPerPatch;
      //  qDebug()<<"decrement batch"<< serverBucketOfPhotons;
    }

}

void TcpServer::appendReceivedResults(){
    newResults = thread->returnRecievedPhotons();
    qDebug()<<"new results"<< newResults.size();
    ReceivedPhotons.append(newResults);
    qDebug()<<"total recieved"<<ReceivedPhotons.size();
   currentlyReceivedPhotons +=newResults.size();
    if (currentlyReceivedPhotons==photonsToBeReceived)
    {
        streamOut(ReceivedPhotons);

    }

}



void TcpServer::streamOut(QVector<Photon> results){
    FILE *output;
    output = fopen("serverReceivedResults.csv", "w");
    std::string state;
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");

    for (int i = 0; i < results.size(); i++)
    {
        switch (results[i].getState())
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
        fprintf(output, "%f,%f,%f,%f,%s\n", results[i].getPosition().x(), results[i].getPosition().y(), results[i].getPosition().z(), results[i].getWeight(), state.c_str());
    }
    //qDebug()<<results[1].getPosition().x()<< results[1].getPosition().y()<< results[1].getPosition().z()<< results[1].getWeight()<< state.c_str();
    fclose(output);
}

