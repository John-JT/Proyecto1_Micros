`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 30.08.2017 23:22:33
// Design Name:
// Module Name: fetch
//////////////////////////////////////////////////////////////////////////////////


module fetch(
    input wire [31:0] DOA_exe, jump_exe,
    input wire reloj,
    input [1:0] SEL_DIR,

    output wire [3:0] PC_4,
    output wire [31:0] OUT_REG1);

    wire [31:0] PC_4_full;
    reg [31:0] out_mux;
    reg [31:0] out_REG1;



 ////// mux SEL_DIR

   always @(SEL_DIR, PC_4_full, DOA_exe, jump_exe)
    case (SEL_DIR)
       2'b00: out_mux = PC_4_full;
       2'b01: out_mux = DOA_exe;
       2'b10: out_mux = jump_exe;
       2'b11: out_mux = PC_4_full;       // en realidad nunca debería darse
    endcase


 //// registro 1 (antes de memoria de inst)

     always @(posedge reloj)
     begin

        out_REG1 <= out_mux;
    end

    ///////// sumador


    assign PC_4_full =  out_REG1 + 3'b100;
    assign PC_4 = PC_4_full [31:28];

    ////////// salida a memoria
    assign OUT_REG1 = out_REG1;


endmodule
