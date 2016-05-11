module adctest2;
	// Inputs
	reg clock;
	reg clockenable;
	reg miso;
	// Outputs
	wire adconv;
	wire [0:11] datos;
	wire ready;
	wire sck;
	// Instantiate the Unit Under Test (UUT)
	adc uut (
		.clock(clock), 
		.clockenable(clockenable), 
		.miso(miso), 
		.adconv(adconv), 
		.datos(datos), 
		.ready(ready), 
		.sck(sck)
	);
	
	initial begin
		clock = 0;
		clockenable = 0;
		miso = 0;
		#100;
		repeat(700) begin
			clock=~clock;
			#50;
		end
	end
	
	initial begin
		clock = 0;
		clockenable = 0;
		miso = 0;
		#50;
		repeat(10) begin
			clockenable=~clockenable;
			#3500;
		end
	end
	
	initial begin
		clock = 0;
		clockenable = 0;
		miso = 0;
		repeat(700) begin
			miso=~miso;
			#100;
		end
	end
endmodule

//Es importante observar en la salida
//datostemp, pues estos se actualizan siempre