`timescale 1ns / 1ps
`include "def.v"

module AT_encoder(
    input [31:0] instr,
    output [31:0] Tnew,
    output [31:0] Tuse_A1,
    output [31:0] Tuse_A2,
    output [31:0] A1,
    output [31:0] A2,
    output [31:0] A3,
    output [31:0] type
);

reg [31:0] Tnew_reg, Tuse_A1_reg, Tuse_A2_reg, A1_reg, 
            A2_reg, A3_reg, type_reg;

always @(*) begin
    if(instr[`op]==`addu_op && instr[`func]==`addu_func) begin //addu
        Tnew_reg <= 2; 
        Tuse_A1_reg <= 1;
        Tuse_A2_reg <= 1; 
        A1_reg <= instr[`rs];
        A2_reg <= instr[`rt];
        A3_reg <= instr[`rd];
        type_reg <= `ALU;
    end
    else if(instr[`op]==`subu_op && instr[`func]==`subu_func) begin //sub
        Tnew_reg <= 2; 
        Tuse_A1_reg <= 1;
        Tuse_A2_reg <= 1; 
        A1_reg <= instr[`rs];
        A2_reg <= instr[`rt];
        A3_reg <= instr[`rd];
        type_reg <= `ALU;
    end
	 else if(instr[`op]==`blezalr_op && instr[`func]==`blezalr_func) begin //blezalr
        Tnew_reg <= 1; 
        Tuse_A1_reg <= 0;
        Tuse_A2_reg <= 0; 
        A1_reg <= instr[`rs];
        A2_reg <= instr[`rt];
        A3_reg <= instr[`rd];
        type_reg <= `ALU;
    end
    else if(instr[`op]==`ori_op ) begin //ori
        Tnew_reg <= 2; 
        Tuse_A1_reg <= 1;
        Tuse_A2_reg <= 4; 
        A1_reg <= instr[`rs];
        A2_reg <= -1;
        A3_reg <= instr[`rt];
        type_reg <= `ALU;
    end
    else if(instr[`op]==`lw_op ) begin //lw
        Tnew_reg <= 3; 
        Tuse_A1_reg <= 1;
        Tuse_A2_reg <= 4; 
        A1_reg <= instr[`rs];
        A2_reg <= -1;
        A3_reg <= instr[`rt];
        type_reg <= `MEM;
    end
    else if(instr[`op]==`sw_op ) begin //sw
        Tnew_reg <= 0; 
        Tuse_A1_reg <= 1;
        Tuse_A2_reg <= 2; 
        A1_reg <= instr[`rs];
        A2_reg <= instr[`rt];
        A3_reg <= -2;
        type_reg <= `NOP;
    end
    else if(instr[`op]==`beq_op ) begin //beq
        Tnew_reg <= 0; 
        Tuse_A1_reg <= 0;
        Tuse_A2_reg <= 0; 
        A1_reg <= instr[`rs];
        A2_reg <= instr[`rt];
        A3_reg <= -2;
        type_reg <= `NOP;
    end
    else if(instr[`op]==`lui_op ) begin //lui
        Tnew_reg <= 2; 
        Tuse_A1_reg <= 4;
        Tuse_A2_reg <= 4; 
        A1_reg <= -1;
        A2_reg <= -1;
        A3_reg <= instr[`rt];
        type_reg <= `ALU;
    end
    else if(instr[`op]==`j_op ) begin //j
        Tnew_reg <= 0; 
        Tuse_A1_reg <= 4;
        Tuse_A2_reg <= 4; 
        A1_reg <= -1;
        A2_reg <= -1;
        A3_reg <= -2;
        type_reg <= `NOP;
    end
    else if(instr[`op]==`jal_op ) begin //jal
        Tnew_reg <= 1; 
        Tuse_A1_reg <= 4;
        Tuse_A2_reg <= 4; 
        A1_reg <= -1;
        A2_reg <= -1;
        A3_reg <= 32'd31;
        type_reg <= `ALU;
    end
    else if(instr[`op]==`jr_op && instr[`func]==`jr_func) begin //jr
        Tnew_reg <= 0; 
        Tuse_A1_reg <= 0;
        Tuse_A2_reg <= 4; 
        A1_reg <= instr[`rs];
        A2_reg <= -1;
        A3_reg <= -2;
        type_reg <= `NOP;
    end
    else if(instr[`op]==`nop_op && instr[`func]==`nop_func) begin //nop
        Tnew_reg <= 0; 
        Tuse_A1_reg <= 4;
        Tuse_A2_reg <= 4; 
        A1_reg <= -1;
        A2_reg <= -1;
        A3_reg <= -2;
        type_reg <= `NOP;
    end
end

assign Tnew = Tnew_reg;
assign Tuse_A1 = Tuse_A1_reg;
assign Tuse_A2 = Tuse_A2_reg;
assign A1 = A1_reg;
assign A2 = A2_reg;
assign A3 = A3_reg;
assign type = type_reg;

endmodule // AT_encoder