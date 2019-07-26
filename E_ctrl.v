`timescale 1ns / 1ps
`include "def.v"

module E_ctrl(
    input [31:0] instr,
    output [31:0] ALUsrc,
    output [31:0] ALUop
);

reg [31:0] ALUsrc_reg;
reg [31:0] ALUop_reg;

initial begin
    ALUsrc_reg <= 0;
    ALUop_reg <= 0;
end

always @ (*) begin
    if (instr[`op]== `addu_op && instr[`func]==`addu_func) begin //addu
        ALUsrc_reg <= 0;
        ALUop_reg <= 0;
    end
    else if (instr[`op]== `subu_op && instr[`func]==`subu_func) begin //subu
        ALUsrc_reg <= 0;
        ALUop_reg <= 1;
    end
	 else if (instr[`op]== `blezalr_op && instr[`func]==`blezalr_func) begin //blezalr
        ALUsrc_reg <= 0;
        ALUop_reg <= 4;
    end
    else if (instr[`op]== `ori_op ) begin //ori
        ALUsrc_reg <= 1;
        ALUop_reg <= 2;
    end
    else if (instr[`op]== `lw_op ) begin //lw
        ALUsrc_reg <= 2;
        ALUop_reg <= 0;
    end
    else if (instr[`op]== `sw_op ) begin //sw
        ALUsrc_reg <= 2;
        ALUop_reg <= 0;
    end
    else if (instr[`op]== `lui_op ) begin //lui
        ALUsrc_reg <= 1;
        ALUop_reg <= 3;
    end
    else if (instr[`op]== `jal_op ) begin //jal
        ALUsrc_reg <= 0;
        ALUop_reg <= 4;
    end
    else begin
        ALUsrc_reg <= 0;
        ALUop_reg <= 0;
    end

end

assign ALUop = ALUop_reg;
assign ALUsrc = ALUsrc_reg;

endmodule // E_ctrl