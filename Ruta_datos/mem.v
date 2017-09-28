`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 28/09/2017 08:12:00 AM
// Module Name: mem
//////////////////////////////////////////////////////////////////////////////////

module mem (
  input reloj,
  input  [31:0] DI_MEM,
  input  [6:0] DIR_MEM,
  input  [2:0] ctrl_MEM
  output [31:0] DO_MEMo
  );
//   ctrl_MEM = {MEM_RD, MEM_WR, w_h};
//w_h = 1 Mitad ; w_h = 0 Completa

  reg [31:0] mem [0:127] = 0; //Memoria de 32bits con 128 entradas
  reg [31:0] DO_MEMor = 32'b0;

  always @(posedge reloj)
    begin
          case (ctrl_MEM)
            3'b010: DO_MEMor <= mem[DIR_MEM]; //Se lee una palabra completa de memoria
            3'b101: mem[DIR_MEM][15:0] <= DI_MEM[15:0]; //Se guarda media palabra en memoria
            3'b100: mem[DIR_MEM] <= DI_MEM; //Se guarda una palabra completa en memoria
            default: DO_MEMor <= 32'b1 ;
          endcase
    end

    assign DO_MEMo = DO_MEMor;

endmodule // mem
