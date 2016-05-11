module ganancia(
	input clock,
	input clockenable,

	output reg mosi,
	output sck,
	output reg ampcs,
	output reg ampshdn
);

reg [3:0]bloque;
//Gain ocupa 1+8+1 bloques (del 1 al ...7,8,9,0)
//Bloque extra para sincronizar y dejar AMPCS en 1
reg [0:7]gain=8'b0010_0010;
//Gain de -2 usual para aplicaciones de audio
//Minimo de 1.025[V] y maximo de 2.275[V]

reg estadosck;
//Para utilizar el spiSCK solo cuando sea necesario
assign sck=estadosck?clock:0;

initial begin
	bloque<=0;
	ampcs<=1;
	ampshdn<=0;
	estadosck<=0;
	mosi<=0;
end

always@(posedge clock) begin
if(clockenable) begin
	if(bloque==0) begin
		bloque<=1;
		ampcs<=0;
	end
	else if (bloque==9) begin
		bloque<=0;
		estadosck<=0;
		ampcs<=1;
	end
	else begin
		bloque<=bloque+1;
		estadosck<=1;
	end
end
end

always@(negedge clock) begin
	if(bloque!=0 & bloque!=9) begin
		mosi<=gain[bloque-1];
	end
	else mosi<=0;
end

endmodule