`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: IF_ID
//////////////////////////////////////////////////////////////////////////////////


module IF_ID(
    input reloj,
    input resetIF,
    input [31:0] DO, //Salida de Memoria de Instrucciones
    input [3:0] PC_4,

    output [5:0] opcode,
    output [5:0] funct,
    output [25:0] JUMP_ADDR,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] imm,
    output [35:0] aux,
    output [3:0] pc_4
    );


    reg [35:0] IF_ID;


    always @(posedge reloj)

    begin
        if (resetIF)
        begin
            IF_ID <= 35'b0;
        end

        else
        begin
            IF_ID <= {PC_4,DO};
        end
    end

      assign opcode = IF_ID[31:26];
      assign funct = IF_ID[5:0];
      assign JUMP_ADDR = IF_ID[25:0];
      assign rs = IF_ID[25:21];
      assign rt = IF_ID[20:16];
      assign rd = IF_ID[15:11];
      assign imm = IF_ID[15:0];
      assign pc_4 = IF_ID[35:32];

      assign aux = IF_ID;
endmodule
