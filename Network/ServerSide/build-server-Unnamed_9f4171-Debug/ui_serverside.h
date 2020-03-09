/********************************************************************************
** Form generated from reading UI file 'serverside.ui'
**
** Created by: Qt User Interface Compiler version 5.9.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_SERVERSIDE_H
#define UI_SERVERSIDE_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_serverSide
{
public:
    QWidget *centralWidget;
    QPushButton *listenButton;
    QLabel *label_2;
    QWidget *layoutWidget;
    QVBoxLayout *verticalLayout_2;
    QVBoxLayout *verticalLayout;
    QLabel *label;
    QListWidget *listWidget;
    QMenuBar *menuBar;
    QToolBar *mainToolBar;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *serverSide)
    {
        if (serverSide->objectName().isEmpty())
            serverSide->setObjectName(QStringLiteral("serverSide"));
        serverSide->resize(501, 341);
        centralWidget = new QWidget(serverSide);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        listenButton = new QPushButton(centralWidget);
        listenButton->setObjectName(QStringLiteral("listenButton"));
        listenButton->setGeometry(QRect(30, 40, 89, 25));
        label_2 = new QLabel(centralWidget);
        label_2->setObjectName(QStringLiteral("label_2"));
        label_2->setGeometry(QRect(20, 86, 131, 121));
        label_2->setStyleSheet(QStringLiteral("background-color: rgb(243, 243, 243);"));
        layoutWidget = new QWidget(centralWidget);
        layoutWidget->setObjectName(QStringLiteral("layoutWidget"));
        layoutWidget->setGeometry(QRect(180, 0, 141, 211));
        verticalLayout_2 = new QVBoxLayout(layoutWidget);
        verticalLayout_2->setSpacing(6);
        verticalLayout_2->setContentsMargins(11, 11, 11, 11);
        verticalLayout_2->setObjectName(QStringLiteral("verticalLayout_2"));
        verticalLayout_2->setContentsMargins(0, 0, 0, 0);
        verticalLayout = new QVBoxLayout();
        verticalLayout->setSpacing(6);
        verticalLayout->setObjectName(QStringLiteral("verticalLayout"));
        label = new QLabel(layoutWidget);
        label->setObjectName(QStringLiteral("label"));

        verticalLayout->addWidget(label);


        verticalLayout_2->addLayout(verticalLayout);

        listWidget = new QListWidget(layoutWidget);
        listWidget->setObjectName(QStringLiteral("listWidget"));

        verticalLayout_2->addWidget(listWidget);

        serverSide->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(serverSide);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 501, 22));
        serverSide->setMenuBar(menuBar);
        mainToolBar = new QToolBar(serverSide);
        mainToolBar->setObjectName(QStringLiteral("mainToolBar"));
        serverSide->addToolBar(Qt::TopToolBarArea, mainToolBar);
        statusBar = new QStatusBar(serverSide);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        serverSide->setStatusBar(statusBar);

        retranslateUi(serverSide);

        QMetaObject::connectSlotsByName(serverSide);
    } // setupUi

    void retranslateUi(QMainWindow *serverSide)
    {
        serverSide->setWindowTitle(QApplication::translate("serverSide", "serverSide", Q_NULLPTR));
        listenButton->setText(QApplication::translate("serverSide", "Listen", Q_NULLPTR));
        label_2->setText(QString());
        label->setText(QApplication::translate("serverSide", "connected devices", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class serverSide: public Ui_serverSide {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SERVERSIDE_H
