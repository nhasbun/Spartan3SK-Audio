module fredivider(
input clk,
output reg clk_out);

//(69*(2*(8+1)/(50*10^6)))^(-1) ---> Fs ~40.3[kHz]
//counter--->8 Reemplazar ese numero para otras Fs

reg [15:0] counter=0;
initial begin
	clk_out<=0;
end

always @(posedge clk)
begin
	if(counter==16'd8) begin
		counter<=16'd0;
		clk_out <= ~clk_out;
	end
	else begin
		counter<=counter+1;
	end
end

endmodule