import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import csv

fig = plt.figure(1)
collective = fig.add_subplot(221, projection='3d')
detected = fig.add_subplot(222, projection='3d')
terminated = fig.add_subplot(223, projection='3d')
escaped = fig.add_subplot(224, projection='3d')

data = csv.reader(open('build/output.csv', 'r'), delimiter=",", quotechar='|')

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


for row in data:
    if int(row[3]) == -1:
        X_terminated.append(float(row[0]))
        Y_terminated.append(float(row[1]))
        Z_terminated.append(float(row[2]))
    elif int(row[3]) == 0:
        X_detected.append(float(row[0]))
        Y_detected.append(float(row[1]))
        Z_detected.append(float(row[2]))
    elif int(row[3]) == 2:
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
