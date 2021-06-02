import matplotlib.pyplot as plt
import numpy as np
from matplotlib.ticker import AutoMinorLocator

plt.rcParams['font.size'] = '16'

supply_voltage = 1.2


def fix_fractional_seconds(fractional_seconds):
    for i in range(len(fractional_seconds) - 1):
        if fractional_seconds[i] > fractional_seconds[i+1]:
            fractional_seconds[i+1:] += 1
    fractional_seconds -= fractional_seconds[0]
    return fractional_seconds


<<<<<<< HEAD
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
=======
def plot(powerfile, digitalfile, title, timeoffset=0):
    if powerfile is not None:
        power_data = np.genfromtxt(powerfile, delimiter=",", skip_header=8)
        power = 1e3*supply_voltage*power_data[:, 1]
        power_time = fix_fractional_seconds(power_data[:, -1])
  
    
    if digitalfile is not None:
        digital_data = np.genfromtxt(digitalfile, delimiter=",", skip_header=8)
        value = digital_data[:, 1]
        digital_time = digital_data[:, 0]
        digital_time -= digital_time[0] - timeoffset
    
    fig = plt.figure()
    grid = fig.add_gridspec(6, 1)
    axes = [fig.add_subplot(grid[:-1, 0]), fig.add_subplot(grid[-1, 0])]
    
    axes[0].sharex(axes[1])

    axes[0].plot(power_time, power)
    axes[0].set_ylabel("Power consumption (mW)")
    axes[0].grid('major', 'major')
    axes[0].yaxis.set_minor_locator(AutoMinorLocator(5))

    axes[1].plot(digital_time, value)
    axes[1].set_xlabel("Time (s)")
    axes[1].set_ylabel("Output")
    axes[1].grid('major', 'major')
    axes[1].set_xlim(0, min([digital_time[-1], power_time[-1]]))
    axes[1].set_ylim(-0.1, 1.1)
    
    axes[1].set_yticks([0, 1])
    axes[1].xaxis.set_minor_locator(AutoMinorLocator(5))
    
    axes[0].set_title(f"Power consumption and digital output ({title})")
    

def avg_power(powerfile):
    power_data = np.genfromtxt(powerfile, delimiter=",", skip_header=8)
    power = 1e3*supply_voltage*power_data[:, 1]
    return np.mean(power[-1000:])

def runs(filename):
>>>>>>> master
    data = np.genfromtxt(filename, delimiter=",", skip_header=8)
    signal = data[:, 1]
    xor = np.logical_xor(signal[:-1], signal[1:])
    return xor.sum()
     
def runs_per_second(filename):
    data = np.genfromtxt(filename, delimiter=",", skip_header=8)
    time = data[:, 0][-10000:]
    total_time = time[-1] - time[0]
    
    signal = data[:, 1][-10000:]
    xor = np.logical_xor(signal[:-1], signal[1:])
    
    return xor.sum()/total_time

<<<<<<< HEAD

def time_per_sort(filename):
    return 1/sorts_per_second(filename)
=======
def seconds_per_run(filename):
    return 1/runs_per_second(filename)


#plot("factorise/factorise2_power.csv", "factorise/factorise2_A2_digital.csv",
#     title="factorisation of long int",
#     timeoffset=-1.125)
>>>>>>> master
