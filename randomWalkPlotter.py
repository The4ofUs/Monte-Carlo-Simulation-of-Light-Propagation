import csv
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

vertical = [-55, 55]
horizontal = [-55, 55]
depth = [-55, 55]

fig = plt.figure(1)
collective = fig.add_subplot(221, projection='3d')
collective.set_zlim(vertical)
collective.set_xlim(horizontal)
collective.set_ylim(depth)
collective.title.set_text('Photons')
detected = fig.add_subplot(222, projection='3d')
detected.set_zlim(vertical)
detected.set_xlim(horizontal)
detected.set_ylim(depth)
detected.title.set_text('Detected Photons')
terminated = fig.add_subplot(223, projection='3d')
terminated.set_zlim(vertical)
terminated.set_xlim(horizontal)
terminated.set_ylim(depth)
terminated.title.set_text('Terminated Photons')
escaped = fig.add_subplot(224, projection='3d')
escaped.set_zlim(vertical)
escaped.set_xlim(horizontal)
escaped.set_ylim(depth)
escaped.title.set_text('Escaped Photons')

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

with open('build/output.csv', 'r', newline='') as file:
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

plt.show()
