/*
	Authored 2018-2019, Ryan Voo.
	All rights reserved.
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions
	are met:
	*	Redistributions of source code must retain the above
		copyright notice, this list of conditions and the following
		disclaimer.
	*	Redistributions in binary form must reproduce the above
		copyright notice, this list of conditions and the following
		disclaimer in the documentation and/or other materials
		provided with the distribution.
	*	Neither the name of the author nor the names of its
		contributors may be used to endorse or promote products
		derived from this software without specific prior written
		permission.
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
	FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
	COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
	LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
	ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
*/



`include "../include/rv32i-defines.v"
`include "../include/sail-core-defines.v"



/*
 *	Description:
 *
 *		This module implements the ALU for the RV32I.
 */



/*
 *	Not all instructions are fed to the ALU. As a result, the ALUctl
 *	field is only unique across the instructions that are actually
 *	fed to the ALU.
 */
module alu(ALUctl, A, B, ALUOut, Branch_Enable);
	input [6:0]		ALUctl;
	input [31:0]		A;
	input [31:0]		B;
	output reg [31:0]	ALUOut;
	output reg		Branch_Enable;

	/*
	 *	This uses Yosys's support for nonzero initial values:
	 *
	 *		https://github.com/YosysHQ/yosys/commit/0793f1b196df536975a044a4ce53025c81d00c7f
	 *
	 *	Rather than using this simulation construct (`initial`),
	 *	the design should instead use a reset signal going to
	 *	modules in the design.
	 */
	/* DSP Adder instantiation*/
	reg dsp_ce;
	reg [15:0] dsp_c;
        reg [15:0] dsp_a;
        reg [15:0] dsp_b;
        reg [15:0] dsp_d;
        reg dsp_irsttop;
        reg dsp_irstbot;
        reg dsp_orsttop;
        reg dsp_orstbot;
        reg dsp_ahold;
        reg dsp_bhold;
        reg dsp_chold;
        reg dsp_dhold;
        reg dsp_oholdtop;
        reg dsp_oholdbot;
        reg dsp_addsubtop;
        reg dsp_addsubbot;
        reg dsp_oloadtop;
        reg dsp_oloadbot;
        reg dsp_ci;

        wire [31:0] dsp_o;
        wire dsp_co;

        //setup the dsp, parameters TOPADDSUB_LOWERINPUT and BOTADDSUB_LOWERINPUT at 2 means we can use MAC operations
        SB_MAC16 #(.C_REG(0), .A_REG(0), .B_REG(0), .D_REG(0), .TOP_8x8_MULT_REG(0), .BOT_8x8_MULT_REG(0),
                   .PIPELINE_16x16_MULT_REG1(0), .PIPELINE_16x16_MULT_REG2(0), .TOPOUTPUT_SELECT(0), .TOPADDSUB_LOWERINPUT(0),
		   .TOPADDSUB_UPPERINPUT(1), .TOPADDSUB_CARRYSELECT(3), .BOTOUTPUT_SELECT(0), .BOTADDSUB_LOWERINPUT(0), .BOTADDSUB_UPPERINPUT(1),
		   .BOTADDSUB_CARRYSELECT(0), .MODE_8x8(1), .A_SIGNED(0), .B_SIGNED(0))
        SB_MAC16_adder(  
      .CE(dsp_ce), .C(dsp_c), .A(dsp_a), .B(dsp_b), .D(dsp_d),
      .IRSTTOP(dsp_irsttop), .IRSTBOT(dsp_irstbot), .ORSTTOP(dsp_orsttop), .ORSTBOT(dsp_orstbot),
      .AHOLD(dsp_ahold), .BHOLD(dsp_bhold), .CHOLD(dsp_chold), .DHOLD(dsp_dhold), .OHOLDTOP(dsp_oholdtop), .OHOLDBOT(dsp_oholdbot),
      .ADDSUBTOP(dsp_addsubtop), .ADDSUBBOT(dsp_addsubbot), .OLOADTOP(dsp_oloadtop), .OLOADBOT(dsp_oloadbot),
      .CI(dsp_ci), .O(dsp_o), .CO(dsp_co)
      );

      initial begin
     	 //default for the dsp
      	 dsp_ce <= 1;
	 dsp_c <= A[31:16];
	 dsp_a <= B[31:16];
	 dsp_b <= B[15:0];
	 dsp_d <= A[15:0];
     	 dsp_irsttop <= 0;
     	 dsp_irstbot <= 0;
     	 dsp_orsttop <= 0;
    	 dsp_orstbot <= 0;
    	 dsp_ahold <= 0;
     	 dsp_bhold <= 0;
     	 dsp_chold <= 0;
     	 dsp_dhold <= 0;
     	 dsp_oholdtop <= 0;
     	 dsp_oholdbot <= 0;
     	 dsp_addsubtop <= 0;
     	 dsp_addsubbot <= 0;
    	 dsp_oloadtop <= 0;
    	 dsp_oloadbot <= 0;
    	 dsp_ci <= 0;
       end
	
	initial begin
		ALUOut = 32'b0;
		Branch_Enable = 1'b0;
	end

	always @(ALUctl, A, B) begin
		case (ALUctl[3:0])
			/*
			 *	AND (the fields also match ANDI and LUI)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_AND:	ALUOut = A & B;

			/*
			 *	OR (the fields also match ORI)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_OR:	ALUOut = A | B;

			/*
			 *	ADD (the fields also match AUIPC, all loads, all stores, and ADDI)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_ADD:	ALUOut = dsp_o;

			/*
			 *	SUBTRACT (the fields also matches all branches)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_SUB:	ALUOut = A - B;

			/*
			 *	SLT (the fields also matches all the other SLT variants)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_SLT:	ALUOut = $signed(A) < $signed(B) ? 32'b1 : 32'b0;

			/*
			 *	SRL (the fields also matches the other SRL variants)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_SRL:	ALUOut = A >> B[4:0];

			/*
			 *	SRA (the fields also matches the other SRA variants)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_SRA:	ALUOut = A >>> B[4:0];

			/*
			 *	SLL (the fields also match the other SLL variants)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_SLL:	ALUOut = A << B[4:0];

			/*
			 *	XOR (the fields also match other XOR variants)
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_XOR:	ALUOut = A ^ B;

			/*
			 *	CSRRW  only
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_CSRRW:	ALUOut = A;

			/*
			 *	CSRRS only
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_CSRRS:	ALUOut = A | B;

			/*
			 *	CSRRC only
			 */
			`kSAIL_MICROARCHITECTURE_ALUCTL_3to0_CSRRC:	ALUOut = (~A) & B;

			/*
			 *	Should never happen.
			 */
			default:					ALUOut = 0;
		endcase
	end

	always @(ALUctl, ALUOut, A, B) begin
		case (ALUctl[6:4])
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BEQ:	Branch_Enable = (ALUOut == 0);
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BNE:	Branch_Enable = !(ALUOut == 0);
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BLT:	Branch_Enable = ($signed(A) < $signed(B));
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BGE:	Branch_Enable = ($signed(A) >= $signed(B));
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BLTU:	Branch_Enable = ($unsigned(A) < $unsigned(B));
			`kSAIL_MICROARCHITECTURE_ALUCTL_6to4_BGEU:	Branch_Enable = ($unsigned(A) >= $unsigned(B));

			default:					Branch_Enable = 1'b0;
		endcase
	end
endmodule

