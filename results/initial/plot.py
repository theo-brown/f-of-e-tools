import matplotlib.pyplot as plt
import numpy as np
from matplotlib.ticker import AutoMinorLocator

plt.rcParams['font.size'] = '16'

supply_voltage = 1.2

# .csv files are Index, Voltage, Current
bsort_forever = np.genfromtxt("bsort_forever.csv", delimiter=",")[1:]
bsort_once = np.genfromtxt("bsort_once.csv", delimiter=",")[1:]
template = np.genfromtxt("template.csv", delimiter=",")[1:]
softwareblink = np.genfromtxt("softwareblink.csv", delimiter=",")[1:]

fig = plt.figure()

plt.plot(bsort_forever[:300, 0], 1e3*supply_voltage*bsort_forever[:300, 1], label="bsort_forever")
plt.plot(bsort_once[:300, 0], 1e3*supply_voltage*bsort_once[:300, 1], label="bsort_once")
plt.plot(template[:300, 0], 1e3*supply_voltage*template[:300, 1], label="template")
plt.plot(softwareblink[:300, 0], 1e3*supply_voltage*softwareblink[:300, 1], label="softwareblink")

plt.ylim(0, 4)
plt.yticks(np.arange(0, 4.5, 0.5))
fig.axes[0].yaxis.set_minor_locator((AutoMinorLocator(5)))
#fig.axes[0].set_yticklabels(["{:.1e}".format(t) for t in fig.axes[0].get_yticks()])
plt.grid(which='major', axis='y')

plt.xlim(1 , 300)

plt.ylabel("Power (mW)")
plt.xlabel("Index")
plt.legend()
plt.title("Supply power over time for different benchmark programs")

plt.show()

fig.set_size_inches(11.7, 8.3)
fig.savefig("power_consumption.png", dpi=500)