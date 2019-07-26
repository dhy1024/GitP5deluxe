`timescale 1ns / 1ps
`include "def.v"

module C_D2E_GRF(
    input reset,
    input clk,
	 input setNOP,
    input [31:0] Tnew_in,
    input [31:0] Tuse_A1_in,
    input [31:0] Tuse_A2_in,
    input [31:0] A1_in,
    input [31:0] A2_in,
    input [31:0] A3_in,
    input [31:0] type_in,
    output reg [31:0] Tnew,
    output reg [31:0] Tuse_A1,
    output reg [31:0] Tuse_A2,
    output reg [31:0] A1,
    output reg [31:0] A2,
    output reg [31:0] A3,
    output reg [31:0] type
);

initial begin
    Tnew <= 0;
    Tuse_A1 <= 4;
    Tuse_A2 <= 4;
    A1 <= -1;
    A2 <= -1;
    A3 <= -2;
    type <=0;
end

always @ (posedge clk) begin
    if (reset)  begin
        Tnew <= 0;
        Tuse_A1 <= 0;
        Tuse_A2 <= 0;
        A1 <= 0;
        A2 <= 0;
        A3 <= 0;
        type <=0;
    end
	 if (setNOP) begin
		Tnew <= 0;
		Tuse_A1 <= 4;
		Tuse_A2 <= 4;
		A1 <= -1;
		A2 <= -1;
		A3 <= -2;
		type <=0;
	 end
    else begin
		if(Tnew_in>0)
        Tnew <= Tnew_in - 1;
        Tuse_A1 <= Tuse_A1_in;
        Tuse_A2 <= Tuse_A2_in;
        A1 <= A1_in;
        A2 <= A2_in;
        A3 <= A3_in;
        type <=type_in;
    end
end

endmodule // C_D2E_GRF

module C_E2M_GRF(
    input reset,
    input clk,
    input [31:0] Tnew_in,
    input [31:0] Tuse_A1_in,
    input [31:0] Tuse_A2_in,
    input [31:0] A1_in,
    input [31:0] A2_in,
    input [31:0] A3_in,
    input [31:0] type_in,
    output reg [31:0] Tnew,
    output reg [31:0] Tuse_A1,
    output reg [31:0] Tuse_A2,
    output reg [31:0] A1,
    output reg [31:0] A2,
    output reg [31:0] A3,
    output reg [31:0] type
);

initial begin
    Tnew <= 0;
    Tuse_A1 <= 4;
    Tuse_A2 <= 4;
    A1 <= -1;
    A2 <= -1;
    A3 <= -2;
    type <=0;
end

always @ (posedge clk) begin
    if (reset)  begin
        Tnew <= 0;
        Tuse_A1 <= 0;
        Tuse_A2 <= 0;
        A1 <= 0;
        A2 <= 0;
        A3 <= 0;
        type <=0;
    end
    else begin
		if(Tnew_in>0)
        Tnew <= Tnew_in -1 ;
        Tuse_A1 <= Tuse_A1_in;
        Tuse_A2 <= Tuse_A2_in;
        A1 <= A1_in;
        A2 <= A2_in;
        A3 <= A3_in;
        type <=type_in;
    end
end

endmodule // C_E2M_GRF


module C_M2W_GRF(
    input reset,
    input clk,
    input [31:0] Tnew_in,
    input [31:0] Tuse_A1_in,
    input [31:0] Tuse_A2_in,
    input [31:0] A1_in,
    input [31:0] A2_in,
    input [31:0] A3_in,
    input [31:0] type_in,
    output reg [31:0] Tnew,
    output reg [31:0] Tuse_A1,
    output reg [31:0] Tuse_A2,
    output reg [31:0] A1,
    output reg [31:0] A2,
    output reg [31:0] A3,
    output reg [31:0] type
);

initial begin
    Tnew <= 0;
    Tuse_A1 <= 4;
    Tuse_A2 <= 4;
    A1 <= -1;
    A2 <= -1;
    A3 <= -2;
    type <=0;
end

always @ (posedge clk) begin
    if (reset)  begin
        Tnew <= 0;
        Tuse_A1 <= 0;
        Tuse_A2 <= 0;
        A1 <= 0;
        A2 <= 0;
        A3 <= 0;
        type <=0;
    end
    else begin
	 if(Tnew_in>0)
        Tnew <= Tnew_in - 1;
        Tuse_A1 <= Tuse_A1_in;
        Tuse_A2 <= Tuse_A2_in;
        A1 <= A1_in;
        A2 <= A2_in;
        A3 <= A3_in;
        type <=type_in;
    end
end

endmodule // C_M2W_GRF