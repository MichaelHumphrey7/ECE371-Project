module playback_filter (writedata_left, writedata_right, read, write,
								read_ready, write_ready, readdata_left, readdata_right, 
								reset, CLOCK_50);
	
	output logic [23:0] writedata_left, writedata_right;
	output logic write, read;
	
	input logic [23:0] readdata_left, readdata_right;
	input logic read_ready, write_ready;
	input logic reset, CLOCK_50;
	
	FIRfilter_N NoiseFilterLeft (.data_out_24(writedata_left), .data_in_24(readdata_left), .read_ready, .reset, .clk(CLOCK_50));
	FIRfilter_N NoiseFilterRight (.data_out_24(writedata_right), .data_in_24(readdata_right), .read_ready, .reset, .clk(CLOCK_50));
	
	assign read = read_ready & write_ready;
	
	// ??? 
	assign write = write_ready & read_ready;
	
	/* ???
	always_ff @(posedge clk) begin
		write <= (DVL && DVR);
	end
	*/
	
endmodule

	