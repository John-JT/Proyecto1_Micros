`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: MEM_WB
//////////////////////////////////////////////////////////////////////////////////


module MEM_WB(
    input reloj,
    input resetMEM,
    input [1:0] ctrl_WB_mem,
    input [31:0] DO, //Salida Memoria de Datos
    input [31:0] DIR, //Entrada Direccion Memoria de Datos
    input [4:0] Y_MUX_mem,

    output DIR_WB,
    output REG_WR,
    output [31:0] DO_wb, //Salida de Memoria de Datos a Multiplexor Selector
    output [31:0] DIR_wb, // Salida "directa" de la ALU
    output [4:0] Y_MUX_wb //Salida para WB
    );


    reg [70:0] MEM_WB;


    always @(posedge reloj)
    begin

       if (resetMEM)
       begin
          MEM_WB <= 71'b0;
       end

       else
       begin
          MEM_WB <= {ctrl_WB_mem, DO, DIR, Y_MUX_mem};
       end
    end

    assign DIR_WB = MEM_WB[70];
    assign REG_WR = MEM_WB[69];//Salida para WB
    assign DO_wb = MEM_WB[68:37];
    assign DIR_wb = MEM_WB[36:5];
    assign Y_MUX_wb = MEM_WB[4:0];

endmodule
