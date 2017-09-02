`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2017 08:23:29 AM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input [31:0] DO_MEM, //Salida Memoria de Datos
    input [31:0] DIR_MEM, //Entrada Direccion Memoria de Datos
    input [31:0] Y_ALU, //Entrada ALU
    input [4:0] rd,
    output [4:0] rd_o, //Salida para WB 
    output [31:0] Y_ALUo, // Salida directa de la ALU
    output [31:0] DO_MEMo //Salida de Memoria de Datos a Multiplexor Selector
    );
endmodule