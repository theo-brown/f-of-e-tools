#plot("bsort_6pll_power.csv",
#     "bsort_6pll_digital.csv",
#     title="6MHz PLL",
#     timeoffset=0.82)
#
#plot("bsort_8pll_power.csv",
#     "bsort_8pll_digital.csv",
#     title="8MHz PLL",
#     timeoffset=0.875)
#
#plot("bsort_10pll_power.csv",
#     "bsort_10pll_digital.csv",
#     title="10MHz PLL",
#     timeoffset=-1.84)
#
#plot("bsort_11pll_power.csv",
#     "bsort_11pll_digital.csv",
#     title="11MHz PLL",
#     timeoffset=-2)


fig = plt.figure()
plt.scatter(runs_per_second('clock/bsort_lfosc_digital.csv'),
            avg_power('clock/bsort_lfosc_power.csv'),
            label="LFOSC")
plt.scatter(runs_per_second("clock/bsort_hfosc_div_2_digital.csv"),
            avg_power("clock/bsort_hfosc_div_2_power.csv"),
            label="HFOSC with frequency_divider (DIVIDE_BY=2)")
plt.scatter(runs_per_second('clock/bsort_hfosc_digital.csv'),
            avg_power('clock/bsort_hfosc_power.csv'),
            label="HFOSC")
plt.scatter(runs_per_second('clock/bsort_8pll_digital.csv'),
            avg_power('clock/bsort_8pll_power.csv'),
            label="8MHz PLL")
plt.scatter(runs_per_second('clock/bsort_10pll_digital.csv'),
            avg_power('clock/bsort_10pll_power.csv'),
            label="10MHz PLL")
plt.scatter(runs_per_second('clock/bsort_11pll_digital.csv'),
            avg_power('clock/bsort_11pll_power.csv'),
            label="11MHz PLL")



plt.xlabel("Average number of bubblesorts completed per second")
plt.ylabel("Average running power consumption (mW)")
plt.title("Power consumption and number of sorts per second for different clock sources")
plt.legend()

data = [["8MHz PLL", runs_per_second('clock/bsort_8pll_digital.csv'), avg_power('clock/bsort_8pll_power.csv')],
        ["10MHz PLL", runs_per_second('clock/bsort_10pll_digital.csv'), avg_power('clock/bsort_10pll_power.csv')],
        ["11MHz PLL", runs_per_second('clock/bsort_11pll_digital.csv'), avg_power('clock/bsort_11pll_power.csv')],
        ["LFOSC", runs_per_second('clock/bsort_lfosc_digital.csv'), avg_power('clock/bsort_lfosc_power.csv')],
        ["HFOSC", runs_per_second('clock/bsort_hfosc_digital.csv'), avg_power('clock/bsort_hfosc_power.csv')],
        ["HFOSC with frequency divider", runs_per_second('clock/bsort_hfosc_div_2_digital.csv'), avg_power('clock/bsort_hfosc_div_2_power.csv')]]

print("\\textbf{Clock source} & \\textbf{Power consumption, P (mW)} & \\textbf{Bubblesorts per second, N} & \\textbf{$\frac{N}{P}}\\\\ \\hline")
for row in data:
    print(f"{row[0]} & {row[2]:.2f} & {int(row[1])} & {row[1]/row[2]:.4f} \\\\ \\hline")
    