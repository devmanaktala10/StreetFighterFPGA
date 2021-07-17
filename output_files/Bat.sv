module Bat(input logic Clk, input logic frame_clk, input logic [13:0] key,input logic isdead, output logic [5:0] out, output logic [7:0] jc,
            output logic hit, input logic [9:0] BS, output logic gen);

enum logic [5:0]{StartI, Idle1, Idle2, Idle3, StartW, Walk1, Walk2, Walk3,
			        StartP, Punch1, Punch2, Punch3, StartPu, Punish1, Punish2, Punish3,
					  StartK, Kick1, Kick2, Kick3, Crouch, StartCP, CrouchP, CrouchPunish,
					  StartJ, Jump1, Jump2, Jump3, Jump4, StartSpesh ,Spesh1, Spesh2, Spesh3, startKO, KO1, KO2} state, next_state;
				
logic [7:0] IdleC = 8'd0;
logic [7:0] WalkC = 8'd0;
logic [7:0] PunchC = 8'd0;
logic [7:0] PunishC = 8'd0;
logic [7:0] KickC = 8'd0;
logic [7:0] CPunchC = 8'd0;
logic [7:0] JumpC = 8'd0;
logic [7:0] SpeshC = 8'd0;
logic [7:0] KOC = 8'd0;

	 logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
		  if(frame_clk_rising_edge)
		  begin
			state <= next_state;
			if(state == StartI)
				IdleC = 8'd0;
			if(state == StartW)
				WalkC = 8'd0;
			if(state == StartP)
				PunchC = 8'd0;
			if(state == StartPu)
				PunishC = 8'd0;
			if(state == StartK)
				KickC = 8'd0;
			if(state == StartCP)
				CPunchC = 8'd0;
			if(state == StartJ)
				JumpC = 8'd0;
			if(state == StartSpesh)
				SpeshC = 8'd0;
			if(state == startKO)
				KOC = 8'd0;
			if(state == KO1)
				KOC = KOC + 1;
			if(SpeshC == 10'd44)
				gen = 1'b1;
			else
				gen = 1'b0;
			if(state == Jump1 || state == Jump2 || state == Jump3 || state == Jump4)
				JumpC = JumpC + 1;
			if(state == Kick1 || state == Kick2 || state == Kick3)
				KickC = KickC + 1;
			if(state == CrouchP)
				CPunchC = CPunchC + 1;
			if(state == Punish1 || state == Punish2 || state == Punish3)
				PunishC = PunishC + 1;
			if(state == Idle1 || state == Idle2 || state == Idle3)
				IdleC = IdleC + 1;
			if(state == Walk1 || state == Walk2 || state == Walk3)
				WalkC = WalkC + 1;
			if(state == Punch1 || state == Punch2 || state == Punch3)
				PunchC = PunchC + 1;
			if(state == Spesh1 || state == Spesh2 || state == Spesh3)
				SpeshC = SpeshC + 1;
			if(PunchC == 8'd4 || KickC == 8'd4 || CPunchC == 8'd1)
				hit = 1'b1;
			else
				hit = 1'b0;
		  end
    end
   
	always_comb
	begin 
		unique case(state)
		StartI:
		begin
			next_state = Idle1;
		end
		Idle1:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(key[4] == 1'b1 || key[3] == 1'b1)
				next_state = StartW;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(IdleC == 8'd8)
				next_state = Idle2;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Idle1;
		end
		Idle2:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(key[4] == 1'b1 || key[3] == 1'b1)
				next_state = StartW;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(IdleC == 8'd16)
				next_state = Idle3;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Idle2;
		end
		Idle3:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(key[4] == 1'b1 || key[3] == 1'b1)
				next_state = StartW;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(IdleC == 8'd24)
				next_state = StartI;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Idle3;
		end
		StartW:
		begin
			next_state = Walk1;
		end
		Walk1:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(!(key[4] == 1'b1 || key[3] == 1'b1))
				next_state = StartI;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(WalkC == 8'd8)
				next_state = Walk2;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Walk1;
		end
		Walk2:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(!(key[4] == 1'b1 || key[3] == 1'b1))
				next_state = StartI;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(WalkC == 8'd16)
				next_state = Walk3;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Walk2;
		end
		Walk3:
		begin
			if(key[6] == 1)
				next_state = StartJ;
			else if(key[5] == 1)
				next_state = Crouch;
			else if(key[1] == 1)
				next_state = StartK;
			else if(key[2] == 1)
				next_state = StartP;
			else if(!(key[4] == 1'b1 || key[3] == 1'b1))
				next_state = StartI;
			else if(key[0] == 1'b1 && BS == 10'd200)
				next_state = StartSpesh;
			else if(WalkC == 8'd24)
				next_state = StartW;
			else if(isdead)
				next_state = startKO;
			else
				next_state = Walk3;
		end
		StartP:
		begin
			next_state = Punch1;
		end
		Punch1:
		begin
			if(PunchC == 8'd3)
				next_state = Punch2;
			else
				next_state = Punch1;
		end
		Punch2:
		begin
			if(PunchC == 8'd10)
				next_state = Punch3;
			else
				next_state = Punch2;
		end
		Punch3:
		begin
			if(PunchC == 8'd15)
				next_state = StartPu;
			else
				next_state = Punch3;
		end
		StartPu:
		begin
			next_state = Punish1;
		end
		Punish1:
		begin
			if(key[2] == 1 || key[1] == 1)
			begin
				if(PunishC == 8'd8)
					next_state = Punish2;
				else
					next_state = Punish1;
			end
			else
				next_state = StartI;
		end
		Punish2:
		begin
			if(key[2] == 1 || key[1] == 1)
			begin
				if(PunishC == 8'd16)
					next_state = Punish2;
				else
					next_state = Punish3;
			end
			else
				next_state = StartI;
		end
		Punish3:
		begin
			if(key[2] == 1 || key[1] == 1)
			begin
				if(PunishC == 8'd24)
					next_state = StartPu;
				else
					next_state = Punish3;
			end
			else
				next_state = StartI;
		end
		StartK:
		begin
			next_state = Kick1;
		end
		Kick1:
		begin
			if(KickC == 8'd3)
				next_state = Kick2;
			else
				next_state = Kick1;
		end
		Kick2:
		begin
			if(KickC == 8'd10)
				next_state = Kick3;
			else
				next_state = Kick2;
		end
		Kick3:
		begin
			if(KickC == 8'd15)
				next_state = StartPu;
			else
				next_state = Kick3;
		end
		Crouch:
		begin
			if(key[5] == 1)
			begin
				if(key[2] == 1)
					next_state = StartCP;
				else
					next_state = Crouch;
			end
			else if(isdead)
				next_state = startKO;
			else
				next_state = StartI;
		end
		StartCP:
			next_state = CrouchP;
		CrouchP:
		begin
			if(CPunchC == 8'd5)
				next_state = CrouchPunish;
			else
				next_state = CrouchP;
		end
		CrouchPunish:
		begin
			if(key[2] == 1)
				next_state = CrouchPunish;
			else
				next_state = Crouch;
		end
		StartJ:
		begin
			next_state = Jump1;
		end
		Jump1:
		begin
			if(JumpC == 8'd5)
				next_state = Jump2;
			else
				next_state = Jump1;
		end
		Jump2:
		begin
			if(JumpC == 8'd15)
				next_state = Jump3;
			else
				next_state = Jump2;
		end
		Jump3:
		begin
			if(JumpC == 8'd55)
				next_state = Jump4;
			else
				next_state = Jump3;
		end
		Jump4:
		begin
			if(JumpC == 8'd75)
				next_state = StartI;
			else
				next_state = Jump4;
		end
		StartSpesh:
		begin
			next_state=Spesh1;
		end
		Spesh1:
		begin
			if(SpeshC == 8'd15)
				next_state=Spesh2;
			else
				next_state=Spesh1;
		end
		Spesh2:
		begin
			if(SpeshC==8'd30)
				next_state = Spesh3;
			else
				next_state = Spesh2;
		end
		Spesh3:
		begin
			if(SpeshC==8'd45)
				next_state = StartI;
			else 
				next_state = Spesh3;
		end
		startKO:
		begin
			next_state = KO1;
		end
		KO1:
		begin
			if(KOC == 8'd10)
			next_state=KO2;
			else
			next_state=KO1;
		end
		KO2:
		begin
			if(isdead)
			next_state=KO2;
			else
			next_state=StartI;
		end
		default:
		begin
			next_state = StartI;
		end
		endcase
	end
	
assign out = state;
assign jc = JumpC;
endmodule
