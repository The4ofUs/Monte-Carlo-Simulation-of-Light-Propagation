import pandas as pd
import matplotlib.pyplot as plt

cpu_data0 = pd.read_csv('../results/cpu_results_p1000_a1_s100.csv')
cpu_data1 = pd.read_csv('../results/cpu_results_p1000_a10_s100.csv')
cpu_data2 = pd.read_csv('../results/cpu_results_p1000_a100_s100.csv')
cpu_data3 = pd.read_csv('../results/cpu_results_p1000_a1000_s100.csv')
cpu_data4 = pd.read_csv('../results/cpu_results_p10000_a1_s100.csv')
cpu_data5 = pd.read_csv('../results/cpu_results_p10000_a10_s100.csv')
cpu_data6 = pd.read_csv('../results/cpu_results_p10000_a100_s100.csv')
cpu_data7 = pd.read_csv('../results/cpu_results_p10000_a1000_s100.csv')
gpu_data0 = pd.read_csv('../results/gpu_results_p1000_a1_s100.csv')
gpu_data1 = pd.read_csv('../results/gpu_results_p1000_a10_s100.csv')
gpu_data2 = pd.read_csv('../results/gpu_results_p1000_a100_s100.csv')
gpu_data3 = pd.read_csv('../results/gpu_results_p1000_a1000_s100.csv')
gpu_data4 = pd.read_csv('../results/gpu_results_p10000_a1_s100.csv')
gpu_data5 = pd.read_csv('../results/gpu_results_p10000_a10_s100.csv')
gpu_data6 = pd.read_csv('../results/gpu_results_p10000_a100_s100.csv')
gpu_data7 = pd.read_csv('../results/gpu_results_p10000_a1000_s100.csv')
cpu_detected_0 = cpu_data0[cpu_data0['State'] == 'DETECTED']
cpu_detected_1 = cpu_data1[cpu_data1['State'] == 'DETECTED']
cpu_detected_2 = cpu_data2[cpu_data2['State'] == 'DETECTED']
cpu_detected_3 = cpu_data3[cpu_data3['State'] == 'DETECTED']
cpu_detected_4 = cpu_data4[cpu_data4['State'] == 'DETECTED']
cpu_detected_5 = cpu_data5[cpu_data5['State'] == 'DETECTED']
cpu_detected_6 = cpu_data6[cpu_data6['State'] == 'DETECTED']
cpu_detected_7 = cpu_data7[cpu_data7['State'] == 'DETECTED']
gpu_detected_0 = gpu_data0[gpu_data0['State'] == 'DETECTED']
gpu_detected_1 = gpu_data1[gpu_data1['State'] == 'DETECTED']
gpu_detected_2 = gpu_data2[gpu_data2['State'] == 'DETECTED']
gpu_detected_3 = gpu_data3[gpu_data3['State'] == 'DETECTED']
gpu_detected_4 = gpu_data4[gpu_data4['State'] == 'DETECTED']
gpu_detected_5 = gpu_data5[gpu_data5['State'] == 'DETECTED']
gpu_detected_6 = gpu_data6[gpu_data6['State'] == 'DETECTED']
gpu_detected_7 = gpu_data7[gpu_data7['State'] == 'DETECTED']
RADIUS = 10
MARGIN = 5
ABSORPTION_CONSTANT = 1
SCATTERING_CONSTANT = 100

fig = plt.figure(figsize=(plt.figaspect(2)))
detector0 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector1 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector2 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector3 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector4 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector5 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector6 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector7 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector8 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector9 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector10 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector11 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector12 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector13 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector14 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
detector15 = plt.Circle((0,0), RADIUS, color='black', fill=False, linestyle='dotted')
# ------------------------------------------------------------------------------------------
ax00 = fig.add_subplot(4, 4, 1)
ax00.set_title('GPU | Ma = 1 | # = 1000')
gpu_detected_0.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax00, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax00.add_artist(detector0)
ax00.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax01 = fig.add_subplot(4, 4, 2)
ax01.set_title('CPU | Ma = 1 | # = 1000')
cpu_detected_0.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax01, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax01.add_artist(detector1)
ax01.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax10 = fig.add_subplot(4, 4, 3)
ax10.set_title('GPU | Ma = 10 | # = 1000')
gpu_detected_1.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax10, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax10.add_artist(detector2)
ax10.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax11 = fig.add_subplot(4, 4, 4)
ax11.set_title('CPU | Ma = 10 | # = 1000')
cpu_detected_1.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax11, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax11.add_artist(detector3)
ax11.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax20 = fig.add_subplot(4, 4, 5)
ax20.set_title('GPU | Ma = 100 | # = 1000')
gpu_detected_2.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax20, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax20.add_artist(detector4)
ax20.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax21 = fig.add_subplot(4, 4, 6)
ax21.set_title('CPU | Ma = 100 | # = 1000')
cpu_detected_2.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax21, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax21.add_artist(detector5)
ax21.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax30 = fig.add_subplot(4, 4, 7)
ax30.set_title('GPU | Ma = 1000 | # = 1000')
gpu_detected_3.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax30, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax30.add_artist(detector6)
ax30.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax31 = fig.add_subplot(4, 4, 8)
ax31.set_title('CPU | Ma = 1000 | # = 1000')
cpu_detected_3.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax31, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax31.add_artist(detector7)
ax31.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax40 = fig.add_subplot(4, 4, 9)
ax40.set_title('GPU | Ma = 1 | # = 10000')
gpu_detected_4.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax40, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax40.add_artist(detector8)
ax40.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax41 = fig.add_subplot(4, 4, 10)
ax41.set_title('CPU | Ma = 1 | # = 10000')
cpu_detected_4.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax41, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax41.add_artist(detector9)
ax41.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax50 = fig.add_subplot(4, 4, 11)
ax50.set_title('GPU | Ma = 10 | # = 10000')
gpu_detected_5.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax50, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax50.add_artist(detector10)
ax50.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax51 = fig.add_subplot(4, 4, 12)
ax51.set_title('CPU | Ma = 10 | # = 10000')
cpu_detected_5.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax51, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax51.add_artist(detector11)
ax51.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax60 = fig.add_subplot(4, 4, 13)
ax60.set_title('GPU | Ma = 100 | # = 10000')
gpu_detected_6.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax60, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax60.add_artist(detector12)
ax60.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax61 = fig.add_subplot(4, 4, 14)
ax61.set_title('CPU | Ma = 100 | # = 10000')
cpu_detected_6.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax61, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax61.add_artist(detector13)
ax61.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------
ax70 = fig.add_subplot(4, 4, 15)
ax70.set_title('GPU | Ma = 1000 | # = 10000')
gpu_detected_7.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax70, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax70.add_artist(detector14)
ax70.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
ax71 = fig.add_subplot(4, 4, 16)
ax71.set_title('CPU | Ma = 1000 | # = 10000')
cpu_detected_7.plot.scatter(x="X", y="Y", alpha=0.5,
                      c='Green', ax=ax71, marker='.').tick_params(axis='both', which='both', left=False,
                                                                 bottom=False,
                                                                 labelbottom=False, labelleft=False)
ax71.add_artist(detector15)
ax71.set(xlim=(-RADIUS - MARGIN, RADIUS + MARGIN), ylim=(-RADIUS - MARGIN, RADIUS + MARGIN), xlabel="", ylabel="")
# -------------------------------------------------------------------------------------------

plt.show()

