`timescale 1ns / 1ps
`include "def.v"

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [31:0] PC,
	 input [31:0] instr,
    input [31:0] ALUop, 
    output [31:0] ALUout
);

reg [31:0] ALUout_reg;

initial begin
    ALUout_reg <= 0;
end

always @ (*) begin
    case (ALUop)
    0: ALUout_reg <= A + B ;
    1: ALUout_reg <= A - B ;
    2: ALUout_reg <= A | B ;
    3: ALUout_reg <= B<<16 ;
    4: ALUout_reg <= PC + 8;
    default : ALUout_reg <= 0;
    endcase
end

assign ALUout =ALUout_reg;

endmodule // ALUinput [31:0] A,