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
  input wire reloj,reset,
  input [1:0] SEL_DIR,

  output wire [31:0] OUT_mem,
  output wire [3:0] PC_4);

    
  reg [31:0] PC;
  wire [31:0] PC_4_32;  


  ////// mux SEL_DIR
  always @(posedge reloj)
  if (reset)
    PC <= 32'b0;
  else
  case (SEL_DIR)
     2'b00: PC <= PC_4_32;
     2'b01: PC <= jump_exe;
     2'b10: PC <= DOA_exe;
     2'b11: PC <= 32'b0;
  endcase

  ///////// sumador
  assign PC_4_32 =  PC + 3'b100;
  assign PC_4 = PC_4_32[31:28];
  

  instruction_mem im(.addr(PC),.data(OUT_mem));


endmodule
