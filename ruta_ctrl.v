`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Grupo DDJ
// Engineer: Dalberth Corrales
// Create Date: 09/24/2017 01:12:01 PM
// Module Name: ruta_ctrl
//////////////////////////////////////////////////////////////////////////////////



module ruta_ctrl(
    //Entradas del pipe IF/ID
    input wire [5:0] opcode,
    input wire [5:0] funct,

    //Salidas a la etapa IF
    output wire MEM_RD_I,
    output wire [1:0] SEL_DIR,

    //Salidas a la etapa ID
    output wire resetIF,
    output wire REG_RD,
    output wire SEL_IM,

    //Salidas a la etapa EXE
    output wire [4:0] ctrl_EXE,

    //Salidas a la etapa MEM
    output wire [2:0] ctrl_MEM,

    //Salidas a la etapa WB
    output wire [1:0] ctrl_WB
    );



    //---Parámetros Importantes---
    //Instrucciones: Para el caso de los tipo R se parametriza el funct, para los demás el opcode
    parameter [5:0] add = 6'h20;
    parameter [5:0] addi = 6'h08;
    parameter [5:0] aand = 6'h24;
    parameter [5:0] aandi = 6'h0c;
    parameter [5:0] j = 6'h02;
    parameter [5:0] jr = 6'h18;       //No es el verdadero funct de MIPS, se cambia por ser igual al addi
    parameter [5:0] lw = 6'h23;
    parameter [5:0] nnor = 6'h27;
    parameter [5:0] oor = 6'h25;
    parameter [5:0] oori = 6'h0d;
    parameter [5:0] slt = 6'h2a;
    parameter [5:0] slti = 6'h0a;
    parameter [5:0] sh = 6'h29;
    parameter [5:0] sw = 6'h2b;
    parameter [5:0] sub = 6'h22;
    //Otros parámetros de interés
    parameter [5:0] tipoR = 6'h00;
    parameter activo = 1'b0;
    parameter desactivo = 1'b1;
    parameter signext = 1'b0;
    parameter zeroext = 1'b1;
    parameter word = 1'b0;
    parameter halfword = 1'b1;



    //---Definición e Inicialización de Variables Reg y Wire---
    reg [5:0] codigop = 6'h00;        // guarda el opcode o funct de la instrucción
    reg [1:0] SEL_DIRr = 2'b00;       // selecciona la próxima instrucción
    reg resetIFr = desactivo;         // resetea el pipe
    reg REG_RDr = desactivo;          // indica si se va leer del banco de reg
    reg SEL_IMr = zeroext;            // indica el tipo de extensión que se le hace al imm
    reg [2:0] ALU_FUN = 3'b000;       // elige la funcion de la ALU
    reg SEL_ALU = 1'b0;               // selecciona si la ALU opera con rt (0) o el imm (1)
    reg SEL_REG = 1'b0;               // selecciona entre mandar rt (0) por el pipe o rd (1)
    reg MEM_RD = desactivo;           // indica si se va leer de la memoria principal
    reg MEM_WR = desactivo;           // indica si se va escribir en la memoria
    reg w_h = word;                   // indica el tipo de dato que se va guardar en memoria
    reg DIR_WB = 1'b1;                // selecciona lo que se va sobrescribir en el banco (1 es salida de ALU, 0 salida mem)
    reg REG_WR = desactivo;           // indica si se va escribir en el banco de reg



    //---Lógica de Decodificación---
    //Codigo de operación de interés, va permitir identificar la instrucción y asi a partir de
    //codigop se establecen las señales de control
    always @(opcode, funct)
    begin
    if (opcode == tipoR)
        if (funct == addi)
            codigop = jr;
        else
            codigop = funct;
    else
        codigop = opcode;
    end

    //Selección de la próxima dirección de la memoria de intrucciones a ejecutar, para los jumps
    //se cambia el orden normal de ejecución (SEL_DIR = 00 = PC+4)
    always @(codigop)
    begin
      case (codigop)
        j:
            SEL_DIRr = 2'b01;
        jr:
            SEL_DIRr = 2'b10;
        default:
            SEL_DIRr = 2'b00;
      endcase
    end

    //En el caso de las dos instrucciones de salto, se debe resetear el pipe IF/ID
    always @ (codigop)
    begin
      case (codigop)
        j:
            resetIFr = activo;
        jr:
            resetIFr = activo;
        default:
            resetIFr = desactivo;
      endcase
    end

    //Solo para la instrucción j (jump) NO se lee nada del banco de reg
    always @ (codigop)
    begin
      case (codigop)
        j:
            REG_RDr = desactivo;
        default:
            REG_RDr = activo;
      endcase
    end

    //Definición de para cuáles instrucciones hacer sign-extension y para cuáles zero-extension
    // 0: sign, 1: zero.
    always @ (codigop)
    begin
      case (condition)
        addi:
            SEL_IMr = signext;
        andi:
            SEL_IMr = zeroext;
        lw:
            SEL_IMr = signext;
        ori:
            SEL_IMr = zeroext;
        slti:
            SEL_IMr = signext;
        sh:
            SEL_IMr = signext;
        sw:    
            SEL_IMr = signext;
        default:
            SEL_IMr = zeroext;     //en realidad para los demás casos no importa (X) pero se pone un 1 como default
      endcase
    end



    //---Asignacion de las Salidas Wire---
    assign MEM_RD_I = 1'b0;
    assign SEL_DIR = SEL_DIRr;
    assign resetIF = resetIFr;
    assign REG_RD = REG_RDr;
    assign SEL_IM = SEL_IMr;
    assign ctrl_EXE = {ALU_FUN, SEL_ALU, SEL_REG};
    assign ctrl_MEM = {MEM_RD, MEM_WR, w_h};
    assign ctrl_WB = {DIR_WB, REG_WR};



endmodule
