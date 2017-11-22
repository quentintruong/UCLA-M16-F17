// EEM16 - Logic Design
// Design Assignment #2 - Problem #2.1
// dassign2_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs
`timescale 1ns / 1ps
// ***************
// Building blocks
// ***************

// D-register (flipflop).  Width set via parameter.
// Includes propagation delay t_PD = 3
module dreg(clk, d, q);
    parameter width = 1;
    input clk;
    input [width-1:0] d;
    output [width-1:0] q;
    reg [width-1:0] q;

    always @(posedge clk) begin
        q <= #3 d;
    end
endmodule

// 2-1 Mux.  Width set via parameter.
// Includes propagation delay t_PD = 3
module mux2(a, b, sel, y);
    parameter width = 1;
    input [width-1:0] a, b;
    input sel;
    output [width-1:0] y;

    assign #3 y = sel ? b : a;
endmodule

// Left-shifter
// No propagation delay, it's just wires really
module shl(a, y);
    parameter width = 1;
    input [width-1:0] a;
    output [width-1:0] y;

    assign y = {a[width-2:0], 1'b0};
endmodule

// Right-shifter
// more wires 
module shr(a, y);
    parameter width = 1;
    input [width-1:0] a;
    output [width-1:0] y;

    assign y = {1'b0, a[width-1:1]};
endmodule

// 16-bit adder (declarative Verilog)
// Includes propagation delay t_PD = 3n = 48
module adder16(a, b, sum);
    input [15:0] a, b;
    output [15:0] sum;

    assign #48 sum = a+b;
endmodule

// ****************
// Blocks to design
// ****************

// Lowest order partial product of two inputs 
// Use declarative verilog only
// IMPORTANT: Do not change module or port names
module partial_product (a, b, pp);

    // your code here
    // Include a propagation delay of #1
    // assign #1 pp = ... ;

  input [15:0] a;
  input b;
  output [15:0] pp;
  
  assign #1 pp = {a & {16{b}}};
    
endmodule

// Determine if multiplication is complete
// Use declarative verilog only
// IMPORTANT: Do not change module or port names
module is_done (a, b, done);

    // your code here
    // Include a propagation delay of #4
    // assign #4 done = ... ;

  input [7:0] a;
  input [7:0] b;
  output done;
  
  assign #4 done = (b == 0);
endmodule

// 8 bit unsigned multiply 
// Use structural verilog only
// IMPORTANT: Do not change module or port names
// MSB is leftmost
module multiply (clk, ain, bin, reset, prod, ready);
    input clk;
    input [7:0] ain, bin;
    input reset;
    output [15:0] prod;
    output ready;

    // your code here
    // do not use any delays!
  
  wire [15:0] a_mux_to_dreg;
  wire [15:0] a_dreg_to_shl;
  wire [15:0] a_shl_to_mux;
  wire [7:0] b_mux_to_dreg;
  wire [7:0] b_dreg_to_shr;
  wire [7:0] b_shr_to_mux;
  wire [15:0] pp_to_add;
  wire [15:0] add_to_mux;
  wire [15:0] dreg_to_add;
  
  mux2 #(16) mux16a(a_shl_to_mux, {8'b0, ain}, reset, a_mux_to_dreg);
  dreg #(16) drega(clk, a_mux_to_dreg, a_dreg_to_shl);
  shl #(16) shla(a_dreg_to_shl, a_shl_to_mux);
  
  mux2 #(8) mux8b(b_shr_to_mux, bin, reset, b_mux_to_dreg);
  dreg #(8) dregb(clk, b_mux_to_dreg, b_dreg_to_shr);
  shr #(8) shrb(b_dreg_to_shr, b_shr_to_mux);
  
  partial_product par_prod(a_dreg_to_shl, b_dreg_to_shr[0], pp_to_add);
  
  adder16 add16(pp_to_add, dreg_to_add, add_to_mux);
  mux2 #(16) mux16p(add_to_mux, 16'b0, reset, prod);
  dreg #(16) dregp(clk, prod, dreg_to_add);

  is_done is_done(ain, b_shr_to_mux, ready);
   
endmodule

// Clock generation.  Period set via parameter:
//   clock changes every half_period ticks
//   full clock period = 2*half_period
// Replace half_period parameter with desired value
module clock_gen(clk);
    parameter half_period = 31; // REPLACE half_period HERE
    output clk;
    reg    clk;

    initial clk = 0;
    always #half_period clk = ~clk;
endmodule