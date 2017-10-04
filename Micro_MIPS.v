`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo DDJ
// Engineer: DDJ
// Create Date: 09/28/2017 10:02:33 PM
// Module Name: Micro_MIPS
//////////////////////////////////////////////////////////////////////////////////



module Micro_MIPS(
    input wire reloj,
    input wire resetM,
    output wire [5:0] P_C,
    output wire [31:0] aux1,
    output wire [115:0] aux2,
    output wire [73:0] aux3,
    output wire [31:0] DI_banco,
    output wire [4:0] DIR_WRA,
    output wire REG_WR,
    output wire [70:0] aux4,
    output wire [31:0] DO_D);



    //---Wires de Interconexión Intermodular---
    //fetch
    wire [5:0] jump_dec;
    wire [1:0] SEL_DIR;
    wire [31:0] DO_I;

    //IF_ID
    wire resetIF_aux;
    wire resetIF = (resetIF_aux & resetM);
    wire [5:0] opcode;
    wire [5:0] funct;
    wire [5:0] JUMP_ADDR;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] imm;

    //ruta control
    wire REG_RD;
    wire SEL_IM;
    wire [4:0] ctrl_EXE;
    wire [2:0] ctrl_MEM;
    wire [1:0] ctrl_WB;

    //decode
    /////wire [4:0] DIR_WRA;
    /////wire [31:0] DI_banco;
    ////////wire REG_WR;
    wire [31:0] DOA;
    wire [31:0] DOB;
    wire [31:0] imm_ext;

    //ID_EX
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

    //execute
    wire [31:0] Y_ALU;
    wire [31:0] DOB_exeinpipe;
    wire [4:0] Y_MUX;

    //EX_MEM
    wire MEM_RD;
    wire MEM_WR;
    wire w_h;
    wire [1:0] ctrl_WB_mem;
    wire [31:0] DIR_D;
    wire [31:0] DI_D;
    wire [4:0] Y_MUX_mem;

    //mem
//    wire [31:0] DO_D;

    //MEM_WB
    wire DIR_WB;
    wire [31:0] DO_D_wb;
    wire [31:0] DIR_D_wb;



    //---Instanciaciones---
    fetch inst_fetch(
          .DOA_exe(DOA[5:0]),
          .jump_exe(jump_dec),
          .reloj(reloj),
          .reset(resetM),
          .SEL_DIR(SEL_DIR),
          .P_C(P_C),
          .OUT_mem(DO_I));

    IF_ID inst_IF_ID(
          .reloj(reloj),
          .resetIF(resetIF),
          .DO(DO_I),
          .opcode(opcode),
          .funct(funct),
          .JUMP_ADDR(JUMP_ADDR),
          .rs(rs),
          .rt(rt),
          .rd(rd),
          .imm(imm),
          .aux(aux1));

    ruta_ctrl inst_ruta_ctrl(
          .opcode(opcode),
          .funct(funct),
          .SEL_DIR(SEL_DIR),
          .resetIF(resetIF_aux),
          .REG_RD(REG_RD),
          .SEL_IM(SEL_IM),
          .ctrl_EXE(ctrl_EXE),
          .ctrl_MEM(ctrl_MEM),
          .ctrl_WB(ctrl_WB));

    decode inst_decode(
          .reloj(reloj),
          .DIR_A(rs),
          .DIR_B(rt),
          .DIR_WRA(DIR_WRA),
          .DI(DI_banco),
          .REG_RD(REG_RD),
          .REG_WR(REG_WR),
          .SEL_I(SEL_IM),
          .IMD(imm),
          .address(JUMP_ADDR),
          .DOA(DOA),
          .DOB(DOB),
          .out_mux_sz(imm_ext),
          .out_addr(jump_dec));

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

    execute inst_execute(
          .ALU_FUN(ALU_FUN),
          .input_A(A),
          .input_sz(imm_ext_exe),
          .input_register(DOB_exe),
          .rt(rt_exe),
          .rd(rd_exe),
          .SEL_ALU(SEL_ALU),
          .SEL_REG(SEL_REG),
          .out_ALU(Y_ALU),
          .out_dato_registro(DOB_exeinpipe),
          .out_mux_sel_reg(Y_MUX));

    EX_MEM inst_EX_MEM(
          .reloj(reloj),
          .resetEX(resetM),
          .ctrl_MEM_exe(ctrl_MEM_exe),
          .ctrl_WB_exe(ctrl_WB_exe),
          .Y_ALU(Y_ALU),
          .DOB_exe(DOB_exeinpipe),
          .Y_MUX(Y_MUX),
          .MEM_RD(MEM_RD),
          .MEM_WR(MEM_WR),
          .w_h(w_h),
          .ctrl_WB_mem(ctrl_WB_mem),
          .DIR(DIR_D),
          .DI(DI_D),
          .Y_MUX_mem(Y_MUX_mem));

    mem inst_mem(
          .reloj(reloj),
          .DI_MEM(DI_D),
          .DIR_MEM(DIR_D[6:0]),
          .MEM_RD(MEM_RD),
          .MEM_WR(MEM_WR),
          .w_h(w_h),
          .DO_MEMo(DO_D));

    MEM_WB inst_MEM_WB(
          .reloj(reloj),
          .resetMEM(resetM),
          .ctrl_WB_mem(ctrl_WB_mem),
          .DO(DO_D),
          .DIR(DIR_D),
          .Y_MUX_mem(Y_MUX_mem),
          .DIR_WB(DIR_WB),
          .REG_WR(REG_WR),
          .DO_wb(DO_D_wb),
          .DIR_wb(DIR_D_wb),
          .Y_MUX_wb(DIR_WRA));

    wb inst_wb(
          .DIR_WB(DIR_WB),
          .DO(DO_D_wb),
          .DIR(DIR_D_wb),
          .out_mux_wb(DI_banco));



    //assign que evite warning:
    //[Synth 8-3332] Sequential element (inst_IF_ID/IF_ID_reg[30]) is unused...
    //...and will be removed from module Micro_MIPS. ****[y otros parecidos]****
    assign aux2 = {ALU_FUN, SEL_ALU, SEL_REG, ctrl_MEM_exe, ctrl_WB_exe, A, DOB_exe, imm_ext_exe, rt_exe, rd_exe};
    assign aux3 = {MEM_RD, MEM_WR, w_h, ctrl_WB_mem, DIR_D, DI_D, Y_MUX_mem};
    assign aux4 = {DIR_WB, REG_WR, DO_D_wb, DIR_D_wb, DIR_WRA};
endmodule