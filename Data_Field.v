`timescale 1ns / 1ps
`include "def.v"

 module Data_Field(
    input clk,
    input reset,
    input PCfreeze,
    input setNOP,
    input [31:0] D_FMUX1_slt,
    input [31:0] D_FMUX2_slt,
    input [31:0] E_FMUX1_slt,
    input [31:0] E_FMUX2_slt,
    input [31:0] M_FUMX_slt,
    output [31:0] instr_ctrl
 );
 
wire [31:0] BranchNPC, JumpNPC, I_PC, I_instr, D_PC, D_instr, 
            WBD, E2M_ALUout, M2W_ALUout, M2W_MEMout, D_D1, D_D2, 
            E_PC, E_instr, E_D1, E_D2,E_ALUout, M_PC, M_instr, 
            M_D2, M_MEMout, W_PC, W_instr, F_D2;
wire [4:0] WR;

wire BranchJudge, JumpJudge, GRFwrite;

I_IFU I_IFU_1 (.BranchJudge(BranchJudge), .JumpJudge(JumpJudge),
                .PCfreeze(PCfreeze), .D_PC(D_PC), .BranchNPC(BranchNPC), 
                .JumpNPC(JumpNPC), .reset(reset), .clk(clk), 
                .PC(I_PC), .instr(I_instr));

I2D_GRF I2D_GRF_1 (.PC_in(I_PC), .instr_in(I_instr), .reset(reset),
                    .clk(clk), .freeze(setNOP), .PC(D_PC), 
                    .instr(D_instr));

D D_1 (.clk(clk), .reset(reset), .PC(D_PC), .W_PC(W_PC), .instr(D_instr),
        .WR(WR), .WBD(WBD), .GRFwrite(GRFwrite), .E2M_ALUout(E2M_ALUout),
        .M2W_ALUout(M2W_ALUout), .M2W_MEMout(M2W_MEMout), .D_FMUX1_slt(D_FMUX1_slt),
        .D_FMUX2_slt(D_FMUX2_slt), .D1(D_D1), .D2(D_D2), .BranchJudge(BranchJudge),
        .JumpJudge(JumpJudge), .BranchNPC(BranchNPC), .JumpNPC(JumpNPC));

D2E_GRF D2E_GRF_1 (.PC_in(D_PC), .instr_in(D_instr), .D1_in(D_D1), .D2_in(D_D2), .setNOP(setNOP),
                    .reset(reset), .clk(clk), .PC(E_PC), .instr(E_instr), .D1(E_D1),
                    .D2(E_D2));

E E_1 (.PC(E_PC), .instr(E_instr), .D1(E_D1), .D2(E_D2), .E2M_ALUout(E2M_ALUout),
        .M2W_ALUout(M2W_ALUout), .M2W_MEMout(M2W_MEMout), .E_FMUX1_slt(E_FMUX1_slt),
        .E_FMUX2_slt(E_FMUX2_slt), .ALUout(E_ALUout), .F_D2(F_D2));

E2M_GRF E2M_GRF_1 (.PC_in(E_PC), .instr_in(E_instr), .ALUout_in(E_ALUout), .D2_in(F_D2),
                    .reset(reset), .clk(clk), .PC(M_PC), .instr(M_instr), 
                    .ALUout(E2M_ALUout), .D2(M_D2));

M M_1 (.reset(reset), .clk(clk), .PC(M_PC), .instr(M_instr), .ALUout(E2M_ALUout),
        .M2W_ALUout(M2W_ALUout), .M2W_MEMout(M2W_MEMout), .D2(M_D2), 
        .M_FUMX_slt(M_FUMX_slt), .MEMout(M_MEMout));

M2W_GRF M2W_GRF_1 (.PC_in(M_PC), .instr_in(M_instr), .ALUout_in(E2M_ALUout),
                     .MEMout_in(M_MEMout), .reset(reset), .clk(clk), .PC(W_PC),
                     .instr(W_instr), .ALUout(M2W_ALUout), .MEMout(M2W_MEMout));

W W_1 (.PC(W_PC), .instr(W_instr), .ALUout(M2W_ALUout), .MEMout(M2W_MEMout),
        .WBD(WBD), .GRFwrite(GRFwrite), .WR(WR));

assign instr_ctrl = D_instr;

endmodule // DataField