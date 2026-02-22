`include "parameters.svh"

module ieu(
        input  logic        clk, reset,
        input  logic [31:0] Instr,
        input  logic [31:0] PC, PCPlus4,
        output logic        PCSrc,
        output logic [1:0]  MemRW,
        output logic [1:0]  ALUSrc,
        output logic [31:0] IEUAdr,
        output logic [31:0] WriteData,
        input  logic [31:0] LoadResult,
        output logic        RegWrite,
        output logic [2:0]  ImmSrc
    );

    logic [2:0]  ALUSelect;
    logic        SubArith;
    logic        ALUResultSrc;
    logic        ResultSrc;
    logic        W64;
    logic        Eq, Lt, Ltu;
    logic [31:0] Result;

    controller c(
        .Op(Instr[6:0]),
        .Funct3(Instr[14:12]),
        .Funct7b5(Instr[30]),
        .Eq, .Lt, .Ltu,
        .PCSrc,
        .ALUResultSrc,
        .ResultSrc,
        .MemRW,
        .ALUSrc,
        .ImmSrc,
        .RegWrite,
        .W64,
        .ALUSelect,
        .SubArith
    );

    datapath dp(
        .clk, .reset,
        .ALUSrc,
        .RegWrite,
        .ImmSrc,
        .ALUSelect,
        .SubArith,
        .ALUResultSrc,
        .ResultSrc,
        .Eq, .Lt, .Ltu,
        .PC, .PCPlus4,
        .Instr,
        .IEUAdr,
        .WriteData,
        .LoadResult,
        .Result
    );
endmodule
