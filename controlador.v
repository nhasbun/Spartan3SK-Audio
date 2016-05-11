module controlador(
	input clock,
	
	output reg enablegain,
	output reg enableadc,
	output reg enabledac,
	
	//Para el funcionamiento correcto del ADC y DAC
	//Hay que deshabilitar algunos modulos del SPI
	output reg spissb,
	output reg sf_ce0,
	output reg fpgainitb
);

reg [6:0]contador;
initial begin
	contador<=0;
	enablegain<=0;
	enableadc<=0;
	enabledac<=0;
	
	spissb<=1;
	sf_ce0<=1;
	fpgainitb<=0;
end
//10 bloques para gain
//35 para adc
//34 para dac
//Contador desde el 1 al "79"
//79=10 para el contador pues nunca se vuelve a "0" (gain solo una vez)
//Se vuelve a ADC

always@(negedge clock) begin
	if(contador<10) begin
		contador<=contador+1;
		enablegain<=1;
	end
	else if(contador<45) begin
		contador<=contador+1;
		enablegain<=0;
		enableadc<=1;
		enabledac<=0;
	end
	else if(contador<78) begin
		contador<=contador+1;
		enableadc<=0;
		enabledac<=1;
	end
	else if(contador==78) contador<=10;
	//No es elegante poner un elif aca
	//Con un else las simulaciones resultaban erroneas
end

endmodule