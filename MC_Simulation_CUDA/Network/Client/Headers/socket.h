#ifndef SOCKET_H
#define SOCKET_H

#include <QObject>
#include <QTcpSocket> //inherets from QAbstractSocket and
#include <QAbstractSocket>
#include <QHostAddress>
#include <QImageReader>
#include <QWidget>
#include <QImageWriter>
#include "../../../code/headers/MC_Photon.cuh"

class socket : public QObject
{
    Q_OBJECT
public:
    explicit socket(QObject *parent = nullptr);
    /**
     * @brief createSocket creats the TCPsocket
     */
    void createSocket();
    /**
     * @brief startSerialization starts the serialization process
     */
    void startSerialization();
    /**
     * @brief setQueryType
     * @param querytype
     */
    void setQueryType(std::string querytype);
    /**
     * @brief setVectorOfMC_Photons
     * @param V
     */
    void setVectorOfPhotons( QVector<MC_Photon> V);
    /**
     * @brief getServerParameters
     */
    void getServerParameters();
    void  getNewBatchPhotons();
    QVector<MC_Photon> getVectorofPhotons();
    QVector<float> getParameters();
    int numberOfPhotons;
    bool serverIsReadytoReceive();
    void setBatchPhotons(int photons);
    int batchPhoton();


public slots:
    /**
     * @brief sendResults
     */
    void sendResults();
    /**
     * @brief disconnected
     */
    void disconnected();
    /**
     * @brief bytesWritten
     * @param bytes
     */
    void bytesWritten(qint64 bytes);
    /**
     * @brief readyRead
     * invkoed upon signal readyRead emitted by the TCP socket when data is received
     */
    void readyRead();
    /**
     * @brief requestParameters
     */
    void requestParameters();
    /**
     * @brief requestBatch
     */
    void requestBatch();

private:
    QTcpSocket *newSocket;
    int dataSize;
    std::string queryType;
    QVector<MC_Photon> incomingVector;
    QVector<float> parameters;
    int batchPhotons;
};

#endif // SOCKET_H
