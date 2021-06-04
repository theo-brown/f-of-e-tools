module frequency_divider(input input_signal, output reg output_signal);

	parameter DIVIDE_BY = 3;
	
	reg [31:0] counter;

	always @(posedge input_signal)
	begin
		counter <= counter + 1;
		if (counter === DIVIDE_BY - 1)
		begin
			counter <= 0;
			output_signal <= (output_signal == 1'b1) ? 1'b0 : 1'b1; // If output is high, set it low, if it's low, set it high
		end
	end

endmodule
		
