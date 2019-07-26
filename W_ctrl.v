`timescale 1ns / 1ps
`include "def.v"

module W_ctrl(
    input [31:0] instr,
    output [31:0] WBslt,
    output GRFwrite,
    output [4:0] WR
);

reg [31:0] WBslt_reg, WR_reg;
reg GRFwrite_reg;

initial begin
    WBslt_reg <= 0;
    WR_reg <= 0;
    GRFwrite_reg <= 0;
end

always @ (*) begin
    case (instr[`op])
    6'b000000: begin //R type
        if(instr[`func]==`addu_func) begin //addu
            GRFwrite_reg <= 1'b1;
            WR_reg <= 1;
            WBslt_reg <= 0;
        end 
        else if(instr[`func]==`subu_func) begin //subu
            GRFwrite_reg <= 1'b1;
            WR_reg <= 1;
            WBslt_reg <= 0;
        end
        else begin //nop
            GRFwrite_reg <= 1'b0;
            WR_reg <= 0;
            WBslt_reg <= 0;
        end      
    end
    `ori_op : begin //ori
        GRFwrite_reg <= 1'b1;
        WR_reg <= 0;
        WBslt_reg <= 0;
    end
    `lw_op : begin //lw
        GRFwrite_reg <= 1'b1;
        WR_reg <= 0;
        WBslt_reg <= 1;
    end
    `lui_op : begin //lui
        GRFwrite_reg <= 1'b1;
        WR_reg <= 0;
        WBslt_reg <= 0;
    end
    `jal_op : begin //jal
        GRFwrite_reg <= 1'b1;
        WR_reg <= 2;
        WBslt_reg <= 0;
    end
	 `blezalr_op : begin
			if (instr[`func]==`blezalr_func) begin
					GRFwrite_reg <= 1'b1;
					WR_reg <= 1;
					WBslt_reg <= 0;
			end
	 end
    default : begin //GRFwrite=0
        GRFwrite_reg <= 1'b0;
        WR_reg <= 0;
        WBslt_reg <= 0;
    end      
    endcase
end

assign GRFwrite = GRFwrite_reg;
assign WBslt = WBslt_reg;
assign WR = (WR_reg==0)? instr[20:16]:
            (WR_reg==1)? instr[15:11]: 5'd31;

endmodule // W_ctrl