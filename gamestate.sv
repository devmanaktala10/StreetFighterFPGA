module gamestate(input logic Clk, input frame_clk, input logic Reset, input logic [13:0] keys, input logic ko, output logic st, output logic gamescreen, output logic dis, output logic [3:0] gamestate);

enum logic [3:0] {start, startgame, three, two, one, fight, game, KO} state, next_state;

logic [9:0] gameC;
assign gamestate = state;
logic frame_clk_delayed, frame_clk_rising_edge;
initial begin
	state <= start;
end

always_ff @ (posedge Clk)
begin
	if(Reset)
	begin
		state <= start;
		gameC <= 10'd0;
	end
	frame_clk_delayed <= frame_clk;
   frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
	if(frame_clk_rising_edge)
	begin
		state <= next_state;
		if(state == startgame)
			st = 1'b1;
		else
			st = 1'b0;
		if(state == startgame)
			gameC <= 10'd0;
		if(state == three || state == two || state == one || state == fight || state == KO)
		begin
			gameC <= gameC + 1;
			dis = 1'b1;
		end
		else
			dis = 1'b0;
	end
end

always_comb
begin
	case(state)
	start:
	begin
		gamescreen = 1'b1;
		if(keys[0] == 1)
			next_state = startgame;
		else
			next_state = start;
	end
	startgame:
	begin
		gamescreen = 1'b0;
		next_state = three;
	end
	three:
	begin
		gamescreen = 1'b0;
		if(gameC == 10'd90)
			next_state = two;
		else
			next_state = three;
	end
	two:
	begin
		gamescreen = 1'b0;
		if(gameC == 10'd180)
			next_state = one;
		else
			next_state = two;
	end
	one:
	begin
		gamescreen = 1'b0;
		if(gameC == 10'd270)
			next_state = fight;
		else
			next_state = one;
	end
	fight:
	begin
		gamescreen = 1'b0;
		if(gameC == 10'd360)
			next_state = game;
		else
			next_state = fight;
	end
	game:
	begin
		gamescreen = 1'b0;
		if(ko)
			next_state = KO;
		else 
			next_state = game;
	end
	KO:
	begin
		gamescreen = 1'b0;
		if(gameC == 10'd500)
			next_state = start;
		else
			next_state = KO;
	end
	default:
	begin
		gamescreen = 1'b0;
		st = 1'b1;
		next_state = start;
	end
	endcase
end
endmodule


