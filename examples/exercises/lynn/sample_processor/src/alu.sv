// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module alu(
        input   logic [31:0]    SrcA, SrcB,
        input   logic [2:0]     ALUSelect,
        input   logic           SubArith,
        output  logic [31:0]    ALUResult, IEUAdr
    );

    logic [31:0] CondInvb, Sum, SLT, SLTU;
    logic        Overflow, Neg, LT;
    logic [4:0]  shiftAmount;

    // Add support for new instructions for Lab 3
    assign shiftAmount = SrcB[4:0];
    assign SLTU = {31'b0, ($unsigned(SrcA) < $unsigned(SrcB))};

    // Add or subtract
    assign CondInvb = SubArith ? ~SrcB : SrcB;
    assign Sum = SrcA + CondInvb + {{(31){1'b0}}, SubArith};
    assign IEUAdr = Sum; // Send this out to IFU and LSU

    // Set less than based on subtraction result
    assign Overflow = (SrcA[31] ^ SrcB[31]) & (SrcA[31] ^ Sum[31]);
    assign Neg = Sum[31];
    assign LT = Neg ^ Overflow;
    assign SLT = {31'b0, LT};

    always_comb begin
        case (ALUSelect)
            3'b000: ALUResult = Sum;                        // add/sub
            3'b001: ALUResult = SrcA << shiftAmount;        // sll
            3'b010: ALUResult = SLT;                        // slt
            3'b011: ALUResult = SLTU;                       // sltu
            3'b100: ALUResult = SrcA ^ SrcB;                // xor
            3'b101: ALUResult = SubArith ?
                $unsigned($signed(SrcA) >>> shiftAmount) :  // sra
                SrcA >> shiftAmount;                        // srl
            3'b110: ALUResult = SrcA | SrcB;                // or
            3'b111: ALUResult = SrcA & SrcB;                // and
            default: ALUResult = 32'bx;
        endcase
    end
endmodule
