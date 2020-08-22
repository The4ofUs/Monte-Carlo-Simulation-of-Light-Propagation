#ifndef CLIENTSOCKET_H
#define CLIENTSOCKET_H
#include "socket.h"


class ClientSocket
{
public:
    ClientSocket();
    void setBatchAvailability(bool state);
    void setBatchPhotons(int photons);
    bool getBatchAvailability();
    void sendResults(MC_Photon *_cpuPhotons);
    QVector<float> requestParameters();
    int requestNewBatch();
    QVector<MC_Photon> getSentPhotons();
private:
    bool newBatchAvailable;
    int  batchPhotons;

};

#endif // CLIENTSOCKET_H
