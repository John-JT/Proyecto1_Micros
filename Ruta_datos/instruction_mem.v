`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 28/09/2017 08:12:29 AM
// Module Name: instruction_mem
//////////////////////////////////////////////////////////////////////////////////

module instruction_mem (
  input [31:0] addr,
  output [31:0] data
  );

  reg [31:0] mem [0:55]; //Memoria de 32bits con 52 entradas
  parameter archivo = "mem_inst.txt";

  initial
    begin
        $readmemb(archivo,mem,0,55);
    end

  assign data = mem[addr[9:2]];

endmodule //instruction_mem
