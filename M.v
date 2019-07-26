`timescale 1ns / 1ps
`include "def.v"

module M(
    input reset,
    input clk,
    input [31:0] PC,
    input [31:0] instr,
    input [31:0] ALUout,
    input [31:0] M2W_ALUout,
    input [31:0] M2W_MEMout,
    input [31:0] D2,
    input [31:0] M_FUMX_slt,
    output [31:0] MEMout
);

wire [31:0] data, MEMmode;
wire MEMwrite_line, MEMread_line;

FMUX_T3 M_FMUX (.a(M2W_ALUout), .b(M2W_MEMout), .c(D2),
                .slt(M_FUMX_slt), .out(data));

M_ctrl M_ctrl_1 (.instr(instr), .MEMwrite(MEMwrite_line),
                .MEMread(MEMread_line), .MEMmode(MEMmode));

M_MEM M_MEM_1 (.reset(reset), .clk(clk), .MEMwrite(MEMwrite_line),
             .MEMread(MEMread_line), .MEMmode(MEMmode),
             .addr(ALUout), .data(data), .PC(PC), .out(MEMout));


endmodule // M