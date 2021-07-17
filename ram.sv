/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module KenIdle1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_Idle_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenIdle2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:20499];

initial
begin
	 $readmemh("Ken_Idle_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenIdle3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:20999];

initial
begin
	 $readmemh("Ken_Idle_3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenWalk1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_walking_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenWalk2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_walking_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenWalk3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_walking_3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenPunch1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_punching_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenPunch2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("Ken_punching_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenKick1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("Ken_kicking_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenKick2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("Ken_kicking_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenCrouch
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:14999];

initial
begin
	 $readmemh("Ken_crouching.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module KenCrouchPunch
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:22499];

initial
begin
	 $readmemh("Ken_crouch_punching.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module KenJump1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:24999];

initial
begin
	 $readmemh("Ken_jumping_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module KenJump2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:14999];

initial
begin
	 $readmemh("Ken_jumping_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenSpesh1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("ken_special1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenSpesh2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("ken_special2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenSpesh3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("ken_special3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenKO1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:14999];

initial
begin
	 $readmemh("ken_ko1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenKO2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:9999];

initial
begin
	 $readmemh("ken_ko2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module KenProj
(
		input [2:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:2499];

initial
begin
	 $readmemh("ken_project.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule





















module BatIdle1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatIdle2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:20499];

initial
begin
	 $readmemh("bat_2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatIdle3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:20999];

initial
begin
	 $readmemh("bat_3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatWalk1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_walk1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatWalk2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_walk2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatWalk3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_walk3.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatPunch1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_punch1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatPunch2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("bat_punch2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatKick1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_kick1new.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatKick2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("bat_kick2new.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatCrouch
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:14999];

initial
begin
	 $readmemh("bat_crouch.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module BatCrouchKick
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:22499];

initial
begin
	 $readmemh("bat_crouchkick.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule


module BatJump1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_jump1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule



module BatJump2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:24999];

initial
begin
	 $readmemh("bat_jump2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatSpesh1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_special1new.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatSpesh2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:29999];

initial
begin
	 $readmemh("bat_special2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatSpesh3
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:19999];

initial
begin
	 $readmemh("bat_special3new.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatKO1
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:14999];

initial
begin
	 $readmemh("bat_ko1.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatKO2
(
		input [3:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [3:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [3:0] mem [0:9999];

initial
begin
	 $readmemh("bat_ko2.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module BatProj
(
		input [2:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:2499];

initial
begin
	 $readmemh("bat_projectile.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

module Three
(
		input [2:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [2:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [2:0] mem [0:39372];

initial
begin
	 $readmemh("three.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule

//module Two
//(
//		input [2:0] data_In,
//		input [18:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [2:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic [2:0] mem [0:5624];
//
//initial
//begin
//	 $readmemh("two.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out<= mem[read_address];
//end
//
//endmodule
//
//module One
//(
//		input [2:0] data_In,
//		input [18:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [2:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic [2:0] mem [0:5624];
//
//initial
//begin
//	 $readmemh("one.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out<= mem[read_address];
//end
//
//endmodule
//
//module Fight
//(
//		input [2:0] data_In,
//		input [18:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [2:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic [2:0] mem [0:14999];
//
//initial
//begin
//	 $readmemh("fight.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out<= mem[read_address];
//end
//
//endmodule
//
//module KO
//(
//		input [2:0] data_In,
//		input [18:0] write_address, read_address,
//		input we, Clk,
//
//		output logic [2:0] data_Out
//);
//
//// mem has width of 3 bits and a total of 400 addresses
//logic [2:0] mem [0:7499];
//
//initial
//begin
//	 $readmemh("ko.txt", mem);
//end
//
//
//always_ff @ (posedge Clk) begin
//	if (we)
//		mem[write_address] <= data_In;
//	data_Out<= mem[read_address];
//end
//
//endmodule






