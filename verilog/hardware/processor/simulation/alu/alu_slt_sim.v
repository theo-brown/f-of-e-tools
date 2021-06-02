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
  $dumpfile ("alu_slt.vcd");
 	$dumpvars;

 	//reg[31:0] A, B;
 	//reg[3:0] FuncCode; //bit 32 + bit 14:12
	//reg[6:0] Opcode; //bits 6:0
  	//1
 	A = 32'b0;
 	B = 32'b0;
 	FuncCode = 4'b0100;
 	Opcode = 7'b0110011;

 	#5

 	//1 xor
  A = 32'h0000005A;
  B = 32'h000000A9;
  FuncCode = 4'b0100;
 	Opcode = 7'b0110011;

 	#5
  
  //2
 	A = 32'h60A0B0C8;	
 	B = 32'h41030507;
  FuncCode = 4'b0010;
 	Opcode = 7'b0110011;

 	#5

 	//3
  A = 32'h41030507;	
 	B = 32'h47030D05;

 	#5

 	//4
 	A = 32'h60A0B0C8;
 	B = 32'h60A0B0C8;

 	#5

 	//5
 	A = 32'hA2345678;
 	B = 32'h9EA1CD00;
  
 	#5

 	//6
 	A = 32'h8765EDC1;
 	B = 32'hD1A2B3C4;

 	#5

 	//7
 	A = 32'h20000000;
 	B = 32'hF0000000;

 	#5

 	//8
 	A = 32'h60000000;
 	B = 32'hA0000000;

 	#5

 	//9
 	A = 32'hF0000000;
 	B = 32'h20000000;
  
 	#5

 	//10
 	A = 32'hA0000000;
 	B = 32'h60000000;

 	#5

 	$finish;
end

endmodule
