`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 28/09/2017 08:12:29 AM
// Module Name: instruction_mem
//////////////////////////////////////////////////////////////////////////////////

module instruction_mem (
 // input reloj, reset,
  input [5:0] addr,
  output [31:0] data
  );
  reg [31:0] mem [0:51]; //Memoria de 32bits con 52 entradas
  //reg [31:0] datareg;

  parameter archivo = "mem_inst.txt";

  initial
    begin
        $readmemb(archivo,mem,0,51);
    end

    assign data = mem[addr];
    
    /*
    always @ (posedge reloj)
    begin
      if (reset) datareg <= 32'b0;
      else datareg <= mem[addr];
    end

    assign data = datareg;
    */
    
endmodule //instruction_mem
