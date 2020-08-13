#include "ServerUI.h"
#include "ui_ServerUI.h"

ServerUI::ServerUI(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ServerUI)
{
    ui->setupUi(this);
    server = new TcpServer();
}

ServerUI::~ServerUI()
{
    delete ui;
}



void ServerUI::on_listenButton_clicked()
{
    server->startListening();
    ui->listenButton->setEnabled(false);
    ui->listenButton->setStyleSheet("background-color: rgb(255, 255, 255);");
    ui->listenButton->setText("Listening..");
}
