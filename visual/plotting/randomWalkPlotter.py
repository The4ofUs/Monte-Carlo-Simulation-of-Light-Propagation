import csv
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import math
import numpy as np
import seaborn as sns

vertical = [-55, 55]
horizontal = [-100, 100]
depth = [-100, 100]


class Point:
    x = 0
    y = 0
    z = 0

    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        pass


detectorCenter = Point(0.0, 0.0, 10.0)

fig = plt.figure(1)
fig2, ax = plt.subplots()

DETECTED = "DETECTED"
ESCAPED = "ESCAPED"
TERMINATED = "TERMINATED"

X = []
Y = []
Z = []
X_terminated = []
Y_terminated = []
Z_terminated = []
X_detected = []
Y_detected = []
Z_detected = []
X_escaped = []
Y_escaped = []
Z_escaped = []
detected_dist = []

with open('/home/gamila/Documents/GP/Task4-RandomWalkCUDA/Monte-Carlo-Simulation-of-Light-Propagation/MC_Simulation_CUDA/Network/build-ServerSide-Desktop-Debug/serverReceivedResults.csv', 'r', newline='') as file:
    has_header = csv.Sniffer().has_header(file.read(1024))
    file.seek(0)  # Rewind.
    reader = csv.reader(file)
    if has_header:
        next(reader)
    for row in reader:
        if row[4] == TERMINATED:
            X_terminated.append(float(row[0]))
            Y_terminated.append(float(row[1]))
            Z_terminated.append(float(row[2]))
        elif row[4] == DETECTED:
            X_detected.append(float(row[0]))
            Y_detected.append(float(row[1]))
            Z_detected.append(float(row[2]))
        elif row[4] == ESCAPED:
            X_escaped.append(float(row[0]))
            Y_escaped.append(float(row[1]))
            Z_escaped.append(float(row[2]))

        X.append(float(row[0]))
        Y.append(float(row[1]))
        Z.append(float(row[2]))

collective = fig.add_subplot(221, projection='3d')

collective.title.set_text('Photons' + ' | ' + str(len(X)))
detected = fig.add_subplot(222, projection='3d')

detected.title.set_text('Detected Photons' + ' | ' + str(len(X_detected)))
terminated = fig.add_subplot(223, projection='3d')

terminated.title.set_text('Terminated Photons' + ' | ' + str(len(X_terminated)))
escaped = fig.add_subplot(224, projection='3d')

escaped.title.set_text('Escaped Photons' + ' | ' + str(len(X_escaped)))

collective.scatter(X, Y, Z, c='b', marker='o')
detected.scatter(X_detected, Y_detected, Z_detected, c='g', marker='o')
terminated.scatter(X_terminated, Y_terminated, Z_terminated, c='r', marker='o')
escaped.scatter(X_escaped, Y_escaped, Z_escaped, c='y', marker='o')

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


def absDistance(x, y, z):
    temp1 = (x - detectorCenter.x) * (x - detectorCenter.x)
    temp2 = (y - detectorCenter.y) * (y - detectorCenter.y)
    temp3 = (z - detectorCenter.z) * (z - detectorCenter.z)
    result = math.sqrt((temp1 + temp2 + temp3))
    return result


for point in X_detected:
    index = X_detected.index(point)
    detected_dist.append(absDistance(X_detected[index], Y_detected[index], Z_detected[index]))
sns.set()
sns.distplot(detected_dist, bins=math.floor(len(detected_dist) / 5))

plt.show()
