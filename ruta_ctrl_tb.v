`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo DDJ
// Engineer: Dalberth
// Create Date: 09/24/2017 10:16:34 PM
// Module Name: ruta_ctrl_tb
//////////////////////////////////////////////////////////////////////////////////



module ruta_ctrl_tb(
    );
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
    wire [5:0] codigopw;

    parameter [5:0] tipoR = 6'h00;
    parameter [5:0] add = 6'h20;
    parameter [5:0] sub = 6'h22;
    parameter [5:0] slti = 6'h0a;



    //---INSTANCIACION---
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
          .ctrl_WB(ctrl_WB),
          .codigopw(codigopw)
                             );



    //---VARIABLES---
    reg [5:0] opcodereg;
    reg [5:0] functreg;



    //---INICIALIZACIONES---
    initial
    begin
    opcodereg <= tipoR;
    functreg <= add;

    #500
    opcodereg <= tipoR;
    functreg <= sub;

    #50
    opcodereg <= slti;
    end

    assign opcode = opcodereg;
    assign funct = functreg;



    //---CICLOS---

endmodule
