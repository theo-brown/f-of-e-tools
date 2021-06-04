module sub(input1, input2, out, co);
	input [31:0]	input1;
	input [31:0]	input2;
	output [31:0]	out;
	output co;

        //setup the dsp, parameters TOPADDSUB_LOWERINPUT and BOTADDSUB_LOWERINPUT at 2 means we can use MAC operations
        SB_MAC16 #(.C_REG(0),
                   .A_REG(0),
                   .B_REG(0),
                   .D_REG(0),
                   .TOP_8x8_MULT_REG(0),
                   .BOT_8x8_MULT_REG(0),
                   .PIPELINE_16x16_MULT_REG1(0),
                   .PIPELINE_16x16_MULT_REG2(0),
                   .TOPOUTPUT_SELECT(0),
                   .TOPADDSUB_LOWERINPUT(0),
		   .TOPADDSUB_UPPERINPUT(1),
                   .TOPADDSUB_CARRYSELECT(2),
                   .BOTOUTPUT_SELECT(0),
                   .BOTADDSUB_LOWERINPUT(0),
                   .BOTADDSUB_UPPERINPUT(1),
		   .BOTADDSUB_CARRYSELECT(0),
                   .MODE_8x8(1),
                   .A_SIGNED(1),
                   .B_SIGNED(1))
                   SB_MAC16_adder(.CE(1),
                                  .C(input1[31:16]),
                                  .A(input2[31:16]),
                                  .B(input2[15:0]),
                                  .D(input1[15:0]),
                                  .IRSTTOP(0),
                                  .IRSTBOT(0),
                                  .ORSTTOP(0),
                                  .ORSTBOT(0),
                                  .AHOLD(0),
                                  .BHOLD(0),
                                  .CHOLD(0),
                                  .DHOLD(0),
                                  .OHOLDTOP(0),
                                  .OHOLDBOT(0),
                                  .ADDSUBTOP(1),
                                  .ADDSUBBOT(1),
                                  .OLOADTOP(0),
                                  .OLOADBOT(0),
                                  .CI(0),
                                  .O(out),
                                  .CO(co));

endmodule
