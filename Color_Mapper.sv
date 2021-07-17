//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input logic Clk,
							  input logic [5:0] ken,
							  input logic [5:0] bat,
							  input logic  is_ryu, // Whether current pixel belongs to ball 
							  input logic is_bat,
                       input logic  [9:0]Ryu_X_Pos,
							  input logic	[9:0]Ryu_Y_Pos,//   or background (computed in ball.sv)
							  input logic  [9:0]Bat_X_Pos,
							  input logic	[9:0]Bat_Y_Pos,//   or background (computed in ball.sv)
                       input logic  [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B, // VGA RGB output
							  output logic [19:0] addr,
							  output logic [15:0] test,
							  input logic keno,
							  input logic bato,
							  input logic is_health,
							  input logic is_outline,
							  input logic [9:0] bX,
							  input logic isSpesh,
							  input logic isKenSp,
							  input logic isBatSp,
							  input logic isLetter,
							  input logic [9:0] KSP,
							  input logic [9:0] BSP,
							  input logic gamescreen,
							  input logic [3:0] gamestate,
							  inout wire [15:0] SRAM_DQ
                     );
    
    logic [7:0] Red, Green, Blue;
	 logic [18:0] ken_address;
	 logic [18:0] letter_address;
	 logic [18:0] bat_address;
	 logic [18:0] ksp_address;
	 logic [18:0] bsp_address;
	 logic [19:0] sram_addr;
	 logic [15:0] sram_data;
	 assign test = sram_data;
	 logic [7:0] Ken_Red, Ken_Green, Ken_Blue;
	 logic [7:0] Bat_Red, Bat_Green, Bat_Blue;
	 logic [7:0] Back_Red, Back_Green, Back_Blue;
	 logic [7:0] Bsp_Red, Bsp_Green, Bsp_Blue;
	 logic [7:0] Ksp_Red, Ksp_Green, Ksp_Blue;
	 logic [7:0] l_Red, l_Green, l_Blue;
	 logic batzero, kenzero, kspzero, bspzero, lzero;
	 logic [19:0] neg;
	 assign neg = {10'd0, ((DrawX + bX)& 10'b1111111110)};
	 logic [19:0] neg2;
	 assign neg2 = {10'd0, DrawX & 10'b1111111110};
	 
	 assign addr = sram_addr;
	 
	 always_comb
	 begin
		if(gamescreen)
		sram_addr = {20'd204959 + {1'b0, neg2[19:1]} + {10'd0, DrawY} * 20'd320};
		else
		sram_addr = {1'b0, neg[19:1]} + {10'd0, DrawY} * 20'd427 ;
		if(gamestate == 4'b0010)
		 letter_address = ({9'd0, DrawX} - {9'd0, 10'd283}) + ({9'd0, DrawY} - {9'd0, 10'd343})*18'd75;
		else if(gamestate == 4'b0011)
			letter_addres = 19'd5625 + ({9'd0, DrawX} - {9'd0, 10'd283}) + ({9'd0, DrawY} - {9'd0, 10'd150})*18'd75;
		else if(gamestate == 4'b0100)
			letter_addres = 19'd11250 + ({9'd0, DrawX} - {9'd0, 10'd283}) + ({9'd0, DrawY} - {9'd0, 10'd150})*18'd75;
		else if(gamestate == 4'b0101)
		 letter_address = 19'd16875 + ({9'd0, DrawX} - {9'd0, 10'd220}) + ({9'd0, DrawY} - {9'd0, 10'd150})*18'd200;
		else if(gamestate == 4'b0111)
		 letter_address = 19'd31875 +({9'd0, DrawX} - {9'd0, 10'd270}) + ({9'd0, DrawY} - {9'd0, 10'd150})*18'd100;			
		else
			letter_address = 19'd0;
	 end

    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
	 always_comb
	 begin
		ksp_address = ({9'd0, DrawX} - {9'd0, KSP}) + ({9'd0, DrawY} - {9'd0, (10'd479 - 10'd200)})*18'd50;
		bsp_address = (19'd50-{9'd0, DrawX} + {9'd0, BSP}) + ({9'd0, DrawY} - {9'd0, (10'd479 - 10'd200)})*18'd50;
	 end
	 
    always_comb
    begin 
        if (is_ryu == 1'b1) 
        begin
			bat_address = 18'd0;
			if(ken == 6'b001010 || ken == 6'b010010 || ken == 6'b010110 || ken == 6'b011101 || ken == 6'b011110 || ken == 6'b011111 || ken == 6'b100000 || ken == 6'b100001 || ken == 6'b100010)
			begin
				if(keno == 1'b1)
					ken_address = ({9'd0, DrawX} - {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd150;
				else
					ken_address = (19'd150-{9'd0, DrawX} + {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd150;

			end
			else if(ken == 6'b100011)
			begin
				if(keno == 1'b1)
					ken_address = ({9'd0, DrawX} - {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd200;
				else
					ken_address = (19'd200-{9'd0, DrawX} + {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd200;

			end
			else
			begin
				if(keno == 1'b1)
					ken_address = ({9'd0, DrawX} - {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd100;
				else
					ken_address = (19'd100 - {9'd0, DrawX} + {9'd0, Ryu_X_Pos}) + ({9'd0, DrawY} - {9'd0, Ryu_Y_Pos})*18'd100;

			end	
        end
        else if (is_bat == 1'b1)
		  begin
				ken_address = 18'd0;
				if(bat == 6'b001010 || bat == 6'b010010 || bat == 6'b010110 || bat == 6'b011111 || bat == 6'b100001 || bat == 6'b100010)
				begin
					if(bato == 1'b1)
						bat_address = ({9'd0, DrawX} - {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd150;
					else
						bat_address = (19'd150 - {9'd0, DrawX} + {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd150;

				end
				else if(bat == 6'b100011)
				begin
					if(bato == 1'b1)
						bat_address = ({9'd0, DrawX} - {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd200;
					else
						bat_address = (19'd200 - {9'd0, DrawX} + {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd200;

				end
			else
			begin
				if(bato == 1'b1)
					bat_address = ({9'd0, DrawX} - {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd100;
				else
					bat_address = (19'd100 - {9'd0, DrawX} + {9'd0, Bat_X_Pos}) + ({9'd0, DrawY} - {9'd0, Bat_Y_Pos})*18'd100;

			end
	     end		
		  else
        begin
				ken_address = 18'd0;
				bat_address = 18'd0;
        end
    end 
	 
Ken_color_mapper kennen(.Clk, .ken, .address(ken_address), .Red(Ken_Red), .Blue(Ken_Blue), .Green(Ken_Green), .zero(kenzero));
Bat_color_mapper batman(.Clk, .bat, .address(bat_address), .Red(Bat_Red), .Blue(Bat_Blue), .Green(Bat_Green), .zero(batzero));
BatSp_mapper bmapper(.Clk, .address(bsp_address), .Red(Bsp_Red), .Blue(Bsp_Blue), .Green(Bsp_Green), .zero(bspzero));
KenSp_mapper kmapper(.Clk, .address(ksp_address), .Red(Ksp_Red), .Blue(Ksp_Blue), .Green(Ksp_Green), .zero(kspzero));
letter_mapper lmapper(.Clk, .address(letter_address), .gamestate, .Red(l_Red), .Blue(l_Blue), .Green(l_Green), .zero(lzero));
background_color_mapper bg(.Clk, .SRAM_DQ(SRAM_DQ), .Red(Back_Red), .gamescreen, .Blue(Back_Blue), .Green(Back_Green), .data(sram_data), .ublb(DrawX[0]));

always_ff @ (posedge Clk)
begin
	if(gamescreen)
	begin
		Red = Back_Red;
		Blue = Back_Blue;
		Green = Back_Green;
	end
	else
	begin
	if(is_ryu && kenzero == 1'b0)
	begin
		Red = Ken_Red;
		Blue = Ken_Blue;
		Green = Ken_Green;
	end
	else if(is_bat && batzero == 1'b0)
	begin
		Red = Bat_Red;
		Blue = Bat_Blue;
		Green = Bat_Green;	
	end
	else if(is_health)
	begin
		Red = 8'd98;
		Green = 8'd244;
		Blue = 8'd66;
	end
	else if(is_outline)
	begin
		Red = 8'd205;
		Green = 8'd209;
		Blue = 8'd204;
	end
	else if(isSpesh)
	begin
		Red = 8'd73;
		Green = 8'd141;
		Blue = 8'd243;
	end
	else if(isKenSp && kspzero==1'b0)
	begin
		Red = Ksp_Red;
		Green = Ksp_Green;
		Blue =Ksp_Blue;
	end
	else if(isBatSp && bspzero==1'b0)
	begin
		Red =Bsp_Red;
		Green = Bsp_Green;
		Blue=Bsp_Blue;
	end
	else if(isLetter)
	begin
		Red =l_Red;
		Green = l_Green;
		Blue=l_Blue;
	end
	else
	begin
		Red = Back_Red;
		Blue = Back_Blue;
		Green = Back_Green;
	end
	end
end
	 
endmodule
