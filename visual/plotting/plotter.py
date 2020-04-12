import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
from mpl_toolkits.mplot3d import Axes3D

#OUTPUT_DIRECTORY = "/home/rania/gp/Monte-Carlo-Simulation-of-Light-Propagation/cuda/build/results.csv"
OUTPUT_DIRECTORY = "/home/gamila/branchRania/Monte-Carlo-Simulation-of-Light-Propagation/cuda/build/results.csv"
RADIUS = 100
MARGIN = 5
DETECTOR_CENTER = (0, 0, 50)


data = pd.read_csv(OUTPUT_DIRECTORY)
total = data[["X", "Y", "Z"]]
detected = data.loc[data["State"] == "DETECTED", ["X", "Y", "Z"]]
terminated = data.loc[data["State"] == "TERMINATED", ["X", "Y", "Z"]]
escaped = data.loc[data["State"] == "ESCAPED", ["X", "Y", "Z"]]
fig = plt.figure(figsize=(plt.figaspect(.5)))
#fig.suptitle('Ma = {}  |   Ms = {}'.format(ABSORPTION_CONSTANT,SCATTERING_CONSTANT), fontsize=16)
fig.canvas.set_window_title("Monte Carlo Simulation")
# 3D Plots
ax1 = fig.add_subplot(231, projection='3d')
ax1.scatter(total['X'], total['Y'], total['Z'], c='b', marker='.')
ax1.set_title('Photons | {}'.format(total.shape[0]))
ax2 = fig.add_subplot(2, 3, 5, projection='3d')
ax2.scatter(terminated['X'], terminated['Y'], terminated['Z'], c='red', marker='.')
ax2.set_title('Terminated | {}'.format(terminated.shape[0]))
ax3 = fig.add_subplot(2, 3, 2, projection='3d')
ax3.scatter(detected['X'], detected['Y'], detected['Z'], c='green', marker='.')
ax3.set_title('Detected | {}'.format(detected.shape[0]))
ax4 = fig.add_subplot(234, projection='3d')
ax4.scatter(escaped['X'], escaped['Y'], escaped['Z'], c='black', marker='.')
ax4.set_title('Escaped | {}'.format(escaped.shape[0]))
# Profile
ax6 = fig.add_subplot(2, 3, 3)
detected.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax6, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
detector = plt.Circle((DETECTOR_CENTER[0], DETECTOR_CENTER[1]), RADIUS, color='black', fill=False, linestyle='dotted')
ax6.add_artist(detector)
ax6.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")

# Distribution
data["Distances"] = (((detected["X"] - DETECTOR_CENTER[0]) ** 2) + ((detected["Y"] - DETECTOR_CENTER[1]) ** 2) + (
        (detected["Z"] - DETECTOR_CENTER[2]) ** 2)) ** 0.5
ax5 = fig.add_subplot(2, 3, 6)
distribution = data["Distances"] - data["Distances"].mean()
sns.set(style="white", palette="muted", color_codes=True)
sns.despine(left=True)
sns.distplot(distribution, hist=False, ax=ax5, color='g', kde_kws={"shade": True})
ax5.tick_params(axis='both', which='both', left=False, bottom=False, labelleft=False)
#ax5.set(xlim=(-20, 20))
ax5.set(xlim=(-RADIUS, RADIUS))

plt.show()
