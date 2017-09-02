`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2017 08:23:29 AM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    input reloj,
    input resetEX,
    input enableEX,
    input [31:0] Y_ALU, //Salida de ALU
    input [4:0] Y_MUX, //Salida MUX que elige entre rd y rt para Write Back
    input [31:0] DOB,
    output [4:0] rd_o,
    output [31:0] DI_MEM,
    output [31:0] DIR_MEM
    );
endmodule
