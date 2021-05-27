`define	kFofE_HFOSC_CLOCK_DIVIDER_FOR_1Hz 	12000000

module blink(led);
	output		led;

	wire 		refclk;
	wire		clk;
	reg		LEDstatus = 1;
	reg [31:0]	count = 0;

	/*
	 *	Creates a 48MHz clock signal from
	 *	internal oscillator of the iCE40
	 */
	SB_HFOSC OSCInst0 (
		.CLKHFPU(1'b1),
		.CLKHFEN(1'b1),
		.CLKHF(refclk)
	);

	// try and set up a PLL
	// 48MHz input, 24Mhz output
	SB_PLL40_CORE #(
									.FEEDBACK_PATH("SIMPLE"),
									.DIVR(4'b0000),         // DIVR =  0
									.DIVF(7'b0001111),      // DIVF = 15
									.DIVQ(3'b101),          // DIVQ =  5
									.FILTER_RANGE(3'b100)   // FILTER_RANGE = 4
	        ) uut (
	                .LOCK(locked),
	                .RESETB(1'b1),
	                .BYPASS(1'b0),
	                .REFERENCECLK(refclk),
	                .PLLOUTCORE(clk)
	                );

	/*
	 *	Blinks LED at approximately 1Hz. The constant kFofE_CLOCK_DIVIDER_FOR_1Hz
	 *	(defined above) is calibrated to yield a blink rate of about 1Hz.
	 */
	always @(posedge clk) begin
		if (count > `kFofE_HFOSC_CLOCK_DIVIDER_FOR_1Hz) begin
			LEDstatus <= !LEDstatus;
			count <= 0;
		end
		else begin
			count <= count + 1;
		end
	end

	/*
	 *	Assign output led to value in LEDstatus register
	 */
	assign	led = LEDstatus;
endmodule
