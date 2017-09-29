`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/01/2017 08:23:29 AM
// Module Name: ID_EX
//////////////////////////////////////////////////////////////////////////////////


module ID_EX(
    input reloj,
    input resetID,
    input enableID,
    input [4:0] ctrl_EXE,
    input [2:0] ctrl_MEM,
    input [1:0] ctrl_WB,
    input [31:0] DOA, //Salida A de Banco de Registros
    input [31:0] DOB, //Salida B de Banco de Registros
    input [31:0] imm_ext,
    input [4:0] rt,
    input [4:0] rd,

    output [2:0] ALU_FUN,
    output SEL_ALU,
    output SEL_REG,
    output [2:0] ctrl_MEM_exe,
    output [1:0] ctrl_WB_exe,
    output [31:0] A,
    output [31:0] DOB_exe,
    output [31:0] imm_ext_exe,
    output [4:0] rt_exe,
    output [4:0] rd_exe
    );


    reg [115:0] ID_EX;


    always @(posedge reloj)

    begin

       if (resetID)
       begin
          ID_EX  <= 116'b0;
       end

       else if (enableID)
       begin
          ID_EX <= {ctrl_EXE, ctrl_MEM, ctrl_WB, DOA, DOB, imm_ext, rt, rd};
       end

       else
          ID_EX <= ID_EX;

    end

    assign ALU_FUN = ID_EX[115:113];
    assign SEL_ALU = ID_EX[112];
    assign SEL_REG = ID_EX[111];
    assign ctrl_MEM_exe = ID_EX[110:108];
    assign ctrl_WB_exe = ID_EX[107:106];
    assign A = ID_EX[105:74];
    assign DOB_exe = ID_EX[73:42];
    assign imm_ext_exe = ID_EX[41:10];
    assign rt_exe = ID_EX[9:5];
    assign rd_exe = ID_EX[4:0];

endmodule
