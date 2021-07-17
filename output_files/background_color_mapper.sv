module background_color_mapper(input logic Clk, inout [15:0] SRAM_DQ, output logic [7:0] Red, input logic gamescreen,
								output logic [7:0] Blue, output logic [7:0] Green, output logic [15:0] data, input logic ublb);

	 logic [15:0] sram_data;
	 logic [23:0] back [0:31];
	 logic [23:0] home [0:15];
	 assign data = sram_data;
	 logic [15:0] actual;
	 
	 always_comb
	 begin
		if(ublb == 1'b1)
			actual = {8'd0, sram_data[7:0]};
		else
			actual = {8'd0, sram_data[15:8]};
	 end
	 
	always_comb
    begin
		  back[0] = 24'hfbd398;
		  back[1] = 24'hd98a62;
		  back[2] = 24'h623d23;
		  back[3] = 24'hddb272;
		  back[4] = 24'hfce0b0;
		  back[5] = 24'hd48a5e;
		  back[6] = 24'h64432a;
		  back[7] = 24'hfffdfe;
		  back[8] = 24'h767675;
		  back[9] = 24'hb9b8b3;
		  back[10] = 24'h1e1e1e;
		  back[11] = 24'h2c2c2c;
		  back[12] = 24'h656565;
		  back[13] = 24'h595959;
		  back[14] = 24'h0a0b05;
		  back[15] = 24'he4ddd3;
		  back[16] = 24'hd1cfd0;
		  back[17] = 24'h766645;
		  back[18] = 24'hbeae8b;
		  back[19] = 24'h4e3f1e;
		  back[20] = 24'hfc8d21;
		  back[21] = 24'h9c3100;
		  back[22] = 24'h861e01;
		  back[23] = 24'h993000;
		  back[24] = 24'h6d0f03;
		  back[25] = 24'hac4000;
		  back[26] = 24'hc35301;
		  back[27] = 24'hdf6b06;
		  back[28] = 24'hff9a30;
		  back[29] = 24'hfcfd97;
		  back[30] = 24'h32281e;
		  back[31] = 24'h7b5e4c;
		  
		  
		  home[0] = 24'h000000;
		  home[1] = 24'ha00000;
		  home[2] = 24'hbf0000;
		  home[3] = 24'h5f0001;
		  home[4] = 24'hcea000;
		  home[5] = 24'h080083;
		  home[6] = 24'ha8a08f;
		  home[7] = 24'hde0502;
		  home[8] = 24'hdea310;
		  home[9] = 24'hf17a24;
		  home[10] = 24'hdb0400;
		  home[11] = 24'hdfa968;
		  home[12] = 24'he9822c;
		  home[13] = 24'hf11128;
		  home[14] = 24'hea403a;
		  home[15] = 24'he8583d;  
	end
	
	always_ff @ (posedge Clk)
	 begin
			if(gamescreen)
			begin
				case(actual)
			16'h0000:
			begin
				Red = home[0][23:16];
				Green = home[0][15:8];
				Blue = home[0][7:0];
			end
			16'h0001:
			begin
				Red = home[1][23:16];
				Green = home[1][15:8];
				Blue = home[1][7:0];
			end
			16'h0002:
			begin
				Red = home[2][23:16];
				Green = home[2][15:8];
				Blue = home[2][7:0];
			end
			16'h0003:
			begin
				Red = home[3][23:16];
				Green = home[3][15:8];
				Blue = home[3][7:0];
			end
			16'h0004:
			begin
				Red = home[4][23:16];
				Green = home[4][15:8];
				Blue = home[4][7:0];
			end
			16'h0005:
			begin
				Red = home[5][23:16];
				Green = home[5][15:8];
				Blue = home[5][7:0];
			end
			16'h0006:
			begin
				Red = home[6][23:16];
				Green = home[6][15:8];
				Blue = home[6][7:0];
			end
			16'h0007:
			begin
				Red = home[7][23:16];
				Green = home[7][15:8];
				Blue = home[7][7:0];
			end
			16'h0008:
			begin
				Red = home[8][23:16];
				Green = home[8][15:8];
				Blue = home[8][7:0];
			end
			16'h0009:
			begin
				Red = home[9][23:16];
				Green = home[9][15:8];
				Blue = home[9][7:0];
			end
			16'h000a:
			begin
				Red = home[10][23:16];
				Green = home[10][15:8];
				Blue = home[10][7:0];
			end
			16'h000b:
			begin
				Red = home[11][23:16];
				Green = home[11][15:8];
				Blue = home[11][7:0];
			end
			16'h000c:
			begin
				Red = home[12][23:16];
				Green = home[12][15:8];
				Blue = home[12][7:0];
			end
			16'h000d:
			begin
				Red = home[13][23:16];
				Green = home[13][15:8];
				Blue = home[13][7:0];
			end
			16'h000e:
			begin
				Red = home[14][23:16];
				Green = home[14][15:8];
				Blue = home[14][7:0];
			end
			16'h000f:
			begin
				Red = home[15][23:16];
				Green = home[15][15:8];
				Blue = home[15][7:0];
			end
			endcase
			end
			else
			begin
			case(actual)
			16'h0000:
			begin
				Red = back[0][23:16];
				Green = back[0][15:8];
				Blue = back[0][7:0];
			end
			16'h0001:
			begin
				Red = back[1][23:16];
				Green = back[1][15:8];
				Blue = back[1][7:0];
			end
			16'h0002:
			begin
				Red = back[2][23:16];
				Green = back[2][15:8];
				Blue = back[2][7:0];
			end
			16'h0003:
			begin
				Red = back[3][23:16];
				Green = back[3][15:8];
				Blue = back[3][7:0];
			end
			16'h0004:
			begin
				Red = back[4][23:16];
				Green = back[4][15:8];
				Blue = back[4][7:0];
			end
			16'h0005:
			begin
				Red = back[5][23:16];
				Green = back[5][15:8];
				Blue = back[5][7:0];
			end
			16'h0006:
			begin
				Red = back[6][23:16];
				Green = back[6][15:8];
				Blue = back[6][7:0];
			end
			16'h0007:
			begin
				Red = back[7][23:16];
				Green = back[7][15:8];
				Blue = back[7][7:0];
			end
			16'h0008:
			begin
				Red = back[8][23:16];
				Green = back[8][15:8];
				Blue = back[8][7:0];
			end
			16'h0009:
			begin
				Red = back[9][23:16];
				Green = back[9][15:8];
				Blue = back[9][7:0];
			end
			16'h000a:
			begin
				Red = back[10][23:16];
				Green = back[10][15:8];
				Blue = back[10][7:0];
			end
			16'h000b:
			begin
				Red = back[11][23:16];
				Green = back[11][15:8];
				Blue = back[11][7:0];
			end
			16'h000c:
			begin
				Red = back[12][23:16];
				Green = back[12][15:8];
				Blue = back[12][7:0];
			end
			16'h000d:
			begin
				Red = back[13][23:16];
				Green = back[13][15:8];
				Blue = back[13][7:0];
			end
			16'h000e:
			begin
				Red = back[14][23:16];
				Green = back[14][15:8];
				Blue = back[14][7:0];
			end
			16'h000f:
			begin
				Red = back[15][23:16];
				Green = back[15][15:8];
				Blue = back[15][7:0];
			end
			16'h0010:
			begin
				Red = back[16][23:16];
				Green = back[16][15:8];
				Blue = back[16][7:0];
			end
			16'h0011:
			begin
				Red = back[17][23:16];
				Green = back[17][15:8];
				Blue = back[17][7:0];
			end
			16'h0012:
			begin
				Red = back[18][23:16];
				Green = back[18][15:8];
				Blue = back[18][7:0];
			end
			16'h0013:
			begin
				Red = back[19][23:16];
				Green = back[19][15:8];
				Blue = back[19][7:0];
			end
			16'h0014:
			begin
				Red = back[20][23:16];
				Green = back[20][15:8];
				Blue = back[20][7:0];
			end
			16'h0015:
			begin
				Red = back[21][23:16];
				Green = back[21][15:8];
				Blue = back[21][7:0];
			end
			16'h0016:
			begin
				Red = back[22][23:16];
				Green = back[22][15:8];
				Blue = back[22][7:0];
			end
			16'h0017:
			begin
				Red = back[23][23:16];
				Green = back[23][15:8];
				Blue = back[23][7:0];
			end
			16'h0018:
			begin
				Red = back[24][23:16];
				Green = back[24][15:8];
				Blue = back[24][7:0];
			end
			16'h0019:
			begin
				Red = back[25][23:16];
				Green = back[25][15:8];
				Blue = back[25][7:0];
			end
			16'h001a:
			begin
				Red = back[26][23:16];
				Green = back[26][15:8];
				Blue = back[26][7:0];
			end
			16'h001b:
			begin
				Red = back[27][23:16];
				Green = back[27][15:8];
				Blue = back[27][7:0];
			end
			16'h001c:
			begin
				Red = back[28][23:16];
				Green = back[28][15:8];
				Blue = back[28][7:0];
			end
			16'h001d:
			begin
				Red = back[29][23:16];
				Green = back[29][15:8];
				Blue = back[29][7:0];
			end
			16'h001e:
			begin
				Red = back[30][23:16];
				Green = back[30][15:8];
				Blue = back[30][7:0];
			end
			16'h001f:
			begin
				Red = back[31][23:16];
				Green = back[31][15:8];
				Blue = back[31][7:0];
			end
			default:
			begin
				Red = 8'h00;//8'h3f; 
				Green = 8'h00;//8'h00;
				Blue = 8'h00;//8'h7f - {1'b0, DrawX[9:3]};
			end
			endcase
			end
	end
	 
tristate trs(.Clk(Clk), .Data_read(sram_data), .Data(SRAM_DQ));

endmodule