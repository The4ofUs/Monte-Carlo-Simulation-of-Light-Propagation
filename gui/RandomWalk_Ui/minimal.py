# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'minimal.ui'
#
# Created by: PyQt5 UI code generator 5.14.0
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(803, 925)
        MainWindow.setStyleSheet("")
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayout_2 = QtWidgets.QGridLayout(self.centralwidget)
        self.gridLayout_2.setObjectName("gridLayout_2")
        self.frame = QtWidgets.QFrame(self.centralwidget)
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.gridLayout = QtWidgets.QGridLayout(self.frame)
        self.gridLayout.setObjectName("gridLayout")
        self.tabWidget = QtWidgets.QTabWidget(self.frame)
        self.tabWidget.setMinimumSize(QtCore.QSize(600, 600))
        self.tabWidget.setObjectName("tabWidget")
        self.tab = QtWidgets.QWidget()
        self.tab.setObjectName("tab")
        self.gridLayout_3 = QtWidgets.QGridLayout(self.tab)
        self.gridLayout_3.setObjectName("gridLayout_3")
        self.splitter = QtWidgets.QSplitter(self.tab)
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setObjectName("splitter")
        self.frame_2 = QtWidgets.QFrame(self.splitter)
        self.frame_2.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_2.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_2.setObjectName("frame_2")
        self.gridLayout_9 = QtWidgets.QGridLayout(self.frame_2)
        self.gridLayout_9.setObjectName("gridLayout_9")
        self.groupBox = QtWidgets.QGroupBox(self.frame_2)
        self.groupBox.setObjectName("groupBox")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.groupBox)
        self.verticalLayout.setObjectName("verticalLayout")
        self.groupBox_2 = QtWidgets.QGroupBox(self.groupBox)
        self.groupBox_2.setObjectName("groupBox_2")
        self.gridLayout_5 = QtWidgets.QGridLayout(self.groupBox_2)
        self.gridLayout_5.setObjectName("gridLayout_5")
        self.horizontalLayout_3 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_3.setObjectName("horizontalLayout_3")
        self.label_3 = QtWidgets.QLabel(self.groupBox_2)
        self.label_3.setObjectName("label_3")
        self.horizontalLayout_3.addWidget(self.label_3)
        self.dPosXSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dPosXSpinBox.setDecimals(2)
        self.dPosXSpinBox.setMinimum(-10000.0)
        self.dPosXSpinBox.setMaximum(10000.0)
        self.dPosXSpinBox.setProperty("value", 0.0)
        self.dPosXSpinBox.setObjectName("dPosXSpinBox")
        self.horizontalLayout_3.addWidget(self.dPosXSpinBox)
        self.dPosYSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dPosYSpinBox.setMinimum(-10000.0)
        self.dPosYSpinBox.setMaximum(10000.0)
        self.dPosYSpinBox.setObjectName("dPosYSpinBox")
        self.horizontalLayout_3.addWidget(self.dPosYSpinBox)
        self.dPosZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dPosZSpinBox.setMinimum(-10000.0)
        self.dPosZSpinBox.setMaximum(10000.0)
        self.dPosZSpinBox.setObjectName("dPosZSpinBox")
        self.horizontalLayout_3.addWidget(self.dPosZSpinBox)
        spacerItem = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_3.addItem(spacerItem)
        self.gridLayout_5.addLayout(self.horizontalLayout_3, 1, 0, 1, 1)
        self.horizontalLayout_4 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_4.setObjectName("horizontalLayout_4")
        self.label_4 = QtWidgets.QLabel(self.groupBox_2)
        self.label_4.setObjectName("label_4")
        self.horizontalLayout_4.addWidget(self.label_4)
        self.dLookAtXSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dLookAtXSpinBox.setMinimum(-10000.0)
        self.dLookAtXSpinBox.setMaximum(10000.0)
        self.dLookAtXSpinBox.setObjectName("dLookAtXSpinBox")
        self.horizontalLayout_4.addWidget(self.dLookAtXSpinBox)
        self.dLookAtYSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dLookAtYSpinBox.setMinimum(-10000.0)
        self.dLookAtYSpinBox.setMaximum(10000.0)
        self.dLookAtYSpinBox.setObjectName("dLookAtYSpinBox")
        self.horizontalLayout_4.addWidget(self.dLookAtYSpinBox)
        self.dLookAtZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dLookAtZSpinBox.setMinimum(-10000.0)
        self.dLookAtZSpinBox.setMaximum(10000.0)
        self.dLookAtZSpinBox.setObjectName("dLookAtZSpinBox")
        self.horizontalLayout_4.addWidget(self.dLookAtZSpinBox)
        spacerItem1 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_4.addItem(spacerItem1)
        self.gridLayout_5.addLayout(self.horizontalLayout_4, 3, 0, 1, 1)
        self.horizontalLayout_14 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_14.setObjectName("horizontalLayout_14")
        self.dPosComboBox = QtWidgets.QComboBox(self.groupBox_2)
        self.dPosComboBox.setObjectName("dPosComboBox")
        self.dPosComboBox.addItem("")
        self.dPosComboBox.addItem("")
        self.dPosComboBox.addItem("")
        self.horizontalLayout_14.addWidget(self.dPosComboBox)
        spacerItem2 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_14.addItem(spacerItem2)
        self.gridLayout_5.addLayout(self.horizontalLayout_14, 2, 0, 1, 1)
        self.horizontalLayout_2 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_2.setObjectName("horizontalLayout_2")
        self.label_2 = QtWidgets.QLabel(self.groupBox_2)
        self.label_2.setObjectName("label_2")
        self.horizontalLayout_2.addWidget(self.label_2)
        self.dRadiusSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_2)
        self.dRadiusSpinBox.setMaximum(10000.0)
        self.dRadiusSpinBox.setObjectName("dRadiusSpinBox")
        self.horizontalLayout_2.addWidget(self.dRadiusSpinBox)
        spacerItem3 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_2.addItem(spacerItem3)
        self.gridLayout_5.addLayout(self.horizontalLayout_2, 0, 0, 1, 1)
        self.horizontalLayout_15 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_15.setObjectName("horizontalLayout_15")
        self.dLookAtCheckBox = QtWidgets.QCheckBox(self.groupBox_2)
        self.dLookAtCheckBox.setObjectName("dLookAtCheckBox")
        self.horizontalLayout_15.addWidget(self.dLookAtCheckBox)
        spacerItem4 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_15.addItem(spacerItem4)
        self.gridLayout_5.addLayout(self.horizontalLayout_15, 4, 0, 1, 1)
        self.verticalLayout.addWidget(self.groupBox_2)
        self.groupBox_3 = QtWidgets.QGroupBox(self.groupBox)
        self.groupBox_3.setObjectName("groupBox_3")
        self.gridLayout_4 = QtWidgets.QGridLayout(self.groupBox_3)
        self.gridLayout_4.setObjectName("gridLayout_4")
        self.horizontalLayout_10 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_10.setObjectName("horizontalLayout_10")
        self.label_10 = QtWidgets.QLabel(self.groupBox_3)
        self.label_10.setObjectName("label_10")
        self.horizontalLayout_10.addWidget(self.label_10)
        self.tCenter2XSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter2XSpinBox.setMinimum(-10000.0)
        self.tCenter2XSpinBox.setMaximum(10000.0)
        self.tCenter2XSpinBox.setObjectName("tCenter2XSpinBox")
        self.horizontalLayout_10.addWidget(self.tCenter2XSpinBox)
        self.tCenter2YSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter2YSpinBox.setMinimum(-10000.0)
        self.tCenter2YSpinBox.setMaximum(10000.0)
        self.tCenter2YSpinBox.setObjectName("tCenter2YSpinBox")
        self.horizontalLayout_10.addWidget(self.tCenter2YSpinBox)
        self.tCenter2ZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter2ZSpinBox.setMinimum(-10000.0)
        self.tCenter2ZSpinBox.setMaximum(10000.0)
        self.tCenter2ZSpinBox.setObjectName("tCenter2ZSpinBox")
        self.horizontalLayout_10.addWidget(self.tCenter2ZSpinBox)
        spacerItem5 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_10.addItem(spacerItem5)
        self.gridLayout_4.addLayout(self.horizontalLayout_10, 4, 0, 1, 1)
        self.horizontalLayout_6 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_6.setObjectName("horizontalLayout_6")
        self.label_6 = QtWidgets.QLabel(self.groupBox_3)
        self.label_6.setObjectName("label_6")
        self.horizontalLayout_6.addWidget(self.label_6)
        self.tRadiusSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tRadiusSpinBox.setMaximum(10000.0)
        self.tRadiusSpinBox.setObjectName("tRadiusSpinBox")
        self.horizontalLayout_6.addWidget(self.tRadiusSpinBox)
        spacerItem6 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_6.addItem(spacerItem6)
        self.gridLayout_4.addLayout(self.horizontalLayout_6, 0, 0, 1, 1)
        self.horizontalLayout_7 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_7.setObjectName("horizontalLayout_7")
        self.label_7 = QtWidgets.QLabel(self.groupBox_3)
        self.label_7.setObjectName("label_7")
        self.horizontalLayout_7.addWidget(self.label_7)
        self.tAbsorpSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tAbsorpSpinBox.setMaximum(10000.0)
        self.tAbsorpSpinBox.setObjectName("tAbsorpSpinBox")
        self.horizontalLayout_7.addWidget(self.tAbsorpSpinBox)
        spacerItem7 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_7.addItem(spacerItem7)
        self.gridLayout_4.addLayout(self.horizontalLayout_7, 1, 0, 1, 1)
        self.horizontalLayout_8 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_8.setObjectName("horizontalLayout_8")
        self.label_8 = QtWidgets.QLabel(self.groupBox_3)
        self.label_8.setObjectName("label_8")
        self.horizontalLayout_8.addWidget(self.label_8)
        self.tScatterSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tScatterSpinBox.setMaximum(10000.0)
        self.tScatterSpinBox.setObjectName("tScatterSpinBox")
        self.horizontalLayout_8.addWidget(self.tScatterSpinBox)
        spacerItem8 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_8.addItem(spacerItem8)
        self.gridLayout_4.addLayout(self.horizontalLayout_8, 2, 0, 1, 1)
        self.horizontalLayout_9 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_9.setObjectName("horizontalLayout_9")
        self.label_9 = QtWidgets.QLabel(self.groupBox_3)
        self.label_9.setObjectName("label_9")
        self.horizontalLayout_9.addWidget(self.label_9)
        self.tCenter1XSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter1XSpinBox.setMinimum(-10000.0)
        self.tCenter1XSpinBox.setMaximum(10000.0)
        self.tCenter1XSpinBox.setObjectName("tCenter1XSpinBox")
        self.horizontalLayout_9.addWidget(self.tCenter1XSpinBox)
        self.tCenter1YSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter1YSpinBox.setMinimum(-10000.0)
        self.tCenter1YSpinBox.setMaximum(10000.0)
        self.tCenter1YSpinBox.setObjectName("tCenter1YSpinBox")
        self.horizontalLayout_9.addWidget(self.tCenter1YSpinBox)
        self.tCenter1ZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_3)
        self.tCenter1ZSpinBox.setMinimum(-10000.0)
        self.tCenter1ZSpinBox.setMaximum(10000.0)
        self.tCenter1ZSpinBox.setObjectName("tCenter1ZSpinBox")
        self.horizontalLayout_9.addWidget(self.tCenter1ZSpinBox)
        spacerItem9 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_9.addItem(spacerItem9)
        self.gridLayout_4.addLayout(self.horizontalLayout_9, 3, 0, 1, 1)
        self.verticalLayout.addWidget(self.groupBox_3)
        self.gridLayout_9.addWidget(self.groupBox, 0, 1, 3, 1)
        self.graphicsView = QtWidgets.QGraphicsView(self.frame_2)
        self.graphicsView.setObjectName("graphicsView")
        self.gridLayout_9.addWidget(self.graphicsView, 0, 0, 1, 1)
        self.groupBox_4 = QtWidgets.QGroupBox(self.frame_2)
        self.groupBox_4.setObjectName("groupBox_4")
        self.gridLayout_6 = QtWidgets.QGridLayout(self.groupBox_4)
        self.gridLayout_6.setObjectName("gridLayout_6")
        self.horizontalLayout_5 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_5.setObjectName("horizontalLayout_5")
        self.label = QtWidgets.QLabel(self.groupBox_4)
        self.label.setObjectName("label")
        self.horizontalLayout_5.addWidget(self.label)
        self.pNumSpinBox = QtWidgets.QSpinBox(self.groupBox_4)
        self.pNumSpinBox.setInputMethodHints(QtCore.Qt.ImhDigitsOnly)
        self.pNumSpinBox.setButtonSymbols(QtWidgets.QAbstractSpinBox.UpDownArrows)
        self.pNumSpinBox.setMaximum(1000000000)
        self.pNumSpinBox.setProperty("value", 0)
        self.pNumSpinBox.setObjectName("pNumSpinBox")
        self.horizontalLayout_5.addWidget(self.pNumSpinBox)
        spacerItem10 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_5.addItem(spacerItem10)
        self.gridLayout_6.addLayout(self.horizontalLayout_5, 0, 0, 1, 1)
        self.horizontalLayout_12 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_12.setObjectName("horizontalLayout_12")
        self.label_11 = QtWidgets.QLabel(self.groupBox_4)
        self.label_11.setObjectName("label_11")
        self.horizontalLayout_12.addWidget(self.label_11)
        self.pLookAtXSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pLookAtXSpinBox.setMinimum(-10000.0)
        self.pLookAtXSpinBox.setMaximum(10000.0)
        self.pLookAtXSpinBox.setObjectName("pLookAtXSpinBox")
        self.horizontalLayout_12.addWidget(self.pLookAtXSpinBox)
        self.pLookAtYSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pLookAtYSpinBox.setMinimum(-10000.0)
        self.pLookAtYSpinBox.setMaximum(10000.0)
        self.pLookAtYSpinBox.setObjectName("pLookAtYSpinBox")
        self.horizontalLayout_12.addWidget(self.pLookAtYSpinBox)
        self.pLookAtZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pLookAtZSpinBox.setMinimum(-10000.0)
        self.pLookAtZSpinBox.setMaximum(10000.0)
        self.pLookAtZSpinBox.setObjectName("pLookAtZSpinBox")
        self.horizontalLayout_12.addWidget(self.pLookAtZSpinBox)
        spacerItem11 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_12.addItem(spacerItem11)
        self.gridLayout_6.addLayout(self.horizontalLayout_12, 3, 0, 1, 1)
        self.horizontalLayout_11 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_11.setObjectName("horizontalLayout_11")
        self.label_5 = QtWidgets.QLabel(self.groupBox_4)
        self.label_5.setObjectName("label_5")
        self.horizontalLayout_11.addWidget(self.label_5)
        self.pPosXSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pPosXSpinBox.setMinimum(-10000.0)
        self.pPosXSpinBox.setMaximum(10000.0)
        self.pPosXSpinBox.setObjectName("pPosXSpinBox")
        self.horizontalLayout_11.addWidget(self.pPosXSpinBox)
        self.pPosYSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pPosYSpinBox.setMinimum(-10000.0)
        self.pPosYSpinBox.setMaximum(10000.0)
        self.pPosYSpinBox.setObjectName("pPosYSpinBox")
        self.horizontalLayout_11.addWidget(self.pPosYSpinBox)
        self.pPosZSpinBox = QtWidgets.QDoubleSpinBox(self.groupBox_4)
        self.pPosZSpinBox.setMinimum(-10000.0)
        self.pPosZSpinBox.setMaximum(10000.0)
        self.pPosZSpinBox.setObjectName("pPosZSpinBox")
        self.horizontalLayout_11.addWidget(self.pPosZSpinBox)
        spacerItem12 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_11.addItem(spacerItem12)
        self.gridLayout_6.addLayout(self.horizontalLayout_11, 1, 0, 1, 1)
        self.horizontalLayout_13 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_13.setObjectName("horizontalLayout_13")
        self.pPosComboBox = QtWidgets.QComboBox(self.groupBox_4)
        self.pPosComboBox.setObjectName("pPosComboBox")
        self.pPosComboBox.addItem("")
        self.pPosComboBox.addItem("")
        self.horizontalLayout_13.addWidget(self.pPosComboBox)
        spacerItem13 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_13.addItem(spacerItem13)
        self.gridLayout_6.addLayout(self.horizontalLayout_13, 2, 0, 1, 1)
        self.horizontalLayout_16 = QtWidgets.QHBoxLayout()
        self.horizontalLayout_16.setObjectName("horizontalLayout_16")
        self.pLookAtCheckBox = QtWidgets.QCheckBox(self.groupBox_4)
        self.pLookAtCheckBox.setObjectName("pLookAtCheckBox")
        self.horizontalLayout_16.addWidget(self.pLookAtCheckBox)
        spacerItem14 = QtWidgets.QSpacerItem(40, 20, QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Minimum)
        self.horizontalLayout_16.addItem(spacerItem14)
        self.gridLayout_6.addLayout(self.horizontalLayout_16, 4, 0, 1, 1)
        self.gridLayout_9.addWidget(self.groupBox_4, 1, 0, 1, 1)
        self.groupBox_5 = QtWidgets.QGroupBox(self.frame_2)
        self.groupBox_5.setObjectName("groupBox_5")
        self.gridLayout_8 = QtWidgets.QGridLayout(self.groupBox_5)
        self.gridLayout_8.setObjectName("gridLayout_8")
        self.horizontalLayout = QtWidgets.QHBoxLayout()
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.label_12 = QtWidgets.QLabel(self.groupBox_5)
        self.label_12.setObjectName("label_12")
        self.horizontalLayout.addWidget(self.label_12)
        self.cThreadsSlider = QtWidgets.QSlider(self.groupBox_5)
        self.cThreadsSlider.setMinimum(32)
        self.cThreadsSlider.setMaximum(1024)
        self.cThreadsSlider.setSingleStep(32)
        self.cThreadsSlider.setPageStep(256)
        self.cThreadsSlider.setOrientation(QtCore.Qt.Horizontal)
        self.cThreadsSlider.setTickPosition(QtWidgets.QSlider.NoTicks)
        self.cThreadsSlider.setTickInterval(32)
        self.cThreadsSlider.setObjectName("cThreadsSlider")
        self.horizontalLayout.addWidget(self.cThreadsSlider)
        self.cThreadsLabel = QtWidgets.QLabel(self.groupBox_5)
        self.cThreadsLabel.setObjectName("cThreadsLabel")
        self.horizontalLayout.addWidget(self.cThreadsLabel)
        self.gridLayout_8.addLayout(self.horizontalLayout, 0, 1, 1, 1)
        self.gridLayout_9.addWidget(self.groupBox_5, 2, 0, 2, 1)
        self.frame_3 = QtWidgets.QFrame(self.frame_2)
        self.frame_3.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_3.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_3.setObjectName("frame_3")
        self.gridLayout_7 = QtWidgets.QGridLayout(self.frame_3)
        self.gridLayout_7.setObjectName("gridLayout_7")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout()
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.buildBtn = QtWidgets.QPushButton(self.frame_3)
        self.buildBtn.setObjectName("buildBtn")
        self.verticalLayout_2.addWidget(self.buildBtn)
        self.runBtn = QtWidgets.QPushButton(self.frame_3)
        self.runBtn.setEnabled(False)
        self.runBtn.setObjectName("runBtn")
        self.verticalLayout_2.addWidget(self.runBtn)
        self.gridLayout_7.addLayout(self.verticalLayout_2, 0, 0, 1, 1)
        self.gridLayout_9.addWidget(self.frame_3, 3, 1, 1, 1)
        self.frame_4 = QtWidgets.QFrame(self.splitter)
        self.frame_4.setMinimumSize(QtCore.QSize(0, 100))
        self.frame_4.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_4.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_4.setObjectName("frame_4")
        self.gridLayout_10 = QtWidgets.QGridLayout(self.frame_4)
        self.gridLayout_10.setObjectName("gridLayout_10")
        self.outputPlainTextEdit = QtWidgets.QPlainTextEdit(self.frame_4)
        self.outputPlainTextEdit.setReadOnly(True)
        self.outputPlainTextEdit.setObjectName("outputPlainTextEdit")
        self.gridLayout_10.addWidget(self.outputPlainTextEdit, 1, 0, 1, 1)
        self.gridLayout_3.addWidget(self.splitter, 0, 0, 1, 1)
        self.tabWidget.addTab(self.tab, "")
        self.tab_2 = QtWidgets.QWidget()
        self.tab_2.setObjectName("tab_2")
        self.gridLayout_11 = QtWidgets.QGridLayout(self.tab_2)
        self.gridLayout_11.setObjectName("gridLayout_11")
        self.frame_5 = QtWidgets.QFrame(self.tab_2)
        self.frame_5.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.frame_5.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_5.setObjectName("frame_5")
        self.gridLayout_12 = QtWidgets.QGridLayout(self.frame_5)
        self.gridLayout_12.setObjectName("gridLayout_12")
        self.splitter_2 = QtWidgets.QSplitter(self.frame_5)
        self.splitter_2.setOrientation(QtCore.Qt.Vertical)
        self.splitter_2.setObjectName("splitter_2")
        self.frame_6 = QtWidgets.QFrame(self.splitter_2)
        self.frame_6.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.frame_6.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_6.setObjectName("frame_6")
        self.gridLayout_13 = QtWidgets.QGridLayout(self.frame_6)
        self.gridLayout_13.setObjectName("gridLayout_13")
        self.frame_8 = QtWidgets.QFrame(self.frame_6)
        self.frame_8.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_8.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_8.setObjectName("frame_8")
        self.gridLayout_14 = QtWidgets.QGridLayout(self.frame_8)
        self.gridLayout_14.setObjectName("gridLayout_14")
        self.verticalLayout_7 = QtWidgets.QVBoxLayout()
        self.verticalLayout_7.setObjectName("verticalLayout_7")
        self.label_13 = QtWidgets.QLabel(self.frame_8)
        self.label_13.setTextFormat(QtCore.Qt.RichText)
        self.label_13.setAlignment(QtCore.Qt.AlignCenter)
        self.label_13.setObjectName("label_13")
        self.verticalLayout_7.addWidget(self.label_13)
        self.photonsPlotWidget = MplWidget3D(self.frame_8)
        self.photonsPlotWidget.setStyleSheet("")
        self.photonsPlotWidget.setObjectName("photonsPlotWidget")
        self.verticalLayout_7.addWidget(self.photonsPlotWidget)
        self.gridLayout_14.addLayout(self.verticalLayout_7, 0, 0, 1, 1)
        self.verticalLayout_4 = QtWidgets.QVBoxLayout()
        self.verticalLayout_4.setObjectName("verticalLayout_4")
        self.label_15 = QtWidgets.QLabel(self.frame_8)
        self.label_15.setTextFormat(QtCore.Qt.RichText)
        self.label_15.setAlignment(QtCore.Qt.AlignCenter)
        self.label_15.setObjectName("label_15")
        self.verticalLayout_4.addWidget(self.label_15)
        self.terminatedPlotWidget = MplWidget3D(self.frame_8)
        self.terminatedPlotWidget.setStyleSheet("")
        self.terminatedPlotWidget.setObjectName("terminatedPlotWidget")
        self.verticalLayout_4.addWidget(self.terminatedPlotWidget)
        self.gridLayout_14.addLayout(self.verticalLayout_4, 1, 0, 1, 1)
        self.gridLayout_13.addWidget(self.frame_8, 0, 0, 1, 1)
        self.frame_9 = QtWidgets.QFrame(self.frame_6)
        self.frame_9.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_9.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_9.setObjectName("frame_9")
        self.gridLayout_15 = QtWidgets.QGridLayout(self.frame_9)
        self.gridLayout_15.setObjectName("gridLayout_15")
        self.verticalLayout_5 = QtWidgets.QVBoxLayout()
        self.verticalLayout_5.setObjectName("verticalLayout_5")
        self.label_16 = QtWidgets.QLabel(self.frame_9)
        self.label_16.setTextFormat(QtCore.Qt.RichText)
        self.label_16.setAlignment(QtCore.Qt.AlignCenter)
        self.label_16.setObjectName("label_16")
        self.verticalLayout_5.addWidget(self.label_16)
        self.escapedPlotWidget = MplWidget3D(self.frame_9)
        self.escapedPlotWidget.setStyleSheet("")
        self.escapedPlotWidget.setObjectName("escapedPlotWidget")
        self.verticalLayout_5.addWidget(self.escapedPlotWidget)
        self.gridLayout_15.addLayout(self.verticalLayout_5, 1, 0, 1, 1)
        self.verticalLayout_3 = QtWidgets.QVBoxLayout()
        self.verticalLayout_3.setObjectName("verticalLayout_3")
        self.label_14 = QtWidgets.QLabel(self.frame_9)
        self.label_14.setTextFormat(QtCore.Qt.RichText)
        self.label_14.setAlignment(QtCore.Qt.AlignCenter)
        self.label_14.setObjectName("label_14")
        self.verticalLayout_3.addWidget(self.label_14)
        self.detectedPlotWidget = MplWidget3D(self.frame_9)
        self.detectedPlotWidget.setSizeIncrement(QtCore.QSize(1, 1))
        self.detectedPlotWidget.setStyleSheet("")
        self.detectedPlotWidget.setObjectName("detectedPlotWidget")
        self.verticalLayout_3.addWidget(self.detectedPlotWidget)
        self.gridLayout_15.addLayout(self.verticalLayout_3, 0, 0, 1, 1)
        self.gridLayout_13.addWidget(self.frame_9, 0, 1, 1, 1)
        self.frame_7 = QtWidgets.QFrame(self.splitter_2)
        self.frame_7.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame_7.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame_7.setObjectName("frame_7")
        self.gridLayout_16 = QtWidgets.QGridLayout(self.frame_7)
        self.gridLayout_16.setObjectName("gridLayout_16")
        self.verticalLayout_6 = QtWidgets.QVBoxLayout()
        self.verticalLayout_6.setObjectName("verticalLayout_6")
        self.label_17 = QtWidgets.QLabel(self.frame_7)
        self.label_17.setAlignment(QtCore.Qt.AlignCenter)
        self.label_17.setObjectName("label_17")
        self.verticalLayout_6.addWidget(self.label_17)
        self.detectedPhotonsDistributionPlotWidget = MplWidget(self.frame_7)
        self.detectedPhotonsDistributionPlotWidget.setStyleSheet("")
        self.detectedPhotonsDistributionPlotWidget.setObjectName("detectedPhotonsDistributionPlotWidget")
        self.verticalLayout_6.addWidget(self.detectedPhotonsDistributionPlotWidget)
        self.gridLayout_16.addLayout(self.verticalLayout_6, 0, 0, 1, 1)
        self.verticalLayout_8 = QtWidgets.QVBoxLayout()
        self.verticalLayout_8.setObjectName("verticalLayout_8")
        self.label_18 = QtWidgets.QLabel(self.frame_7)
        self.label_18.setAlignment(QtCore.Qt.AlignCenter)
        self.label_18.setObjectName("label_18")
        self.verticalLayout_8.addWidget(self.label_18)
        self.samplingDistributionPlotWidget = MplWidget(self.frame_7)
        self.samplingDistributionPlotWidget.setObjectName("samplingDistributionPlotWidget")
        self.verticalLayout_8.addWidget(self.samplingDistributionPlotWidget)
        self.gridLayout_16.addLayout(self.verticalLayout_8, 0, 1, 1, 1)
        self.gridLayout_12.addWidget(self.splitter_2, 0, 0, 1, 1)
        self.gridLayout_11.addWidget(self.frame_5, 0, 0, 1, 1)
        self.tabWidget.addTab(self.tab_2, "")
        self.tab_3 = QtWidgets.QWidget()
        self.tab_3.setObjectName("tab_3")
        self.tabWidget.addTab(self.tab_3, "")
        self.tab_4 = QtWidgets.QWidget()
        self.tab_4.setObjectName("tab_4")
        self.tabWidget.addTab(self.tab_4, "")
        self.tab_5 = QtWidgets.QWidget()
        self.tab_5.setObjectName("tab_5")
        self.tabWidget.addTab(self.tab_5, "")
        self.gridLayout.addWidget(self.tabWidget, 0, 0, 1, 1)
        self.gridLayout_2.addWidget(self.frame, 0, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)
        self.menuBar = QtWidgets.QMenuBar(MainWindow)
        self.menuBar.setGeometry(QtCore.QRect(0, 0, 803, 22))
        self.menuBar.setObjectName("menuBar")
        self.menuFile = QtWidgets.QMenu(self.menuBar)
        self.menuFile.setObjectName("menuFile")
        self.menuEdit = QtWidgets.QMenu(self.menuBar)
        self.menuEdit.setObjectName("menuEdit")
        self.menuView = QtWidgets.QMenu(self.menuBar)
        self.menuView.setObjectName("menuView")
        self.menuFill_with_Sample_parameters = QtWidgets.QMenu(self.menuView)
        self.menuFill_with_Sample_parameters.setObjectName("menuFill_with_Sample_parameters")
        self.menuAbout = QtWidgets.QMenu(self.menuBar)
        self.menuAbout.setObjectName("menuAbout")
        self.menuAbout_2 = QtWidgets.QMenu(self.menuBar)
        self.menuAbout_2.setObjectName("menuAbout_2")
        MainWindow.setMenuBar(self.menuBar)
        self.actionplaceholder = QtWidgets.QAction(MainWindow)
        self.actionplaceholder.setObjectName("actionplaceholder")
        self.actionplaceholder_2 = QtWidgets.QAction(MainWindow)
        self.actionplaceholder_2.setObjectName("actionplaceholder_2")
        self.actionSample1 = QtWidgets.QAction(MainWindow)
        self.actionSample1.setObjectName("actionSample1")
        self.actionSample2 = QtWidgets.QAction(MainWindow)
        self.actionSample2.setObjectName("actionSample2")
        self.actionSample3 = QtWidgets.QAction(MainWindow)
        self.actionSample3.setObjectName("actionSample3")
        self.actionSample4 = QtWidgets.QAction(MainWindow)
        self.actionSample4.setObjectName("actionSample4")
        self.actionSample = QtWidgets.QAction(MainWindow)
        self.actionSample.setObjectName("actionSample")
        self.actionSample1_2 = QtWidgets.QAction(MainWindow)
        self.actionSample1_2.setObjectName("actionSample1_2")
        self.actionSample2_2 = QtWidgets.QAction(MainWindow)
        self.actionSample2_2.setObjectName("actionSample2_2")
        self.actionSample3_3 = QtWidgets.QAction(MainWindow)
        self.actionSample3_3.setObjectName("actionSample3_3")
        self.menuFile.addAction(self.actionplaceholder)
        self.menuFile.addAction(self.actionplaceholder_2)
        self.menuFill_with_Sample_parameters.addAction(self.actionSample)
        self.menuFill_with_Sample_parameters.addAction(self.actionSample1_2)
        self.menuFill_with_Sample_parameters.addAction(self.actionSample2_2)
        self.menuFill_with_Sample_parameters.addAction(self.actionSample3_3)
        self.menuView.addAction(self.menuFill_with_Sample_parameters.menuAction())
        self.menuBar.addAction(self.menuFile.menuAction())
        self.menuBar.addAction(self.menuEdit.menuAction())
        self.menuBar.addAction(self.menuView.menuAction())
        self.menuBar.addAction(self.menuAbout.menuAction())
        self.menuBar.addAction(self.menuAbout_2.menuAction())

        self.retranslateUi(MainWindow)
        self.tabWidget.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "RandomWalk - CUDA"))
        self.groupBox.setTitle(_translate("MainWindow", "Enviroment Setup"))
        self.groupBox_2.setTitle(_translate("MainWindow", "Detector"))
        self.label_3.setText(_translate("MainWindow", "Position"))
        self.label_4.setText(_translate("MainWindow", "LookAt"))
        self.dPosComboBox.setItemText(0, _translate("MainWindow", "Free"))
        self.dPosComboBox.setItemText(1, _translate("MainWindow", "Stick to Center #1"))
        self.dPosComboBox.setItemText(2, _translate("MainWindow", "Stick to Center #2"))
        self.label_2.setText(_translate("MainWindow", "Radius"))
        self.dLookAtCheckBox.setText(_translate("MainWindow", "LookAt Tissue"))
        self.groupBox_3.setTitle(_translate("MainWindow", "Tissue"))
        self.label_10.setText(_translate("MainWindow", "Center #2"))
        self.label_6.setText(_translate("MainWindow", "Radius"))
        self.label_7.setText(_translate("MainWindow", "Absorption Coefficient"))
        self.label_8.setText(_translate("MainWindow", "Scattering Coefficient"))
        self.label_9.setText(_translate("MainWindow", "Center #1"))
        self.groupBox_4.setTitle(_translate("MainWindow", "Photon Source"))
        self.label.setText(_translate("MainWindow", "# Photons"))
        self.label_11.setText(_translate("MainWindow", "LookAt"))
        self.label_5.setText(_translate("MainWindow", "Position"))
        self.pPosComboBox.setItemText(0, _translate("MainWindow", "Free"))
        self.pPosComboBox.setItemText(1, _translate("MainWindow", "Emit from Detector\'s Center"))
        self.pLookAtCheckBox.setText(_translate("MainWindow", "Normal to Detector\'s Screen"))
        self.groupBox_5.setTitle(_translate("MainWindow", "CUDA"))
        self.label_12.setText(_translate("MainWindow", "#Threads/Block"))
        self.cThreadsLabel.setText(_translate("MainWindow", "32"))
        self.buildBtn.setText(_translate("MainWindow", "Build"))
        self.runBtn.setText(_translate("MainWindow", "Run"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab), _translate("MainWindow", "Execution"))
        self.label_13.setText(_translate("MainWindow", "Photons"))
        self.label_15.setText(_translate("MainWindow", "Terminated"))
        self.label_16.setText(_translate("MainWindow", "Escaped"))
        self.label_14.setText(_translate("MainWindow", "Detected"))
        self.label_17.setText(_translate("MainWindow", "Detected Photons Distribution"))
        self.label_18.setText(_translate("MainWindow", "Sampling Distribution"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_2), _translate("MainWindow", "Analytics"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_3), _translate("MainWindow", "Performance"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_4), _translate("MainWindow", "Tracking"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_5), _translate("MainWindow", "Network"))
        self.menuFile.setTitle(_translate("MainWindow", "File"))
        self.menuEdit.setTitle(_translate("MainWindow", "Edit"))
        self.menuView.setTitle(_translate("MainWindow", "Tools"))
        self.menuFill_with_Sample_parameters.setTitle(_translate("MainWindow", "Fill with Sample parameters"))
        self.menuAbout.setTitle(_translate("MainWindow", "View"))
        self.menuAbout_2.setTitle(_translate("MainWindow", "About"))
        self.actionplaceholder.setText(_translate("MainWindow", "placeholder"))
        self.actionplaceholder_2.setText(_translate("MainWindow", "placeholder"))
        self.actionSample1.setText(_translate("MainWindow", "Sample1"))
        self.actionSample2.setText(_translate("MainWindow", "Sample2"))
        self.actionSample3.setText(_translate("MainWindow", "Sample3"))
        self.actionSample4.setText(_translate("MainWindow", "Sample4"))
        self.actionSample.setText(_translate("MainWindow", "Sample"))
        self.actionSample1_2.setText(_translate("MainWindow", "Sample1"))
        self.actionSample2_2.setText(_translate("MainWindow", "Sample2"))
        self.actionSample3_3.setText(_translate("MainWindow", "Sample3"))
from mplwidget import MplWidget, MplWidget3D


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())
