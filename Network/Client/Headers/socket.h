#ifndef SOCKET_H
#define SOCKET_H

#include <QObject>
#include <QTcpSocket> //inherets from QAbstractSocket and
#include <QAbstractSocket>
#include <QHostAddress>
#include <QImageReader>
#include <QWidget>
#include <QImageWriter>
#include "/home/eman/3D-Random-Walk-CUDA/code/headers/common.h"
#include "/home/eman/3D-Random-Walk-CUDA/code/headers/Photon.h"


class socket : public QObject
{
    Q_OBJECT
public:
    explicit socket(QObject *parent = nullptr);
    void createSocket();
    void readData();
    bool isConnected();
    bool serverIsReadytoReceive();
    void getPhotonFinalState(float x, float y,float z,float w, int s);
    void startSerialization();

    //void updateVector(float x, float y,float z,float w, int s);
    void getVectorOfPhotons( QVector<Photon> V);
    QVector<Photon> getVectorToBeSend();
    void getServerParameters();
    void getNewBatch();
    QVector<float> getParameters();
    std::string queryType;
    int numberOfPhotons;

signals:
    void sendImage();

public slots:

    // some signals inereted form QAbstractSocket
    void sendResults();
    void disconnected();
    // some signal inhereted form QIODevice
    void bytesWritten(qint64 bytes);
    void readyRead(); // Tell when there actually information for us to read    
    void requestParameters();
    void requestBatch();
private:
    QTcpSocket *newSocket;
    int dataSize;
    bool state;
    QVector<Photon> incomingVector;
    QVector<float> parameters;

};

#endif // SOCKET_H
