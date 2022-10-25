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

module fullAdder_4bit(ain, bin, c, s);
	input [3:0]ain,bin;
	wire c1,c2,c3;
	output [3:0] s;
	output c;
	halfAdder h0 (ain[0], bin[0], c1, s[0]);
	fullAdder f0 (ain[1], bin[1], c1, c2, s[1]);
	fullAdder f1 (ain[2], bin[2], c2, c3, s[2]);
	fullAdder f2 (ain[3], bin[3], c3, c, s[3]);
endmodule

module main;
	reg [3:0] ain, bin, cin;
	wire [3:0] s;
	wire c;
	//halfAdder h0 (a,b,c,s);
	fullAdder_4bit f0 (ain, bin, c, s); 
	initial begin;
	ain = 0101;
	bin = 0011;
	cin = 0;
	#10
	$display(s);
	end
endmodule