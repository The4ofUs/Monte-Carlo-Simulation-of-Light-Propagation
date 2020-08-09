#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QTcpServer>
#include<QDebug>
#include "Thread.h"

class TcpServer : public QTcpServer
{
    Q_OBJECT
public:
    explicit TcpServer(QObject *parent = nullptr);
    /**
     * @brief startListening
     */
    void startListening();
    /**
     * @brief streamOut
     * @param results
     */
    void streamOut(QVector<Photon> results);

public slots:
    /**
     * @brief decrementBatch
     * decrements one batch from the server photons bucket
     */
    void decrementBatch();
    /**
     * @brief appendReceivedResults
     * append the recently received results to the old ones
     */
    void appendReceivedResults();
protected:
    void incomingConnection(qintptr socketDescriptor);
private:
    Thread *thread;
    QVector<Photon> newResults;
    QVector<Photon> ReceivedPhotons;
    QVector<float> X;
    QVector<float> Y;
    QVector<float> Z;
    QVector<float> W;
    QVector<int> ST;
    int serverBucketOfPhotons;
    int photonsPerPatch;
    int photonsToBeReceived;
    int  currentlyReceivedPhotons;
};


#endif // TCPSERVER_H
