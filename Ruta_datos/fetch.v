`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 30.08.2017 23:22:33
// Design Name:
// Module Name: fetch
//////////////////////////////////////////////////////////////////////////////////
module fetch(

input wire [31:0] DOA_exe, jump_exe,
input wire clock,  MEM_RD,reset,
input [1:0] SEL_DIR,

output wire [31:0] OUT_mem,
output wire [31:0] PC_4

    );

    reg [31:0] PC;




 ////// mux SEL_DIR

   always @(posedge clock)
   if (reset)
   PC <= 32'd0;
   else
    case (SEL_DIR)
       2'b00: PC <= PC_4;
       2'b01: PC <= DOA_exe;
       2'b10: PC <= jump_exe;
       2'b11: PC = 0;
    endcase

    ///////// sumador


 assign PC_4 =  PC + 3'b100;

instruction_mem im(.addr(PC_4),.data(OUT_mem));







endmodule
