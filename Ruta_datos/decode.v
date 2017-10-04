`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// Create Date: 11.09.2017 22:01:26
// Design Name:
// Module Name: decode
//////////////////////////////////////////////////////////////////////////////////

`ifndef DEBUG_CPU_REG
`define DEBUG_CPU_REG 0
module decode(
    input reloj,
    input [4:0] DIR_A, DIR_B, DIR_WRA,
    input [31:0] DI,
    input REG_RD, REG_WR, SEL_I,
    input [15:0] IMD,
    input [5:0] address,

    output [31:0] DOA, DOB, out_mux_sz, 
    output [5:0] out_addr);


    reg [31:0] routA, routB = 32'b0;
    reg [31:0] registro [0:31];
    reg [31:0] out_sign, out_zero = 0;

initial begin
		if (`DEBUG_CPU_REG) begin
			$display("     $v0,      $v1,      $t0,      $t1,      $t2,      $t3,      $t4,      $t5,      $t6,      $t7,      $t8,      $t9");
			$monitor("%x, %x, %x, %x, %x, %x, %x, %x, %x, %x, %x, %x",
					registro[1][31:0],	/* $v0 */
					registro[2][31:0],	/* $v1 */
					registro[3][31:0],	/* $t0 */
					registro[4][31:0],	/* $t1 */
					registro[5][31:0],	/* $t2 */
					registro[6][31:0],	/* $t3 */
					registro[7][31:0],	/* $t4 */
					registro[8][31:0],	/* $t5 */
					registro[9][31:0],	/* $t6 */
					registro[10][31:0],	/* $t7 */
					registro[11][31:0],	/* $t7 */
					registro[12][31:0],	/* $t7 */
				);
		end
	end



   ////////// banco de registros
    always @ (REG_RD, REG_WR, DIR_A, DIR_B)
    begin
    if (REG_RD == 1'b0)
    begin
        routA = registro [DIR_A];
        routB = registro [DIR_B];
    end
    else
    begin
        routA = 32'b0;
        routB = 32'b0;
    end
    end

    always @ (posedge reloj)
    begin
    if (REG_WR == 0) registro[DIR_WRA] <= DI;
    else registro[DIR_WRA] <= registro[DIR_WRA];
    end

    assign DOA = routA;
    assign DOB = routB;


    ///////////sign extension
    always @(IMD)
    begin

    if(IMD[15]==1'b1) out_sign = {16'b1111111111111111,IMD};

    else out_sign = {16'b0000000000000000,IMD};

    end


   /////// zero extension
    always @(IMD)
    begin
    out_zero <= {16'b0000000000000000,IMD};
    end


    ////////// mux sign and zero
    assign out_mux_sz = SEL_I ? out_sign: out_zero;


    /////// calculo para jump addr
    assign out_addr = {address};
endmodule
`endif
