import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import csv

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

data = csv.reader(open('build/output.csv', 'r'), delimiter=",", quotechar='|')

X = []
Y = []
Z = []

for row in data:
    X.append(float(row[0]))
    Y.append(float(row[1]))
    Z.append(float(row[2]))

ax.scatter(X, Y, Z, c='r', marker='o')

ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

plt.show()
