from PyQt5 import QtCore, QtGui, QtWidgets
from minimal import Ui_MainWindow
import math
import sys


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
        self.ui.buildBtn.clicked.connect(self.printAll)

    def detectorRadiusEntry(self):
        self.dRadius = float(self.ui.dRadiusSpinBox.text())

    def detectorPosEntry(self, index, spinBox):
        self.dPosition[index] = spinBox.value()
        if self.ui.pPosComboBox.currentIndex() != 0:
            self.sourcePosLockIn()

    def detectorPosLockIn(self):
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
        self.dLookAt[index] = spinBox.value()
        if self.ui.pLookAtCheckBox.isChecked():
            self.sourceLookAtLockIn()

    def detectorLookAtLockIn(self):
        if self.ui.dLookAtCheckBox.isChecked():
            self.ui.dLookAtXSpinBox.setValue(self.tCenter1[0])
            self.ui.dLookAtYSpinBox.setValue(self.tCenter1[1])
            self.ui.dLookAtZSpinBox.setValue(self.tCenter1[2])
            self.ui.dLookAtXSpinBox.setReadOnly(True)
            self.ui.dLookAtYSpinBox.setReadOnly(True)
            self.ui.dLookAtZSpinBox.setReadOnly(True)
        else:
            self.ui.dLookAtXSpinBox.setReadOnly(False)
            self.ui.dLookAtYSpinBox.setReadOnly(False)
            self.ui.dLookAtZSpinBox.setReadOnly(False)

    def tissueRadiusEntry(self):
        self.tRadius = self.ui.tRadiusSpinBox.value()

    def tissueAbsorpEntry(self):
        self.tAbsorpCoeff = self.ui.tAbsorpSpinBox.value()

    def tissueScatterEntry(self):
        self.tScatterCoeff = self.ui.tScatterSpinBox.value()

    def tissueCenter1Entry(self, index, spinBox):
        self.tCenter1[index] = spinBox.value()
        if self.ui.dPosComboBox.currentIndex() != 0:
            self.detectorPosLockIn()
        if self.ui.dLookAtCheckBox.isChecked():
            self.detectorLookAtLockIn()

    def tissueCenter2Entry(self, index, spinBox):
        self.tCenter2[index] = spinBox.value()
        if self.ui.dPosComboBox.currentIndex() != 0:
            self.detectorPosLockIn()

    def sourcePhotonNumEntry(self):
        self.pNum = self.ui.pNumSpinBox.value()

    def sourcePosEntry(self, index, spinBox):
        self.pPosition[index] = spinBox.value()

    def sourcePosLockIn(self):
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
        self.pLookAt[index] = spinBox.value()

    def sourceLookAtLockIn(self):
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
        value = self.ui.cThreadsSlider.value()
        step = math.floor(value / 32)
        self.ui.cThreadsSlider.setValue(step * 32)
        self.cThreadNum = self.ui.cThreadsSlider.value()
        self.updateSliderLabel(self.ui.cThreadsSlider.value())

    def updateSliderLabel(self, value):
        self.ui.cThreadsLabel.setText(str(value))

    def printAll(self):
        print("Detector\n" + "Radius = " + str(self.dRadius) + "\n" + "Position= ( " + str(self.dPosition[0]) + ", " +
              str(self.dPosition[1]) + ", " + str(self.dPosition[2]) + " )\n" + "LookAt = ( " + str(
            self.dLookAt[0]) + ", " +
              str(self.dLookAt[1]) + ", " + str(self.dLookAt[2]) + " )\n")
        print("Tissue\n" + "Radius = " + str(self.tRadius) + "\n" + "Absorption Coefficient = " + str(
            self.tAbsorpCoeff) + "\n" +
              "Scatter Coefficient = " + str(self.tScatterCoeff) + "\n" + "Center #1 = ( " + str(
            self.tCenter1[0]) + ", " +
              str(self.tCenter1[1]) + ", " + str(self.tCenter1[2]) + " )\n" + "Center #2 = ( " + str(
            self.tCenter2[0]) + ", " +
              str(self.tCenter2[1]) + ", " + str(self.tCenter2[2]) + " )\n")
        print("Photon Source\n" + "# Photons = " + str(self.pNum) + "\n" + "Position = ( " + str(
            self.pPosition[0]) + ", " +
              str(self.pPosition[1]) + ", " + str(self.pPosition[2]) + " )\n" + "LookAt = ( " + str(
            self.pLookAt[0]) + ", " +
              str(self.pLookAt[1]) + ", " + str(self.pLookAt[2]) + " )\n")
        print("CUDA\n" + "# Threads/Block = " + str(self.cThreadNum))
        self.ui.runBtn.setEnabled(True)


def main():
    app = QtWidgets.QApplication(sys.argv)
    application = ApplicationWindow()
    application.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
