import math
import sys

from PyQt5 import QtWidgets

from minimal import Ui_MainWindow
import commands


class ApplicationWindow(QtWidgets.QMainWindow):
    def __init__(self):
        super(ApplicationWindow, self).__init__()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.configSignals()
        # Detector
        self.dRadius = None
        self.dPosition = []
        self.dLookAt = []
        # Tissue
        self.tRadius = None
        self.tAbsorpCoeff = None
        self.tScatterCoeff = None
        self.tCenter1 = []
        self.tCenter2 = []
        self.tTarget = []
        # Photon Source
        self.pNum = None
        self.pPosition = []
        self.pLookAt = []
        # CUDA
        self.cThreadNum = None
        self.setDefaultValues()

    def setDefaultValues(self):
        self.dRadius = self.ui.dRadiusSpinBox.value()
        self.dPosition.append(self.ui.dPosXSpinBox.value())
        self.dPosition.append(self.ui.dPosYSpinBox.value())
        self.dPosition.append(self.ui.dPosZSpinBox.value())
        self.dLookAt.append(self.ui.dLookAtXSpinBox.value())
        self.dLookAt.append(self.ui.dLookAtYSpinBox.value())
        self.dLookAt.append(self.ui.dLookAtZSpinBox.value())
        self.tRadius = self.ui.tRadiusSpinBox.value()
        self.tAbsorpCoeff = self.ui.tAbsorpSpinBox.value()
        self.tScatterCoeff = self.ui.tScatterSpinBox.value()
        self.tCenter1.append(self.ui.tCenter1XSpinBox.value())
        self.tCenter1.append(self.ui.tCenter1YSpinBox.value())
        self.tCenter1.append(self.ui.tCenter1ZSpinBox.value())
        self.tCenter2.append(self.ui.tCenter2XSpinBox.value())
        self.tCenter2.append(self.ui.tCenter2YSpinBox.value())
        self.tCenter2.append(self.ui.tCenter2ZSpinBox.value())
        self.pNum = self.ui.pNumSpinBox.value()
        self.pPosition.append(self.ui.pPosXSpinBox.value())
        self.pPosition.append(self.ui.pPosYSpinBox.value())
        self.pPosition.append(self.ui.pPosZSpinBox.value())
        self.pLookAt.append(self.ui.pLookAtXSpinBox.value())
        self.pLookAt.append(self.ui.pLookAtYSpinBox.value())
        self.pLookAt.append(self.ui.pLookAtZSpinBox.value())
        self.cThreadNum = self.ui.cThreadsSlider.value()

    def configSignals(self):
        self.ui.actionSample.triggered.connect(lambda: self.actionSampleTriggered(0))
        self.ui.actionSample1_2.triggered.connect(lambda: self.actionSampleTriggered(1))
        self.ui.actionSample2_2.triggered.connect(lambda: self.actionSampleTriggered(2))
        self.ui.actionSample3_3.triggered.connect(lambda: self.actionSampleTriggered(3))
        self.ui.dRadiusSpinBox.valueChanged.connect(self.detectorRadiusEntry)
        self.ui.dPosXSpinBox.valueChanged.connect(lambda: self.detectorPosEntry(0, self.ui.dPosXSpinBox))
        self.ui.dPosYSpinBox.valueChanged.connect(lambda: self.detectorPosEntry(1, self.ui.dPosYSpinBox))
        self.ui.dPosZSpinBox.valueChanged.connect(lambda: self.detectorPosEntry(2, self.ui.dPosZSpinBox))
        self.ui.dPosComboBox.currentIndexChanged.connect(self.detectorPosLockIn)
        self.ui.dLookAtXSpinBox.valueChanged.connect(lambda: self.detectorLookAtEntry(0, self.ui.dLookAtXSpinBox))
        self.ui.dLookAtYSpinBox.valueChanged.connect(lambda: self.detectorLookAtEntry(1, self.ui.dLookAtYSpinBox))
        self.ui.dLookAtZSpinBox.valueChanged.connect(lambda: self.detectorLookAtEntry(2, self.ui.dLookAtZSpinBox))
        self.ui.dLookAtCheckBox.stateChanged.connect(self.detectorLookAtLockIn)
        self.ui.tRadiusSpinBox.valueChanged.connect(self.tissueRadiusEntry)
        self.ui.tAbsorpSpinBox.valueChanged.connect(self.tissueAbsorpEntry)
        self.ui.tScatterSpinBox.valueChanged.connect(self.tissueScatterEntry)
        self.ui.tCenter1XSpinBox.valueChanged.connect(lambda: self.tissueCenter1Entry(0, self.ui.tCenter1XSpinBox))
        self.ui.tCenter1YSpinBox.valueChanged.connect(lambda: self.tissueCenter1Entry(1, self.ui.tCenter1YSpinBox))
        self.ui.tCenter1ZSpinBox.valueChanged.connect(lambda: self.tissueCenter1Entry(2, self.ui.tCenter1ZSpinBox))
        self.ui.tCenter2XSpinBox.valueChanged.connect(lambda: self.tissueCenter2Entry(0, self.ui.tCenter2XSpinBox))
        self.ui.tCenter2YSpinBox.valueChanged.connect(lambda: self.tissueCenter2Entry(1, self.ui.tCenter2YSpinBox))
        self.ui.tCenter2ZSpinBox.valueChanged.connect(lambda: self.tissueCenter2Entry(2, self.ui.tCenter2ZSpinBox))
        self.ui.pNumSpinBox.valueChanged.connect(self.sourcePhotonNumEntry)
        self.ui.pPosXSpinBox.valueChanged.connect(lambda: self.sourcePosEntry(0, self.ui.pPosXSpinBox))
        self.ui.pPosYSpinBox.valueChanged.connect(lambda: self.sourcePosEntry(1, self.ui.pPosYSpinBox))
        self.ui.pPosZSpinBox.valueChanged.connect(lambda: self.sourcePosEntry(2, self.ui.pPosZSpinBox))
        self.ui.pPosComboBox.currentIndexChanged.connect(self.sourcePosLockIn)
        self.ui.pLookAtXSpinBox.valueChanged.connect(lambda: self.sourceLookAtEntry(0, self.ui.pLookAtXSpinBox))
        self.ui.pLookAtYSpinBox.valueChanged.connect(lambda: self.sourceLookAtEntry(1, self.ui.pLookAtYSpinBox))
        self.ui.pLookAtZSpinBox.valueChanged.connect(lambda: self.sourceLookAtEntry(2, self.ui.pLookAtZSpinBox))
        self.ui.pLookAtCheckBox.stateChanged.connect(self.sourceLookAtLockIn)
        self.ui.cThreadsSlider.valueChanged.connect(self.quantizeSlider)
        self.ui.buildBtn.clicked.connect(self.buildBtnClicked)
        self.ui.runBtn.clicked.connect(self.runBtnClicked)

    def actionSampleTriggered(self, index):
        if index == 0:
            self.ui.dRadiusSpinBox.setValue(10.0)
            self.ui.dPosComboBox.setCurrentIndex(1)
            self.ui.dLookAtCheckBox.setChecked(True)
            self.ui.tRadiusSpinBox.setValue(50.0)
            self.ui.tAbsorpSpinBox.setValue(1.0)
            self.ui.tScatterSpinBox.setValue(100.0)
            self.ui.tCenter1XSpinBox.setValue(0.0)
            self.ui.tCenter1YSpinBox.setValue(0.0)
            self.ui.tCenter1ZSpinBox.setValue(10.0)
            self.ui.tCenter2XSpinBox.setValue(0.0)
            self.ui.tCenter2YSpinBox.setValue(0.0)
            self.ui.tCenter2ZSpinBox.setValue(-10.0)
            self.ui.pNumSpinBox.setValue(1000)
            self.ui.pPosComboBox.setCurrentIndex(1)
            self.ui.pLookAtCheckBox.setChecked(True)
            self.ui.cThreadsSlider.setValue(1024)
        elif index == 1:
            self.ui.dRadiusSpinBox.setValue(10.0)
            self.ui.dPosComboBox.setCurrentIndex(1)
            self.ui.dLookAtCheckBox.setChecked(True)
            self.ui.tRadiusSpinBox.setValue(50.0)
            self.ui.tAbsorpSpinBox.setValue(1.0)
            self.ui.tScatterSpinBox.setValue(100.0)
            self.ui.tCenter1XSpinBox.setValue(10.0)
            self.ui.tCenter1YSpinBox.setValue(0.0)
            self.ui.tCenter1ZSpinBox.setValue(0.0)
            self.ui.tCenter2XSpinBox.setValue(-10.0)
            self.ui.tCenter2YSpinBox.setValue(0.0)
            self.ui.tCenter2ZSpinBox.setValue(0.0)
            self.ui.pNumSpinBox.setValue(1000)
            self.ui.pPosComboBox.setCurrentIndex(1)
            self.ui.pLookAtCheckBox.setChecked(True)
            self.ui.cThreadsSlider.setValue(512)
        elif index == 2:
            self.ui.dRadiusSpinBox.setValue(10.0)
            self.ui.dPosComboBox.setCurrentIndex(1)
            self.ui.dLookAtCheckBox.setChecked(True)
            self.ui.tRadiusSpinBox.setValue(50.0)
            self.ui.tAbsorpSpinBox.setValue(1.0)
            self.ui.tScatterSpinBox.setValue(100.0)
            self.ui.tCenter1XSpinBox.setValue(0.0)
            self.ui.tCenter1YSpinBox.setValue(10.0)
            self.ui.tCenter1ZSpinBox.setValue(0.0)
            self.ui.tCenter2XSpinBox.setValue(0.0)
            self.ui.tCenter2YSpinBox.setValue(-10.0)
            self.ui.tCenter2ZSpinBox.setValue(0.0)
            self.ui.pNumSpinBox.setValue(1000)
            self.ui.pPosComboBox.setCurrentIndex(1)
            self.ui.pLookAtCheckBox.setChecked(True)
            self.ui.cThreadsSlider.setValue(256)
        elif index == 3:
            self.ui.dRadiusSpinBox.setValue(10.0)
            self.ui.dPosComboBox.setCurrentIndex(1)
            self.ui.dLookAtCheckBox.setChecked(True)
            self.ui.tRadiusSpinBox.setValue(50.0)
            self.ui.tAbsorpSpinBox.setValue(1.0)
            self.ui.tScatterSpinBox.setValue(100.0)
            self.ui.tCenter1XSpinBox.setValue(10.0)
            self.ui.tCenter1YSpinBox.setValue(10.0)
            self.ui.tCenter1ZSpinBox.setValue(10.0)
            self.ui.tCenter2XSpinBox.setValue(-10.0)
            self.ui.tCenter2YSpinBox.setValue(-10.0)
            self.ui.tCenter2ZSpinBox.setValue(-10.0)
            self.ui.pNumSpinBox.setValue(1000)
            self.ui.pPosComboBox.setCurrentIndex(1)
            self.ui.pLookAtCheckBox.setChecked(True)
            self.ui.cThreadsSlider.setValue(128)

    def detectorRadiusEntry(self):
        self.ui.runBtn.setEnabled(True)
        self.dRadius = float(self.ui.dRadiusSpinBox.text())

    def detectorPosEntry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.dPosition[index] = spinBox.value()
        if self.ui.pPosComboBox.currentIndex() != 0:
            self.sourcePosLockIn()

    def detectorPosLockIn(self):
        self.ui.runBtn.setEnabled(True)
        currentIndex = self.ui.dPosComboBox.currentIndex()
        if currentIndex == 1:
            self.ui.dPosXSpinBox.setValue(self.tCenter1[0])
            self.ui.dPosYSpinBox.setValue(self.tCenter1[1])
            self.ui.dPosZSpinBox.setValue(self.tCenter1[2])
            self.ui.dPosXSpinBox.setReadOnly(True)
            self.ui.dPosYSpinBox.setReadOnly(True)
            self.ui.dPosZSpinBox.setReadOnly(True)
        elif currentIndex == 2:
            self.ui.dPosXSpinBox.setValue(self.tCenter2[0])
            self.ui.dPosYSpinBox.setValue(self.tCenter2[1])
            self.ui.dPosZSpinBox.setValue(self.tCenter2[2])
            self.ui.dPosXSpinBox.setReadOnly(True)
            self.ui.dPosYSpinBox.setReadOnly(True)
            self.ui.dPosZSpinBox.setReadOnly(True)
        else:
            self.ui.dPosXSpinBox.setReadOnly(False)
            self.ui.dPosYSpinBox.setReadOnly(False)
            self.ui.dPosZSpinBox.setReadOnly(False)

    def detectorLookAtEntry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.dLookAt[index] = spinBox.value()
        if self.ui.pLookAtCheckBox.isChecked():
            self.sourceLookAtLockIn()

    def detectorLookAtLockIn(self):
        self.ui.runBtn.setEnabled(True)
        if self.ui.dLookAtCheckBox.isChecked():
            if self.dPosition == self.tCenter2:
                self.ui.dLookAtXSpinBox.setValue(self.tCenter1[0])
                self.ui.dLookAtYSpinBox.setValue(self.tCenter1[1])
                self.ui.dLookAtZSpinBox.setValue(self.tCenter1[2])
                self.ui.dLookAtXSpinBox.setReadOnly(True)
                self.ui.dLookAtYSpinBox.setReadOnly(True)
                self.ui.dLookAtZSpinBox.setReadOnly(True)
            else:
                self.ui.dLookAtXSpinBox.setValue(self.tCenter2[0])
                self.ui.dLookAtYSpinBox.setValue(self.tCenter2[1])
                self.ui.dLookAtZSpinBox.setValue(self.tCenter2[2])
                self.ui.dLookAtXSpinBox.setReadOnly(True)
                self.ui.dLookAtYSpinBox.setReadOnly(True)
                self.ui.dLookAtZSpinBox.setReadOnly(True)
        else:
            self.ui.dLookAtXSpinBox.setReadOnly(False)
            self.ui.dLookAtYSpinBox.setReadOnly(False)
            self.ui.dLookAtZSpinBox.setReadOnly(False)

    def tissueRadiusEntry(self):
        self.ui.runBtn.setEnabled(True)
        self.tRadius = self.ui.tRadiusSpinBox.value()

    def tissueAbsorpEntry(self):
        self.ui.runBtn.setEnabled(True)
        self.tAbsorpCoeff = self.ui.tAbsorpSpinBox.value()

    def tissueScatterEntry(self):
        self.ui.runBtn.setEnabled(True)
        self.tScatterCoeff = self.ui.tScatterSpinBox.value()

    def tissueCenter1Entry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.tCenter1[index] = spinBox.value()
        if self.ui.dPosComboBox.currentIndex() != 0:
            self.detectorPosLockIn()
        if self.ui.dLookAtCheckBox.isChecked():
            self.detectorLookAtLockIn()

    def tissueCenter2Entry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.tCenter2[index] = spinBox.value()
        if self.ui.dPosComboBox.currentIndex() != 0:
            self.detectorPosLockIn()
        if self.ui.dLookAtCheckBox.isChecked():
            self.detectorLookAtLockIn()

    def sourcePhotonNumEntry(self):
        self.ui.runBtn.setEnabled(True)
        self.pNum = self.ui.pNumSpinBox.value()

    def sourcePosEntry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.pPosition[index] = spinBox.value()

    def sourcePosLockIn(self):
        self.ui.runBtn.setEnabled(True)
        if self.ui.pPosComboBox.currentIndex() != 0:
            self.ui.pPosXSpinBox.setValue(self.dPosition[0])
            self.ui.pPosYSpinBox.setValue(self.dPosition[1])
            self.ui.pPosZSpinBox.setValue(self.dPosition[2])
            self.ui.pPosXSpinBox.setReadOnly(True)
            self.ui.pPosYSpinBox.setReadOnly(True)
            self.ui.pPosZSpinBox.setReadOnly(True)
        else:
            self.ui.pPosXSpinBox.setReadOnly(False)
            self.ui.pPosYSpinBox.setReadOnly(False)
            self.ui.pPosZSpinBox.setReadOnly(False)

    def sourceLookAtEntry(self, index, spinBox):
        self.ui.runBtn.setEnabled(True)
        self.pLookAt[index] = spinBox.value()

    def sourceLookAtLockIn(self):
        self.ui.runBtn.setEnabled(True)
        if self.ui.pLookAtCheckBox.isChecked():
            self.ui.pLookAtXSpinBox.setValue(self.dLookAt[0])
            self.ui.pLookAtYSpinBox.setValue(self.dLookAt[1])
            self.ui.pLookAtZSpinBox.setValue(self.dLookAt[2])
            self.ui.pLookAtXSpinBox.setReadOnly(True)
            self.ui.pLookAtYSpinBox.setReadOnly(True)
            self.ui.pLookAtZSpinBox.setReadOnly(True)
        else:
            self.ui.pLookAtXSpinBox.setReadOnly(False)
            self.ui.pLookAtYSpinBox.setReadOnly(False)
            self.ui.pLookAtZSpinBox.setReadOnly(False)

    def quantizeSlider(self):
        self.ui.runBtn.setEnabled(True)
        value = self.ui.cThreadsSlider.value()
        step = math.floor(value / 32)
        self.ui.cThreadsSlider.setValue(step * 32)
        self.cThreadNum = self.ui.cThreadsSlider.value()
        self.updateSliderLabel(self.ui.cThreadsSlider.value())

    def updateSliderLabel(self, value):
        self.ui.cThreadsLabel.setText(str(value))

    def buildBtnClicked(self):
        self.ui.buildBtn.setDisabled(True)
        commands.buildRW(self)

    def runBtnClicked(self):
        self.ui.runBtn.setDisabled(True)
        commands.runRW(self)

    def logUpdates(self, text):
        self.ui.outputPlainTextEdit.appendPlainText(text)

    def logClear(self):
        self.ui.outputPlainTextEdit.clear()

    def enableAll(self):
        self.ui.environmentGroupBox.setEnabled(True)
        self.ui.pSourceGroupBox.setEnabled(True)
        self.ui.cudaGroupBox.setEnabled(True)
        self.ui.runBtn.setEnabled(True)
        self.ui.menuTools.setEnabled(True)


def main():
    app = QtWidgets.QApplication(sys.argv)
    application = ApplicationWindow()
    application.show()
    ret = app.exec_()
    commands.deleteBuildDir()
    sys.exit(ret)


if __name__ == "__main__":
    main()
