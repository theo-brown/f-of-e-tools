module instruction_memory(clk, addr, out);
	input			clk;
	input [31:0]		addr;
	output reg [31:0]	out;

	reg [31:0]		instruction_memory[0:1279];

	initial
	begin
		$readmemh("verilog/program.hex", instruction_memory);
	end

	always @(posedge clk)
	begin
		out <= {instruction_memory[addr >> 2][31:16], instruction_memory[addr >> 2][15:0]};
	end
	
endmodule
