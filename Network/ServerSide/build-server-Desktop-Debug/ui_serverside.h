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
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_serverSide
{
public:
    QWidget *centralWidget;
    QGridLayout *gridLayout;
    QHBoxLayout *horizontalLayout_6;
    QPushButton *listenButton;
    QSpacerItem *horizontalSpacer;
    QSpacerItem *verticalSpacer;
    QToolBar *toolBar;

    void setupUi(QMainWindow *serverSide)
    {
        if (serverSide->objectName().isEmpty())
            serverSide->setObjectName(QStringLiteral("serverSide"));
        serverSide->resize(192, 282);
        serverSide->setStyleSheet(QLatin1String("\n"
"background-color: rgb(87, 135, 132);"));
        centralWidget = new QWidget(serverSide);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        gridLayout = new QGridLayout(centralWidget);
        gridLayout->setSpacing(6);
        gridLayout->setContentsMargins(11, 11, 11, 11);
        gridLayout->setObjectName(QStringLiteral("gridLayout"));
        horizontalLayout_6 = new QHBoxLayout();
        horizontalLayout_6->setSpacing(6);
        horizontalLayout_6->setObjectName(QStringLiteral("horizontalLayout_6"));
        listenButton = new QPushButton(centralWidget);
        listenButton->setObjectName(QStringLiteral("listenButton"));
        QFont font;
        font.setFamily(QStringLiteral("Ubuntu Mono"));
        font.setPointSize(14);
        font.setBold(true);
        font.setWeight(75);
        listenButton->setFont(font);
        listenButton->setStyleSheet(QStringLiteral("background-color: rgb(186, 189, 182);"));

        horizontalLayout_6->addWidget(listenButton);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout_6->addItem(horizontalSpacer);


        gridLayout->addLayout(horizontalLayout_6, 0, 0, 1, 1);

        verticalSpacer = new QSpacerItem(20, 208, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout->addItem(verticalSpacer, 1, 0, 1, 1);

        serverSide->setCentralWidget(centralWidget);
        toolBar = new QToolBar(serverSide);
        toolBar->setObjectName(QStringLiteral("toolBar"));
        serverSide->addToolBar(Qt::TopToolBarArea, toolBar);

        retranslateUi(serverSide);

        QMetaObject::connectSlotsByName(serverSide);
    } // setupUi

    void retranslateUi(QMainWindow *serverSide)
    {
        serverSide->setWindowTitle(QApplication::translate("serverSide", "serverSide", Q_NULLPTR));
        listenButton->setText(QApplication::translate("serverSide", "Listen", Q_NULLPTR));
        toolBar->setWindowTitle(QApplication::translate("serverSide", "toolBar", Q_NULLPTR));
    } // retranslateUi

};

namespace Ui {
    class serverSide: public Ui_serverSide {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_SERVERSIDE_H
