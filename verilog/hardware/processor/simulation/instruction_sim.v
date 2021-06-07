module top();
	reg clk = 0;

  wire[31:0] instruction_o;
  reg[31:0] addr;

  instruction_memory instructionmem_inst(
    .clk(clk),
    .addr(addr),
    .out(instruction_o)
  );

//simulation
always
 #0.5 clk = ~clk;

initial begin
	$dumpfile ("instruction_mem.vcd");
 	$dumpvars;
  addr = 32'b0;
  
  #5
  
 addr = addr + 32'b100;
  
  #5
    
  addr = addr + 32'b100;
  
  #5
    
  addr = addr + 32'b100;
  
  #5
    
  addr = addr + 32'b100;
  
  #5
    
  addr = addr + 32'b100;
  
  #5
  $finish;
  
end
  
endmodule
  
  
