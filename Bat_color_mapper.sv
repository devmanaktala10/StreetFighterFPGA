module Bat_color_mapper(input logic Clk, input logic [18:0] address, input logic [5:0] bat, output logic [7:0] Red,
								output logic [7:0] Blue, output logic [7:0] Green, output logic zero);

	 logic [3:0] color_code_1;
	 logic [3:0] color_code_2;
	 logic [3:0] color_code_3;
	 logic [3:0] color_code_4;
	 logic [3:0] color_code_5;
	 logic [3:0] color_code_6;
	 logic [3:0] color_code_7;
	 logic [3:0] color_code_8;
	 logic [3:0] color_code_9;
	 logic [3:0] color_code_10;
	 logic [3:0] color_code_11;
	 logic [3:0] color_code_12;
	 logic [3:0] color_code_13;
	 logic [3:0] color_code_14;
	 logic [3:0] color_code_15;
	 logic [3:0] color_code_16;
	 logic [3:0] color_code_17;
	 logic [3:0] color_code_18;
	 logic [3:0] color_code_19;
	 logic [3:0] color_code;	
	 logic [23:0] palette [0:15];
	
	always_comb
	 begin
		case(bat)
		6'b000000: //StartI
			color_code = color_code_1;
		6'b000001: //Idle1
			color_code = color_code_1;
		6'b000010: //Idle2
			color_code = color_code_2;
		6'b000011: //
			color_code = color_code_3;
		6'b000100:
			color_code = color_code_4;
		6'b000101:
			color_code = color_code_4;
		6'b000110:
			color_code = color_code_5;
		6'b000111:
			color_code = color_code_6;
		6'b001000:
			color_code = color_code_7;
		6'b001001:
			color_code = color_code_7;
		6'b001010:
			color_code = color_code_8;
		6'b001011:
			color_code = color_code_7;
		6'b001100:
			color_code = color_code_1;
		6'b001101:
			color_code = color_code_1;
		6'b001110:
			color_code = color_code_2;
		6'b001111:
			color_code = color_code_3;
		6'b010000:
			color_code = color_code_9;
		6'b010001:
			color_code = color_code_9;
		6'b010010:
			color_code = color_code_10;
		6'b010011:
			color_code = color_code_9;
		6'b010100:
			color_code = color_code_11; //crouch
		6'b010101:
			color_code = color_code_11; // start crouch punch
		6'b010110:
			color_code = color_code_12; // crouch punch
		6'b010111:
			color_code = color_code_11; // crouch punish
		6'b011000:
			color_code = color_code_13; // start jump
		6'b011001:
			color_code = color_code_13; // jump 1
		6'b011010:
			color_code = color_code_13; // jump 2
		6'b011011:
			color_code = color_code_14; // jump 3
		6'b011100:
			color_code = color_code_14; // jump 4
		6'b011101:
			color_code = color_code_15;
		6'b011110:
			color_code = color_code_15;
		6'b011111:
			color_code = color_code_16;
		6'b100000:
			color_code = color_code_17;
		6'b100001:
			color_code = color_code_18;
		6'b100010:
			color_code = color_code_18;
		6'b100011:
			color_code = color_code_19;
		default:
			color_code = color_code_1;
		endcase
	 end
	 
	always_comb
    begin
		  palette[0] = 24'hececec;//24'h80b8a8;
		  palette[1] = 24'h101018;//24'hf0b000;
		  palette[2] = 24'h092173;//24'hf0e079;
		  palette[3] = 24'h3952ce;//24'hf0da9a;
		  palette[4] = 24'h07319c;//24'hf0c080;
		  palette[5] = 24'he7d603;//24'hbf744f;
		  palette[6] = 24'hb58c39;//24'h101010;
		  palette[7] = 24'h945a21;//24'h440403;
		  palette[8] = 24'h949494;//24'hf34700;
		  palette[9] = 24'h292929;//24'hd84000;
		  palette[10] = 24'h424242;//24'hb03000;
		  palette[11] = 24'hc69400;//24'h6d3829;
		  palette[12] = 24'h5b2100;//24'hf84800;
		  palette[13] = 24'h737373;//24'hcc885c;
		  palette[14] = 24'hc69400;//24'hf0f0f0;
		  palette[15] = 24'h692f08;//24'h584048;
	end
	
	always_ff @ (posedge Clk)
	 begin
			if(color_code == 4'h0)
				zero = 1'b1;
			else
				zero = 1'b0;
			case(color_code)
			4'h0:
			begin
				Red = 8'hff; 
				Green = 8'hff;
				Blue = 8'hff;
			end
			4'h1:
			begin
				Red = palette[1][23:16];
				Green = palette[1][15:8];
				Blue = palette[1][7:0];
			end
			4'h2:
			begin
				Red = palette[2][23:16];
				Green = palette[2][15:8];
				Blue = palette[2][7:0];
			end
			4'h3:
			begin
				Red = palette[3][23:16];
				Green = palette[3][15:8];
				Blue = palette[3][7:0];	
			end
			4'h4:
			begin
				Red = palette[4][23:16];
				Green = palette[4][15:8];
				Blue = palette[4][7:0];
			end
			4'h5:
			begin
				Red = palette[5][23:16];
				Green = palette[5][15:8];
				Blue = palette[5][7:0];
			end
			4'h6:
			begin
				Red = palette[6][23:16];
				Green = palette[6][15:8];
				Blue = palette[6][7:0];
			end
			4'h7:
			begin
				Red = palette[7][23:16];
				Green = palette[7][15:8];
				Blue = palette[7][7:0];
			end
			4'h8:
			begin
				Red = palette[8][23:16];
				Green = palette[8][15:8];
				Blue = palette[8][7:0];
			end
			4'h9:
			begin
				Red = palette[9][23:16];
				Green = palette[9][15:8];
				Blue = palette[9][7:0];
			end
			4'ha:
			begin
				Red = palette[10][23:16];
				Green = palette[10][15:8];
				Blue = palette[10][7:0];
			end
			4'hb:
			begin
				Red = palette[11][23:16];
				Green = palette[11][15:8];
				Blue = palette[11][7:0];
			end
			4'hc:
			begin
				Red = palette[12][23:16];
				Green = palette[12][15:8];
				Blue = palette[12][7:0];
			end
			4'hd:
			begin
				Red = palette[13][23:16];
				Green = palette[13][15:8];
				Blue = palette[13][7:0];
			end
			4'he:
			begin
				Red = palette[14][23:16];
				Green = palette[14][15:8];
				Blue = palette[14][7:0];
			end
			4'hf:
			begin
				Red = palette[15][23:16];
				Green = palette[15][15:8];
				Blue = palette[15][7:0];
			end
			endcase
	end
	 
BatIdle1 ken1(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_1));
BatIdle2 ken2(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_2));
BatIdle3 ken3(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_3));
BatWalk1 ken4(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_4));
BatWalk2 ken5(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_5));
BatWalk3 ken6(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_6));
BatPunch1 ken7(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_7));
BatPunch2 ken8(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_8));
BatKick1 ken9(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_9));
BatKick2 ken10(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_10));
BatCrouch ken11(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_11));
BatCrouchKick ken12(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_12));
BatJump1 ken13(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_13));
BatJump2 ken14(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_14));
BatSpesh1 ken15(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_15));
BatSpesh2 ken16(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_16));
BatSpesh3 ken17(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_17));
BatKO1 ken18(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_18));
BatKO2 ken19(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_19));

endmodule
