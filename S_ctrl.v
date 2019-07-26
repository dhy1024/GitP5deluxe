`timescale 1ns / 1ps
`include "def.v"

module S_ctrl(
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

    output stop
);

wire ES, ES1, ES2, 
     MS, MS1, MS2,
     WS, WS1, WS2;

assign ES1 = (D_A1==E_A3 && D_Tuse_A1<E_Tnew)? 1:0;
assign ES2 = (D_A2==E_A3 && D_Tuse_A2<E_Tnew)? 1:0;

assign MS1 = (D_A1==M_A3 && D_Tuse_A1<M_Tnew)? 1:0;
assign MS2 = (D_A2==M_A3 && D_Tuse_A2<M_Tnew)? 1:0;

assign WS1 = (D_A1==W_A3 && D_Tuse_A1<W_Tnew)? 1:0;
assign WS2 = (D_A2==W_A3 && D_Tuse_A2<W_Tnew)? 1:0;

assign ES = ES1 | ES2;
assign MS = MS1 | MS2;
assign WS = WS1 | WS2;

assign stop = (ES | MS | WS);

endmodule // S_ctrl