import os
import subprocess

NUMBER_OF_TEST_RUNS = 100
total = 0


os.chdir('../build')
for i in range(NUMBER_OF_TEST_RUNS):
    cp = subprocess.run("./RandomWalk", universal_newlines=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    total += float(cp.stdout)

print(total/NUMBER_OF_TEST_RUNS)
