import matplotlib

matplotlib.use("Agg")

import matplotlib.pyplot as plt
import numpy as np

plt.style.use("mnras_durham")

matplotlib.rcParams["font.sans-serif"] = ["Open Sans"]
matplotlib.rcParams["font.family"] = "sans-serif"
matplotlib.rcParams["font.size"] = 30 / 3
small_font_size = 18 / 3

figure = plt.figure(figsize=(11 / 3, 9 / 3))


def get_time(filename):
    first_try = np.loadtxt(filename, usecols=-2).sum()

    if first_try:
        return first_try / (60 * 1000)
    else:
        # Wrong column to read
        return np.loadtxt(filename, usecols=-1).sum() / (60 * 1000)


versions = [f"0.{x}.0" for x in [5, 6, 7, 8]]
threads = [2, 4, 8, 14, 28, 28 * 2, 28 * 4, 28 * 8]
output = [
    [get_time(f"output/{v}/timesteps_{t}.txt") for t in threads] for v in versions
]

plt.loglog()
plt.gca().set_xscale("log", basex=2)

# First, plot ideal scaling
x = np.linspace(threads[0], threads[-1], 1000)
y = 0.9 * threads[0] * output[-1][0] / x
plt.plot(x, y, linestyle="--", color="grey", label="Ideal scaling", zorder=-1000)

# Now, plot "other" info

# Production run line
plt.axvline(8, color="C0", zorder=-101, lw=1, linestyle="dotted", alpha=0.8)
plt.text(
    8,
    2,
    "Production Run Load",
    color="C0",
    rotation=90,
    va="bottom",
    ha="right",
    zorder=-101,
    alpha=0.8,
    fontsize=small_font_size,
)

# Multi-Node
x_in_between = 10 ** ((np.log10(28 * 2) + np.log10(28)) * 0.5)
plt.axvline(x_in_between, color="C1", alpha=0.8, zorder=-102, lw=1, linestyle="-.")
plt.text(
    x_in_between,
    90,
    r"Single Node $\uparrow$",
    rotation=90,
    va="top",
    ha="right",
    color="C1",
    alpha=0.8,
    fontsize=small_font_size,
)
plt.text(
    x_in_between,
    90,
    r"$\uparrow$ Multi-Node",
    rotation=270,
    va="top",
    ha="left",
    color="C1",
    alpha=0.8,
    fontsize=small_font_size,
)


# Finally we can plot the real data!
c = 0
for version, times in zip(versions, output):
    plt.scatter(threads, times, s=4, color=f"C{c}", zorder=c)
    plt.plot(threads, times, label=f"v{version}", color=f"C{c}", lw=1.5, zorder=c)
    c += 1

plt.xticks(threads, threads)

plt.ylim(bottom=min([x[-1] for x in output]) * 0.7)

plt.legend(frameon=False, markerfirst=False, fontsize=small_font_size * 1.2)
plt.xlabel("Threads")
plt.ylabel("Time-to-solution [mins]")

plt.tight_layout()

plt.savefig("runtime_scaling.pdf")
