#include "initiateServer.h"
#include "Photon.h"
QVector<float> X_total;
QVector<float> Y_total;
QVector<float> Z_total;
QVector<float> W_total;
QVector<float> ST_total;
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
        serverTotalPhotons=100000;
        photonsPerPatch = 10000;
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
        //streamOut(X_total, Y_total, Z_total, W_total, ST_total);
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

void initiateServer::appendToVectors(QVector<float> X,QVector<float> Y,QVector<float> Z,QVector<float> W,QVector<int> ST){
    for (int i = 0; i < X.size(); i++)
    {
        X_total.push_back(X[i]);
        Y_total.push_back(Y[i]);
        Z_total.push_back(Z[i]);
        W_total.push_back(W[i]);
        ST_total.push_back(ST[i]);

    }

}

void initiateServer::streamOut(QVector<float> X_total,QVector<float> Y_total,QVector<float> Z_total,QVector<float> W_total,QVector<int> ST_total){
    FILE *output;
    output = fopen("serverOutput.csv", "w");
    std::string state;
    fprintf(output, "X,Y,Z,WEIGHT,STATE\n");

    for (int i = 0; i < X.size(); i++)
    {
        switch (ST_total[i])
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
        fprintf(output, "%f,%f,%f,%f,%s\n", X_total[i], Y_total[i], Z_total[i], W_total[i], state.c_str());

    }
    fclose(output);
}
