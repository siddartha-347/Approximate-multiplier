`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.01.2025 14:03:45
// Design Name: 
// Module Name: approx_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module full_adder(a,b,ci,s,co);
output s,co;
input a,b,ci;
//assign s=(a|b)^ci;
assign s=(a|b)|ci;
//assign co=(a&b)|(b&ci);
//assign co=a;
assign co=b;
endmodule


module half_adder(a,b,s,c);
output s,c;
input a,b;
assign s=a|b;
assign c=a&b;
endmodule 


module compressor(a,b,c,d,cin,c1,c2,s);
output c1,c2,s;
input a,b,c,d,cin;
assign c2=cin;
//assign s=(a^b)|(c^d);
//assign s=(a|b)|(c|d);
assign s=(a^b)|(c|d);//main case
//assign s=(a^b)|(c^d);
//assign s=(a|b)^(c|d);
//assign s=(a|b)|(c^d);
assign c1=(a&b)|(c&d);
endmodule


module approx_multiplier(a,b,c);
input [3:0] a,b;
output [0:7] c;
assign a00=a[0]&b[0];
assign a10=a[1]&b[0];
assign a20=a[2]&b[0];
assign a30=a[3]&b[0];
assign a01=a[0]&b[1];
assign a11=a[1]&b[1];
assign a21=a[2]&b[1];
assign a31=a[3]&b[1];
assign a02=a[0]&b[2];
assign a12=a[1]&b[2];
assign a22=a[2]&b[2];
assign a32=a[3]&b[2];
assign a03=a[0]&b[3];
assign a13=a[1]&b[3];
assign a23=a[2]&b[3];
assign a33=a[3]&b[3];
assign p10= a10|a01;
assign g10= a10&a01;
assign p20= a20|a02;
assign g20= a20&a02;
assign p30= a30|a03;
assign g30= a30&a03;
assign p21= a12|a21;
assign g21= a12&a21;
assign p31= a13|a31;
assign g31= a13&a31;
assign p32= a32|a23;
assign g32= a32&a23;
assign c[7]=a00;
half_adder h1 (p10,g10,c[6],ci_5);
compressor c8 (p20,g20,a11,0,ci_5,ci_4,c4,c[5]);
compressor c7 (p30,g30,g21,p21,ci_4,ci_3_1,ci_3_2,c_4);
compressor c6 (p31,g31,a22,ci_3_1,ci_3_2,ci_2_1,ci_2_2,c_3);
//compressor c5 (p32,g32,ci_2_1,ci_2_2,0,ci_1_1,ci_1_2,c_2);
full_adder f0 (p32,g32,ci_2_1,c_2,ci_1);
// full_adder f1 (a33,ci_1_1,ci_1_2,c_0,c_1);
half_adder h0 (a33,ci_1,c_1,c_0);
half_adder h2 (c4,c_4,c[4],c3);
half_adder h3 (c3,c_3,c[3],c2);
//half_adder h4 (c2,c_2,c[2],c1);
full_adder h4 (c_2,ci_2_2,c2,c[2],c1);
half_adder h5 (c1,c_1,c[1],c0);
half_adder h6 (c0,c_0,c[0],leave);

endmodule
