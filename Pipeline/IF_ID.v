`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: IF_ID
//////////////////////////////////////////////////////////////////////////////////

/*
Comentario Dalberth: no hace falta el shamt, hace falta el jump address (bits [25:0])
*/

module IF_ID(
    input reloj,
    input resetIF,
    input enableIF,
    input [31:0] PC_4, //Salida de Sumador de PC+4
    input [31:0] DO, //Salida de Memoria de Instrucciones
    output [4:0] rd,
    output [4:0] rs,
    output [4:0] rt,
    output [15:0] imm,
    output [5:0] opcode,
    output [5:0] funct,
    output [31:0] PC_4o,
    output [4:0] shamt
    );
   
   
    reg [63:0] IF_ID;   

always @(posedge reloj)

begin
    if (resetIF) 
    begin
        IF_ID <= 64'b1;
    end 
    
    else if (enableIF) 
    begin
        IF_ID <= {PC_4,DO};
    end
    
    else
        IF_ID <= IF_ID;
end
        
  assign imm = IF_ID[15:0];
  assign rd = IF_ID[15:11];
  assign rt = IF_ID[20:16];
  assign rs = IF_ID[25:21];
  assign opcode = IF_ID[31:26];
  assign funct = IF_ID[5:0];  
  assign shamt = IF_ID[10:6];
  assign PC_4o = IF_ID[63:32];  
    
    
    
    
    
endmodule
