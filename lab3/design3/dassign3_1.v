// EEM16 - Logic Design
// Design Assignment #3.1
// dassign3_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
`timescale 1ns / 1ps
// ****************
// Blocks to design
// ****************

// 3.1a) Rectified linear unit
// out = max(0, in/4)
// 16 bit signed input
// 8 bit unsigned output
module relu(in, out);
    input [15:0] in;
    output [7:0] out;

    // your code here
    assign out = {16{~in[15]}} & {2'b0, in[15:2]};
endmodule

// 3.1b) Pipelined 5 input ripple-carry adder
// 16 bit signed inputs
// 1 bit input: valid (when the other inputs are useful numbers)
// 16 bit signed output (truncated)
// 1 bit output: ready (when the output is the sum of valid inputs)
module piped_adder(clk, a, b, c, d, e, valid, sum, ready);
    input clk, valid;
    input [15:0] a, b, c, d, e;
    output [15:0] sum;
    output ready;
  
    // your code here
  
    wire v1, v2, v3;
    dreg dreg_v0(clk, valid, v1);
    dreg dreg_v1(clk, v1, v2);
    dreg dreg_v2(clk, v2, ready);

    wire [15:0] a_1, a_2, a_3;
    wire [15:0] b_1, b_2, b_3;
    wire [15:0] c_1, c_2, c_3;
    wire [15:0] d_1, d_2, d_3;
    wire [15:0] e_1, e_2, e_3; 

    dreg #(16)  dreg_a1(clk, a, a_1);
    dreg #(16)  dreg_a2(clk, a_1, a_2);
    dreg #(16)  dreg_a3(clk, a_2, a_3);

    dreg #(16)  dreg_b1(clk, b, b_1);
    dreg #(16)  dreg_b2(clk, b_1, b_2);
    dreg #(16)  dreg_b3(clk, b_2, b_3);

    dreg #(16)  dreg_c1(clk, c, c_1);
    dreg #(16)  dreg_c2(clk, c_1, c_2);
    dreg #(16)  dreg_c3(clk, c_2, c_3);

    dreg #(16)  dreg_d1(clk, d, d_1);
    dreg #(16)  dreg_d2(clk, d_1, d_2);
    dreg #(16)  dreg_d3(clk, d_2, d_3);

    dreg #(16)  dreg_e1(clk, e, e_1);
    dreg #(16)  dreg_e2(clk, e_1, e_2);
    dreg #(16)  dreg_e3(clk, e_2, e_3);

    wire co_0_3_1_i, co_0_3_1_o;
    wire co_0_4_0_i, co_0_4_0_o;
    wire co_0_4_1_i, co_0_4_1_o;

    wire co_1_3_1_i, co_1_3_1_o;
    wire co_1_4_0_i, co_1_4_0_o;
    wire co_1_4_1_i, co_1_4_1_o;

    wire co_2_3_1_i, co_2_3_1_o;
    wire co_2_4_0_i, co_2_4_0_o;
    wire co_2_4_1_i, co_2_4_1_o;

    wire co_3_3_1_i, co_3_3_1_o;
    wire co_3_4_0_i, co_3_4_0_o;
    wire co_3_4_1_i, co_3_4_1_o;

    dreg dreg_co_0_3_1(clk, co_0_3_1_i, co_0_3_1_o);
    dreg dreg_co_0_4_0(clk, co_0_4_0_i, co_0_4_0_o);
    dreg dreg_co_0_4_1(clk, co_0_4_1_i, co_0_4_1_o);

    dreg dreg_co_1_3_1(clk, co_1_3_1_i, co_1_3_1_o);
    dreg dreg_co_1_4_0(clk, co_1_4_0_i, co_1_4_0_o);
    dreg dreg_co_1_4_1(clk, co_1_4_1_i, co_1_4_1_o);

    dreg dreg_co_2_3_1(clk, co_2_3_1_i, co_2_3_1_o);
    dreg dreg_co_2_4_0(clk, co_2_4_0_i, co_2_4_0_o);
    dreg dreg_co_2_4_1(clk, co_2_4_1_i, co_2_4_1_o);

    dreg dreg_co_3_3_1(clk, co_3_3_1_i, co_3_3_1_o);
    dreg dreg_co_3_4_0(clk, co_3_4_0_i, co_3_4_0_o);
    dreg dreg_co_3_4_1(clk, co_3_4_1_i, co_3_4_1_o);

    wire [3:0]  sum0_i, sum0_o;
    wire [7:0]  sum1_i, sum1_o;
    wire [11:0] sum2_i;

    dreg #(4)   dreg_s0(clk,  sum0_i,                 sum0_o);  
    dreg #(8)   dreg_s1(clk,  {sum1_i[7:4], sum0_o},  sum1_o);  
    dreg #(12)  dreg_s2(clk,  {sum2_i[11:8], sum1_o}, sum[11:0]);  

    adder5carry a5c_0(a[3:0],     b[3:0],     c[3:0],     d[3:0],     e[3:0],     1'b0,       1'b0,       1'b0,       co_0_4_1_i, co_0_3_1_i, co_0_4_0_i, sum0_i[3:0]);
    adder5carry a5c_1(a_1[7:4],   b_1[7:4],   c_1[7:4],   d_1[7:4],   e_1[7:4],   co_0_4_1_o, co_0_4_0_o, co_0_3_1_o, co_1_4_1_i, co_1_3_1_i, co_1_4_0_i, sum1_i[7:4]);
    adder5carry a5c_2(a_2[11:8],  b_2[11:8],  c_2[11:8],  d_2[11:8],  e_2[11:8],  co_1_4_1_o, co_1_4_0_o, co_1_3_1_o, co_2_4_1_i, co_2_3_1_i, co_2_4_0_i, sum2_i[11:8]);
    adder5carry a5c_3(a_3[15:12], b_3[15:12], c_3[15:12], d_3[15:12], e_3[15:12], co_2_4_1_o, co_2_4_0_o, co_2_3_1_o, co_3_4_1_i, co_3_3_1_i, co_3_4_0_i, sum[15:12]);
  
endmodule

// 3.1c) Pipelined neuron
// 8 bit signed weights, bias (constant)
// 8 bit unsigned inputs 
// 1 bit input: new (when a set of inputs are available)
// 8 bit unsigned output 
// 1 bit output: ready (when the output is valid)
module neuron(clk, w1, w2, w3, w4, b, x1, x2, x3, x4, new, y, ready);
    input clk;
    input [7:0] w1, w2, w3, w4, b;  // signed 2s complement
    input [7:0] x1, x2, x3, x4;     // unsigned
    input new;
    output [7:0] y;                 // unsigned
    output ready;

    // your code here

    wire [15:0] prod1, prod2, prod3, prod4;
    wire [15:0] sum;

    wire r1, r2, r3, r4;
    wire pa_r;
    wire [7:0] y_i;

    multiply m1(clk, w1, x1, new, prod1, r1);
    multiply m2(clk, w2, x2, new, prod2, r2);
    multiply m3(clk, w3, x3, new, prod3, r3);
    multiply m4(clk, w4, x4, new, prod4, r4);

    wire r1234, delay;

    dreg        dreg_d(clk, r1 & r2 & r3 & r4, delay);
    mux2        mux_r(r1 & r2 & r3 & r4, 1'b0, delay, r1234);

    piped_adder pa_0(clk, prod1, prod2, prod3, prod4, {{8{b[7]}}, b}, r1234, sum, pa_r);

    relu relu_0(sum, y_i);
  
    dreg          dreg_r(clk,  pa_r, ready);  
    dreg #(8)     dreg_y(clk,  y_i,  y);  

endmodule
