module letter_mapper(input logic Clk, input logic [18:0] address, output logic [7:0] Red,
								output logic [7:0] Blue, output logic [7:0] Green, output logic zero);

	 logic [2:0] color_code;
	 logic [23:0] palette [0:7];
	 
	always_comb
    begin
		palette[0] = 24'h272323;
		palette[1] = 24'hffffff;
		palette[2] = 24'hf7a503;
		palette[3] = 24'h0b0b0b;
		palette[4] = 24'hdeef00;
		palette[5] = 24'he83000;
		palette[6] = 24'hf77b02;
		palette[7] = 24'hffcf00;
	end
	
	always_ff @ (posedge Clk)
	 begin
			if(color_code == 4'h0)
				zero = 1'b1;
			else
				zero = 1'b0;
			case(color_code)
			3'd0:
			begin
				Red = 8'hff; 
				Green = 8'hff;
				Blue = 8'hff;
			end
			3'd1:
			begin
				Red = palette[1][23:16];
				Green = palette[1][15:8];
				Blue = palette[1][7:0];
			end
			3'd2:
			begin
				Red = palette[2][23:16];
				Green = palette[2][15:8];
				Blue = palette[2][7:0];
			end
			3'd3:
			begin
				Red = palette[3][23:16];
				Green = palette[3][15:8];
				Blue = palette[3][7:0];	
			end
			3'd4:
			begin
				Red = palette[4][23:16];
				Green = palette[4][15:8];
				Blue = palette[4][7:0];
			end
			3'd5:
			begin
				Red = palette[5][23:16];
				Green = palette[5][15:8];
				Blue = palette[5][7:0];
			end
			3'd6:
			begin
				Red = palette[6][23:16];
				Green = palette[6][15:8];
				Blue = palette[6][7:0];
			end
			3'd7:
			begin
				Red = palette[7][23:16];
				Green = palette[7][15:8];
				Blue = palette[7][7:0];
			end
			default:
			begin
				Red = 8'hff; 
				Green = 8'hff;
				Blue = 8'hff;
			end
			endcase
	end
	 
Three ken1(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code));
//Two ken2(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_2));
//One ken3(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_1));
//Fight ken4(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_f));
//KO ken5(.data_In(), .write_address(), .read_address(address), .we(), .Clk(Clk), .data_Out(color_code_ko));



endmodule