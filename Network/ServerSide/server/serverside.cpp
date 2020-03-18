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
    ui->tableWidget->hide();
}

void serverSide::startServer(){
    server->StartServer();
    ui->listenButton->setEnabled(false);
    ui->listenButton->setStyleSheet("background-color: rgb(255, 255, 255);");
    ui->listenButton->setText("Listening..");
    ui->tableWidget->show();
    QTableWidgetItem* item1 = new QTableWidgetItem;
    item1->setText("Client No.");
    QTableWidgetItem* item2 = new QTableWidgetItem;
    QTableWidgetItem* item3 = new QTableWidgetItem;
    item2->setText("Detected");
    item3->setText("Terminated");
    ui->tableWidget->insertRow(0);
    ui->tableWidget->insertColumn(0);
    ui->tableWidget->insertColumn(1);
    ui->tableWidget->insertColumn(2);
    ui->tableWidget->setItem(0,0, item1);
    ui->tableWidget->setItem(0,1, item2);
    ui->tableWidget->setItem(0,2, item3);

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
    ui->tableWidget->insertRow(i);
    QTableWidgetItem* item2 = new QTableWidgetItem;
    item2->setData(Qt::EditRole, i);
    ui->tableWidget->setItem(i,0, item2);
    QTableWidgetItem* item3 = new QTableWidgetItem;
    item3->setData(Qt::EditRole, D);
    ui->tableWidget->setItem(i,1, item3);
    QTableWidgetItem* item = new QTableWidgetItem;
    item->setData(Qt::EditRole, T);
    ui->tableWidget->setItem(i,2, item);

    i++;

}
