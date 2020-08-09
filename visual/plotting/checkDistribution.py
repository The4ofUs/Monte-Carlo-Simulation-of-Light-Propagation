import matplotlib.pyplot as plt
import csv

x = []

with open('build/random.csv', 'r', newline='') as file:
    reader = csv.reader(file)
    for row in reader:
        x.append(float(row[0]))
n, bins, patches = plt.hist(x, 15, facecolor='blue', alpha=0.5)
plt.show()