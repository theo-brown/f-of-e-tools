with open("clock_files_power.txt") as f:
    powerfiles = [l.strip() for l in f.readlines()]
with open("clock_files_digital.txt") as f:
    digitalfiles = [l.strip() for l in f.readlines()]

#for p, d in zip(powerfiles, digitalfiles):
#    plot(p, d, p)

power = []
for f in powerfiles:
    fname = f.split('/')[-1]
    label = '_'.join(fname.split('_')[1:-1])
    power.append((avg_power(f), label))

performance = []
for f in digitalfiles:
    fname = f.split('/')[-1]
    label = '_'.join(fname.split('_')[1:-2])
    performance.append((runs_per_second(f), label))

data = []
for p in power:
    itempower = p[0]
    itemlabel = p[1]
    for q in performance:
        if q[1] == itemlabel:
            itemperformance = q[0]
    data.append((itemperformance, itempower, itemlabel))

fig = plt.figure()
for d in data:
    plt.scatter(d[0], d[1], label=d[2])

plt.xlabel("Average number of factorisations completed per second")
plt.ylabel("Average running power consumption (mW)")
plt.title("Power consumption and number of factorisations per second for different clock sources")
plt.legend()

print("\\textbf{Clock source} & \\textbf{Power consumption, P (mW)} & \\textbf{Factorisations per second, N} \\\\ \\hline")
for row in data:
    print(f"{row[2]} & {row[1]:.2f} & {row[0]:.3f} \\\\ \\hline")
    