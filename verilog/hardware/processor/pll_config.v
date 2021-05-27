/**
 * PLL configuration
 *
 * This Verilog header file was generated automatically
 * using the icepll tool from the IceStorm project.
 * It is intended for use with FPGA primitives SB_PLL40_CORE,
 * SB_PLL40_PAD, SB_PLL40_2_PAD, SB_PLL40_2F_CORE or SB_PLL40_2F_PAD.
 * Use at your own risk.
 *
 * Given input frequency:        96.000 MHz
 * Requested output frequency:   20.000 MHz
 * Achieved output frequency:    20.000 MHz
 */

.FEEDBACK_PATH("SIMPLE"),
.DIVR(4'b0010),         // DIVR =  2
.DIVF(7'b0010011),      // DIVF = 19
.DIVQ(3'b101),          // DIVQ =  5
.FILTER_RANGE(3'b011)   // FILTER_RANGE = 3
