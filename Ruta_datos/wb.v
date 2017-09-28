`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2017 18:18:00
// Design Name: 
// Module Name: wb
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


module wb(

input DIR_WB,
input [31:0] DO,DIR,

output [31:0] out_mux_wb


    );
    
    
      assign out_mux_wb = DIR_WB ? DIR : DO;
    
    
    
    
endmodule
