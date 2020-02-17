from Extractor import Extractor
import os


def produceAnalytics(application):
    if application.pNum > 0:
        application.ui.photonsPlotWidget.canvas.ax.clear()
        application.ui.detectedPlotWidget.canvas.ax.clear()
        application.ui.terminatedPlotWidget.canvas.ax.clear()
        application.ui.escapedPlotWidget.canvas.ax.clear()
        application.ui.detectedPhotonsDistributionPlotWidget.canvas.ax.clear()
        application.ui.samplingDistributionPlotWidget.canvas.ax.clear()
        if os.path.isfile(os.getcwd() + '/output.csv'):
            dataExtractor = Extractor('output.csv')
            application.ui.photonsPlotWidget.canvas.ax.scatter([photon.position[0] for photon in dataExtractor.photons],
                                                               [photon.position[1] for photon in dataExtractor.photons],
                                                               [photon.position[2] for photon in dataExtractor.photons],
                                                               c='b',
                                                               marker='o')
            application.ui.detectedPlotWidget.canvas.ax.scatter([photon.position[0] for photon in dataExtractor.detected],
                                                                [photon.position[1] for photon in dataExtractor.detected],
                                                                [photon.position[2] for photon in dataExtractor.detected],
                                                                c='g', marker='o')
            application.ui.terminatedPlotWidget.canvas.ax.scatter(
                [photon.position[0] for photon in dataExtractor.terminated],
                [photon.position[1] for photon in dataExtractor.terminated],
                [photon.position[2] for photon in dataExtractor.terminated],
                c='r', marker='o')
            application.ui.escapedPlotWidget.canvas.ax.scatter([photon.position[0] for photon in dataExtractor.escaped],
                                                               [photon.position[1] for photon in dataExtractor.escaped],
                                                               [photon.position[2] for photon in dataExtractor.escaped],
                                                               c='y',
                                                               marker='o')
            application.ui.detectedPhotonsDistributionPlotWidget.canvas.ax.hist(dataExtractor.detectedPhotonsDistribution)
        else:
            application.logUpdates("Can't find output.csv in :" + os.getcwd())
    else:
        application.logUpdates("Are you going to tell me how many Photons should I take for a walk ?")
