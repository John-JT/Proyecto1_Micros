`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2017 22:01:26
// Design Name: 
// Module Name: decode
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


module decode(

input [4:0] DIR_A, DIR_B, DIR_WRA,
input [31:0] DI,PC_4,
input REG_RD, REG_WR,SEL_I,
input [15:0] IMD,
input [25:0] address,



output wire [31:0] DOA,DOB,out_mux_sz, out_addr


    );
    
reg [31:0] routA, routB = 0; 
reg [31:0] registro [0:31];
reg [31:0] out_sign, out_zero = 0;
 

   ////////// banco de registros

always @(*)
begin
registro [0] <= 0;

    if (REG_RD == 0)
    begin
    
    routA <= registro [DIR_A];
    routB <= registro [DIR_B];
    
    end
    
    else if(REG_WR == 0)
    begin
    
    registro[DIR_WRA] <= DI;
    
    end
    
    else 
    begin
    
    routA <= 0;
    routB <= 0;   
    
    end


end   

      assign DOA = routA;
      assign DOB = routB;
    
    
    ///////////sign extension
    
always @(*)
    
    begin
    
    if(IMD[15]==1'b1)
 begin
    out_sign <= {16'b1111111111111111,IMD};
   end 

    
    else if (IMD[15]==1'b0)
   begin
    out_sign <= {16'b0000000000000000,IMD};
    end
 
    
    else
    begin 

    out_sign <= out_sign;
    end

    
    end
    
    
   /////// zero extension 
    
    always @(*)
    begin
    
    out_zero <= {16'b0000000000000000,IMD};
    
    
    end
    
    
    
    ////////// mux sign and zero
    
    assign out_mux_sz = SEL_I ? out_sign: out_zero; 
    
    
    /////// calculo para jump addr 
    
    
    assign out_addr = {PC_4[31:28],address,2'b00};
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
