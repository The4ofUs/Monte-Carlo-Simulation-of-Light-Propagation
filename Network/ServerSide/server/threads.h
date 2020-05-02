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
    int terminatedCounter();
    int DetectedCounter();
signals:
    void error(QTcpSocket::SocketError socketerror);
    void emitSignalReady();
    void newBatchSignal();

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
    int batchPhotons;
};

#endif // THREADS_H
