`timescale 1ns / 1ps
`include "def.v"

module mips(
    input reset,
    input clk
);

wire stop;
wire [31:0] instr_ctrl, D_FMUX1_slt,  D_FMUX2_slt, E_FMUX1_slt, E_FMUX2_slt,
             M_FUMX_slt;

Crtl_Field Crtl_Field_1 (.reset(reset), .clk(clk), .instr(instr_ctrl), .stop(stop),
            .D_FMUX1_slt(D_FMUX1_slt), .D_FMUX2_slt(D_FMUX2_slt), 
            .E_FMUX1_slt(E_FMUX1_slt), .E_FMUX2_slt(E_FMUX2_slt),
            .M_FUMX_slt(M_FUMX_slt));

Data_Field Data_Field_1 (.clk(clk), .reset(reset), .PCfreeze(stop), .setNOP(stop),
            .D_FMUX1_slt(D_FMUX1_slt), .D_FMUX2_slt(D_FMUX2_slt), 
            .E_FMUX1_slt(E_FMUX1_slt), .E_FMUX2_slt(E_FMUX2_slt), 
            .M_FUMX_slt(M_FUMX_slt), .instr_ctrl(instr_ctrl));

endmodule // mips