`timescale 1ns / 1ps
`include "def.v"

module D_GRF(
    input clk,
    input reset,
    input GRFwrite,
    input [4:0] R1,
    input [4:0] R2,
    input [4:0] WR,
    input [31:0] WD,
    input [31:0] W_PC,
    output [31:0] D1,
    output [31:0] D2 
);

reg [31:0] D1_reg, D2_reg, i;
reg [31:0] GRFcell [0:31];

initial begin
    for (i=0; i<32; i=i+1) begin
        GRFcell[i] <= 0;
    end
end

always @(posedge clk) begin
    //reset
    if(reset) begin
        for (i=0; i<32; i=i+1) begin
            GRFcell[i] <= 0;
        end
    end
    //write
    else if (GRFwrite) begin
        $display("%d@%h: $%d <= %h", $time, W_PC, WR, WD);
        if ( WR != 5'h0 ) begin
            GRFcell[WR] <= WD;
        end
    end
end

//read
assign D1 = GRFcell[R1];
assign D2 = GRFcell[R2];

    
endmodule