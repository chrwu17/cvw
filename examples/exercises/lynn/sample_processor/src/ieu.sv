// ieu.sv
// RISC-V integer execution unit
// David_Harris@hmc.edu 2020 kacassidy@hmc.edu 2025

`include "parameters.svh"

module ieu(
        input  logic        clk, reset,
        input  logic [31:0] Instr,
        input  logic [31:0] PC, PCPlus4,
        output logic        PCSrc,
        output logic [1:0]  MemRW,
        output logic [31:0] IEUAdr,
        output logic [31:0] WriteData,
        input  logic [31:0] LoadResult
    );

    // Internal signals
    logic [2:0]  ALUSelect;
    logic        SubArith;
    logic        ALUResultSrc;
    logic [1:0]  ResultSrc;
    logic        W64;
    logic        Eq, LT, LTU;
    logic [31:0] Result;
    logic [1:0]  ALUSrc;
    logic        RegWrite;
    logic [2:0]  ImmSrc;

    controller c(
        .Op(Instr[6:0]),
        .Funct3(Instr[14:12]),
        .Funct7b5(Instr[30]),
        .Eq, .LT, .LTU,
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
        .Eq, .LT, .LTU,
        .PC, .PCPlus4,
        .Instr,
        .IEUAdr,
        .WriteData,
        .LoadResult,
        .Result
    );

endmodule
