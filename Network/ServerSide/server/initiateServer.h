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
    void streamOut(QVector<Photon> results);


signals:
    void readyISREAD();
public slots:
    void readIsReady();
    void decrementBatch();
    void appendReceivedResults();
protected:
    void incomingConnection(qintptr socketDescriptor);
private:
    threads *thread;
    QVector<Photon> newResults;
    QVector<Photon> ReceivedPhotons;
};

#endif // INITIATESERVER_H
