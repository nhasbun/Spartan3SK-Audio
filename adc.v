module adc(
	input clock,
	input clockenable,
	input miso,

	output adconv,
	output reg [0:11]datos,
	output reg ready, 
	//Puede ser util tener una señal de aviso
	output sck
);

reg [5:0]bloque;
//Ocupa 1+34 bloques
//1 para el impulso inicial
//bloque 35=0
reg estadoadconv,estadosck;
reg [0:11]datostemp;
//Variable para no estar cambiando los datos a cada momento
//Puede ser util para evitar errores
assign adconv=estadoadconv?clock:0;
assign sck=estadosck?clock:0;

initial begin
	estadoadconv<=0;
	estadosck<=0;
	bloque<=0;
	ready<=0;
end

always@(posedge clock) begin 
if(clockenable) begin 
//Es importante que el clock enable 
// Inicie antes del posedge
//Idealmente medio clock antes
	if(bloque==0) begin
		bloque<=1;
		estadoadconv<=1;
	end
	else if(bloque==34) begin
		bloque<=0;
	end
	else begin
		bloque<=bloque+1;
		estadoadconv<=0;
	end 
end
end

always@(negedge clock) begin
	if(bloque>=4 & bloque<=15) datostemp[bloque-4]<=miso;
	else if(bloque==16) datos<=datostemp;
	else if(bloque==34) ready<=1;
	else if(bloque==0) begin 
		ready<=0;
		estadosck<=0;
	end
	else if(bloque==1) estadosck<=1;
	// Se avisa en el ultimo bloque
	//para no interrumpir el funcionamiento normal del adc
	//Ready funciona con negedge en el ultimo bloque
end

endmodule