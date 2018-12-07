module FIRfilter_N (data_out_24, data_in_24, read_ready, reset, clk);
	//where N = 2^N_BIT_WIDTH
	parameter N = 16;
	parameter N_BIT_WIDTH = 4;
	
	output logic [23:0] data_out_24;
	input logic [23:0] data_in_24;
	input logic read_ready, reset, clk;

	logic [23:0] dbN [0: N - 1];
	logic [23:0] avg_comp_sum;
	
	genvar i;
	generate
		DFF_24 InputBuff (dbN[0], {{N_BIT_WIDTH{data_in_24[23]}}, data_in_24[23:N_BIT_WIDTH]},
								read_ready, clk, reset);
		for (i = 0; i < N - 1; i++) begin : data_buffer_generator
			DFF_24 DataBuff (dbN[i+1], dbN[i], read_ready, clk, reset);
			// create a 24 bit adder and compute the sum of databuffs ASR by 3
		end
	endgenerate
	
	assign avg_comp_sum = dbN[0] - dbN[N - 1];
	
	accumulator a (data_out_24, avg_comp_sum,  read_ready, clk, reset);
endmodule


module FIR_N_testbench();
	logic [23:0] data_out_24;
	logic [23:0] din;
	logic en, reset, clk;
	
	FIRfilter_N dut(data_out_24, din, en, reset, clk);
	
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
