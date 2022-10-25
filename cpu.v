module halfAdder(ain, bin,c,s);
	//c is carry, s is sum
	input ain,bin;
	output c,s;
	assign s = ain ^ bin;
	assign c = ain & bin;
endmodule

module fullAdder(ain, bin,cin, c, s);
	input ain,bin,cin;
	output c,s;
	assign s = ain ^ bin ^ cin;
	assign c = (ain & bin) | ((ain ^ bin) & cin) ;  
endmodule

module main;
	reg ain, bin, cin;
	wire c,s;
	//halfAdder h0 (a,b,c,s);
	fullAdder f0 (ain, bin, cin, c, s); 
	initial begin;
	ain = 1;
	bin = 1;
	cin = 0;
	#10
	$display(s);
	end
endmodule