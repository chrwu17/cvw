`include "parameters.svh"

module controller (
        input  logic [6:0]  Op,
        input  logic [2:0]  Funct3,
        input  logic        Funct7b5,
        input  logic        Eq, LT, LTU,

        output logic        PCSrc,
        output logic        ALUResultSrc,
        output logic [1:0]  ResultSrc,
        output logic [1:0]  MemRW,
        output logic [1:0]  ALUSrc,
        output logic [2:0]  ImmSrc,
        output logic        RegWrite,
        output logic        W64,
        output logic [2:0]  ALUSelect,
        output logic        SubArith
    );

    logic Branch, Jump, ALUOp;

   // Main Decoder
    always_comb begin
        // defaults
        {Branch, Jump}   = 2'b00;
        ALUSrc           = 2'b00;
        ImmSrc           = 3'b000;
        ALUOp            = 1'b0;
        ALUResultSrc     = 1'b0;
        ResultSrc        = 1'b0;
        RegWrite         = 1'b0;
        MemRW            = 2'b00;
        W64              = 1'b0;

        case (Op)
            7'h33: begin // R-type
                RegWrite     = 1'b1;
                ALUSrc       = 2'b00;
                ALUOp        = 1'b1;
            end
            7'h13: begin // I-type ALU
                RegWrite     = 1'b1;
                ALUSrc       = 2'b01;
                ImmSrc       = 3'b000;
                ALUOp        = 1'b1;
            end
            7'h03: begin // loads
                RegWrite     = 1'b1;
                ALUSrc       = 2'b01;
                ImmSrc       = 3'b000;
                MemRW        = 2'b10;   // MemRead
                ResultSrc    = 2'b10;
            end
            7'h23: begin // stores
                ALUSrc       = 2'b01;
                ImmSrc       = 3'b001;
                MemRW        = 2'b01;   // MemWrite
            end
            7'h63: begin // branches
                Branch       = 1'b1;
                ALUSrc       = 2'b00;
                ImmSrc       = 3'b010;
            end
            7'h6F: begin // jal
                Jump         = 1'b1;
                ALUSrc       = 2'b11;
                ImmSrc       = 3'b011;
                ResultSrc    = 2'b01;
                RegWrite     = 1'b1;
            end
            7'h67: begin // jalr
                Jump         = 1'b1;
                ALUSrc       = 2'b01;
                ImmSrc       = 3'b000;
                ResultSrc    = 2'b01;
                RegWrite     = 1'b1;
            end
            7'h37: begin // lui
                ALUSrc       = 2'b01;
                ImmSrc       = 3'b100;
                ALUResultSrc = 1'b1;
                RegWrite     = 1'b1;
            end
            7'h17: begin // auipc
                ALUSrc       = 2'b11;
                ImmSrc       = 3'b100;
                RegWrite     = 1'b1;
            end
            default: begin
                // all signals already defaulted to 0
            end
        endcase
    end

    // ALU Decoder
    logic Slt, Sltu, Sra, Sub;

    always_comb begin
        ALUSelect = 3'b000; // default: add
        SubArith  = 1'b0;

        if (ALUOp) begin
            ALUSelect = Funct3;

            Slt      = (Funct3 == 3'b010);
            Sltu     = (Funct3 == 3'b011);
            Sra      = (Funct3 == 3'b101) & Funct7b5;
            Sub      = (Funct3 == 3'b000) & Funct7b5 & Op[5];
            SubArith = Slt | Sltu | Sra | Sub;
        end else begin
            Slt   = 1'b0;
            Sltu  = 1'b0;
            Sra   = 1'b0;
            Sub   = 1'b0;
        end
    end

    // Branch Logic
    logic BranchTaken;

    always_comb
        case (Funct3)
            3'b000: BranchTaken = Eq;
            3'b001: BranchTaken = ~Eq;
            3'b100: BranchTaken = LT;
            3'b101: BranchTaken = ~LT;
            3'b110: BranchTaken = LTU;
            3'b111: BranchTaken = ~LTU;
            default: BranchTaken = 1'b0;
        endcase

    assign PCSrc = (Branch & BranchTaken) | Jump;

endmodule
