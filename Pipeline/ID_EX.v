`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2017 08:23:29 AM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input reloj,
    input resetID,
    input enableID,
    input [4:0] rd,
    input [4:0] rs,
    input [4:0] rt,
    input [31:0] DOA, //Salida A de Banco de Registros
    input [31:0] DOB, //Salida B de Banco de Registros
    output [31:0] A,
    output [31:0] B,
    output [4:0] rd_o,
    output [4:0] rs_o,
    output [4:0] rt_o
    );
endmodule
