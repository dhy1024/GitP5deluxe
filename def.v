`timescale 1ns / 1ps

//op
`define addu_op  6'b000000
`define subu_op   6'b000000
`define ori_op   6'b001101
`define lw_op    6'b100011
`define sw_op    6'b101011
`define beq_op   6'b000100
`define lui_op   6'b001111
`define j_op     6'b000010
`define jal_op   6'b000011
`define jr_op    6'b000000
`define nop_op   6'b000000
`define blezalr_op 6'b011000

//func
`define addu_func  6'b100001
`define subu_func  6'b100011
`define jr_func    6'b001000
`define nop_func   6'b000000
`define blezalr_func 6'b011110

//type

`define NOP  0
`define ALU  1
`define MEM  2


//value
`define op 31:26
`define rs 25:21
`define rt 20:16
`define rd 15:11
`define func 5:0