`timescale 1ns / 1ps
`include "def.v"

module Crtl_Field(
    input reset,
    input clk,
    input [31:0] instr,

    output stop,
    output [31:0] D_FMUX1_slt,
    output [31:0] D_FMUX2_slt,
    output [31:0] E_FMUX1_slt,
    output [31:0] E_FMUX2_slt,
    output [31:0] M_FUMX_slt
);

wire [31:0] D_Tnew, D_Tuse_A1, D_Tuse_A2,
            D_A1, D_A2, D_A3, D_type,

            E_Tnew, E_Tuse_A1, E_Tuse_A2,
            E_A1, E_A2, E_A3, E_type,

            M_Tnew, M_Tuse_A1, M_Tuse_A2,
            M_A1, M_A2, M_A3, M_type,

            W_Tnew, W_Tuse_A1, W_Tuse_A2,
            W_A1, W_A2, W_A3, W_type;

AT_encoder AT_encoder_1 (.instr(instr), .Tnew(D_Tnew), .Tuse_A1(D_Tuse_A1),
            .Tuse_A2(D_Tuse_A2), .A1(D_A1), .A2(D_A2), .A3(D_A3), .type(D_type));

C_D2E_GRF C_D2E_GRF_1 (.reset(reset), .clk(clk), .setNOP(stop), .Tnew_in(D_Tnew), 
            .Tuse_A1_in(D_Tuse_A1), .Tuse_A2_in(D_Tuse_A2), .A1_in(D_A1),
            .A2_in(D_A2), .A3_in(D_A3), .type_in(D_type), .Tnew(E_Tnew),
            .Tuse_A1(E_Tuse_A1), .Tuse_A2(E_Tuse_A2), .A1(E_A1), .A2(E_A2),
            .A3(E_A3), .type(E_type));

C_E2M_GRF C_E2M_GRF_1 (.reset(reset), .clk(clk), .Tnew_in(E_Tnew), 
            .Tuse_A1_in(E_Tuse_A1), .Tuse_A2_in(E_Tuse_A2), .A1_in(E_A1),
            .A2_in(E_A2), .A3_in(E_A3), .type_in(E_type), .Tnew(M_Tnew),
            .Tuse_A1(M_Tuse_A1), .Tuse_A2(M_Tuse_A2), .A1(M_A1), .A2(M_A2),
            .A3(M_A3), .type(M_type));

C_M2W_GRF C_M2W_GRF_1 (.reset(reset), .clk(clk), .Tnew_in(M_Tnew), 
            .Tuse_A1_in(M_Tuse_A1), .Tuse_A2_in(M_Tuse_A2), .A1_in(M_A1),
            .A2_in(M_A2), .A3_in(M_A3), .type_in(M_type), .Tnew(W_Tnew),
            .Tuse_A1(W_Tuse_A1), .Tuse_A2(W_Tuse_A2), .A1(W_A1), .A2(W_A2),
            .A3(W_A3), .type(W_type));

S_ctrl S_ctrl_1 (.D_Tnew(D_Tnew), .D_Tuse_A1(D_Tuse_A1), .D_Tuse_A2(D_Tuse_A2),
            .D_A1(D_A1), .D_A2(D_A2), .D_A3(D_A3), .D_type(D_type),

            .E_Tnew(E_Tnew), .E_Tuse_A1(E_Tuse_A1), .E_Tuse_A2(E_Tuse_A2),
            .E_A1(E_A1), .E_A2(E_A2), .E_A3(E_A3), .E_type(E_type),

            .M_Tnew(M_Tnew), .M_Tuse_A1(M_Tuse_A1), .M_Tuse_A2(M_Tuse_A2),
            .M_A1(M_A1), .M_A2(M_A2), .M_A3(M_A3), .M_type(M_type),

            .W_Tnew(W_Tnew), .W_Tuse_A1(W_Tuse_A1), .W_Tuse_A2(W_Tuse_A2),
            .W_A1(W_A1), .W_A2(W_A2), .W_A3(W_A3), .W_type(W_type),
            
            .stop(stop));

F_ctrl F_ctrl_1 (.D_Tnew(D_Tnew), .D_Tuse_A1(D_Tuse_A1), .D_Tuse_A2(D_Tuse_A2),
            .D_A1(D_A1), .D_A2(D_A2), .D_A3(D_A3), .D_type(D_type),

            .E_Tnew(E_Tnew), .E_Tuse_A1(E_Tuse_A1), .E_Tuse_A2(E_Tuse_A2),
            .E_A1(E_A1), .E_A2(E_A2), .E_A3(E_A3), .E_type(E_type),

            .M_Tnew(M_Tnew), .M_Tuse_A1(M_Tuse_A1), .M_Tuse_A2(M_Tuse_A2),
            .M_A1(M_A1), .M_A2(M_A2), .M_A3(M_A3), .M_type(M_type),

            .W_Tnew(W_Tnew), .W_Tuse_A1(W_Tuse_A1), .W_Tuse_A2(W_Tuse_A2),
            .W_A1(W_A1), .W_A2(W_A2), .W_A3(W_A3), .W_type(W_type),

            .D_FMUX1_slt(D_FMUX1_slt), .D_FMUX2_slt(D_FMUX2_slt), 
            .E_FMUX1_slt(E_FMUX1_slt), .E_FMUX2_slt(E_FMUX2_slt), 
            .M_FUMX_slt(M_FUMX_slt));


endmodule // Crtl_Field