import csv
import math

TERMINATED = -1
DETECTED = 1
ESCAPED = 2


def absolute_distance(p1, p2):
    x = p2[0] - p1[0]
    y = p2[1] - p1[1]
    z = p2[2] - p2[2]
    return math.sqrt(x * x + y * y + z * z)


class Photon:
    def __init__(self, position, weight, state):
        self.state = state
        self.position = position
        self.weight = weight


class Extractor:
    def __init__(self, csv_file):
        self.detected = []
        self.terminated = []
        self.escaped = []
        self.photons = []
        self.detectedPhotonsDistribution = []
        self.metadata = {}
        with open(csv_file, 'r', newline='') as file:
            reader = csv.reader(file)
            for header in reader:  # Meta-data
                self.metadata[header[5]] = int(header[6])
                self.metadata[header[7]] = int(header[8])
                self.metadata[header[9]] = float(header[10])
                self.metadata[header[11]] = [float(header[12]), float(header[13]), float(header[14])]
                self.metadata[header[15]] = [float(header[16]), float(header[17]), float(header[18])]
                self.metadata[header[19]] = float(header[20])
                self.metadata[header[21]] = float(header[22])
                self.metadata[header[23]] = float(header[24])
                self.metadata[header[25]] = [float(header[26]), float(header[27]), float(header[28])]
                self.metadata[header[29]] = [float(header[30]), float(header[31]), float(header[32])]
                break

            for row in reader:  # Photons data
                position = [float(row[0]), float(row[1]), float(row[2])]
                weight = row[3]
                photon = None
                if row[4] == "TERMINATED":
                    photon = Photon(position, weight, TERMINATED)
                    self.terminated.append(photon)
                elif row[4] == "DETECTED":
                    photon = Photon(position, weight, DETECTED)
                    self.detected.append(photon)
                elif row[4] == "ESCAPED":
                    photon = Photon(position, weight, ESCAPED)
                    self.escaped.append(photon)

                if photon is not None:
                    self.photons.append(photon)

        self.extractDetectedPhotonsDistribution()

    def extractDetectedPhotonsDistribution(self):
        for detectedPhoton in self.detected:
            self.detectedPhotonsDistribution.append(
                absolute_distance(self.metadata['detector_pos'], detectedPhoton.position))
        self.detectedPhotonsDistribution[:] = [value / max(self.detectedPhotonsDistribution) for value in self.detectedPhotonsDistribution]
