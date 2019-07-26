`timescale 1ns / 1ps
`include "def.v"

module D_JumpCtrl(
    input [31:0] PC,
    input [31:0] instr,
    input [31:0] D1,
    output [31:0] JumpNPC,
    output JumpJudge
    
);

reg JumpJudge_reg;
reg [31:0] JumpNPC_reg;

always @ (*) begin
    if ( instr[31:26] == `j_op ) begin  // j
        JumpJudge_reg <= 1'b1;
        JumpNPC_reg <= {PC[31:28], instr[25:0], 2'b00};
    end
    else if ( instr[31:26] == `jal_op ) begin // jal
        JumpJudge_reg <= 1'b1;
        JumpNPC_reg <= {PC[31:28], instr[25:0], 2'b00};
    end
    else if ( (instr[31:26] == `jr_op)&&(instr[5:0] == `jr_func) ) begin // jr
        JumpJudge_reg <= 1'b1;
        JumpNPC_reg <= D1;
    end

    else begin // is not j type instr
        JumpJudge_reg <= 1'b0;
        JumpNPC_reg <= 0;
    end

end

assign JumpNPC = JumpNPC_reg;
assign JumpJudge = JumpJudge_reg;

endmodule // D_JumpCtrl