#ifndef THREADS_H
#define THREADS_H

#include <QObject>
#include <QThread>
#include <QTcpSocket>
#include <QtDebug>
#include <QWidget>
#include <QVector>
#include <Photon.h>
class threads : public QThread
{
    Q_OBJECT
public:
    QTcpSocket *socket;
    explicit threads(int ID, QObject *parent = nullptr);
    void run();
    void sendData();
    void sendParameters();
    void sendNewBatch();
    void getBatchremainingPhotons(int batches);
    void getNumberOfPhotons(int numPhotons);
    int terminatedCounter();
    int DetectedCounter();
    QVector<Photon> returnRecievedPhotons();
    void reconditionResultsToPhotons(QVector<float> x,QVector<float> y, QVector<float> z, QVector<float> w, QVector<float> s);

signals:
    void error(QTcpSocket::SocketError socketerror);
    void emitSignalReady();
    void newBatchSignal();
    void appendNewReceivedResultsSignal();
public slots:
    void disconnected();
    void readData();
    void readPhotonsVector();
    void read();
private:

    int socketDescriptor; // the underlying socket ID number from the operating system
    int dataSize;
    bool readflag;
    std::string queryType;
    int batchRemainingPhotons;
};

#endif // THREADS_H
