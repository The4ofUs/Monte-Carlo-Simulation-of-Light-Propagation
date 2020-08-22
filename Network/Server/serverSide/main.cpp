#include "headers/ServerUI.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    ServerUI w;
    w.show();

    return a.exec();
}
