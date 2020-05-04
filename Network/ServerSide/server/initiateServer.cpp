#include "initiateServer.h"
#include "Photon.h"
#include <unistd.h>


QVector<float> X;
QVector<float> Y;
QVector<float> Z;
QVector<float> W;
QVector<int> ST;

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

        serverTotalPhotons=5000;
        serverTotalRecievedPhotons =5000; // To make sure that we recieved the whol volume before closing the server
        photonsPerPatch = 1000;
        totalRecievedSize = 0;
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
    connect(thread,SIGNAL(appendNewReceivedResultsSignal()),this,SLOT(appendReceivedResults()));

}


void initiateServer::decrementBatch(){
    if(serverTotalPhotons==0){
        qDebug()<<"there are no more batches to be sent";
        this->close();
        qDebug()<< "Server is closed";

    }
    else{
        serverTotalPhotons = serverTotalPhotons-photonsPerPatch;
        qDebug()<<"decrement batch"<<serverTotalPhotons;
    }
}

void initiateServer::appendReceivedResults(){
    newResults = thread->returnRecievedPhotons();
    qDebug()<<"new results"<< newResults.size();
    ReceivedPhotons.append(newResults);
    qDebug()<<"total recieved"<<ReceivedPhotons.size();
    totalRecievedSize +=newResults.size();
    if (totalRecievedSize == serverTotalRecievedPhotons)
    {
        streamOut(ReceivedPhotons);

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


void initiateServer::streamOut(QVector<Photon> results){
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
        //qDebug()<<results[i].getPosition().x()<< results[i].getPosition().y()<< results[i].getPosition().z()<< results[i].getWeight()<< state.c_str();
    }
    fclose(output);
}
