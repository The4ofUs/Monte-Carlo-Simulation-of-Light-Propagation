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
            coeff1_time_cpu.append(math.log10(float(row[1])))
            coeff1_time_gpu.append(math.log10(float(row[2])))
            # coeff1_time_cpu.append(float(row[1]))
            # coeff1_time_gpu.append(float(row[2]))
            line_count +=1
        elif line_count % 3 == 1:
            coeff2_N.append(int(row[0]))
            coeff2_time_cpu.append(math.log10(float(row[1])))
            coeff2_time_gpu.append(math.log10(float(row[2])))
            # coeff2_time_cpu.append(float(row[1]))
            # coeff2_time_gpu.append(float(row[2]))
            line_count +=1
        else:
            coeff3_N.append(int(row[0]))
            coeff3_time_cpu.append(math.log10(float(row[1])))
            coeff3_time_gpu.append(math.log10(float(row[2])))
            # coeff3_time_cpu.append(float(row[1]))
            # coeff3_time_gpu.append(float(row[2]))
            line_count +=1
    # print(coeff1_time_cpu)
    # print(coeff1_time_gpu)
    # print(coeff2_time_cpu)
    # print(coeff2_time_gpu)
    # print(coeff3_time_cpu)
    # print(coeff3_time_gpu)




# Now switch to a more OO interface to exercise more features.
fig, (ax_1, ax_2, ax_3) = plt.subplots(nrows=1, ncols=3)
# plt.xticks(fontsize =15)
# plt.yticks(fontsize =15)
# fig= plt.figure()
# ax_1 = fig.add_subplot(111)

ax_1.set_title('Ma = 100  , Ms = 100',  fontsize = 20)
ax_1.plot(coeff1_time_cpu,coeff1_N, label = "CPU", linewidth =4)
ax_1.plot(coeff1_time_gpu, coeff1_N, label = "GPU ", linewidth =4)
ax_1.legend()
ax_1.set_xlabel('(a)', fontsize = 20)
ax_1.set_ylabel('Number of photons', fontsize = 20)
ax_1.tick_params(labelsize =15)
ax_2.set_title('Ma = 1000 , Ms = 100', fontsize = 20)
ax_2.plot(coeff2_time_cpu,coeff1_N, label = "CPU", linewidth =4)
ax_2.plot(coeff2_time_gpu, coeff1_N, label = "GPU ", linewidth =4)
#ax_2.legend()
ax_2.set_xlabel('(b)'+ '\n'+'Time', fontsize = 20)
#ax_2.set_ylabel('Numb er of photons', fontsize = 20)
ax_2.tick_params(labelsize =15)


ax_3.set_title('Ma = 10000 , Ms = 100',  fontsize = 20)
ax_3.plot(coeff3_time_cpu,coeff1_N, label = "CPU", linewidth =4)
ax_3.plot(coeff3_time_gpu, coeff1_N, label = "GPU ", linewidth =4)
#ax_3.legend()
ax_3.set_xlabel('(c)', fontsize = 20)
#ax_3.set_ylabel('Number of photons',fontsize = 20)
ax_3.tick_params(labelsize =15)





fig.suptitle('')
plt.show()