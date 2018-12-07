module DFF_24 (Q, D, enable, clk, reset);
	input  logic [23:0] D;
	input logic enable, clk, reset;
	output logic [23:0] Q;
	
	always_ff @(posedge clk) begin 
		if (reset)  
			Q <= 24'b0; 
		else if (enable)
			Q <= D;  
	end  
	
endmodule   
