`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: EX_MEM
//////////////////////////////////////////////////////////////////////////////////


module EX_MEM(
    input reloj,
    input resetEX,
    input enableEX,
    input [2:0] ctrl_MEM_exe,
    input [1:0] ctrl_WB_exe,
    input [31:0] Y_ALU, //Salida de
    input [31:0] DOB_exe,//salida DOB en la etapa EXE
    input [4:0] Y_MUX, //Salida MUX que elige entre rd y rt para Write Back

    output MEM_RD,
    output MEM_WR,
    output w_h,
    output [1:0] ctrl_WB_mem,
    output [31:0] DIR,
    output [31:0] DI,
    output [4:0] Y_MUX_mem
    );


    reg [73:0] EX_MEM;


    always @(posedge reloj)

    begin
       if (resetEX)
       begin
          EX_MEM <= 74'b0;
       end

       else if (enableEX)
       begin
          EX_MEM <= {ctrl_MEM_exe, ctrl_WB_exe, Y_ALU, DOB_exe, Y_MUX};
       end

       else
          EX_MEM <= EX_MEM;
    end

    assign MEM_RD = EX_MEM[73];
    assign MEM_WR = EX_MEM[72];
    assign w_h = EX_MEM[71];
    assign ctrl_WB_mem = EX_MEM[70:69];
    assign DIR = EX_MEM[68:37];
    assign DI = EX_MEM[36:5];
    assign Y_MUX_mem = EX_MEM[4:0];

endmodule
