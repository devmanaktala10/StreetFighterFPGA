module sf2(input logic             CLOCK_50,
             input logic      [3:0]  KEY,          //bit 0 is set up as Reset
				 input logic PS2_CLK,
				 input logic PS2_DAT,
				 output logic [19:0] SRAM_ADDR,
				 output logic SRAM_WE_N,
				 output logic SRAM_UB_N,
				 output logic SRAM_LB_N,
				 output logic SRAM_CE_N,
				 output logic SRAM_OE_N,
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,      //VGA horizontal sync signal
				inout wire 	 [15:0]  SRAM_DQ
												);
logic Reset_h, Clk;
	
	 assign SRAM_UB_N = 1'b0;
	 assign SRAM_LB_N = 1'b0;
	 assign SRAM_CE_N = 1'b0;
	 assign SRAM_OE_N = 1'b0;
	 assign SRAM_WE_N = 1'b1;

	 logic [19:0] addr;
    logic [13:0] keys;
	 logic [7:0] keyCode_temp;
	 logic [9:0] DrawX_temp;
	 logic [9:0] DrawY_temp;
	 logic [9:0] Ryu_X_Pos_temp;
	 logic [9:0] Ryu_Y_Pos_temp;
	 logic [9:0] Bat_X_Pos_temp;
	 logic [9:0] Bat_Y_Pos_temp;
	 logic [9:0] bXtemp;
	 logic [5:0] ken;
	 logic [5:0] bat;
	 logic [7:0] jc;
	 logic [15:0] test;
	 logic press_temp;
	 logic psClk;
	 logic psData;
    logic isRyu;
	 logic isBat;
	 logic isHealth;
	 logic [7:0] jcx;
	 logic [7:0] jc2;
	 logic kenot;
	 logic batot;
	 logic isOutline;
	 logic bhit;
	 logic khit;
	 logic isSpesh;
	 logic bdead;
	 logic kdead;
	 logic isKenSp;
	 logic isBatSp;
	 logic [9:0] KSP;
	 logic [9:0] BSP;
	 logic [9:0] KS;
	 logic [9:0] BS;
	 logic kengen;
	 logic batgen;
	 logic gamescreen;
	 logic st;
	 logic kotemp;
	 logic [3:0] gamestate;
	 logic isL;
	
	 
	 assign SRAM_ADDR = addr;
	 
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
	 
	 assign psClk = PS2_CLK;
	 assign psData = PS2_DAT;
	 
	 

    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.Clk, .Reset(Reset_h), .VGA_HS, .VGA_VS, .VGA_CLK, .VGA_BLANK_N, .VGA_SYNC_N, .DrawX(DrawX_temp), .DrawY(DrawY_temp));  // incomplete) ;
//    
//    // Which signal should be frame_clk?
    ball ball_instance(.Clk, .ken(ken), .bat(bat), .Reset(Reset_h), .key(keys), .frame_clk(VGA_VS),
	 .DrawX(DrawX_temp), .DrawY(DrawY_temp), .is_ryu(isRyu), .is_bat(isBat),
	 .Ryu_X(Ryu_X_Pos_temp), .Ryu_Y(Ryu_Y_Pos_temp), .Bat_X(Bat_X_Pos_temp), .Bat_Y(Bat_Y_Pos_temp),
	 .jc(jcx), .jc2(jc2), .bato(batot), .keno(kenot), .ishealth(isHealth), .isoutline(isOutline)
	 , .khit(khit), .bhit(bhit), .bX(bXtemp), .isSp(isSpesh),.kendead(kdead),.batdead(bdead),
	 .isKenSpecial(isKenSp), .isBatSpecial(isBatSp), .KSP, .BSP, .KS, .BS, .Kengen(kengen), .Batgen(batgen),
	 .gamestate, .isLetter(isL));
//    
    color_mapper color_instance(.Clk(Clk), .ken(ken), .is_ryu(isRyu), .DrawX(DrawX_temp),
	 .DrawY(DrawY_temp), .Ryu_X_Pos(Ryu_X_Pos_temp), .Ryu_Y_Pos(Ryu_Y_Pos_temp), .VGA_R, .VGA_G,
	 .VGA_B, .addr(addr), .SRAM_DQ(SRAM_DQ), .test, .is_bat(isBat), .Bat_X_Pos(Bat_X_Pos_temp),
	 .Bat_Y_Pos(Bat_Y_Pos_temp), .bat(bat), .keno(kenot), .bato(batot), .is_health(isHealth),
	 .is_outline(isOutline), .bX(bXtemp), .isSpesh(isSpesh), .isBatSp, .isKenSp, .KSP, .BSP, .gamescreen, .isLetter(isL), .gamestate);
	 
	 keypress key(.Clk, .keyCode(keyCode_temp), .press(press_temp), .keys);
	 
	 gamestate gms(.Clk, .Reset(Reset_h), .frame_clk(VGA_VS), .keys, .ko(kdead | bdead), .st, .gamescreen, .gamestate);
	 
	 keyboard kas(.Clk, .psClk, .psData, .reset(Reset_h), .keyCode(keyCode_temp), .press(press_temp));
	 
	 Ken k(.Clk, .frame_clk(VGA_VS), .key(keys), .out(ken), .jc(jcx), .hit(khit),.isdead(kdead), .KS, .gen(kengen));
	
	 Bat b(.Clk, .frame_clk(VGA_VS), .key(keys), .out(bat), .jc(jc2), .hit(bhit), .isdead(bdead), .BS, .gen(batgen));	
    
    // Display keycode on hex display
    HexDriver hex_inst_0 (bXtemp[3:0], HEX0);
    HexDriver hex_inst_1 (bXtemp[7:4], HEX1);
	 HexDriver hex_inst_2 (test[11:8], HEX2);
	 HexDriver hex_inst_3 (test[15:12], HEX3);
    
endmodule
