#ifndef SOCKET_H
#define SOCKET_H

#include <QObject>
#include <QTcpSocket> //inherets from QAbstractSocket and
#include <QAbstractSocket>
#include <QHostAddress>
class socket : public QObject
{
    Q_OBJECT
public:
    explicit socket(QObject *parent = nullptr);
    void createSocket();
    QImage image;
    void sendData();
    void readData();
    bool isConnected();
    void sendArray();
    void sendStruct();

signals:
    void sendImage();

public slots:

    // some signals inereted form QAbstractSocket
    void connected();
    void disconnected();

    // some signal inhereted form QIODevice
    void bytesWritten(qint64 bytes);
    void readyRead(); // Tell when there actually information for us to read
private:
    QImage randomImage();

    QTcpSocket *newSocket;
    int dataSize;
    bool state;
    int num[5]={1,2,3,4,5};
};

#endif // SOCKET_H
