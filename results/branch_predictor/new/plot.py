import matplotlib.pyplot as plt
import numpy as np
from matplotlib.ticker import AutoMinorLocator

plt.rcParams['font.size'] = '16'

supply_voltage = 1.2

def plot_power(filename, figure=None):
    if figure is None:
        figure = plt.figure()
    data = np.genfromtxt(filename, delimiter=",", skip_header=8)
    plt.plot(data[:, 0], 1e3*supply_voltage*data[:, 1], label=filename)

    #plt.ylim(0, 4)
    #plt.yticks(np.arange(0, 4.5, 0.5))
    #figure.axes[0].yaxis.set_minor_locator((AutoMinorLocator(5)))
    plt.grid(which='major', axis='y')

    plt.ylabel("Power (mW)")
    plt.xlabel("Index")
    plt.legend()
    plt.title("Supply power over time for different benchmark programs")
    plt.show()


def plot_digital(filename, figure=None, offset=0):
    if figure is None:
        figure = plt.figure()
    data = np.genfromtxt(filename, delimiter=",", skip_header=8)
    plt.plot(data[:, 0], data[:, 1] + offset, label=filename)
    plt.grid(axis='x')
    plt.ylabel("Signal")
    plt.xlabel("Time (s)")
    plt.legend()
    plt.title("Output signal on pin A2")
    plt.show()


def sorts_per_second(filename):
    data = np.genfromtxt(filename, delimiter=",", skip_header=8)
    time = data[:, 0]
    signal = data[:, 1]
    total_time = time[-1] - time[0]
    xor = np.logical_xor(signal[:-1], signal[1:])
    return xor.sum()/total_time


def time_per_sort(filename):
    return 1/sorts_per_second(filename)



file = "branch_o_timing.csv"
print(sorts_per_second(file))
print(time_per_sort(file))
plot_digital(file)
# plot_digital("blink_12pll_D_A2_800hz.csv")
# plt.show()
