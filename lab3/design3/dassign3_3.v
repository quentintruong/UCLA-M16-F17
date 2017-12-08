// EEM16 - Logic Design
// Design Assignment #3.3
// dassign3_3.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
`timescale 1ns / 1ps
module net(clk, x3, x2, x1, x0, new, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z, ready);
    input clk;
    input [7:0] x3, x2, x1, x0;
    input new;
    output [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
    output ready;

    reg [39:0] rom [0:29]; // ROM that stores neuron weights

    // Initialize values in ROM
    initial $readmemb("./weights_rom", rom);

    wire [7:0] y0, y1, y2, y3;
    wire [7:0] h0, h1, h2, h3;
    wire ready_0, ready_1, ready_2, ready_3, ready_h;
    wire [25:0] ready_out;

    // Input layer of neurons (from 3.1)
    neuron l0n3(clk, rom[0][39:32], rom[0][31:24], rom[0][23:16], rom[0][15:8], rom[0][7:0], x3, x2, x1, x0, new, y3, ready_3);
    neuron l0n2(clk, rom[1][39:32], rom[1][31:24], rom[1][23:16], rom[1][15:8], rom[1][7:0], x3, x2, x1, x0, new, y2, ready_2);
    neuron l0n1(clk, rom[2][39:32], rom[2][31:24], rom[2][23:16], rom[2][15:8], rom[2][7:0], x3, x2, x1, x0, new, y1, ready_1);
    neuron l0n0(clk, rom[3][39:32], rom[3][31:24], rom[3][23:16], rom[3][15:8], rom[3][7:0], x3, x2, x1, x0, new, y0, ready_0);

    // Interlayer module (from 3.2)
    interlayer i2o(clk, new, y3, ready_3, y2, ready_2, y1, ready_1, y0, ready_0, h3, h2, h1, h0, ready_h);

    // Output layer of neurons (from 3.1)
    neuron  l1n0(clk,  rom[4][39:32],  rom[4][31:24],  rom[4][23:16],  rom[4][15:8],  rom[4][7:0], h3, h2, h1, h0, ready_h, a,  ready_out[0]);
    neuron  l1n1(clk,  rom[5][39:32],  rom[5][31:24],  rom[5][23:16],  rom[5][15:8],  rom[5][7:0], h3, h2, h1, h0, ready_h, b,  ready_out[1]);
    neuron  l1n2(clk,  rom[6][39:32],  rom[6][31:24],  rom[6][23:16],  rom[6][15:8],  rom[6][7:0], h3, h2, h1, h0, ready_h, c,  ready_out[2]);
    neuron  l1n3(clk,  rom[7][39:32],  rom[7][31:24],  rom[7][23:16],  rom[7][15:8],  rom[7][7:0], h3, h2, h1, h0, ready_h, d,  ready_out[3]);
    neuron  l1n4(clk,  rom[8][39:32],  rom[8][31:24],  rom[8][23:16],  rom[8][15:8],  rom[8][7:0], h3, h2, h1, h0, ready_h, e,  ready_out[4]);
    neuron  l1n5(clk,  rom[9][39:32],  rom[9][31:24],  rom[9][23:16],  rom[9][15:8],  rom[9][7:0], h3, h2, h1, h0, ready_h, f,  ready_out[5]);
    neuron  l1n6(clk, rom[10][39:32], rom[10][31:24], rom[10][23:16], rom[10][15:8], rom[10][7:0], h3, h2, h1, h0, ready_h, g,  ready_out[6]);
    neuron  l1n7(clk, rom[11][39:32], rom[11][31:24], rom[11][23:16], rom[11][15:8], rom[11][7:0], h3, h2, h1, h0, ready_h, h,  ready_out[7]);
    neuron  l1n8(clk, rom[12][39:32], rom[12][31:24], rom[12][23:16], rom[12][15:8], rom[12][7:0], h3, h2, h1, h0, ready_h, i,  ready_out[8]);
    neuron  l1n9(clk, rom[13][39:32], rom[13][31:24], rom[13][23:16], rom[13][15:8], rom[13][7:0], h3, h2, h1, h0, ready_h, j,  ready_out[9]);
    neuron l1n10(clk, rom[14][39:32], rom[14][31:24], rom[14][23:16], rom[14][15:8], rom[14][7:0], h3, h2, h1, h0, ready_h, k, ready_out[10]);
    neuron l1n11(clk, rom[15][39:32], rom[15][31:24], rom[15][23:16], rom[15][15:8], rom[15][7:0], h3, h2, h1, h0, ready_h, l, ready_out[11]);
    neuron l1n12(clk, rom[16][39:32], rom[16][31:24], rom[16][23:16], rom[16][15:8], rom[16][7:0], h3, h2, h1, h0, ready_h, m, ready_out[12]);
    neuron l1n13(clk, rom[17][39:32], rom[17][31:24], rom[17][23:16], rom[17][15:8], rom[17][7:0], h3, h2, h1, h0, ready_h, n, ready_out[13]);
    neuron l1n14(clk, rom[18][39:32], rom[18][31:24], rom[18][23:16], rom[18][15:8], rom[18][7:0], h3, h2, h1, h0, ready_h, o, ready_out[14]);
    neuron l1n15(clk, rom[19][39:32], rom[19][31:24], rom[19][23:16], rom[19][15:8], rom[19][7:0], h3, h2, h1, h0, ready_h, p, ready_out[15]);
    neuron l1n16(clk, rom[20][39:32], rom[20][31:24], rom[20][23:16], rom[20][15:8], rom[20][7:0], h3, h2, h1, h0, ready_h, q, ready_out[16]);
    neuron l1n17(clk, rom[21][39:32], rom[21][31:24], rom[21][23:16], rom[21][15:8], rom[21][7:0], h3, h2, h1, h0, ready_h, r, ready_out[17]);
    neuron l1n18(clk, rom[22][39:32], rom[22][31:24], rom[22][23:16], rom[22][15:8], rom[22][7:0], h3, h2, h1, h0, ready_h, s, ready_out[18]);
    neuron l1n19(clk, rom[23][39:32], rom[23][31:24], rom[23][23:16], rom[23][15:8], rom[23][7:0], h3, h2, h1, h0, ready_h, t, ready_out[19]);
    neuron l1n20(clk, rom[24][39:32], rom[24][31:24], rom[24][23:16], rom[24][15:8], rom[24][7:0], h3, h2, h1, h0, ready_h, u, ready_out[20]);
    neuron l1n21(clk, rom[25][39:32], rom[25][31:24], rom[25][23:16], rom[25][15:8], rom[25][7:0], h3, h2, h1, h0, ready_h, v, ready_out[21]);
    neuron l1n22(clk, rom[26][39:32], rom[26][31:24], rom[26][23:16], rom[26][15:8], rom[26][7:0], h3, h2, h1, h0, ready_h, w, ready_out[22]);
    neuron l1n23(clk, rom[27][39:32], rom[27][31:24], rom[27][23:16], rom[27][15:8], rom[27][7:0], h3, h2, h1, h0, ready_h, x, ready_out[23]);
    neuron l1n24(clk, rom[28][39:32], rom[28][31:24], rom[28][23:16], rom[28][15:8], rom[28][7:0], h3, h2, h1, h0, ready_h, y, ready_out[24]);
    neuron l1n25(clk, rom[29][39:32], rom[29][31:24], rom[29][23:16], rom[29][15:8], rom[29][7:0], h3, h2, h1, h0, ready_h, z, ready_out[25]);
    assign ready = &(ready_out);
endmodule

// ****************
// Blocks to design
// ****************

// 3.3a) Morse decoder
// 1 bit time-series input 
// 5 bit letter [a=0, ..., z=25] output
// 7 bit 7-segment display output
// 1 bit flag indicating done

module decoder(clk, in, letter, display, done);
    input clk;
    input in;
    output [4:0] letter;
    output [6:0] display;
    output done;

    // your code here

    wire [7:0] x3_i, x2_i, x1_i, x0_i;
    wire [7:0] x3_o, x2_o, x1_o, x0_o;
    wire new_i, new_o;
    wire [7:0] a_i, b_i, c_i, d_i, e_i, f_i, g_i, h_i, i_i, j_i, k_i, l_i, m_i, n_i, o_i, p_i, q_i, r_i, s_i, t_i, u_i, v_i, w_i, x_i, y_i, z_i;

    deserializer deserializer_o(clk, in, x3_i, x2_i, x1_i, x0_i, new_i);

    mux2 #(8) mux_x0(x0_o, x0_i, new_i, x0_o);
    mux2 #(8) mux_x1(x1_o, x1_i, new_i, x1_o);
    mux2 #(8) mux_x2(x2_o, x2_i, new_i, x2_o);
    mux2 #(8) mux_x3(x3_o, x3_i, new_i, x3_o);
    mux2      mux_xn(new_o, new_i, new_i, new_o);

    net neural_net(clk, x3_o, x2_o, x1_o, x0_o, new_i, a_i, b_i, c_i, d_i, e_i, f_i, g_i, h_i, i_i, j_i, k_i, l_i, m_i, n_i, o_i, p_i, q_i, r_i, s_i, t_i, u_i, v_i, w_i, x_i, y_i, z_i, done_i);

    wire done_i;

    dreg dregd(clk, done_i, done);

    maxindex mi(a_i, b_i, c_i, d_i, e_i, f_i, g_i, h_i, i_i, j_i, k_i, l_i, m_i, n_i, o_i, p_i, q_i, r_i, s_i, t_i, u_i, v_i, w_i, x_i, y_i, z_i, letter);

    display_rom display_rom(letter, display);
endmodule
