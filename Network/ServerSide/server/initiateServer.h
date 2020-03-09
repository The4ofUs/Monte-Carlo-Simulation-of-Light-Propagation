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

signals:
    void readyISREAD();
public slots:
void readIsReady();
protected:
    void incomingConnection(qintptr socketDescriptor);
private:
       threads *thread;
};

#endif // INITIATESERVER_H
