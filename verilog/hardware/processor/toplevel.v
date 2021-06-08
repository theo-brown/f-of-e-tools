/*
 *	top.v
 *
 *	Top level entity, linking cpu with data and instruction memory.
 */

module top (led);
	output reg	led;

	wire		clk_proc;
	wire		data_clk_stall;
	
	wire		clk;
	wire		hfosc;
	wire		pll;	

	SB_HFOSC OSCInst0 (.CLKHFEN(1),
			   .CLKHFPU(1),
			   .CLKHF(hfosc));

	pll pll_inst (hfosc, pll);


	SB_DFF dividebytwo_dff (.Q(clk),	// output clk
				.C(pll),	// input from pll
				.D(~clk));

	/*
	 *	Memory interface
	 */
	wire[31:0]	inst_in;
	wire[31:0]	inst_out;
	wire[31:0]	data_out;
	wire[31:0]	data_addr;
	wire[31:0]	data_WrData;
	wire		data_memwrite;
	wire		data_memread;
	wire[3:0]	data_sign_mask;


	cpu processor(
		.clk(clk_proc),
		.inst_mem_in(inst_in),
		.inst_mem_out(inst_out),
		.data_mem_out(data_out),
		.data_mem_addr(data_addr),
		.data_mem_WrData(data_WrData),
		.data_mem_memwrite(data_memwrite),
		.data_mem_memread(data_memread),
		.data_mem_sign_mask(data_sign_mask)
	);

	instruction_memory inst_mem( 
		.addr(inst_in), 
		.out(inst_out)
	);

	data_mem data_mem_inst(
			.clk(clk),
			.addr(data_addr),
			.write_data(data_WrData),
			.memwrite(data_memwrite), 
			.memread(data_memread), 
			.read_data(data_out),
			.sign_mask(data_sign_mask),
			.led(led),
			.clk_stall(data_clk_stall)
		);

	assign clk_proc = (data_clk_stall) ? 1'b1 : clk;
endmodule
