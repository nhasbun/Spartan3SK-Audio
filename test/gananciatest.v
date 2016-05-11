module gananciatest;

	// Inputs
	reg clock;
	reg clockenable;

	// Outputs
	wire mosi;
	wire sck;
	wire ampcs;
	wire ampshdn;

	// Instantiate the Unit Under Test (UUT)
	ganancia uut (
		.clock(clock), 
		.clockenable(clockenable), 
		.mosi(mosi), 
		.sck(sck), 
		.ampcs(ampcs), 
		.ampshdn(ampshdn)
		
	);

	initial begin
		clock = 0;
		clockenable = 0;
		#100;
		repeat(200) begin
		clock=~clock;
		#50;
		end
	end
	initial begin
		clock = 0;
		clockenable = 0;
		#50;
		repeat(10) begin
		clockenable=~clockenable;
		#1000;
		end
	end
endmodule

