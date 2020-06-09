#ifndef THREAD_H
#define THREAD_H
#include <QObject>
#include <QThread>
#include <QTcpSocket>
#include <QtDebug>
#include <QWidget>
#include <QVector>
#include <Photon.h>
/**
 * @brief The Thread class inherits QThread in order to handle
 * multiple incoming connections simultaneously
 */
class Thread : public QThread
{
    Q_OBJECT
public:
    QTcpSocket *socket;
    explicit Thread(int ID, QObject *parent = nullptr);
    /**
     * @brief Thread::run
     * Virtual function which represents the starting point for a thread
     * It's invoked after calling start(), it calls exec() by default
     */
    void run();
    /**
     * @brief sendParameters
     * send the parameters to the client
     */
    void sendParameters();
    /**
     * @brief sendNewBatch
     * send new batch when the client demands it
     */
    void sendNewBatch();
    /**
     * @brief getBucketRemainingPhotons
     *  get the remaining photons in the server bucket
     * @param remainingPhotons
     */
    void getBucketRemainingPhotons(int remainingPhotons);
    /**
     * @brief getNumberOfPhotons
     *  get the number of photons to be send per batch
     * @param numPhotons
     */
    void getNumberOfPhotons(int numPhotons);
    /**
     * @brief Thread::returnRecievedPhotons
     * @return the received results after reconditioning to be appended to the previous received results
     */
    QVector<Photon> returnRecievedPhotons();
    /**
     * @brief Thread::reconditionResultsToPhotons
     * @param x is the received photons final x position
     * @param y is the received photons final y position
     * @param z is the received photons final z position
     * @param w is the received photons final weight
     * @param s is the received photons final state
     */
    void reconditionResultsToPhotons(QVector<float> x,QVector<float> y, QVector<float> z, QVector<float> w, QVector<float> s);

signals:
    void error(QTcpSocket::SocketError socketerror);
    void emitSignalReady();
    void newBatchSignal();
    void appendNewReceivedResultsSignal();
public slots:
    void disconnected();
    /**
     * @brief readResults
     * Read the received results and then recondition them from Vectors of floats to
     * one consistent vector of photons
     */
    void readResults();
    /**
     * @brief readQuery
     * Invoked upon readyRead signal
     * Interprets the coming request and reply according to it
     */
    void readQuery();
private:
    int socketDescriptor; // the underlying socket ID number from the operating system
    int dataSize;
    bool readflag;
    std::string queryType;
    int bucketRemainingPhotons;
    int photonsPerPatch;

};

#endif // THREADS_H
