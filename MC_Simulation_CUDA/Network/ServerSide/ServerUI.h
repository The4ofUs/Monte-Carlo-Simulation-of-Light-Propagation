#ifndef SERVERUI_H
#define SERVERUI_H

#include <QMainWindow>
#include "TcpServer.h"
namespace Ui {
class ServerUI;
}

class ServerUI : public QMainWindow
{
    Q_OBJECT

public:
    explicit ServerUI(QWidget *parent = 0);
    ~ServerUI();
public slots:

private slots:

    void on_listenButton_clicked();

private:
    Ui::ServerUI *ui;
    TcpServer* server;
};

#endif // SERVERUI_H
