#include "../headers/TcpServer.h"
#include "../headers/Photon.h"
#include <unistd.h>
#include <ctime>
#include <ratio>
#include <chrono>
#include <iostream>
using namespace std::chrono;

high_resolution_clock::time_point t1;

TcpServer::TcpServer(QObject *parent) :  QTcpServer(parent)
{
}

void TcpServer::startListening()
{   t1 = high_resolution_clock::now();


    if(!this->listen(QHostAddress::Any, 4567))
    {
        qDebug() << "Couldn't Start Server";

    }
    else
    {
        qDebug() << "Listening .....";

        serverBucketOfPhotons= 1000;
        photonsToBeReceived = 1000;
        photonsPerBatch = 100;
        currentlyReceivedPhotons = 0;
    }

}

void TcpServer::incomingConnection(qintptr socketDescriptor)
{
    thread = new Thread(socketDescriptor,this);
    thread->start();
    thread->getBucketRemainingPhotons(serverBucketOfPhotons);
    thread->getNumberOfPhotons(photonsPerBatch);
    connect(thread,SIGNAL(finished()),thread,SLOT(deleteLater()));
    connect(thread,SIGNAL(newBatchSignal()),this,SLOT(decrementBatch()));
    connect(thread,SIGNAL(appendNewReceivedResultsSignal()),this,SLOT(appendReceivedResults()));

}


void TcpServer::decrementBatch(){
    if( serverBucketOfPhotons==0){
        qDebug()<<"Server has no more batches!";
    }
    else{
        serverBucketOfPhotons =  serverBucketOfPhotons-photonsPerBatch;
    }
    qDebug()<<"Bucket photons ="<<serverBucketOfPhotons;

}

void TcpServer::appendReceivedResults(){
    newResults = thread->returnRecievedPhotons();
    qDebug()<<"New recieved photons = "<< newResults.size() << " photons";
    ReceivedPhotons.append(newResults);
    qDebug()<<"Total recieved photons = "<<ReceivedPhotons.size() <<" photons";
    currentlyReceivedPhotons +=newResults.size();

    if (currentlyReceivedPhotons==photonsToBeReceived)
    {
        streamOut(ReceivedPhotons);
        this->close();
        qDebug()<< "Server is closed";

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
        case (0):
            state ="ROAMING" ;
            break;
        case (1):
            state ="TERMINATED";
            break;
        case (2):
            state = "DETECTED";
            break;
        case (3):
            state = "ESCAPED";
            break;
        }

        // Streaming out my output in a log file
        fprintf(output, "%f,%f,%f,%f,%s\n", results[i].getPosition().x(), results[i].getPosition().y(), results[i].getPosition().z(), results[i].getWeight(), state.c_str());
    }
     high_resolution_clock::time_point t2 = high_resolution_clock::now();
     duration<double> time_span = duration_cast<duration<double>>(t2 - t1);

     std::cout << "Overall Network time = " << (time_span.count())*1000 << " ms";
     std::cout << std::endl;
    //qDebug()<<results[1].getPosition().x()<< results[1].getPosition().y()<< results[1].getPosition().z()<< results[1].getWeight()<< state.c_str();
    fclose(output);
}

