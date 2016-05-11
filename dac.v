module dac(
	input clock,
	input clockenable,
	input [0:11]datos,
	
	output reg mosi,
	output reg daccs,
	output sck,
	output dacclr
	);

wire [0:11]datos2compl;
assign datos2compl[0]=~datos[0];
assign datos2compl[1:11]=datos[1:11];
//ADC escribe en complemento 2
//DAC lee en unsigned
	
//DAC necesita 1+32+1 bloques
//Bloque 34=0
//Ultimo bloque se utiliza para dejar dacCS en 1
// Asi no molestar a otros componentes del modulo SPI
reg [5:0]bloque;
reg estadosck;

reg [0:3]command=4'b0011;
reg [0:3]address=4'b0000;
//Los datos del DAC salen en el pinA
assign sck=estadosck?clock:0;
assign dacclr=1;

initial begin
	daccs<=1;
	bloque<=0;
	estadosck<=0;
	mosi<=0;
end

always@(posedge clock) begin
if(clockenable) begin
	if(bloque==0) begin
		bloque<=1;
		daccs<=0;
	end
	
	else if(bloque==33) begin
		bloque<=0;
		daccs<=1;
		estadosck<=0;
	end
	else begin
		bloque<=bloque+1;
		estadosck<=1;
	end
end
end

always@(negedge clock) begin
	if(bloque>=9 & bloque<=12) mosi<=command[bloque-9];
	else if(bloque>=13 & bloque<=16) mosi<=address[bloque-13];
	else if(bloque>=17 & bloque<=28) mosi<=datos2compl[bloque-17];	
	else mosi<=0;
end

endmodule
