`timescale 1ns / 1ps
`include "def.v"

module I_IFU(
	input BranchJudge,
	input JumpJudge,
    input PCfreeze,
	 input [31:0] D_PC,
    input [31:0] BranchNPC,
    input [31:0] JumpNPC,
    input reset,
    input clk,
	output [31:0] PC,
    output [31:0] instr
    );

    reg [31:0] PC_reg, instr_reg;
    reg [31:0] IM [0:1023];

    wire [31:0] PC_line, npc_line;

    initial begin
        $readmemh("code.txt",IM);
        PC_reg <= 32'h00003000;
    end

    always @(posedge clk)begin
		if (reset)	
			PC_reg <= 32'h00003000;
		else if ( !PCfreeze )
            PC_reg <= npc_line;
	end
    
    assign instr = IM[(PC_line - 32'h00003000)/4];
    assign PC_line = PC_reg;
    assign PC = PC_line;
	
    assign npc_line =   (PCfreeze) ? PC_line :
								( BranchJudge )? BranchNPC :
                        ( JumpJudge )? JumpNPC : (PC_line + 4) ;
                        
endmodule