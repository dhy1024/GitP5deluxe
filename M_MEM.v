`timescale 1ns / 1ps
`include "def.v"

module M_MEM(
    input reset,
    input clk,
    input MEMwrite,
    input MEMread,
    input [31:0] MEMmode,
    input [31:0] addr,
    input [31:0] data,
    input [31:0] PC,
    output [31:0] out
);

reg [7:0] MEMcell [0:4095];
reg [31:0] i;
wire [31:0] out_wire_word, out_wire_byte, out_wire_half;

initial begin
    for (i=0; i<4096; i=i+1)  
        MEMcell[i] <= 0;
end

always @(posedge clk) begin
    //reset
    if (reset) begin
        for (i=0; i<4096; i=i+1)  
            MEMcell[i] <= 0;
    end
    //write
    else if (MEMwrite) begin
        $display("%d@%h: *%h <= %h", $time, PC, addr, data);
        if (MEMmode == 0) //word
            { MEMcell[addr+3], MEMcell[addr+2], 
            MEMcell[addr+1], MEMcell[addr] } <= data;
        else if (MEMmode == 1) //byte
            MEMcell[addr] <= data[7:0];
        else if (MEMmode == 2) //half byte
            { MEMcell[addr+1], MEMcell[addr]} <= data[15:0];
    end

end

//out
assign out_wire_word = { MEMcell[addr+3], MEMcell[addr+2], 
                    MEMcell[addr+1], MEMcell[addr] };
assign out_wire_byte = $signed(MEMcell[addr]);
assign out_wire_half = $signed({MEMcell[addr+1],MEMcell[addr]});

assign out = (MEMmode==0)? out_wire_word :
             (MEMmode==1)? out_wire_byte : out_wire_half;

endmodule // M_MEM