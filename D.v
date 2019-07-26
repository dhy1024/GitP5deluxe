`timescale 1ns / 1ps
`include "def.v"

module D(
    input clk,
    input reset,
    input [31:0] PC,
    input [31:0] W_PC,
    input [31:0] instr,
    input [4:0] WR,
    input [31:0] WBD,
    input GRFwrite,
    input [31:0] E2M_ALUout,
    input [31:0] M2W_ALUout,
    input [31:0] M2W_MEMout,
    input [31:0] D_FMUX1_slt,
    input [31:0] D_FMUX2_slt,
    output [31:0] D1,
    output [31:0] D2,
    output BranchJudge,
    output JumpJudge,
    output [31:0] BranchNPC,
    output [31:0] JumpNPC
);

wire [31:0] D1_grf, D2_grf, D1_line, D2_line, F_D1, F_D2;

D_GRF D_GRF_1(.clk(clk), .reset(reset),.GRFwrite(GRFwrite),
             .R1(instr[25:21]), .R2(instr[20:16]), .WR(WR),
             .WD(WBD), .W_PC(W_PC), .D1(D1_grf), .D2(D2_grf));

FMUX_T4 D_FMUX1 (.a(E2M_ALUout), .b(M2W_ALUout), .c(M2W_MEMout),
                 .d(D1_line), .slt(D_FMUX1_slt), .out(F_D1));

FMUX_T4 D_FMUX2 (.a(E2M_ALUout), .b(M2W_ALUout), .c(M2W_MEMout),
                 .d(D2_line), .slt(D_FMUX2_slt), .out(F_D2));

D_BranchCtrl D_BranchCtrl_1 (.D1(F_D1), .D2(F_D2), .PC(PC),
                 .instr(instr), .BranchJudge(BranchJudge), 
                 .BranchNPC(BranchNPC)); 

D_JumpCtrl D_JumpCtrl_1(.PC(PC), .instr(instr), .D1(F_D1),
                 .JumpNPC(JumpNPC), .JumpJudge(JumpJudge));          

assign D1_line = (instr[`rs]==WR && instr[`rs]!=0 && GRFwrite==1)? WBD : D1_grf;
assign D2_line = (instr[`rt]==WR && instr[`rt]!=0 && GRFwrite==1)? WBD : D2_grf;

assign D1 = F_D1;
assign D2 = F_D2;

endmodule // D