`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: ID_EX
//////////////////////////////////////////////////////////////////////////////////


module ID_EX(
    input reloj,
    input resetID,
    input enableID,
    input [31:0] SIGN_EXT,
    input [4:0] rd,
    input [4:0] rs,
    input [4:0] rt,
    input [31:0] DOA, //Salida A de Banco de Registros
    input [31:0] DOB, //Salida B de Banco de Registros
    output [31:0] A,
    output [31:0] B,
    output [4:0] rd_o,
    output [4:0] rs_o,
    output [4:0] rt_o,
    output [31:0] SIGN_EXTo
    );
    
    
 reg [110:0] ID_EX;    
    
always @(posedge reloj)

begin

   if (resetID) 
   begin
      ID_EX  <= 111'b1;
   end 
   
   else if (enableID) 
   begin
      ID_EX <= {DOA,DOB,SIGN_EXT,rd,rs,rt};
   end
   
   else
      ID_EX <= ID_EX;
   
end	

   assign A = ID_EX[110:79];
   assign B = ID_EX[78:47];
   assign SIGN_EXTo = ID_EX[46:15];
   assign rd_o = ID_EX[14:10];
   assign rs_o = ID_EX[9:5];
   assign rt_o = ID_EX[4:0];					
						
endmodule
