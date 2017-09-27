`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2017 23:40:10
// Design Name: 
// Module Name: execute
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


module execute(

input [2:0] ALU_FUN,
input [31:0] input_A, input_sz,input_register,
input [4:0] rt,rd,
input SEL_ALU,SEL_REG,




output [31:0] out_ALU,out_dato_registro,
output [4:0] out_mux_sel_reg

    );
    
    
    reg [31:0] out_alu;
    wire [31:0] input_B;
    
    
    
    
    ///////////// mux alu
    
    
     assign input_B = SEL_ALU ? input_sz: input_register; 
        
    
    
    
  ////////// ALU
  
  always @(*)
  begin
  
    if(ALU_FUN==3'b001)
    begin
    out_alu <= input_A + input_B;
    
    end
    
    else if(ALU_FUN==3'b010)
    begin
    out_alu <= input_A - input_B;
        
    end 
  
  
    else if(ALU_FUN==3'b011)
    begin
    out_alu <= input_A & input_B;
           
    end
  
    else if(ALU_FUN==3'b100)
    begin
    out_alu <= input_A | input_B;
            
    end
  
    else if(ALU_FUN==3'b101)
    begin
    out_alu <= ~(input_A | input_B);
                
    end
    
    else if(ALU_FUN==3'b110 && input_A < input_B )
        begin
        out_alu <= 1;
                
        end

    else if(ALU_FUN==3'b110 && input_A > input_B )
        begin
        out_alu <= 0;
                
        end  
    
    else 
    begin
    out_alu <= out_alu;
    end
    
  
  
  end
  
  
  
  
  
  /////////// mux sel_reg
  
  
  assign out_mux_sel_reg = SEL_REG ? rd: rt; 
  
  
  
  
  //////// asignar salidas 
  
  
  assign out_ALU = out_alu;
  assign out_dato_registro = input_register;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
