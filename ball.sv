//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [13:0]   keycode,
					input [5:0] ken,
					input [5:0] bat,
					input [13:0] key,
					input [7:0] jc,
					input [7:0] jc2,
               output logic  is_ryu,
					output logic  is_bat,
					output logic  [9:0]Ryu_X,
					output logic  [9:0]Ryu_Y,// Whether current pixel belongs to ball or background
					output logic  [9:0]Bat_X,
					output logic  [9:0]Bat_Y,
					output logic bato,
					output logic keno,
					output logic ishealth,
					output logic isLetter,
					input logic bhit,
					input logic khit,
					input logic Kengen,
					input logic Batgen,
					output logic isoutline,
					output logic isSp,
					output logic batdead,
					output logic kendead,
					output logic [9:0] KS,
					output logic [9:0] BS,
					output logic isKenSpecial,
					output logic isBatSpecial,
					input logic [3:0] gamestate,
					output logic [9:0] KSP,
					output logic [9:0] BSP,
					output logic [9:0] bX// Whether current pixel belongs to ball or background
              );
    
    parameter [9:0] Ryu_X_Center = 10'd150;  // Center position on the X axis
    parameter [9:0] Ryu_Y_Center = 10'd279;  // Center position on the Y axis
    parameter [9:0] Ryu_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ryu_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ryu_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ryu_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Ryu_X_Step = 10'd5;      // Step size on the X axis
    parameter [9:0] Ryu_Y_Step = 10'd5;      // Step size on the Y axis
	 logic [9:0] Ryu_X_Size ;//= 10'd100;
	 logic [9:0] Ryu_Y_Size ;//= 10'd200;
	 logic [9:0] BatSpecial;
	 logic [9:0] KenSpecial;
	 logic [9:0] BatSpecialin;
	 logic [9:0] KenSpecialin;
	 logic bsp;
	 logic ksp;
	 
	 parameter [9:0] Bat_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Bat_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Bat_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Bat_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Bat_X_Step = 10'd5;      // Step size on the X axis
    parameter [9:0] Bat_Y_Step = 10'd5;      // Step size on the Y axis
	 
	 parameter [9:0] Bat_X_Center = 10'd330;  // Center position on the X axis
    parameter [9:0] Bat_Y_Center = 10'd279;  // Center position on the Y axis
	 
	 logic [9:0] Bat_X_Size ;//= 10'd100;
	 logic [9:0] Bat_Y_Size ;//= 10'd200;
	 logic [9:0] Bat_Sp;
	 logic [9:0] Ken_Sp;
	 
	 assign KS = Ken_Sp;
	 assign BS = Bat_Sp;
	 logic isSpesh;
	 logic backl;
	 logic backr;
	 assign bX = backX;
    
    logic [9:0] Ryu_X_Pos, Ryu_X_Motion, Ryu_Y_Pos, Ryu_Y_Motion;
    logic [9:0] Ryu_X_Pos_in, Ryu_X_Motion_in, Ryu_Y_Pos_in, Ryu_Y_Motion_in;
	 
	 logic [9:0] Bat_X_Pos, Bat_X_Motion, Bat_Y_Pos, Bat_Y_Motion;
    logic [9:0] Bat_X_Pos_in, Bat_X_Motion_in, Bat_Y_Pos_in, Bat_Y_Motion_in;
	 logic bathit;
	 logic kenhit;
	 logic batleftmove;
	 logic kenleftmove;
	 logic [9:0] kenhealth;
	 logic [9:0] bathealth;
	 logic [9:0] backX;
	 logic batspecialhit;
	 logic kenspecialhit;
	 
	 always_comb
	 begin
		keno = 1'b1;
		bato = 1'b0;
		if(bathealth == 10'd0)
			batdead=1'b1;
		else
			batdead=1'b0;
		if(kenhealth == 10'd0)
			kendead=1'b1;
		else
			kendead=1'b0;
	 end
	 
	 always_comb
	 begin
		case(ken)
		6'b00000:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200; 
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b00001:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000010:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd205;
			Ryu_Y_Pos_in = 10'd479 - 10'd205 - 10'd25;
		end
		6'b000011:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd210;
			Ryu_Y_Pos_in = 10'd479 - 10'd210 - 10'd25;
		end
		6'b000100:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000101:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000110:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000111:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001000:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001001:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001010:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001011:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001100:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001101:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001110:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd205;
			Ryu_Y_Pos_in = 10'd479 - 10'd205 - 10'd25;
		end
		6'b001111:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd210;
			Ryu_Y_Pos_in = 10'd479 - 10'd210 - 10'd25;
		end
		6'b010000:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010001:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010010:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010011:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010100: // Crouch
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010101: // Start Crouch Punch
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010110: // Crouch Punch
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010111: // Crouch Punish
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b011000: // Start Jump
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd250;
			Ryu_Y_Pos_in = 10'd479 - 10'd250 - 10'd25;
		end
		6'b011001: // Jump 1
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd250;
			Ryu_Y_Pos_in = 10'd479 - 10'd250 - 10'd6*jc - 10'd25;
		end
		6'b011010: // Jump 2
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd250 - 10'd6*jc - 10'd25;
		end
		6'b011011: // Jump 3
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd150;
			Ryu_Y_Pos_in = 10'd479 - 10'd250 - 10'd6*10'd30 + 10'd3*(jc-8'd15) - 10'd25;
		end
		6'b011100: // Jump 4
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd250;
			Ryu_Y_Pos_in = 10'd479 - 10'd250 - 10'd6*10'd30 + 10'd3*(jc-8'd15) - 10'd25;
		end
		6'b011101:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b011110:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b011111:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b100000:
		begin
			Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b100001:
		begin
		   Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd100;
			Ryu_Y_Pos_in = 10'd479 - 10'd100 - 10'd25;
		end
		6'b100010:
		begin
		   Ryu_X_Size = 10'd150;
			Ryu_Y_Size = 10'd100;
			Ryu_Y_Pos_in = 10'd479 - 10'd100 - 10'd25;
		end
		6'b100011:
		begin
		   Ryu_X_Size = 10'd200;
			Ryu_Y_Size = 10'd50;
			Ryu_Y_Pos_in = 10'd479 - 10'd50 - 10'd25;
		end
		default:
		begin
			Ryu_X_Size = 10'd100;
			Ryu_Y_Size = 10'd200;
			Ryu_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		endcase
	 end
	 
	 
	 always_comb
	 begin
		case(bat)
		6'b000000:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000001:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000010:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd205;
			Bat_Y_Pos_in = 10'd479 - 10'd205 - 10'd25;
		end
		6'b000011:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd210;
			Bat_Y_Pos_in = 10'd479 - 10'd210 - 10'd25;
		end
		6'b00100:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000101:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000110:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b000111:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001000:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001001:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001010:
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001011:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001100:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001101:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b001110:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd205;
			Bat_Y_Pos_in = 10'd479 - 10'd205 - 10'd25;
		end
		6'b001111:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd210;
			Bat_Y_Pos_in = 10'd479 - 10'd210 - 10'd25;
		end 
		6'b010000:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010001:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010010:
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010011:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b010100: // Crouch
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd150;
			Bat_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010101: // Start Crouch Punch
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd150;
			Bat_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010110: // Crouch Punch
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd150;
			Bat_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b010111: // Crouch Punish
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd150;
			Bat_Y_Pos_in = 10'd479 - 10'd150 - 10'd25;
		end
		6'b011000: // Start Jump
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd250;
			Bat_Y_Pos_in = 10'd479 - 10'd250 - 10'd25;
		end
		6'b011001: // Jump 1
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd15*jc2 - 10'd25;
		end
		6'b011010: // Jump 2
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd15*jc2 - 10'd25;
		end
		6'b011011: // Jump 3
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd250;
			Bat_Y_Pos_in = 10'd479 - 10'd250 - 10'd175 + 10'd3*(jc2-8'd15) - 10'd25;
		end
		6'b011100: // Jump 4
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd250;
			Bat_Y_Pos_in = 10'd479 - 10'd250 - 10'd175 + 10'd3*(jc2-8'd15) - 10'd25;
		end
		6'b011101:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b011110:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b011111:
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b100000:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end
		6'b100001:
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd100;
			Bat_Y_Pos_in = 10'd479 - 10'd100 - 10'd25;
		end
		6'b100010:
		begin
			Bat_X_Size = 10'd150;
			Bat_Y_Size = 10'd100;
			Bat_Y_Pos_in = 10'd479 - 10'd100 - 10'd25;
		end
		6'b100011:
		begin
			Bat_X_Size = 10'd200;
			Bat_Y_Size = 10'd50;
			Bat_Y_Pos_in = 10'd479 - 10'd50 - 10'd25;
		end
		default:
		begin
			Bat_X_Size = 10'd100;
			Bat_Y_Size = 10'd200;
			Bat_Y_Pos_in = 10'd479 - 10'd200 - 10'd25;
		end 
		endcase
	 end
	 
	 assign Ryu_X = Ryu_X_Pos;
	 assign Ryu_Y = Ryu_Y_Pos;
	 
	 assign Bat_X = Bat_X_Pos;
	 assign Bat_Y = Bat_Y_Pos;
	 
	 initial begin
	 ksp = 1'b0;
	 bsp = 1'b0;
	 kenhealth = 10'd200;
	 bathealth = 10'd200;
	 Ryu_X_Pos <= Ryu_X_Center;
    Ryu_Y_Pos <= 10'd10;
    Ryu_X_Motion <= 10'd0;
    Ryu_Y_Motion <= 10'd0;
	 backX <= 10'd106;
	 Bat_X_Pos <= 10'd600;
    Bat_Y_Pos <= Bat_Y_Center;
    Bat_X_Motion <= 10'd0;
    Bat_Y_Motion <= 10'd0;
	 Ken_Sp <= 10'd0;
	 Bat_Sp <= 10'd0;
	 end
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ryu_X_Pos <= Ryu_X_Center;
            Ryu_Y_Pos <= 10'd10;
            Ryu_X_Motion <= 10'd0;
            Ryu_Y_Motion <= 10'd0;
				Bat_X_Pos <= 10'd550;
            Bat_Y_Pos <= 10'd10;
            Bat_X_Motion <= 10'd0;
            Bat_Y_Motion <= 10'd0;
				kenhealth = 10'd200;
				bathealth = 10'd200;
				Ken_Sp <= 10'd0;
				Bat_Sp <= 10'd0;
				ksp = 1'b0;
				bsp = 1'b0;
        end
        else
        begin
            Ryu_X_Pos <= Ryu_X_Pos_in;
				Ryu_Y_Pos <= Ryu_Y_Pos_in;
            Ryu_X_Motion <= Ryu_X_Motion_in;
            Ryu_Y_Motion <= Ryu_Y_Motion_in;
            Bat_X_Pos <= Bat_X_Pos_in;
				Bat_Y_Pos <= Bat_Y_Pos_in;
            Bat_X_Motion <= Bat_X_Motion_in;
            Bat_Y_Motion <= Bat_Y_Motion_in;
				KenSpecial <= KenSpecialin;
				BatSpecial <= BatSpecialin;
        end
		  if(frame_clk_rising_edge)
		  begin
		   if(bhit && kenhit && kenhealth >= 10'd5)
			begin
				kenhealth = kenhealth - 10'd5;
			end
			if(khit && bathit && bathealth >= 10'd5)
			begin
				bathealth = bathealth - 10'd5;
			end
			if(bhit && kenhit && Bat_Sp < 200)
			begin
				Bat_Sp <= Bat_Sp + 10'd20;
			end
			if(khit && bathit && Ken_Sp < 200)
			begin
				Ken_Sp <= Ken_Sp + 10'd20;
			end
			if(batspecialhit == 1'b1)
			begin
				if(bathealth >= 10'd20)
				bathealth = bathealth - 10'd20;
				else if(bathealth < 10'd20 && bathealth > 10'd0)
				bathealth = 10'd0;
				ksp = 1'b0;
			end
			if(kenspecialhit == 1'b1)
			begin
				if(kenhealth >= 10'd20)
				kenhealth = kenhealth - 10'd20;
				else if(kenhealth < 10'd20 && kenhealth > 10'd0)
				kenhealth = 10'd0;
				bsp = 1'b0;
			end
			if(backl == 1'b1)
				backX = backX - 10'd5;
			if(backr == 1'b1)
				backX = backX + 10'd5;
			if(Kengen)
			begin
				Ken_Sp <= 10'd0;
				ksp = 1'b1;
			end
			if(Batgen)
			begin
				Bat_Sp <= 10'd0;
				bsp = 1'b1;
			end
		  end
    end
    //////// Do not modify the always_ff blocks. ////////
	 
	 always_comb
	 begin
			KenSpecialin = KenSpecial;
			BatSpecialin = BatSpecial;
		if(frame_clk_rising_edge)
		begin
		if(ksp == 1'b0)
			KenSpecialin = Ryu_X_Pos + Ryu_X_Size + 10'd5;
		else
			KenSpecialin = KenSpecial + 10'd5;
		if(bsp == 1'b0)
			BatSpecialin = Bat_X_Pos - Bat_X_Size - 10'd5;
		else
			BatSpecialin = BatSpecial - 10'd5;
		end
	 end
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
		  batspecialhit = 1'b0;
		  kenspecialhit = 1'b0;
		  bathit = 1'b0;
		  kenhit = 1'b0;
		  backl = 1'b0;
		  backr = 1'b0;
		  batleftmove = 1'b0;
		  kenleftmove = 1'b0;
		  Ryu_X_Pos_in = Ryu_X_Pos;
		  Ryu_X_Motion_in = Ryu_X_Motion;
		  Ryu_Y_Motion_in = Ryu_Y_Motion;
		  Bat_X_Pos_in = Bat_X_Pos;
		  Bat_X_Motion_in = Bat_X_Motion;
		  Bat_Y_Motion_in = Bat_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
			if(keno == 1'b1)
			begin
				//handle player collision + attacks
				if(Bat_X_Pos - Bat_X_Size <= KenSpecial && ksp == 1)
				begin
					batspecialhit = 1'b1;
					Bat_X_Motion_in = Bat_X_Step;
				end
				else if(Ryu_X_Pos + Ryu_X_Size >= BatSpecial && bsp == 1)
				begin
					kenspecialhit = 1'b1;
					Ryu_X_Motion_in = ~(Ryu_X_Step) + 1'b1;
				end
				else if(Ryu_X_Pos + Ryu_X_Size >= Bat_X_Pos - Bat_X_Size)//collision
				begin
					if((ken == 6'd18 && bat != 6'd20)|| ken == 6'd10 || ken == 6'd22)
					begin
						bathit = 1'b1;
						Bat_X_Pos_in = Ryu_X_Pos + Ryu_X_Size + Bat_X_Size + 1'b1;
					end
					else if((bat == 6'd18&& ken != 6'd20) || bat == 6'd22 || bat == 6'd10)
					begin
						kenhit = 1'b1;
						Ryu_X_Pos_in = Bat_X_Pos - Bat_X_Size - Ryu_X_Size - 1'b1;
						if(Ryu_X_Pos_in + 10'd50 < 10'd55)
						begin
							Ryu_X_Pos_in = 10'd5;
							Bat_X_Pos_in = 10'd5 + Ryu_X_Size+Bat_X_Size;
						end
					end
					else
					begin
						Bat_X_Motion_in = Bat_X_Step;
						Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
					end
				end
				//handle wall collision
				//handle movement
				else
				begin // 1
					if ( Ryu_X_Pos + Ryu_X_Size >= Ryu_X_Max)
					begin //2
						Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
					end //2
					else if ( Ryu_X_Pos + 10'd50<= Ryu_X_Min + 10'd6 + 10'd50)
					begin//2
						if(Bat_X_Pos + 10'd5 <= Bat_X_Max && backX >= 10'd5)
						begin
							Ryu_X_Pos_in = Ryu_X_Pos + 10'd5;
							Bat_X_Pos_in = Bat_X_Pos + 10'd5;
							backl = 1'b1;
						end
						else
						Ryu_X_Motion_in = Ryu_X_Step;
					end //2
					else
					begin //2
						if(ken == 6'b001001 || ken == 6'b001010 || ken == 6'b001011 || ken == 6'b001000 ||
							ken == 6'b010000 || ken == 6'b010001 || ken == 6'b010010 || ken == 6'b010011 ||
							ken == 6'b010100 || ken == 6'b010101 || ken == 6'b010110 || ken == 6'b010111 ||
							ken == 6'b011101 || ken == 6'b011110 || ken == 6'b011111 || ken == 6'b100000)
							Ryu_X_Motion_in = 10'd0;
						else if(key[12] == 1'b1)
							Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
						else if(key[10] == 1'b1) 
							Ryu_X_Motion_in = Ryu_X_Step;
						else
							Ryu_X_Motion_in = 10'd0;
					end //2
					
					if ( Bat_X_Pos >= Bat_X_Max)
					begin //2
						if(Ryu_X_Pos > Ryu_X_Min + 10'd10 && backX <= 10'd208)
						begin
							Ryu_X_Pos_in = Ryu_X_Pos - 10'd5;
							Bat_X_Pos_in = Bat_X_Pos - 10'd5;
							backr = 1'b1;
						end
						else
						Bat_X_Motion_in = (~(Bat_X_Step) + 1'b1);
					end //2
					else if (Bat_X_Pos - Bat_X_Size <= Bat_X_Min + 3'd5)
					begin//2
						Bat_X_Motion_in = Bat_X_Step;
					end//2
					else
					begin//2
						if(bat == 6'b001001 || bat == 6'b001010 || bat == 6'b001011 || bat == 6'b001000 ||
							bat == 6'b010000 || bat == 6'b010001 || bat == 6'b010010 || bat == 6'b010011 ||
							bat == 6'b010100 || bat == 6'b010101 || bat == 6'b010110 || bat == 6'b010111 ||
							bat == 6'b011101 || bat == 6'b011110 || bat == 6'b011111 || bat == 6'b100000)
							Bat_X_Motion_in = 10'd0;
						else if(key[4] == 1'b1)
							Bat_X_Motion_in = (~(Bat_X_Step) + 1'b1);
						else if(key[3] == 1'b1) 
							Bat_X_Motion_in = Bat_X_Step;
						else
							Bat_X_Motion_in = 10'd0;
					end//2
				end//1 else end
		   end//keno == 1
			 if(bathit == 1'b0 && kenhit == 1'b0 && backr == 1'b0 && backl == 1'b0)
			 begin
			 Ryu_X_Pos_in = Ryu_X_Pos + Ryu_X_Motion;
			 Bat_X_Pos_in = Bat_X_Pos + Bat_X_Motion;
		    end
	 end //frame clock end
	end // always comb end
	
	
	always_comb
	begin
		isSpesh = 1'b0;
		if((DrawX > 10'd5 && DrawX < Ken_Sp + 10'd5 && DrawY > 10'd25 && DrawY < 10'd35) || 
		(DrawX + Bat_Sp > 10'd434 + 10'd200 && DrawX < 10'd634 && DrawY > 10'd25 && DrawY < 10'd35))
		begin
			isSpesh = 1'b1;
		end
	end
    
	 always_comb
	 begin
		ishealth = 1'b0;
		isoutline = 1'b0;
		if(
		(
		(DrawY == 10'd5 || DrawY == 10'd25)&&
		((DrawX >= 10'd5 && DrawX <= 10'd205) || (DrawX >= 10'd434 && DrawX <= 10'd634))
		)|| 
		(
		(DrawX == 10'd5 || DrawX == 10'd205 || DrawX == 10'd434 || DrawX == 10'd634) 
		&& 
		(DrawY >= 10'd5 && DrawY <= 10'd25))
		)
		begin
			isoutline = 1'b1;
		end
		else if((DrawX > 10'd5 && DrawX < kenhealth + 10'd5 && DrawY > 10'd5 && DrawY < 10'd25) || 
		(DrawX + bathealth > 10'd434 + 10'd200 && DrawX < 10'd634 && DrawY > 10'd5 && DrawY < 10'd25))
		begin
			ishealth = 1'b1;
		end
	 end
	 
	 
    always_comb begin
		if(keno == 1'b1)//ken right
		begin
			if(DrawX >= 10'd283 && DrawX < 10'd358 && DrawY >= 10'd150 && DrawY < 10'd225 && (gamestate == 4'b0010 || gamestate == 4'b0011 || gamestate == 4'b0100))
				isLetter = 1'b1;
			else if(DrawX >= 10'd270 && DrawX < 10'd370 && DrawY >= 10'd150 && DrawY < 10'd225 && (gamestate == 4'b0111))
				isLetter = 1'b1;
			else if(DrawX >= 10'd220 && DrawX < 10'd420 && DrawY >= 10'd150 && DrawY < 10'd225 && (gamestate == 4'b0101))
				isLetter = 1'b1;
			else
				isLetter = 1'b0;
        if (DrawX >= Ryu_X_Pos && DrawX < (Ryu_X_Pos + Ryu_X_Size) && DrawY >= Ryu_Y_Pos && DrawY < (Ryu_Y_Pos + Ryu_Y_Size)) 
            is_ryu = 1'b1;
        else
            is_ryu = 1'b0;
				
        if (DrawX >= (Bat_X_Pos - Bat_X_Size) && DrawX < Bat_X_Pos && DrawY >= Bat_Y_Pos && DrawY < (Bat_Y_Pos + Bat_Y_Size)) 
            is_bat = 1'b1;
        else
            is_bat = 1'b0;
		  if (DrawX >= KenSpecial && DrawX < KenSpecial + 10'd50 && DrawY >= (10'd479 - 10'd200) && DrawY < (10'd479 - 10'd150) && ksp == 1'b1)
				isKenSpecial = 1'b1;
			else
				isKenSpecial = 1'b0;
		  if (DrawX + 10'd50 >= BatSpecial&& DrawX < BatSpecial && DrawY >= (10'd479 - 10'd200) && DrawY < (10'd479 - 10'd150) && bsp == 1'b1)
				isBatSpecial = 1'b1;
			else
				isBatSpecial = 1'b0;	
		end
		else
		begin
			isLetter =1'b0;
			isBatSpecial = 1'b0;
			isKenSpecial = 1'b0;
		  if (DrawX >= (Ryu_X_Pos - Ryu_X_Size) && DrawX < Ryu_X_Pos && DrawY >= Ryu_Y_Pos && DrawY < (Ryu_Y_Pos + Ryu_Y_Size)) 
            is_ryu = 1'b1;
        else
            is_ryu = 1'b0;
				
        if (DrawX >= Bat_X_Pos && DrawX < (Bat_X_Pos + Bat_X_Size) && DrawY >= Bat_Y_Pos && DrawY < (Bat_Y_Pos + Bat_Y_Size)) 
            is_bat = 1'b1;
        else
            is_bat = 1'b0;
		end
    end
	 
	 	 assign isSp = isSpesh;
		 assign KSP = KenSpecial;
		 assign BSP = BatSpecial;
    
endmodule

//if(bato == 1'b1 && (Bat_X_Pos + Bat_X_Size >= Ryu_X_Pos))//bat is facing right
//				begin
//					Bat_X_Motion_in = (~(Bat_X_Step) + 1'b1);
//					Ryu_X_Motion_in = Ryu_X_Step;
//				end
//				else if(keno == 1'b1 && (Ryu_X_Pos + Ryu_X_Size >= Bat_X_Pos))
//				begin
//					if(ken == 6'd10 || ken == 6'd18 || ken == 6'd22)
//					begin
//						bathit = 1'b1;
//						Bat_X_Pos_in = Ryu_X_Pos + Ryu_X_Size + 1'b1;
//					end
//					else if(bat == 6'd10 || bat == 6'd18 || bat == 6'd22)
//					begin
//						kenhit = 1'b1;
//						Ryu_X_Pos_in = Bat_X_Pos - Bat_X_Size - 1'b1;
//						if(Ryu_X_Pos_in <= 10'd5)
//							Ryu_X_Pos_in = 10'd5;
//					end
//					else
//					begin
//						Bat_X_Motion_in = Bat_X_Step;
//						Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
//					end
//				end
//				else
//				begin
//				if ( Ryu_X_Pos + Ryu_X_Size >= Ryu_X_Max)
//				begin
//					Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
//				end
//				else if ( Ryu_X_Pos <= Ryu_X_Min + 3'd5)
//				begin
//					Ryu_X_Motion_in = Ryu_X_Step;
//				end
//				else
//				begin
//					if(ken == 6'b001001 || ken == 6'b001010 || ken == 6'b001011 || ken == 6'b001000 ||
//					   ken == 6'b010000 || ken == 6'b010001 || ken == 6'b010010 || ken == 6'b010011 ||
//						ken == 6'b010100 || ken == 6'b010101 || ken == 6'b010110 || ken == 6'b010111)
//						Ryu_X_Motion_in = 10'd0;
//					else if(key[12] == 1'b1)
//						Ryu_X_Motion_in = (~(Ryu_X_Step) + 1'b1);
//					else if(key[10] == 1'b1) 
//						Ryu_X_Motion_in = Ryu_X_Step;
//					else
//						Ryu_X_Motion_in = 10'd0;
//				end
//				
//				if ( Bat_X_Pos + Bat_X_Size >= Bat_X_Max)
//				begin
//					Bat_X_Motion_in = (~(Bat_X_Step) + 1'b1);
//				end
//				else if ( Bat_X_Pos <= Bat_X_Min + 3'd5)
//				begin
//					Bat_X_Motion_in = Bat_X_Step;
//				end
//				else
//				begin
//					if(bat == 6'b001001 || bat == 6'b001010 || bat == 6'b001011 || bat == 6'b001000 ||
//					   bat == 6'b010000 || bat == 6'b010001 || bat == 6'b010010 || bat == 6'b010011 ||
//						bat == 6'b010100 || bat == 6'b010101 || bat == 6'b010110 || bat == 6'b010111)
//						Bat_X_Motion_in = 10'd0;
//					else if(key[4] == 1'b1)
//						Bat_X_Motion_in = (~(Bat_X_Step) + 1'b1);
//					else if(key[3] == 1'b1) 
//						Bat_X_Motion_in = Bat_X_Step;
//					else
//						Bat_X_Motion_in = 10'd0;
//				end
//			end
//			if(bathit == 1'b0 && kenhit == 1'b0)
//			begin
