/********************************************************************************
** Form generated from reading UI file 'ServerUI.ui'
**
** Created by: Qt User Interface Compiler version 5.9.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SERVERUI_H
#define UI_SERVERUI_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_ServerUI
{
public:
    QWidget *centralWidget;
    QPushButton *listenButton;
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *ServerUI)
    {
        if (ServerUI->objectName().isEmpty())
            ServerUI->setObjectName(QStringLiteral("ServerUI"));
        ServerUI->resize(400, 300);
        centralWidget = new QWidget(ServerUI);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        listenButton = new QPushButton(centralWidget);
        listenButton->setObjectName(QStringLiteral("listenButton"));
        listenButton->setGeometry(QRect(100, 40, 89, 25));
        ServerUI->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(ServerUI);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 400, 22));
        ServerUI->setMenuBar(menuBar);
        mainToolBar = new QToolBar(ServerUI);
        mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
        ServerUI->addToolBar(Qt::TopToolBarArea, mainToolBar);
        statusBar = new QStatusBar(ServerUI);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        ServerUI->setStatusBar(statusBar);

        retranslateUi(ServerUI);

        QMetaObject::connectSlotsByName(ServerUI);
    } // setupUi

    void retranslateUi(QMainWindow *ServerUI)
    {
        ServerUI->setWindowTitle(QApplication::translate("ServerUI", "ServerUI", Q_NULLPTR));
        listenButton->setText(QApplication::translate("ServerUI", "Listen", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class ServerUI: public Ui_ServerUI {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SERVERUI_H
