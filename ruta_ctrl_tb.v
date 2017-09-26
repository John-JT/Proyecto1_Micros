`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo DDJ
// Engineer: Dalberth
// Create Date: 09/24/2017 10:16:34 PM
// Module Name: ruta_ctrl_tb
//////////////////////////////////////////////////////////////////////////////////



module ruta_ctrl_tb(
    );
    //Wires de interconexión
    wire [5:0] opcode;
    wire [5:0] funct;
    wire MEM_RD_I;
    wire [1:0] SEL_DIR;
    wire resetIF;
    wire REG_RD;
    wire SEL_IM;
    wire [4:0] ctrl_EXE;
    wire [2:0] ctrl_MEM;
    wire [1:0] ctrl_WB;
    //Parámetros de interés
    parameter [5:0] add = 6'h20;
    parameter [5:0] addi = 6'h08;
    parameter [5:0] aand = 6'h24;
    parameter [5:0] andi = 6'h0c;
    parameter [5:0] j = 6'h02;
    parameter [5:0] jr = 6'h18;
    parameter [5:0] lw = 6'h23;
    parameter [5:0] nnor = 6'h27;
    parameter [5:0] oor = 6'h25;
    parameter [5:0] ori = 6'h0d;
    parameter [5:0] slt = 6'h2a;
    parameter [5:0] slti = 6'h0a;
    parameter [5:0] sh = 6'h29;
    parameter [5:0] sw = 6'h2b;
    parameter [5:0] sub = 6'h22;
    parameter [5:0] tipoR = 6'h00;



    //---Instanciación---
    ruta_ctrl inst_ruta_ctrl(
          .opcode(opcode),
          .funct(funct),
          .MEM_RD_I(MEM_RD_I),
          .SEL_DIR(SEL_DIR),
          .resetIF(resetIF),
          .REG_RD(REG_RD),
          .SEL_IM(SEL_IM),
          .ctrl_EXE(ctrl_EXE),
          .ctrl_MEM(ctrl_MEM),
          .ctrl_WB(ctrl_WB)
                             );



    //---Regs de entrada---
    reg [5:0] opcoder;
    reg [5:0] functr;



    //---Inicializaciones y cambios en el tiempo---
    initial
    begin
    opcoder <= tipoR;
    functr <= add;

    #100
    opcoder <= addi;
    #100
    opcoder <= tipoR;
    functr <= aand;
    #100
    opcoder <= andi;
    #100
    opcoder <= j;
    #100
    opcoder <= tipoR;
    functr <= 6'h08;
    #100
    opcoder <= lw;
    #100
    opcoder <= tipoR;
    functr <= nnor;
    #100
    opcoder <= tipoR;
    functr <= oor;
    #100
    opcoder <= ori;
    #100
    opcoder <= tipoR;
    functr <= slt;
    #100
    opcoder <= slti;
    #100
    opcoder <= sh;
    #100
    opcoder <= sw;
    #100
    opcoder <= tipoR;
    functr <= sub;
    end



    //---Asignacion de wires de interconexión---
    assign opcode = opcoder;
    assign funct = functr;



    //---CICLOS---

endmodule
