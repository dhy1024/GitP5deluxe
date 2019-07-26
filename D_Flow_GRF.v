`timescale 1ns / 1ps
`include "def.v"

module I2D_GRF(
    input [31:0] PC_in,
    input [31:0] instr_in,
    input reset,
    input clk,
    input freeze,
    output reg [31:0] PC,
    output reg [31:0] instr
);

initial begin
    PC <= 0;
    instr <= 0;
end

always @ (posedge clk) begin
    if (reset)  begin
        PC <= 0;
        instr <= 0;
    end
    else if (!freeze) begin
        PC <= PC_in;
        instr <= instr_in;
    end
end

endmodule // I2D_GRF

////////////////////////////////////////

module D2E_GRF(
    input [31:0] PC_in,
    input [31:0] instr_in,
    input [31:0] D1_in,
    input [31:0] D2_in,
    input reset,
    input clk,
	 input setNOP,
    output reg [31:0] PC,
    output reg [31:0] instr,
    output reg [31:0] D1,
    output reg [31:0] D2
);

initial begin
    PC <= 0;
    instr <= 0;
    D1 <= 0;
    D2 <= 0;
end

always @ (posedge clk) begin
    if (reset | setNOP)  begin
        PC <= 0;
        instr <= 0;
        D1 <= 0;
        D2 <= 0;
    end
    else begin
        PC <= PC_in;
        instr <= instr_in;
        D1 <= D1_in;
        D2 <= D2_in;
    end
end

endmodule // D2E_GRF

/////////////////////////////////////////

module E2M_GRF(
    input [31:0] PC_in,
    input [31:0] instr_in,
    input [31:0] ALUout_in,
    input [31:0] D2_in,
    input reset,
    input clk,
    output reg [31:0] PC,
    output reg [31:0] instr,
    output reg [31:0] ALUout,
    output reg [31:0] D2
);

initial begin
    PC <= 0;
    instr <= 0;
    ALUout <= 0;
    D2 <= 0;
end

always @ (posedge clk) begin
    if (reset )  begin
        PC <= 0;
        instr <= 0;
        ALUout <= 0;
        D2 <= 0;
    end
    else begin
        PC <= PC_in;
        instr <= instr_in;
        ALUout <= ALUout_in;
        D2 <= D2_in;
    end
end

endmodule // E2M_GRF

//////////////////////////////////

module M2W_GRF(
    input [31:0] PC_in,
    input [31:0] instr_in,
    input [31:0] ALUout_in,
    input [31:0] MEMout_in,
    input reset,
    input clk,
    output reg [31:0] PC,
    output reg [31:0] instr,
    output reg [31:0] ALUout,
    output reg [31:0] MEMout
);

initial begin
    PC <= 0;
    instr <= 0;
    ALUout <= 0;
    MEMout <= 0;
end

always @ (posedge clk) begin
    if (reset )  begin
        PC <= 0;
        instr <= 0;
        ALUout <= 0;
        MEMout <= 0;
    end
    else begin
        PC <= PC_in;
        instr <= instr_in;
        ALUout <= ALUout_in;
        MEMout <= MEMout_in;
    end
end

endmodule // M2W_GRF