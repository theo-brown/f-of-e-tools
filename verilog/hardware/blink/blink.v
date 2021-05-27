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
		.CLKHF(reflck)
	);

	// try and set up a PLL
	// 48MHz input, 16Mhz output
	SB_PLL40_CORE #(
	                .FEEDBACK_PATH("SIMPLE"),
									.DIVR(4'b0010),         // DIVR =  2
	                .DIVF(7'b0111111),      // DIVF = 63
	                .DIVQ(3'b110),          // DIVQ =  6
	                .FILTER_RANGE(3'b001)   // FILTER_RANGE = 1
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
