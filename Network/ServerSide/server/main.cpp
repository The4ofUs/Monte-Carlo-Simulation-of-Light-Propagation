#include "serverside.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    serverSide w;
    w.show();

    return a.exec();
}
