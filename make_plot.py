import matplotlib
matplotlib.use("Agg")

import matplotlib.pyplot as plt
import numpy as np

def get_time(filename):
    first_try = np.loadtxt(filename, usecols=-2).sum()

    if first_try:
        return first_try / (60 * 1000)
    else:
        # Wrong column to read
        return np.loadtxt(filename, usecols=-1).sum() / (60 * 1000)

versions = [f"0.{x}.0" for x in [5, 6, 7, 8]]
threads = [2, 4, 8, 14, 28]
output = [[get_time(f"output/{v}/timesteps_{t}.txt") for t in threads] for v in versions]

plt.loglog()

for version, times in zip(versions, output):
    plt.plot(threads, times, label=version)

plt.xticks(threads, threads)

plt.legend()
plt.xlabel("Threads")
plt.ylabel("Runtime [mins]")

plt.savefig("runtime_scaling.pdf")
