import matplotlib
matplotlib.use("Agg")

import matplotlib.pyplot as plt
import numpy as np

def get_time(filename):
    first_try = np.loadtxt(filename, usecols=-2).sum()

    if first_try:
        return first_try
    else:
        # Wrong column to read
        return np.loadtxt(filename, usecols=-1).sum()

versions = [f"0.{x}.0" for x in [5, 6, 7, 8]]
threads = [4, 8]
output = [[get_time(f"output/{v}/timesteps_{t}.txt") for t in threads] for v in versions]

plt.loglog()

for version, times in zip(versions, output):
    plt.plot(threads, times, label=version)

plt.legend()
plt.xlabel("Threads")
plt.ylabel("Runtime [ms]")

plt.savefig("runtime_scaling.pdf")
