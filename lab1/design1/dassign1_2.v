// EEM16 - Logic Design
// Design Assignment #1 - Problem #1.2
// dassign1_2.v
// Verilog template

// You may define any additional modules as necessary
// Do not change the module or port names of these stubs

module fcmp2(a, b, e, out);
    input [1:0] a, b;
    input e;
    output out;

    assign out = (~a[1] & ~a[0] & e) | (~a[1] & b[0] & e) | (b[1] & b[0] & e) | (~a[1] & b[1]) | (~a[1] & ~a[0] & b[0]) | (~a[0] & b[1] & b[0]) | (a[1] & ~a[0] & b[1] & e);
endmodule

module fcmp8(a, b, e, out);
    input [7:0] a, b;
    input e;
    output out;

    wire fcmp2_1_o, fcmp2_2_o, fcmp2_3_o, fcmp2_4_o;

    fcmp2   fcmp2_1(a[1:0], b[1:0], e,          fcmp2_1_o);
    fcmp2   fcmp2_2(a[3:2], b[3:2], fcmp2_1_o,  fcmp2_2_o);
    fcmp2   fcmp2_3(a[5:4], b[5:4], fcmp2_2_o,  fcmp2_3_o);
    fcmp2   fcmp2_4(a[7:6], b[7:6], fcmp2_3_o,  out);
endmodule

module mux8(a, b, select, out);
    input [7:0] a, b;
    input select;
  
    output [7:0] out;
    assign out[0] = (~select & a[0]) | (select & b[0]);
    assign out[1] = (~select & a[1]) | (select & b[1]);
    assign out[2] = (~select & a[2]) | (select & b[2]);
    assign out[3] = (~select & a[3]) | (select & b[3]);
    assign out[4] = (~select & a[4]) | (select & b[4]);
    assign out[5] = (~select & a[5]) | (select & b[5]);
    assign out[6] = (~select & a[6]) | (select & b[6]);
    assign out[7] = (~select & a[7]) | (select & b[7]);
endmodule

module mux5(a, b, select, out);
    input [4:0] a, b;
    input select;
  
    output [4:0] out;
    assign out[0] = (~select & a[0]) | (select & b[0]);
    assign out[1] = (~select & a[1]) | (select & b[1]);
    assign out[2] = (~select & a[2]) | (select & b[2]);
    assign out[3] = (~select & a[3]) | (select & b[3]);
    assign out[4] = (~select & a[4]) | (select & b[4]);
endmodule

// Max/argmax (declarative verilog)
// IMPORTANT: Do not change module or port names
module mam (in1_value, in1_label, in2_value, in2_label, out_value, out_label);
    input   [7:0] in1_value, in2_value;
    input   [4:0] in1_label, in2_label;
    output  [7:0] out_value;
    output  [4:0] out_label;

    // your code here
    // do not use any delays!

    wire out;

    fcmp8   fcmp8_1(in1_value, in2_value, 1, out);
    mux8    mux8_1(in1_value, in2_value, out, out_value);
    mux5    mux5_1(in1_label, in2_label, out, out_label);
endmodule

