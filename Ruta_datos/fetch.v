`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2017 23:22:33
// Design Name: 
// Module Name: fetch
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


module fetch(

input wire [31:0] DOA_exe, jump_exe,
input wire clock,  MEM_RD,
input [1:0] SEL_DIR,

output wire [31:0] PC_4, OUT_mem

    );
    
    
    reg [31:0] out_mux;
 
    reg [31:0] out_REG1;
    
    
    
    
    
    
 ////// mux SEL_DIR   
 
   always @(*)
    case (SEL_DIR)
       2'b00: out_mux <= PC_4;
       2'b01: out_mux <= DOA_exe;
       2'b10: out_mux <= jump_exe;
       2'b11: out_mux = 0;
    endcase
 
 
 //// registro 1 (antes de memoria de inst)
 
 always @(posedge clock)
 begin 

    out_REG1 <= out_mux;
end
    
    ///////// sumador
    
    
 assign PC_4 =  out_REG1 + 3'b100;
 
 
    
    
    
    
    
    
    
    
    
        
endmodule
