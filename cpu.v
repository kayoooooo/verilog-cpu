// adds two bits together, outputs carry and sum
module halfAdder(ain, bin, c, s);
	//c is carry, s is sum
	input ain,bin;
	output c,s;
	assign s = ain ^ bin;
	assign c = ain & bin;
endmodule

// adds three bits together, outputs carry and sum
module fullAdder(ain, bin, cin, c, s);
	input ain,bin,cin;
	output c,s;
	assign s = (ain ^ bin) ^ cin;
	assign c = (ain & bin) | ((ain ^ bin) & cin);  
endmodule

// adds two 4 bit numbers, outputs 4 digit sum and single digit carry
module fullAdder_4bit(ain, bin, c, s);
	input [3:0] ain,bin;
	wire c1,c2,c3;
	output [3:0] s;
	output c;
	halfAdder h0 (ain[0], bin[0], c1, s[0]);
	fullAdder f0 (ain[1], bin[1], c1, c2, s[1]);
	fullAdder f1 (ain[2], bin[2], c2, c3, s[2]);
	fullAdder f2 (ain[3], bin[3], c3, c, s[3]);
endmodule

// computes "dot product" of two 4 bit numbers (bitwise and)
module multiplier_4bit(ain, bin, p);
	input [3:0] ain,bin;
	output [3:0] p;	
	genvar i;

	for (i = 0; i < 4; i = i + 1) begin;
		assign p[i] = (ain[i] & bin[i]);
	end;
endmodule

// multiples two 2 bit numbers, outputs 4 bit 
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


// module store(in);
// 	input [3:0] in [0:1];
// 	initial begin;
// 	$writememb("mem.list", in, 0, 3);
// 	end
// endmodule

module main;
	reg [3:0] ain, bin;
	wire [3:0] s, p;
	wire c;
	fullAdder_4bit f0 (ain, bin, c, s); 
	multiplier_4bit m0 (ain, bin, p);
	reg [9:0] memory [0:1];
	reg [1:0] a,b;
	wire [3:0] x;
	reg [9:0] inp;
	reg [1:0] func;
	integer f;
	//reg ar [0:9];
	multiply m1 (a,b,x);
	integer i;

	//func = 3 circuit
	reg [1:0] l,m,n,o;
	wire c1;
	wire [3:0] q,r,z;
	multiply m2 (l,m,q);
	multiply m3 (n,o,r);
	fullAdder_4bit f1 (q,r,c1,z);
	initial begin;
		//$readmemb("mem.txt", memory);
		//$display(memory[0]);
		f = $fopen("mem.txt", "r");
		// for (i=0; i < 10; i = i + 1) begin;
		// 	assign ar[i] = $fgetc(f);
		// end;
		//$display(ar);


		//input is func
		//input 00 addition 9:6 + 5:2
		//input 01 multiplication 9:8 * 7:6
		//input 10 dot product 9:6 dot 5:2
		//input 11 multiplyadd 9:8 * 7:6 + 5:4 * 3:2 
		ain = 1111;
		$display("%b", ain);
		$display(ain[3], ain[2], ain[1], ain[0]);
		bin = 0000;

		ain[3] = $fgetc(f);
		ain[2] = $fgetc(f);
		ain[1] = $fgetc(f);
		ain[0] = $fgetc(f);
		bin[3] = $fgetc(f);
		bin[2] = $fgetc(f);
		bin[1] = $fgetc(f);
		bin[0] = $fgetc(f);
		func[1] = $fgetc(f);
		func[0] = $fgetc(f);
		
		if (func == 3) begin;
			l[1] = ain[3];
			l[0] = ain[2];
			m[1] = ain[1];
			m[0] = ain[0];
			n[1] = bin[3];
			n[0] = bin[2];
			o[1] = bin[1];
			o[0] = bin[0];
			#10
			$display("multiply add function thing = %2d", (z + 16 * c1));
		end else if (func == 2) begin;
			#10
			$display("pairwise and = %b", p);
		end else if (func == 1) begin; 
			a[1] = ain[3];
			a[0] = ain[2];
			b[1] = ain[1];
			b[0] = ain[0];
			#10
			$display("%b", x);
		end else if (func == 0) begin;
			#10
			$display("sum = %2d", (s + 16 * c));
		end
	end
endmodule