// Maximum index (structural verilog)
// IMPORTANT: Do not change module or port names
module maxindex(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,out);
    input [7:0] a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;
    output [4:0] out;

    // your code here
    // do not use any delays!

    wire [7:0] mam_ab_v, mam_cd_v, mam_ef_v, mam_gh_v, mam_ij_v, mam_kl_v, mam_mn_v, mam_op_v, mam_qr_v, mam_st_v, mam_uv_v, mam_wx_v, mam_yz_v, mam_ab_cd_v, mam_ef_gh_v, mam_ij_kl_v, mam_mn_op_v, mam_qr_st_v, mam_uv_wx_v, mam_abcd_efgh_v, mam_ijkl_mnop_v, mam_qrst_uvwx_v, mam_abcdefgh_ijklmnop_v, mam_qrstuvwx_yz_v, mam_all_v;
    
    wire [4:0] mam_ab_l, mam_cd_l, mam_ef_l, mam_gh_l, mam_ij_l, mam_kl_l, mam_mn_l, mam_op_l, mam_qr_l, mam_st_l, mam_uv_l, mam_wx_l, mam_yz_l, mam_ab_cd_l, mam_ef_gh_l, mam_ij_kl_l, mam_mn_op_l, mam_qr_st_l, mam_uv_wx_l, mam_abcd_efgh_l, mam_ijkl_mnop_l, mam_qrst_uvwx_l, mam_abcdefgh_ijklmnop_l, mam_qrstuvwx_yz_l;
  
    mam     mam_ab(a, 0, b, 1, mam_ab_v, mam_ab_l);
    mam     mam_cd(c, 2, d, 3, mam_cd_v, mam_cd_l);
    mam     mam_ef(e, 4, f, 5, mam_ef_v, mam_ef_l);
    mam     mam_gh(g, 6, h, 7, mam_gh_v, mam_gh_l);
    mam     mam_ij(i, 8, j, 9, mam_ij_v, mam_ij_l);
    mam     mam_kl(k, 10, l, 11, mam_kl_v, mam_kl_l);
    mam     mam_mn(m, 12, n, 13, mam_mn_v, mam_mn_l);
    mam     mam_op(o, 14, p, 15, mam_op_v, mam_op_l);
    mam     mam_qr(q, 16, r, 17, mam_qr_v, mam_qr_l);
    mam     mam_st(s, 18, t, 19, mam_st_v, mam_st_l);
    mam     mam_uv(u, 20, v, 21, mam_uv_v, mam_uv_l);
    mam     mam_wx(w, 22, x, 23, mam_wx_v, mam_wx_l);
    mam     mam_yz(y, 24, z, 25, mam_yz_v, mam_yz_l);

    mam     mam_ab_cd(mam_ab_v, mam_ab_l, mam_cd_v, mam_cd_l, mam_ab_cd_v, mam_ab_cd_l);
    mam     mam_ef_gh(mam_ef_v, mam_ef_l, mam_gh_v, mam_gh_l, mam_ef_gh_v, mam_ef_gh_l);
    mam     mam_ij_kl(mam_ij_v, mam_ij_l, mam_kl_v, mam_kl_l, mam_ij_kl_v, mam_ij_kl_l);
    mam     mam_mn_op(mam_mn_v, mam_mn_l, mam_op_v, mam_op_l, mam_mn_op_v, mam_mn_op_l);
    mam     mam_qr_st(mam_qr_v, mam_qr_l, mam_st_v, mam_st_l, mam_qr_st_v, mam_qr_st_l);
    mam     mam_uv_wx(mam_uv_v, mam_uv_l, mam_wx_v, mam_wx_l, mam_uv_wx_v, mam_uv_wx_l);

    mam     mam_abcd_efgh(mam_ab_cd_v, mam_ab_cd_l, mam_ef_gh_v, mam_ef_gh_l, mam_abcd_efgh_v, mam_abcd_efgh_l);
    mam     mam_ijkl_mnop(mam_ij_kl_v, mam_ij_kl_l, mam_mn_op_v, mam_mn_op_l, mam_ijkl_mnop_v, mam_ijkl_mnop_l);
    mam     mam_qrst_uvwx(mam_qr_st_v, mam_qr_st_l, mam_uv_wx_v, mam_uv_wx_l, mam_qrst_uvwx_v, mam_qrst_uvwx_l);

    mam     mam_abcdefgh_ijklmnop(mam_abcd_efgh_v, mam_abcd_efgh_l, mam_ijkl_mnop_v, mam_ijkl_mnop_l, mam_abcdefgh_ijklmnop_v, mam_abcdefgh_ijklmnop_l);
    mam     mam_qrstuvwx_yz(mam_qrst_uvwx_v, mam_qrst_uvwx_l, mam_yz_v, mam_yz_l, mam_qrstuvwx_yz_v, mam_qrstuvwx_yz_l);

    mam     mam_all(mam_abcdefgh_ijklmnop_v, mam_abcdefgh_ijklmnop_l, mam_qrstuvwx_yz_v, mam_qrstuvwx_yz_l, mam_all_v, out);

endmodule
