`include "./ganancia.v"
`include "./dac.v"
`include "./adc.v"
`include "./controlador.v"
`include "./divisorF.v"

module topaudio(
	input clock,
	input miso,
	
	output adconv,
	output ready,
	output sck,
	output mosi,
	output daccs,
	output dacclr,
	output spissb,
	output sf_ce0,
	output fpgainitb,
	output ampcs,
	output ampshdn
);

wire clockslow; //fredivider1
wire enablegain, enableadc, enabledac; //controlador1
wire mosigain, sckgain; //gain1
wire [0:11]datosinterno; //adc1
wire sckadc;
wire mosidac, sckdac; //dac1

assign mosi=mosidac | mosigain;
assign sck=(sckgain | sckadc | sckdac);

fredivider fredivider1(
	.clk(clock),
	
	.clk_out(clockslow) //interno
);

controlador controlador1(
	.clock(clockslow),
	
	.enablegain(enablegain), //interno
	.enableadc(enableadc), //interno
	.enabledac(enabledac), //interno
	.spissb(spissb),
	.sf_ce0(sf_ce0),
	.fpgainitb(fpgainitb)
);

ganancia gain1(
	.clock(clockslow),
	.clockenable(enablegain),
	
	.mosi(mosigain), //interno
	.sck(sckgain), //interno
	.ampcs(ampcs),
	.ampshdn(ampshdn)
);

adc adc1(
	.clock(clockslow),
	.clockenable(enableadc),
	.miso(miso),
	
	.adconv(adconv),
	.ready(ready),
	.sck(sckadc), //interno
	.datos(datosinterno) //interno
);

dac dac1(
	.clock(clockslow), 
	.clockenable(enabledac),
	.datos(datosinterno),
	
	.mosi(mosidac), //interno
	.daccs(daccs),
	.sck(sckdac), //interno
	.dacclr(dacclr)
);

endmodule