
//Data cache

module data_mem (clk, addr, write_data, memwrite, memread, sign_mask, read_data, led, clk_stall);
	input			clk;
	input [31:0]		addr;
	input [31:0]		write_data;
	input			memwrite;
	input			memread;
	input [3:0]		sign_mask;
	output reg [31:0]	read_data;
	output reg		led;
	output reg		clk_stall;	//Sets the clock high


	// States
	integer			state = 0;
	parameter		IDLE = 0;
	parameter		READ_BUFFER = 1;
	parameter		READ = 2;
	parameter		WRITE = 3;

	// Buffers
	reg [31:0]		word_buf;
	wire [31:0]		read_buf;
	reg			memread_buf;
	reg			memwrite_buf;
	reg [31:0]		write_data_buffer;
	reg [31:0]		addr_buf;
	reg [3:0]		sign_mask_buf;

	// Memory
	reg [31:0]		data_block[0:1023];

	// Wire connections
	wire [9:0]		addr_buf_block_addr;
	wire [1:0]		addr_buf_byte_offset;

	assign			addr_buf_block_addr	= addr_buf[11:2];
	assign			addr_buf_byte_offset	= addr_buf[1:0];

	// Read
	wire select0;
	wire select1;
	wire select2;
	
	wire[31:0] out1;
	wire[31:0] out2;
	wire[31:0] out3;
	wire[31:0] out4;
	wire[31:0] out5;
	wire[31:0] out6;
	
	// A = sign_mask_buf[2]
	// B = sign_mask_buf[1]
	// C = addr_buf_byte_offset[1]
	// D = addr_buf_byte_offset[0]

	// select0 = ~A~BCD + ~ACD + ~AB 
	assign select0 = (~sign_mask_buf[2] & ~sign_mask_buf[1] & ~addr_buf_byte_offset[1] & addr_buf_byte_offset[0]) | (~sign_mask_buf[2] & addr_buf_byte_offset[1] & addr_buf_byte_offset[0]) | (~sign_mask_buf[2] & sign_mask_buf[1] & addr_buf_byte_offset[1]);
	// select1 = ~A~BC + AB
	assign select1 = (~sign_mask_buf[2] & ~sign_mask_buf[1] & addr_buf_byte_offset[1]) | (sign_mask_buf[2] & sign_mask_buf[1]);
	
	// 1 BYTE
	// out1 = signed/unsigned word_buf[15:8] or signed/unsigned word_buf[7:0]
	assign out1 = (select0)? (sign_mask_buf[3]? {{24{word_buf[15]}}, word_buf[15:8]} : {24'b0, word_buf[15:8]}) : (sign_mask_buf[3]? {{24{word_buf[7]}}, word_buf[7:0]} : {24'b0, word_buf[7:0]});
	// out2 = signed/unsigned word_buf[31:24] or signed/unsigned word_buf[23:16]
	assign out2 = (select0)? (sign_mask_buf[3]? {{24{word_buf[31]}}, word_buf[31:24]} : {24'b0, word_buf[31:24]}) : (sign_mask_buf[3]? {{24{word_buf[23]}}, word_buf[23:16]} : {24'b0, word_buf[23:16]}); 

	// 2 BYTES
	// out3 = signed/unsigned word_buf[31:16] or signed/unsigned word_buf[16:0]
	assign out3 = (select0)? (sign_mask_buf[3]? {{16{word_buf[31]}}, word_buf[31:16]} : {16'b0, word_buf[31:16]}) : (sign_mask_buf[3]? {{16{word_buf[15]}}, word_buf[15:0]} : {16'b0, word_buf[15:0]});

	// 4 BYTES
	assign out4 = (select0)? 32'b0 : word_buf;
	
	assign out5 = (select1)? out2 : out1;
	assign out6 = (select1)? out4 : out3;
	
	assign read_buf = (sign_mask_buf[1]) ? out6 : out5;
	
	initial begin
		$readmemh("verilog/data.hex", data_block);
		clk_stall = 0;
	end

	/*
	 *	LED register interfacing with I/O
	 */
	always @(posedge clk) begin
		if(memwrite == 1'b1 && addr == 32'h2000) begin
			led <= write_data[0];
		end
	end

	/*
	 *	State machine
	 */
	always @(posedge clk) begin
		case (state)
			IDLE: begin
				clk_stall <= 0;
				memread_buf <= memread;
				memwrite_buf <= memwrite;
				write_data_buffer <= write_data;
				addr_buf <= addr;
				sign_mask_buf <= sign_mask;
				
				if(memread==1'b1) begin
					state <= READ_BUFFER;
					clk_stall <= 1;
				end
				else if(memwrite==1'b1)
				begin
					state <= WRITE;
					clk_stall <= 1;
				end
			end

			READ_BUFFER: begin
				/*
				 *	Subtract out the size of the instruction memory.
				 *	(Bad practice: The constant should be a `define).
				 */
				word_buf <= data_block[addr_buf_block_addr - 32'h1000];
				state <= READ;
			end

			READ: begin
				clk_stall <= 0;
				read_data <= read_buf;
				state <= IDLE;
			end

			WRITE: begin
				clk_stall <= 0;
				
				casez ({sign_mask_buf[2:1], addr_buf_byte_offset[1:0]})

					// Write whole buffer
					4'b1???: data_block[addr_buf_block_addr - 32'h1000] <= write_data_buffer;

					// Write halfword
					4'b0110: data_block[addr_buf_block_addr - 32'h1000][31:16] <= write_data_buffer[15:0];
					4'b0111: data_block[addr_buf_block_addr - 32'h1000][15:0] <= write_data_buffer[15:0];

					// Write 1 byte
					4'b0000: data_block[addr_buf_block_addr - 32'h1000][7:0] <= write_data_buffer[7:0];
					4'b0001: data_block[addr_buf_block_addr - 32'h1000][15:8] <= write_data_buffer[7:0];
					4'b0010: data_block[addr_buf_block_addr - 32'h1000][23:16] <= write_data_buffer[7:0];
					4'b0011: data_block[addr_buf_block_addr - 32'h1000][31:24] <= write_data_buffer[7:0];

				endcase 

				//data_block[addr_buf_block_addr - 32'h1000] <= replacement_word;
				state <= IDLE;
			end

		endcase
	end

endmodule
