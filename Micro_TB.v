`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/02/2017 06:59:43 PM
// Module Name: Micro_TB
//////////////////////////////////////////////////////////////////////////////////


module Micro_TB(
    );

    reg reloj;
    reg resetM;
    wire [31:0] P_C;
    wire [35:0] aux1;
    wire [115:0] aux2;
    wire [73:0] aux3;
    wire [70:0] aux4;
    wire [31:0] DI_banco,DO_D;
    wire [4:0] DIR_WRA;
    wire REG_WR;
    reg [31:0] arreglo [0:31];
    reg [31:0] mem [0:31];

    integer i = 0;

    Micro_MIPS micro(
          .reloj(reloj),
          .resetM(resetM),
          .P_C(P_C),
          .aux1(aux1),
          .aux2(aux2),
          .aux3(aux3),
          .aux4(aux4),
          .DI_banco(DI_banco),
          .DIR_WRA(DIR_WRA),
          .REG_WR(REG_WR),
          .DO_D(DO_D)
    );


    always
    begin
    #5 reloj = ~reloj;
    end


    initial

    begin

    for (i = 0; i < 32; i = i + 1)    ////// inicialiazar arreglo en 0
        begin
        arreglo[i] = {31'b0};
        mem[i] = {31'b0};
        end

    reloj = 0;
    resetM = 1;

    #30;
    resetM = 0;

    end


    always
    begin
      @(posedge reloj);
      if (P_C >= 12 && REG_WR == 0)
      begin
        arreglo[DIR_WRA] = {DI_banco}|{DO_D};
        $display("%d: %h",DIR_WRA, arreglo[DIR_WRA]);
      end
      //@(negedge aux3[72]);
      //mem[aux3[42:37]]={aux3[36:5]};
      //$display("%d: %h",aux3[42:37], mem[aux3[42:37]]);
      end

      //assign aux2 = {ALU_FUN, SEL_ALU, SEL_REG, ctrl_MEM_exe, ctrl_WB_exe, A, DOB_exe, imm_ext_exe, rt_exe, rd_exe};
      //assign aux3 = {MEM_RD, MEM_WR, w_h, ctrl_WB_mem, DIR_D, DI_D, Y_MUX_mem};
      //assign aux4 = {DIR_WB, REG_WR, DO_D_wb, DIR_D_wb, DIR_WRA};

endmodule
