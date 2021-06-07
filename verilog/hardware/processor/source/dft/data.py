import numpy as np
import matplotlib.pyplot as plt

max_x = 3
N = 16
x = np.linspace(0, max_x, N)

y1 = np.sin(x)
y2 = 0.5*np.cos(2*x)
y3 = 0.25*np.sin(8*x)

y = y1 + y2 + y3

plt.plot(x, y)

print(y)