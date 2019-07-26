`timescale 1ns / 1ps
`include "def.v"

module W(
    input [31:0] PC,
    input [31:0] instr,
    input [31:0] ALUout,
    input [31:0] MEMout,
    output [31:0] WBD,
    output GRFwrite,
    output [4:0] WR
);

wire [31:0] WBslt;

W_ctrl W_ctrl_1 (.instr(instr), .WBslt(WBslt),
                 .GRFwrite(GRFwrite), .WR(WR));

assign WBD = (WBslt == 0)? ALUout : MEMout ;

endmodule // W