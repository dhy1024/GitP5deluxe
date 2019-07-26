`timescale 1ns / 1ps
`include "def.v"

module M_ctrl(
    input [31:0] instr,
    output MEMwrite,
    output MEMread,
    output [31:0] MEMmode
);

reg MEMwrite_reg, MEMread_reg;
reg [31:0] MEMmode_reg;

initial begin
    MEMwrite_reg <= 0;
    MEMread_reg <= 0;
    MEMmode_reg <= 0;
end

always @ (*) begin
    if (instr[`op]==`lw_op) begin //lw
        MEMread_reg <= 1'b1;
        MEMwrite_reg <= 1'b0;
        MEMmode_reg <= 0;
    end
    else if (instr[`op]==`sw_op) begin //sw
        MEMread_reg <= 1'b0;
        MEMwrite_reg <= 1'b1;
        MEMmode_reg <= 1'b0;
    end
	 else if (instr[`op]==`blezalr_op && instr[`func]==`blezalr_func) begin //blezalr
        MEMread_reg <= 1'b0;
        MEMwrite_reg <= 1'b0;
        MEMmode_reg <= 1'b0;
	end
    else begin
        MEMread_reg <= 1'b0;
        MEMwrite_reg <= 1'b0;
        MEMmode_reg <= 1'b0;
    end
end

assign MEMwrite = MEMwrite_reg;
assign MEMread = MEMread_reg;
assign MEMmode = MEMmode_reg;

endmodule // M_ctrl