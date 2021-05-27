/**
 * PLL configuration
 *
 * This Verilog module was generated automatically
 * using the icepll tool from the IceStorm project.
 * Use at your own risk.
 *
 * Given input frequency:        96.000 MHz
 * Requested output frequency:   16.000 MHz
 * Achieved output frequency:    16.000 MHz
 */

module pll(
        input  clock_in,
        output clock_out,
        output locked
        );

SB_PLL40_CORE #(
                .FEEDBACK_PATH("SIMPLE"),
                .DIVR(4'b0010),         // DIVR =  2
                .DIVF(7'b0011111),      // DIVF = 31
                .DIVQ(3'b110),          // DIVQ =  6
                .FILTER_RANGE(3'b011)   // FILTER_RANGE = 3
        ) uut (
                .LOCK(locked),
                .RESETB(1'b1),
                .BYPASS(1'b0),
                .REFERENCECLK(clock_in),
                .PLLOUTCORE(clock_out)
                );

endmodule

/* 9Mhz:
.FEEDBACK_PATH("SIMPLE"),
.DIVR(4'b0000),         // DIVR =  0
.DIVF(7'b0000101),      // DIVF =  5
.DIVQ(3'b101),          // DIVQ =  5
.FILTER_RANGE(3'b101)   // FILTER_RANGE = 5
*/
