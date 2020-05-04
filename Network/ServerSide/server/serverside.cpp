#include "serverside.h"
#include "ui_serverside.h"
#include "initiateServer.h"
#include <QFileDialog>
#include <threads.h>
serverSide::serverSide(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::serverSide)
{
    server=new initiateServer();
    ui->setupUi(this);
    connect(ui->listenButton,SIGNAL(released()),this,SLOT(startServer()));
    //emitSignal is being emiited as long as the thread is Running
    //connect(server,SIGNAL(emitSinal()),this,SLOT(displayCounter()));
    connect(server,SIGNAL(newConnection()),this,SLOT(newConnection()));
    connect(server,SIGNAL(readyISREAD()),SLOT(displayCounter()));
}

void serverSide::startServer(){
    server->StartServer();
    ui->listenButton->setEnabled(false);
    ui->listenButton->setStyleSheet("background-color: rgb(255, 255, 255);");
    ui->listenButton->setText("Listening..");


}

serverSide::~serverSide()
{
    delete ui;
}
void serverSide::newConnection(){
    int Descriptor=server->sendDescriptor();
}

int i=1;
void serverSide::displayCounter(){
    int D=server->DetectedCounter();
    int T=server->terminatedCounter();


}
