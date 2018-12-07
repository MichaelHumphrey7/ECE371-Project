module squarewave_generator (writedata_square, reset, CLOCK_50);
parameter NOTE_FREQUENCY = 440; //Hz
// Audio reads/writes at 48KHz, 50M/48K ~= 1041
parameter AMPLITUDE = 6'h000100;

	output logic [23:0] writedata_square = AMPLITUDE;
	
	input logic reset, CLOCK_50;
	
	int clockCount;
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			clockCount = 0;
			writedata_square = AMPLITUDE;
		end
		else begin
			if (clockCount == 50000000 / (NOTE_FREQUENCY*2)) begin
				clockCount = 0;
				writedata_square = -1 * writedata_square;
			end
			else
				clockCount++;
				
		end
		
	end
	
endmodule
