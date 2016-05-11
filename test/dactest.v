module dactest;

	// Inputs
	reg clock;
	reg clockenable;
	reg [0:11] datos;

	// Outputs
	wire mosi;
	wire daccs;
	wire sck;
	wire dacclr;

	// Instantiate the Unit Under Test (UUT)
	dac uut (
		.clock(clock), 
		.clockenable(clockenable), 
		.datos(datos), 
		.mosi(mosi), 
		.daccs(daccs), 
		.sck(sck), 
		.dacclr(dacclr)
	);

	initial begin
		clock = 0;
		clockenable = 0;
		datos = 2357;
		#100;
		repeat(340) begin
			clock=~clock;
			#50;
		end
	end

	initial begin
		clock = 0;
		clockenable = 0;
		datos = 2357;
		#50;
		repeat(5) begin
			clockenable=~clockenable;
			#3400;
		end
    end
      
endmodule

