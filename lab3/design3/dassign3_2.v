// EEM16 - Logic Design
// Design Assignment #3.2
// dassign3_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided

// ****************
// Blocks to design
// ****************
`timescale 1ns / 1ps
// 3.2a) Inter-layer module
// four sets of inputs: 8 bit value, 1 bit input ready
// one 1 bit input new (from input layer of neurons)
// four sets of 8 bits output
// one 1 bit output ready
module interlayer(clk, new, in1, ready1, in2, ready2, in3, ready3, in4, ready4,
                  out1, out2, out3, out4, ready_out);
    input clk;
    input new;
    input [7:0] in1, in2, in3, in4;
    input ready1, ready2, ready3, ready4;
    output [7:0] out1, out2, out3, out4;
    output ready_out;

    // your code here

    wire [7:0] dreg_to_mux_i1, dreg_to_mux_i2, dreg_to_mux_i3, dreg_to_mux_i4;

    mux2 #(8)   mux2_i1(dreg_to_mux_i1, in1, ready1, out1);
    dreg #(8)   dreg_i1(clk,  out1,  dreg_to_mux_i1);

    mux2 #(8)   mux2_i2(dreg_to_mux_i2, in2, ready2, out2);
    dreg #(8)   dreg_i2(clk,  out2,  dreg_to_mux_i2);  

    mux2 #(8)   mux2_i3(dreg_to_mux_i3, in3, ready3, out3);
    dreg #(8)   dreg_i3(clk,  out3,  dreg_to_mux_i3);  

    mux2 #(8)   mux2_i4(dreg_to_mux_i4, in4, ready4, out4);
    dreg #(8)   dreg_i4(clk,  out4,  dreg_to_mux_i4);  

    wire delay;

    dreg        dreg_d(clk, ready1 & ready2 & ready3 & ready4, delay);
    mux2        mux_r(ready1 & ready2 & ready3 & ready4, 1'b0, delay, ready_out);

endmodule


/*

muxes pass 
ready1 & not new, passes it through to dreg
dreg holds
new resets the muxes




*/
