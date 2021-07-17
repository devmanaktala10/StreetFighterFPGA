module keypress(input logic Clk, input logic [7:0] keyCode, input logic press, output logic [13:0]keys);

logic [13:0] key ;// w a s d t y u up down left right , . /

initial begin
	for(int i = 0; i < 14; i++)
		key[i] = 0;
end

always_ff @ (posedge Clk)
begin
	case (keyCode)
	8'h1d: // w
	begin
		if(press == 1'b1)
		begin
			key[13] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[13] = 1'b0;
		end
	end
	8'h1c: // a
	begin
		if(press == 1'b1)
		begin
			key[12] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[12] = 1'b0;
		end
	end
	8'h1b: // s
	begin
		if(press == 1'b1)
		begin
			key[11] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[11] = 1'b0;
		end
	end
	8'h23: // d
	begin
		if(press == 1'b1)
		begin
			key[10] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[10] = 1'b0;
		end
	end
	8'h2c: // t
	begin
		if(press == 1'b1)
		begin
			key[9] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[9] = 1'b0;
		end
	end
	8'h35: // y
	begin
		if(press == 1'b1)
		begin
			key[8] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[8] = 1'b0;
		end
	end
	8'h3c: // u
	begin
		if(press == 1'b1)
		begin
			key[7] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[7] = 1'b0;
		end
	end
	8'h41: // ,
	begin
		if(press == 1'b1)
		begin
			key[2] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[2] = 1'b0;
		end
	end
	8'h49: // .
	begin
		if(press == 1'b1)
		begin
			key[1] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[1] = 1'b0;
		end
	end
	8'h4a: // /
	begin
		if(press == 1'b1)
		begin
			key[0] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[0] = 1'b0;
		end
	end
	8'h75: // up ** weird for key presses
	begin
		if(press == 1'b1)
		begin
			key[6] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[6] = 1'b0;
		end
	end
	8'h6b: // left
	begin
		if(press == 1'b1)
		begin
			key[4] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[4] = 1'b0;
		end
	end
	8'h72: // down
	begin
		if(press == 1'b1)
		begin
			key[5] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[5] = 1'b0;
		end
	end
	8'h74: // right
	begin
		if(press == 1'b1)
		begin
			key[3] = 1'b1;
		end
		else if(press == 1'b0)
		begin
			key[3] = 1'b0;
		end
	end
	endcase
end

assign keys = key;

endmodule
