`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: MEM_WB
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB(
    input reloj,
    input resetMEM,
    input enableMEM,
    input [31:0] DO_MEM, //Salida Memoria de Datos
    input [31:0] DIR_MEM, //Entrada Direccion Memoria de Datos
    input [4:0] rd,
    output [4:0] rd_o, //Salida para WB 
    output [31:0] DIR_MEMo, // Salida directa de la ALU
    output [31:0] DO_MEMo //Salida de Memoria de Datos a Multiplexor Selector
    );
    
   reg [68:0] MEM_WB;

always @(posedge reloj)
begin

   if (resetMEM) begin
      MEM_WB <= 69'b1;
   end 
   
   else if (enableMEM) 
   begin
      MEM_WB <= {DO_MEM,DIR_MEM,rd};
   end
   
   else
      MEM_WB <= MEM_WB;
      
end


    assign DO_MEMo = MEM_WB[68:37];
    assign DIR_MEMo = MEM_WB[36:5];
    assign rd_o = MEM_WB[4:0];					
						
    
    
endmodule