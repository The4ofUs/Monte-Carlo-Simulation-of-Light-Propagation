import matplotlib.pyplot as plt
import  csv
import math
coeff1_time_cpu = []
coeff2_time_cpu = []
coeff3_time_cpu = []
coeff1_time_gpu = []
coeff2_time_gpu = []
coeff3_time_gpu = []

coeff1_N = []
coeff2_N = []
coeff3_N = []


# with open('metrics.csv', 'r', newline='') as file: #GPU file
#     file.seek(0)  # Rewind.
#     reader = csv.reader(file)
#     line_count = 0
#     for row in reader:
#         if  line_count % 3 == 0:
#             coeff1_time_gpu.append(float(row[2]))
#             line_count +=1
#         elif line_count % 3 == 1:
#             coeff2_time_gpu.append(float(row[2]))
#             line_count +=1
#         else:
#             coeff3_time_gpu.append(float(row[2]))
#             line_count +=1

with open('metrics.csv', 'r', newline='') as file: #CPU file
    file.seek(0)  # Rewind.
    reader = csv.reader(file)
    line_count = 0
    for row in reader:
        if  line_count % 3 == 0:
            coeff1_N.append(int(row[0]))
            # coeff1_time_cpu.append(math.log10(float(row[1])))
            # coeff1_time_gpu.append(math.log10(float(row[2])))
            coeff1_time_cpu.append(float(row[1]))
            coeff1_time_gpu.append(float(row[2]))
            line_count +=1
        elif line_count % 3 == 1:
            coeff2_N.append(int(row[0]))
            # coeff2_time_cpu.append(math.log10(float(row[1])))
            # coeff2_time_gpu.append(math.log10(float(row[2])))
            coeff2_time_cpu.append(float(row[1]))
            coeff2_time_gpu.append(float(row[2]))
            line_count +=1
        else:
            coeff3_N.append(int(row[0]))
            # coeff3_time_cpu.append(math.log10(float(row[1])))
            # coeff3_time_gpu.append(math.log10(float(row[2])))
            coeff3_time_cpu.append(float(row[1]))
            coeff3_time_gpu.append(float(row[2]))
            line_count +=1




# Now switch to a more OO interface to exercise more features.
fig, (ax_1, ax_2, ax_3) = plt.subplots(nrows=1, ncols=3)

ax_1.set_title('Ma = 100  , Ms = 100 ')
ax_1.plot(coeff1_time_cpu,coeff1_N, label = "CPU")
ax_1.plot(coeff1_time_gpu, coeff1_N, label = "GPU ")
ax_1.legend()
ax_1.set_xlabel('Time (ms)')
ax_1.set_ylabel('Number of photons')

ax_2.set_title('Ma = 1000 , Ms = 100')
ax_2.plot(coeff2_time_cpu,coeff1_N, label = "CPU")
ax_2.plot(coeff2_time_gpu, coeff1_N, label = "GPU ")
ax_2.legend()
ax_2.set_xlabel('Time (ms)')
ax_2.set_ylabel('Number of photons')

ax_3.set_title('Ma = 10000 , Ms = 100')
ax_3.plot(coeff3_time_cpu,coeff1_N, label = "CPU")
ax_3.plot(coeff3_time_gpu, coeff1_N, label = "GPU ")
ax_3.legend()
ax_3.set_xlabel('Time (ms)')
ax_3.set_ylabel('Number of photons')




fig.suptitle('')
plt.show()