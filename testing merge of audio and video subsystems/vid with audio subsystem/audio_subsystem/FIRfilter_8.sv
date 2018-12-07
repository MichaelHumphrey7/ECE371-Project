module FIRfilter_8 (data_out_24, data_in_24, read_ready, reset, clk);
	output logic [23:0] data_out_24;
	input logic [23:0] data_in_24;
	input logic read_ready, reset, clk;

	logic [23:0] db8 [7:0];
	//assign db8[0] = data_in_24;
	
	genvar i;
	generate
		DFF_24 InputBuff (db8[0], data_in_24, read_ready, clk, reset);
		for (i = 0; i < 8-1; i++) begin : data_buffer_generator
			DFF_24 DataBuff (db8[i+1], db8[i], read_ready, clk, reset);
			// create a 24 bit adder and compute the sum of databuffs ASR by 3
		end
	endgenerate
	

	assign data_out_24 = {{3{db8[0][23]}}, db8[0][23:3]} + {{3{db8[1][23]}}, db8[1][23:3]} + {{3{db8[2][23]}}, db8[2][23:3]} + 
								{{3{db8[3][23]}}, db8[3][23:3]} + {{3{db8[4][23]}}, db8[4][23:3]} + {{3{db8[5][23]}}, db8[5][23:3]} + 
								{{3{db8[6][23]}}, db8[6][23:3]} + {{3{db8[7][23]}}, db8[7][23:3]};
	
endmodule


module FIR_testbench();
	logic [23:0] data_out_24;
	logic [23:0] din;
	logic en, reset, clk;
	
	FIRfilter_8 dut(data_out_24, din, en, reset, clk);
	
	initial begin
		clk = 0;
		forever #100 clk <= ~clk;
	end
	
	initial begin
		din = 24'd8; reset = 1; en = 0;
		@(posedge clk);
		reset = 0;
		@(posedge clk);
		en = 1;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd8;
		@(posedge clk);
		din = 24'd16;
		@(posedge clk);
		din = 24'd32;
		@(posedge clk);
		din = 24'd64;
		@(posedge clk);
		din = 24'd128;
		@(posedge clk);
		din = 24'd256;
		@(posedge clk);
		din = 24'd512;
		@(posedge clk);
		din = 24'd1024;
		@(posedge clk);
		din = 24'd2048;
		@(posedge clk);
		en = 0;
		@(posedge clk);
		en = 0;
		@(posedge clk);
		en = 1;
		@(posedge clk);
		din = 24'd4096;
		@(posedge clk);
		din = 24'd8192;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);

		
		$stop;
	end
endmodule
