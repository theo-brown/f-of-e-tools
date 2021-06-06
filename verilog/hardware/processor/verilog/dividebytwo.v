module dividebytwo(input input_signal, output reg output_signal);
	initial output_signal <= 0;

	always @(posedge input_signal)
	begin
		output_signal <= (output_signal == 1'b1)? 1'b0 : 1'b1; // If output is high, set it low, if it's low, set it high
	end

endmodule
		
