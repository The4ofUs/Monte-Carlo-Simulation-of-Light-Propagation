#ifndef SERVERSIDE_H
#define SERVERSIDE_H

#include <QMainWindow>
#include <QTcpServer>
#include<QDebug>
#include"threads.h"
#include "initiateServer.h"
#include "threads.h"
namespace Ui {
class serverSide;
}

class serverSide : public QMainWindow
{
    Q_OBJECT

public:
    explicit serverSide(QWidget *parent = 0);
    ~serverSide();
    QImage image;

public slots:
    void startServer();

private slots:
    void on_pushButton_clicked();
    void displayCounter();
    void newConnection();
    void on_listenButton_clicked();

private:
    Ui::serverSide *ui;

    initiateServer* server;

};

#endif // SERVERSIDE_H
