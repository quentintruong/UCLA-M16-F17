// EEM16 - Logic Design
// Design Assignment #1 - Problem #1.1
// dassign1_1.v
// Verilog template

// You may define any additional modules as necessary
// Do not delete or modify any of the modules provided
//
// The modules you will have to design are at the end of the file
// Do not change the module or port names of these stubs

// CMOS gates (declarative Verilog)
// Includes propagation delay t_PD = 1
module inverter(a,y);
    input a;
    output y;

    assign #1 y = ~a;
endmodule

module fa_gate_1(a,b,c,y);
    input a,b,c;
    output y;

    assign #1 y = ~((a&b) | (c&(b|a)));
endmodule

module fa_gate_2(a,b,c,m,y);
    input a,b,c,m;
    output y;

    assign #1 y = ~((a&b&c) | ((a|b|c)&m));
endmodule

// Full adder (structural Verilog)
module fa(a,b,ci,co,s);
    input a,b,ci;
    output s,co;

    wire nco, ns;

    fa_gate_1   fa_gate_1_1(a,b,ci, nco);
    fa_gate_2   fa_gate_2_1(a,b,ci,nco, ns);
    inverter    inverter_1(nco, co); 
    inverter    inverter_2(ns, s);
endmodule

// 5+2 input full adder (structural Verilog)
// IMPORTANT: Do not change module or port names
module fa5 (a,b,c,d,e,ci0,ci1, 
            co1,co0,s);

    input a,b,c,d,e,ci0,ci1;
    output co1, co0, s;
  
    // your code here
    // do not use any delays!
  
    wire fa_1_co, fa_1_s, fa_2_co, fa_2_s, fa_3_co;
  
    fa fa_1(a      ,b      ,c      ,fa_1_co,fa_1_s);
    fa fa_2(d      ,e      ,ci1    ,fa_2_co,fa_2_s);
    fa fa_3(fa_1_s ,fa_2_s ,ci0    ,fa_3_co,s     );
    fa fa_4(fa_1_co,fa_2_co,fa_3_co,co1    ,co0   );
  
endmodule

// 5-input 4-bit ripple-carry adder (structural Verilog)
// IMPORTANT: Do not change module or port names
module adder5 (a,b,c,d,e, sum);
    input [3:0] a,b,c,d,e;
  output [6:0] sum;
    // your code here
    // do not use any delays!
  
    wire fa_1_co, fa_1_s, fa_2_co, fa5_1_co1, fa5_1_co0, fa5_2_co1, fa5_2_co0, fa5_3_co1, fa5_3_co0;
  
    fa fa_1(a[0], b[0], c[0], fa_1_co, fa_1_s);
    fa fa_2(d[0], e[0], fa_1_s, fa_2_co, sum[0]);
    fa5 fa5_1(a[1], b[1], c[1], d[1], e[1], fa_1_co, fa_2_co, fa5_1_co1, fa5_1_co0, sum[1]);
    fa5 fa5_2(a[2], b[2], c[2], d[2], e[2], fa5_1_co0, 0, fa5_2_co1, fa5_2_co0, sum[2]);
    fa5 fa5_3(a[3], b[3], c[3], d[3], e[3], fa5_2_co0, fa5_1_co1, fa5_3_co1, fa5_3_co0, sum[3]);
    fa5 fa5_4(fa5_3_co1, fa5_3_co1, 0, 0, 0, fa5_3_co0, fa5_2_co1, sum[6], sum[5], sum[4]);
  
endmodule
