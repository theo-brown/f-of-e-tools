plot("factorise2_power.csv", "factorise2_digital.csv",
     title="factorisation of long int",
     timeoffset=-1.125)

data = [["Bubblesort", runs_per_second('../clock/bsort_hfosc_digital.csv'), avg_power('../clock/bsort_hfosc_power.csv')],
        ["Factorise", runs_per_second('factorise2_digital.csv'), avg_power('factorise2_power.csv')]]

print("\\textbf{Benchmark program} & \\textbf{Power consumption (mW)} & \\textbf{Completed runs per second} \\\\ \\hline")
for row in data:
    print(f"{row[0]} & {row[2]:.2f} & {row[1]:.2f} \\\\ \\hline")
    