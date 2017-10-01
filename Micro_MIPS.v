`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo DDJ
// Engineer: DDJ
// Create Date: 09/28/2017 10:02:33 PM
// Module Name: Micro_MIPS
//////////////////////////////////////////////////////////////////////////////////



module Micro_MIPS(
    input wire reloj,
    input wire resetM);



    //---Wires de Interconexión Intermodular---
    wire [5:0] opcode;
    wire [5:0] funct;
    wire [1:0] SEL_DIR;
    wire resetIF;
    wire REG_RD;
    wire SEL_IM;
    wire [4:0] ctrl_EXE;
    wire [2:0] ctrl_MEM;
    wire [1:0] ctrl_WB;

    wire [3:0] PC_4;
    wire [31:0] DO_I;
    wire [25:0] JUMP_ADDR;
    wire [3:0] PC_4o;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] imm;

    wire [31:0] DOA;
    wire [31:0] DOB;
    wire [31:0] imm_ext;
    wire [2:0] ALU_FUN;
    wire SEL_ALU;
    wire SEL_REG;
    wire [2:0] ctrl_MEM_exe;
    wire [1:0] ctrl_WB_exe;
    wire [31:0] A;
    wire [31:0] DOB_exe;
    wire [31:0] imm_ext_exe;
    wire [4:0] rt_exe;
    wire [4:0] rd_exe;

    wire [31:0] Y_ALU;
    wire [4:0] Y_MUX;
    wire MEM_RD;
    wire MEM_WR;
    wire w_h;
    wire [1:0] ctrl_WB_mem;
    wire [31:0] DIR;
    wire [31:0] DI;
    wire [4:0] Y_MUX_mem;

    wire [31:0] DO_D;
    wire DIR_WB;
    wire REG_WR;
    wire [31:0] DO_wb;
    wire [31:0] DIR_wb;
    wire [4:0] Y_MUX_wb;



    //---Instanciación Ruta Control---
    ruta_ctrl inst_ruta_ctrl(
          .opcode(opcode),
          .funct(funct),
          .SEL_DIR(SEL_DIR),
          .resetIF(resetIF),
          .REG_RD(REG_RD),
          .SEL_IM(SEL_IM),
          .ctrl_EXE(ctrl_EXE),
          .ctrl_MEM(ctrl_MEM),
          .ctrl_WB(ctrl_WB));



    //---Instanciación Pipeline---
    IF_ID inst_IF_ID(
          .reloj(reloj),
          .resetIF(resetIF),
          .PC_4(PC_4),
          .DO(DO_I),
          .opcode(opcode),
          .funct(funct),
          .JUMP_ADDR(JUMP_ADDR),
          .PC_4o(PC_4o),
          .rs(rs),
          .rt(rt),
          .rd(rd),
          .imm(imm));
    ID_EX inst_ID_EX(
          .reloj(reloj),
          .resetID(resetM),
          .ctrl_EXE(ctrl_EXE),
          .ctrl_MEM(ctrl_MEM),
          .ctrl_WB(ctrl_WB),
          .DOA(DOA),
          .DOB(DOB),
          .imm_ext(imm_ext),
          .rt(rt),
          .rd(rd),
          .ALU_FUN(ALU_FUN),
          .SEL_ALU(SEL_ALU),
          .SEL_REG(SEL_REG),
          .ctrl_MEM_exe(ctrl_MEM_exe),
          .ctrl_WB_exe(ctrl_WB_exe),
          .A(A),
          .DOB_exe(DOB_exe),
          .imm_ext_exe(imm_ext_exe),
          .rt_exe(rt_exe),
          .rd_exe(rd_exe));
    EX_MEM inst_EX_MEM(
          .reloj(reloj),
          .resetEX(resetM),
          .ctrl_MEM_exe(ctrl_MEM_exe),
          .ctrl_WB_exe(ctrl_WB_exe),
          .Y_ALU(Y_ALU),
          .DOB_exe(DOB_exe),
          .Y_MUX(Y_MUX),
          .MEM_RD(MEM_RD),
          .MEM_WR(MEM_WR),
          .w_h(w_h),
          .ctrl_WB_mem(ctrl_WB_mem),
          .DIR(DIR),
          .DI(DI),
          .Y_MUX_mem(Y_MUX_mem));
    MEM_WB inst_MEM_WB(
          .reloj(reloj),
          .resetMEM(resetM),
          .ctrl_WB_mem(ctrl_WB_mem),
          .DO(DO_D),
          .DIR(DIR),
          .Y_MUX_mem(Y_MUX_mem),

          .DIR_WB(DIR_WB),
          .REG_WR(REG_WR),
          .DO_wb(DO_wb),
          .DIR_wb(DIR_wb),
          .Y_MUX_wb(Y_MUX_wb));



endmodule
