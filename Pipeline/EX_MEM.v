`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: EX_MEM
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM(
    input reloj,
    input resetEX,
    input enableEX,
    input [31:0] Y_ALU, //Salida de ALU
    input [4:0] Y_MUX, //Salida MUX que elige entre rd y rt para Write Back
    input [31:0] DOB,
    output [4:0] rd_rt,
    output [31:0] DI_MEM,
    output [31:0] DIR_MEM
    );
    
 reg [68:0] EX_MEM;
    
always @(posedge reloj)

begin
   if (resetEX) 
   begin
      EX_MEM <= 69'b1;
   end
    
   else if (enableEX) 
   begin
      EX_MEM <= {Y_ALU,DOB,Y_MUX};
   end
   
   else
      EX_MEM <= EX_MEM;
end
						
    assign DIR_MEM = EX_MEM[68:37];
    assign DI_MEM = EX_MEM[36:5];
    assign rd_rt = EX_MEM[4:0];						
    
    
    
    
endmodule
