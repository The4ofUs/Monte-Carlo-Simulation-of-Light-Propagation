import csv
import tkinter
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import math
import numpy as np

DETECTED = 1
TERMINATED = -1
ESCAPED = 2


def absolute_distance(p1, p2):
    x = p2.x - p1.x
    y = p2.y - p1.y
    z = p2.z - p2.z
    return x * x + y * y + z * z


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
        self.metadata = {}
        with open(csv_file, 'r', newline='') as file:
            reader = csv.reader(file)
            for header in reader:   # Meta-data
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
                print(self.metadata.__str__())
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


def plot(p, d, t, e):
    fig = plt.figure()

    collective = fig.add_subplot(221, projection='3d')
    collective.title.set_text('Photons' + ' | ' + str(len(p)))

    detected = fig.add_subplot(222, projection='3d')
    detected.title.set_text('Detected Photons' + ' | ' + str(len(d)))

    terminated = fig.add_subplot(223, projection='3d')
    terminated.title.set_text('Terminated Photons' + ' | ' + str(len(t)))

    escaped = fig.add_subplot(224, projection='3d')
    escaped.title.set_text('Escaped Photons' + ' | ' + str(len(e)))

    collective.scatter([photon.position[0] for photon in p], [photon.position[1] for photon in p],
                       [photon.position[2] for photon in p], c='b', marker='o')
    detected.scatter([d_photon.position[0] for d_photon in d], [d_photon.position[1] for d_photon in d],
                     [d_photon.position[2] for d_photon in d], c='g', marker='o')
    terminated.scatter([t_photon.position[0] for t_photon in t], [t_photon.position[1] for t_photon in t],
                       [t_photon.position[2] for t_photon in t], c='r', marker='o')
    escaped.scatter([e_photon.position[0] for e_photon in e], [e_photon.position[1] for e_photon in e],
                    [e_photon.position[2] for e_photon in e], c='y', marker='o')

    collective.set_xlabel('X')
    collective.set_ylabel('Y')
    collective.set_zlabel('Z')

    detected.set_xlabel('X')
    detected.set_ylabel('Y')
    detected.set_zlabel('Z')

    terminated.set_xlabel('X')
    terminated.set_ylabel('Y')
    terminated.set_zlabel('Z')

    escaped.set_xlabel('X')
    escaped.set_ylabel('Y')
    escaped.set_zlabel('Z')

    plt.show()


extractor = Extractor("/home/mustafa/3D-Random-Walk-CUDA/build/output.csv")
plot(extractor.photons, extractor.detected, extractor.terminated, extractor.escaped)
