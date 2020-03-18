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
    void streamOut(QVector<Photon> V, int size);

    int terminatedCounter();
    int DetectedCounter();

signals:
    void error(QTcpSocket::SocketError socketerror);
    void emitSignalReady();

public slots:
    void readyRead(); // from QIOObject
    void disconnected();
    void readData();
    void readPhotonsVector();
private:

    int socketDescriptor; // the underlying socket ID number from the operating system
    int dataSize;
    bool readflag;

};

#endif // THREADS_H
