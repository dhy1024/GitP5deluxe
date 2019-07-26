`timescale 1ns / 1ps
`include "def.v"

module F_ctrl(
    input [31:0] D_Tnew,
    input [31:0] D_Tuse_A1,
    input [31:0] D_Tuse_A2,
    input [31:0] D_A1,
    input [31:0] D_A2,
    input [31:0] D_A3,
    input [31:0] D_type,

    input [31:0] E_Tnew,
    input [31:0] E_Tuse_A1,
    input [31:0] E_Tuse_A2,
    input [31:0] E_A1,
    input [31:0] E_A2,
    input [31:0] E_A3,
    input [31:0] E_type,

    input [31:0] M_Tnew,
    input [31:0] M_Tuse_A1,
    input [31:0] M_Tuse_A2,
    input [31:0] M_A1,
    input [31:0] M_A2,
    input [31:0] M_A3,
    input [31:0] M_type,

    input [31:0] W_Tnew,
    input [31:0] W_Tuse_A1,
    input [31:0] W_Tuse_A2,
    input [31:0] W_A1,
    input [31:0] W_A2,
    input [31:0] W_A3,
    input [31:0] W_type,

    output [31:0] D_FMUX1_slt,
    output [31:0] D_FMUX2_slt,
    output [31:0] E_FMUX1_slt,
    output [31:0] E_FMUX2_slt,
    output [31:0] M_FUMX_slt
);

assign D_FMUX1_slt = (D_A1!=0 && D_A1==M_A3 && M_type==`ALU)? 0 :
                     (D_A1!=0 && D_A1==W_A3 && W_type==`ALU)? 1 :
                     (D_A1!=0 && D_A1==W_A3 && W_type==`MEM)? 2 : 3;

assign D_FMUX2_slt = (D_A2!=0 && D_A2==M_A3 && M_type==`ALU)? 0 :
                     (D_A2!=0 && D_A2==W_A3 && W_type==`ALU)? 1 :
                     (D_A2!=0 && D_A2==W_A3 && W_type==`MEM)? 2 : 3;

assign E_FMUX1_slt = (E_A1!=0 && E_A1==M_A3 && M_type==`ALU)? 0 :
                     (E_A1!=0 && E_A1==W_A3 && W_type==`ALU)? 1 :
                     (E_A1!=0 && E_A1==W_A3 && W_type==`MEM)? 2 : 3;

assign E_FMUX2_slt = (E_A2!=0 && E_A2==M_A3 && M_type==`ALU)? 0 :
                     (E_A2!=0 && E_A2==W_A3 && W_type==`ALU)? 1 :
                     (E_A2!=0 && E_A2==W_A3 && W_type==`MEM)? 2 : 3;

assign M_FUMX_slt =  (M_A2!=0 && M_A2==W_A3 && W_type==`ALU)? 0:
                     (M_A2!=0 && M_A2==W_A3 && W_type==`MEM)? 1: 2;


endmodule // F_ctrl