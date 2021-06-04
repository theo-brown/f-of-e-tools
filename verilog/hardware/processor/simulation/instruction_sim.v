module top();
	reg clk = 0;

  wire[31:0] instruction_o;
  wire[31:0] addr;

  instruction_memory instructionmem_inst(
    .clk(clk),
    .addr(addr),
    .out(instruction_o)
  );

//simulation
always
 #0.5 clk = ~clk;

initial begin
	$dumpfile ("alu_addsub.vcd");
 	$dumpvars;
  instruction_o = 32'b0;
  
  #5
  
  instruction_o = instruction_o + 32'b100;
  
  #5
    
  instruction_o = instruction_o + 32'b100;
  
  #5
    
  instruction_o = instruction_o + 32'b100;
  
  #5
    
  instruction_o = instruction_o + 32'b100;
  
  #5
    
  instruction_o = instruction_o + 32'b100;
  
  #5
  $finish;
  
end
  
endmodule
  
  
