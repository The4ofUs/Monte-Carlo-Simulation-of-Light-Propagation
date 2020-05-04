#ifndef INITIATESERVER_H
#define INITIATESERVER_H

#include <QObject>
#include <QTcpServer>
#include<QDebug>
#include "threads.h"

class initiateServer : public QTcpServer
{
    Q_OBJECT
public:
    explicit initiateServer(QObject *parent = nullptr);
    void StartServer();
    int Descriptor;
    int sendDescriptor();
    int DetectedCounter();
    int terminatedCounter();
    int serverTotalPhotons;
    int photonsPerPatch;
    void streamOut(QVector<float> X_total,QVector<float> Y_total,QVector<float> Z_total,QVector<float> W_total,QVector<int> ST_total);
    void appendToVectors(QVector<float> X,QVector<float> Y,QVector<float> Z,QVector<float> W,QVector<int> ST);


signals:
    void readyISREAD();
public slots:
void readIsReady();
void decrementBatch();
protected:
    void incomingConnection(qintptr socketDescriptor);
private:
       threads *thread;
};

#endif // INITIATESERVER_H
