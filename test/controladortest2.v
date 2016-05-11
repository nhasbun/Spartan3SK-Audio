module controladortest2;

	// Inputs
	reg clock;

	// Outputs
	wire enablegain;
	wire enableadc;
	wire enabledac;
	wire spissb;
	wire sf_ce0;
	wire fpgainitb;

	// Instantiate the Unit Under Test (UUT)
	controlador uut (
		.clock(clock), 
		.enablegain(enablegain), 
		.enableadc(enableadc), 
		.enabledac(enabledac), 
		.spissb(spissb), 
		.sf_ce0(sf_ce0), 
		.fpgainitb(fpgainitb)
	);

	initial begin
		clock = 0;
		#100;
		repeat(300) begin
			clock=~clock;
			#50;
		end
	end
      
endmodule

