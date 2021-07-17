module tristate(
	input logic Clk, 
	//input logic tristate_output_enable,
	//input logic [15:0] Data_write, // Data from Mem2IO
	output logic [15:0] Data_read, // Data to Mem2IO
	inout wire [15:0] Data // inout bus to SRAM
);

// Registers are needed between synchronized circuit and asynchronized SRAM 
logic [15:0] Data_write_buffer, Data_read_buffer;

always_ff @(posedge Clk)
begin
	// Always read data from the bus
	Data_read_buffer <= Data;
	// Always updated with the data from Mem2IO which will be written to the bus
	//Data_write_buffer <= Data_write;
end

// Drive (write to) Data bus only when tristate_output_enable is active.
assign Data = {16{1'bZ}};

assign Data_read = Data_read_buffer;

endmodule