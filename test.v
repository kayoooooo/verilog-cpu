module halfAdder(ain, bin, c, s);
	//c is carry, s is sum
	input ain,bin;
	output c,s;
	assign s = ain ^ bin;
	assign c = ain & bin;
endmodule

module multiply(a, b, c);
	output [3:0] c;
	input [1:0] a,b;
	wire s1, s2, s3, s4;

	assign c[0] = a[0] & b[0];
	assign s1 = a[1] & b[0];
	assign s2 = a[0] & b[1];
	halfAdder h0 (s1,s2,s4,c[1]);
	assign s3 = a[1] & b[1];
	halfAdder h1 (s3,s4,c[3],c[2]);
endmodule

module main;
    reg [1:0] a,b;
    wire [3:0] c;
    multiply m0 (a,b,c);
    initial begin;
        a = 11;
        b = 01;
        #10
        $display("%b", c);
    end;
endmodule