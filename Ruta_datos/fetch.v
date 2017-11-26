`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 30.08.2017 23:22:33
// Design Name:
// Module Name: fetch
//////////////////////////////////////////////////////////////////////////////////


module fetch(
  input wire [31:0] DOA_exe,
  input wire reloj,reset,
  input [1:0] SEL_DIR,
  input [31:0] jump_exe,
  output wire [31:0] P_C,
  output [3:0] PC_4
  );


  reg [31:0] PC = 32'd0;


  ////// mux SEL_DIR
  always @(posedge reloj)
  if (reset)
    begin
        PC <= 32'd0;
    end
  else
    begin
        case (SEL_DIR)
         2'b00: PC <= PC + 32'd4;
         2'b01: PC <= jump_exe;
         2'b10: PC <= DOA_exe;
         2'b11: PC <= 32'd0;
        endcase
    end


    assign P_C = PC;
    assign PC_4 = P_C[31:28];


endmodule
