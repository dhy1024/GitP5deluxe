`timescale 1ns / 1ps
`include "def.v"

module D_BranchCtrl(
    input [31:0] D1,
    input [31:0] D2,
    input [31:0] PC,
    input [31:0] instr,
    output BranchJudge,
    output [31:0] BranchNPC
);

reg BranchJudge_reg;
reg [31:0] BranchNPC_reg;

always @ (*) begin
    case (instr[31:26])
    `beq_op : begin
        if (D1 == D2) begin
            BranchJudge_reg <= 1'b1;
            BranchNPC_reg <= ( PC + 4 + ({{14{instr[15]}},instr[15:0],2'b00}) );
        end
        else begin
            BranchJudge_reg <=1'b0;
            BranchNPC_reg <= 0;
        end
    end
	 `blezalr_op : begin
			if(instr[`func]==`blezalr_func) begin
					if(D1[31]==1'b1 || D1==32'b0) begin
							BranchJudge_reg <= 1'b1;
							BranchNPC_reg <= D2;
					end
					else begin
						BranchJudge_reg <=1'b0;
						BranchNPC_reg <= 0;
					end
			end
	 end
    default : begin
        BranchJudge_reg <=1'b0;
        BranchNPC_reg <= 0;
    end
	endcase
end

assign BranchJudge = BranchJudge_reg;
assign BranchNPC = BranchNPC_reg;

endmodule // D_BranchCtrl