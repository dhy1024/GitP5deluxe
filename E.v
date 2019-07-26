`timescale 1ns / 1ps
`include "def.v"

module E(
    input [31:0] PC,
    input [31:0] instr,
    input [31:0] D1,
    input [31:0] D2,
    input [31:0] E2M_ALUout,
    input [31:0] M2W_ALUout,
    input [31:0] M2W_MEMout,
    input [31:0] E_FMUX1_slt,
    input [31:0] E_FMUX2_slt,
    output [31:0] ALUout,
	 output [31:0] F_D2
);

wire [31:0] F_D1, ALUop, B, ALUsrc;

FMUX_T4 E_FMUX1 (.a(E2M_ALUout), .b(M2W_ALUout), .c(M2W_MEMout),
                 .d(D1), .slt(E_FMUX1_slt), .out(F_D1));

FMUX_T4 E_FMUX2 (.a(E2M_ALUout), .b(M2W_ALUout), .c(M2W_MEMout),
                 .d(D2), .slt(E_FMUX2_slt), .out(F_D2));

E_ctrl E_ctrl_1 (.instr(instr), .ALUsrc(ALUsrc), .ALUop(ALUop));

ALU ALU_1 (.A(F_D1), .B(B), .PC(PC), .instr(instr), .ALUop(ALUop), .ALUout(ALUout));

assign B = (ALUsrc == 0)? F_D2 :
				(ALUsrc == 1)? {16'b0,instr[15:0]} : {{16{instr[15]}},instr[15:0]};

endmodule // E