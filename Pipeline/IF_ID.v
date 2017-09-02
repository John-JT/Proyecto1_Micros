`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2017 08:23:29 AM
// Design Name: 
// Module Name: IF_ID
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
    output [5:0] opcode
    );
endmodule
