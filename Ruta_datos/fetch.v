`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 30.08.2017 23:22:33
// Design Name:
// Module Name: fetch
//////////////////////////////////////////////////////////////////////////////////


module fetch(
  input wire [5:0] DOA_exe, jump_exe,
  input wire reloj,reset,
  input [1:0] SEL_DIR,
  output wire [5:0] P_C,
  output wire [31:0] OUT_mem);


  reg [5:0] PC = 6'b000000;
  //wire [5:0] PC_4;


  ////// mux SEL_DIR
  always @(posedge reloj)
  if (reset)
    begin
        PC <= 6'b000000;
    end
  else
    begin
        case (SEL_DIR)
         2'b00: PC <= PC + 6'b000001;
         2'b01: PC <= jump_exe;
         2'b10: PC <= DOA_exe;
         2'b11: PC <= 6'b0;
        endcase
    end

    assign P_C = PC;

  ///////// sumador
  //assign PC_4 = PC + 6'b000001;


  //////// memoria de instrucciones
  instruction_mem im(.addr(PC),.data(OUT_mem));


endmodule
