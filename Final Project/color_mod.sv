module color_mod #(parameter WIDTH = 640, parameter HEIGHT = 480)
(mred, mgreen, mblue, inred, ingreen, inblue, color_s);
	
	input logic [2:0] color_s;
	input logic [7:0] inred, ingreen, inblue;
	
	output logic [7:0] mred, mgreen, mblue;
	
	logic [7:0] avg;
	assign avg = inred/3 + ingreen/3 + inblue/3;
	
	always_comb begin
		if (|color_s) begin
			if (color_s[2]) mred = avg;
			else mred = 0;
			
			if (color_s[1]) mgreen = avg;
			else mgreen = 0;
			
			if (color_s[0]) mblue = avg;
			else mblue = 0;
		end
		else begin
			mred = inred;
			mgreen = ingreen;
			mblue = inblue;
		end
	end
	
endmodule
