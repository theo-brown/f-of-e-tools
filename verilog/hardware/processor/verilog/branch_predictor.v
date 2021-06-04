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



/*
 *		Branch Predictor FSM
 */

module branch_predictor(
		clk,
		actual_branch_decision,
		branch_decode_sig,
		branch_mem_sig,
		in_addr,
		offset,
		branch_addr,
		prediction
	);

	/*
	 *	inputs
	 */
	input		clk;
	input		actual_branch_decision;
	input		branch_decode_sig;
	input		branch_mem_sig;
	input [31:0]	in_addr;
	input [31:0]	offset;

	/*
	 *	outputs
	 */
	output [31:0]	branch_addr;
	output		prediction;

	/*
	 *	internal state
	 */
	/*
	reg [1:0]	s0;
	reg [1:0]	s1;
	reg [1:0]	s2;
	reg [1:0]	s3;
	*/
	reg [7:0] s;
	reg [1:0]	h;
	reg 		p;

	reg		branch_mem_sig_reg;

	/*
	 *	The `initial` statement below uses Yosys's support for nonzero
	 *	initial values:
	 *
	 *		https://github.com/YosysHQ/yosys/commit/0793f1b196df536975a044a4ce53025c81d00c7f
	 *
	 *	Rather than using this simulation construct (`initial`),
	 *	the design should instead use a reset signal going to
	 *	modules in the design and to thereby set the values.
	 */
	initial begin
		/*
		s0 = 2'b00;
		s1 = 2'b00;
		s2 = 2'b00;
		s3 = 2'b00;
		*/
		s = 8'b00000000
		h = 2'b00;
		p = 1'b0;
		branch_mem_sig_reg = 1'b0;
	end

	always @(negedge clk) begin
		branch_mem_sig_reg <= branch_mem_sig;
	end

	/*
	 *	Using this microarchitecture, branches can't occur consecutively
	 *	therefore can use branch_mem_sig as every branch is followed by
	 *	a bubble, so a 0 to 1 transition
	 */
	always @(posedge clk) begin
		if (branch_mem_sig_reg) begin
			h[1] <= h[0];
			h[0] <= actual_branch_decision;
			if (h == 2'b00) begin
				s[1] <= (s[1]&s[0]) | (s[0]&actual_branch_decision) | (s[1]&actual_branch_decision);
				s[0] <= (s[1]&(!s[0])) | ((!s[0])&actual_branch_decision) | (s[1]&actual_branch_decision);
				p <= s[1];
			end
			if (h == 2'b01) begin
				s[3] <= (s[3]&s[2]) | (s[2]&actual_branch_decision) | (s[3]&actual_branch_decision);
				s[2] <= (s[3]&(!s[2])) | ((!s[2])&actual_branch_decision) | (s[3]&actual_branch_decision);
				p <= s[3];
			end
			if (h == 2'b10) begin
				s[5] <= (s[5]&s[4]) | (s[4]&actual_branch_decision) | (s[5]&actual_branch_decision);
				s[4] <= (s[5]&(!s[4])) | ((!s[4])&actual_branch_decision) | (s[5]&actual_branch_decision);
				p <= s[5];
			end
			if (h == 2'b11) begin
				s[7] <= (s[7]&s[6]) | (s[6]&actual_branch_decision) | (s[7]&actual_branch_decision);
				s[6] <= (s[7]&(!s[6])) | ((!s[6])&actual_branch_decision) | (s[7]&actual_branch_decision);
				p <= s[7];
			end
		end
	end

	assign branch_addr = in_addr + offset;
	assign prediction = p & branch_decode_sig;
endmodule
