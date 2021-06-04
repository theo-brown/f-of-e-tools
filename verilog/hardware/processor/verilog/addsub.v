module addsub(input1, input2, addsubin, out);
	input [31:0]	input1;
	input [31:0]	input2;
        input addsubin;
	output [31:0]	out;

	wire dsp_ce;
	wire [15:0] dsp_c;
        wire [15:0] dsp_a;
        wire [15:0] dsp_b;
        wire [15:0] dsp_d;
        wire dsp_irsttop;
        wire dsp_irstbot;
        wire dsp_orsttop;
        wire dsp_orstbot;
        wire dsp_ahold;
        wire dsp_bhold;
        wire dsp_chold;
        wire dsp_dhold;
        wire dsp_oholdtop;
        wire dsp_oholdbot;
        wire dsp_addsubtop;
        wire dsp_addsubbot;
        wire dsp_oloadtop;
        wire dsp_oloadbot;
        wire dsp_ci;

        wire [31:0] dsp_o;
        wire dsp_co;

        //setup the dsp, parameters TOPADDSUB_LOWERINPUT and BOTADDSUB_LOWERINPUT at 2 means we can use MAC operations
        SB_MAC16 #(.C_REG(0), .A_REG(0), .B_REG(0), .D_REG(0), .TOP_8x8_MULT_REG(0), .BOT_8x8_MULT_REG(0),
                   .PIPELINE_16x16_MULT_REG1(0), .PIPELINE_16x16_MULT_REG2(0), .TOPOUTPUT_SELECT(0), .TOPADDSUB_LOWERINPUT(0),
		   .TOPADDSUB_UPPERINPUT(1), .TOPADDSUB_CARRYSELECT(2), .BOTOUTPUT_SELECT(0), .BOTADDSUB_LOWERINPUT(0), .BOTADDSUB_UPPERINPUT(1),
		   .BOTADDSUB_CARRYSELECT(0), .MODE_8x8(1), .A_SIGNED(1), .B_SIGNED(1))
        SB_MAC16_adder(  
      .CE(dsp_ce), .C(dsp_c), .A(dsp_a), .B(dsp_b), .D(dsp_d),
      .IRSTTOP(dsp_irsttop), .IRSTBOT(dsp_irstbot), .ORSTTOP(dsp_orsttop), .ORSTBOT(dsp_orstbot),
      .AHOLD(dsp_ahold), .BHOLD(dsp_bhold), .CHOLD(dsp_chold), .DHOLD(dsp_dhold), .OHOLDTOP(dsp_oholdtop), .OHOLDBOT(dsp_oholdbot),
      .ADDSUBTOP(dsp_addsubtop), .ADDSUBBOT(dsp_addsubbot), .OLOADTOP(dsp_oloadtop), .OLOADBOT(dsp_oloadbot),
      .CI(dsp_ci), .O(dsp_o), .CO(dsp_co)
      );

     /* always @(input1, input2) begin
     	 //default for the dsp
      dsp_ce = 1;
	    dsp_c = input1[31:16];
	    dsp_a = input2[31:16];
	    dsp_b = input2[15:0];
	    dsp_d = input1[15:0];
     	dsp_irsttop = 0;
     	dsp_irstbot = 0;
     	dsp_orsttop = 0;
    	dsp_orstbot = 0;
    	dsp_ahold = 0;
     	dsp_bhold = 0;
     	dsp_chold = 0;
     	dsp_dhold = 0;
     	dsp_oholdtop = 0;
     	dsp_oholdbot = 0;
     	dsp_addsubtop = addsubin;
     	dsp_addsubbot = addsubin;
    	dsp_oloadtop = 0;
    	dsp_oloadbot = 0;
    	dsp_ci = 0;
      end*/
	
	    assign out = dsp_o;
      assign dsp_ce = 1;
	    assign dsp_c = input1[31:16];
	    assign dsp_a = input2[31:16];
	    assign dsp_b = input2[15:0];
	    assign dsp_d = input1[15:0];
     	assign dsp_irsttop = 0;
     	assign dsp_irstbot = 0;
     	assign dsp_orsttop = 0;
    	assign dsp_orstbot = 0;
    	assign dsp_ahold = 0;
     	assign dsp_bhold = 0;
     	assign dsp_chold = 0;
     	assign dsp_dhold = 0;
     	assign dsp_oholdtop = 0;
     	assign dsp_oholdbot = 0;
     	assign dsp_addsubtop = addsubin;
     	assign dsp_addsubbot = addsubin;
    	assign dsp_oloadtop = 0;
    	assign dsp_oloadbot = 0;
    	assign dsp_ci = 0;
endmodule
