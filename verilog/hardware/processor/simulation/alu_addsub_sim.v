module top();
	reg clk = 0;

	reg[31:0] A, B;
	wire[31:0] ALUOut;
	wire Branch_Enable;

	//alu_control interface
	reg[3:0] FuncCode;
	reg[6:0] Opcode;

	//alu aluctl interface
	wire[6:0] AluCtl_wire;

	ALUControl aluCtrl_inst(
		.FuncCode(FuncCode),
		.ALUCtl(AluCtl_wire),
		.Opcode(Opcode)
	);

	alu alu_inst(
		.ALUctl(AluCtl_wire),
		.A(A),
		.B(B),
		.ALUOut(ALUOut),
		.Branch_Enable(Branch_Enable)
	);

//simulation
always
 #0.5 clk = ~clk;

initial begin
	$dumpfile ("adder.vcd");
 	$dumpvars;

 	//reg[31:0] A, B;
 	//reg[3:0] FuncCode; //bit 32 + bit 14:12
	//reg[6:0] Opcode; //bits 6:0
  //1
 	A = 32'b0;
 	B = 32'b0;
 	FuncCode = 4'b0;
 	Opcode = 7'b0110011;

 	#5

 	FuncCode = 4'b1000;
  Opcode = 7'b0110011;

 	#5
  
  //2
 	A = 32'd10;	
  B = 32'd0;
  FuncCode = 4'b0;
  Opcode = 7'b0110011;

 	#5

 	FuncCode = 4'b1000;

 	#5

 	//3
 	A = 32'h3E8;
 	B = 32'hA;
 	FuncCode = 4'b0;

 	#5

 	FuncCode = 4'b1000;
  
 	#5

 	//4
 	A = 32'h3001000;
 	B = 32'hFFFF;
 	FuncCode = 4'b0;

 	#5

 	FuncCode = 4'b1000;

 	#5

 	//5
 	A = 32'hFFFF;
 	B = 32'h3001000;
 	FuncCode = 4'b0;

 	#5

 	FuncCode = 4'b1000;
  
 	#5

 	//6
 	A = 32'hFFFF;
 	B = 32'hA3001000;
 	FuncCode = 4'b0;

 	#5

 	FuncCode = 4'b1000;

 	#5

 	//7
 	A = 32'hA3001000;
  B = 32'hFFFF;
 	FuncCode = 4'b0;
  
 	#5

 	FuncCode = 4'b1000;
  
 	#5

 	//8
 	A = 32'hA3001000;
  B = 32'hB000FFFF;
 	FuncCode = 4'b0;

 	#5

 	FuncCode = 4'b1000;
  
  #5

 	$finish;
end

endmodule
