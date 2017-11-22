// EEM16 - Logic Design
// Design Assignment #2 - Problem #2.2
// dassign2_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs
`timescale 1ns / 1ps
// Include constants file defining THRESHOLD, CMDs, STATEs

`include "constants2_2.vh"

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

// 4-1 Mux.  Width set via parameter.
// Includes propagation delay t_PD = 3
module mux4(a, b, c, d, sel, y);
    parameter width = 1;
    input [width-1:0] a, b, c, d;
    input [1:0] sel;
    output [width-1:0] y;
    reg [width-1:0] y;

    always @(*) begin
        case (sel)
            2'b00:    y <= #3 a;
            2'b01:    y <= #3 b;
            2'b10:    y <= #3 c;
            default:  y <= #3 d;
        endcase
    end
endmodule

// ****************
// Blocks to design
// ****************

// Evaluates incoming pulses/gaps 
// Use any combination of declarative or structural verilog
// IMPORTANT: Do not change module or port names
module pulse_width(clk, in, pwidth, long, type, new);
    parameter width = 8;
    input clk, in;
    output [width-1:0] pwidth;
    output long, type, new;

  wire [7:0] out;
  wire [7:0] count;
  wire inn;
  
  assign #1 inn = in;
  
  tally tally(clk, inn, out, new, type);
  counter counter(clk, out, new, count);
  dreg #(8) dreg8(clk, count, pwidth);
  
  assign long = (pwidth > `THRESHOLD);
  

endmodule

module tally(clk, in, out, new, type);
  input clk;
  input in;
  output [7:0] out;
  output new;
  output type;
  
  wire dreg_to_xnor;
  
  dreg dreg(clk, in, dreg_to_xnor);
  assign out = {7'b0, dreg_to_xnor ^~ in}; 
  assign new = dreg_to_xnor ^ in;
  assign type = dreg_to_xnor;
  
endmodule

module counter(clk, in, reset, count);
  input clk;
  input [7:0] in;
  input reset;
  output [7:0] count;
  
  wire [7:0] mux_to_adder;
  wire [7:0] dreg_to_mux;
  
  mux2 #(8) mux8(dreg_to_mux, 8'b1, reset, mux_to_adder);
  assign count = mux_to_adder + in;
  dreg #(8) dreg8(clk, count, dreg_to_mux);
  
endmodule

// Four valued shift-register
// Use any combination of declarative or structural verilog
//    or procedural verilog, provided it obeys rules for combinational logic
// IMPORTANT: Do not change module or port names
module shift4(clk, in, cmd, out3, out2, out1, out0);
    parameter width = 1;
    input clk;
    input [width-1:0] in;
    input [`CMD_WIDTH-1:0] cmd;
    output [width-1:0] out3, out2, out1, out0;

  wire [width-1:0] dout0, dout1, dout2, dout3;
  
  dreg #(width) d0(clk, dout0, out0);
  mux4 #(width) m0(8'b0, in, out0, 8'b0, cmd, dout0);
  
  dreg #(width) d1(clk, dout1, out1);
  mux4 #(width) m1(8'b0, out0, out1, 8'b0, cmd, dout1);
  
  dreg #(width) d2(clk, dout2, out2);
  mux4 #(width) m2(8'b0, out1, out2, 8'b0, cmd, dout2);

  dreg #(width) d3(clk, dout3, out3);
  mux4 #(width) m3(8'b0, out2, out3, 8'b0, cmd, dout3);
 
endmodule

// Control FSM for shift register
// Use any combination of declarative or structural verilog
//    or procedural verilog, provided it obeys rules for combinational logic
// IMPORTANT: Do not change module or port names
module control_fsm(clk, long, type, cmd, done);
    input clk, long, type;
    output [`CMD_WIDTH-1:0] cmd;
    output done;

    // your code here
    // do not use any delays!
  
  mux4 #(2) mc(`CMD_HOLD, `CMD_LOAD, `CMD_CLEAR, `CMD_LOAD, {long, type}, cmd);
  mux4 md(1'b0, 1'b0, 1'b1, 1'b0, {long, type}, done);
  
endmodule

// Input de-serializer
// Use structural verilog only
// IMPORTANT: Do not change module or port names
module deserializer(clk, in, out3, out2, out1, out0, done);
    parameter width = 8;
    input clk, in;
    output [width-1:0] out3, out2, out1, out0;
    output done;

    // your code here
    // do not use any delays!
  
    wire [7:0] pwidth;
  wire long;
  wire type;
  wire new;
  
  
  wire [`CMD_WIDTH-1:0] cmd;
  
  
  pulse_width #(width) pw(clk, in, pwidth, long, type, new);
  
  
  shift4 #(width) s4(clk, pwidth, cmd, out3, out2, out1, out0);
  
  
  control_fsm cf(clk, long & new, type & new, cmd, done);
  
  

endmodule
