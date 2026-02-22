module lsu(
        input   logic [31:0]    ALUResult,
        input   logic [31:0]    WriteData,
        input   logic [31:0]    ReadData,
        input   logic [2:0]     Funct3,
        input   logic [1:0]     MemRW,
        output  logic [31:0]    IEUAdr,
        output  logic [31:0]    StoreData,
        output  logic [31:0]    LoadResult,
        output  logic [3:0]     WriteByteEn,
        output  logic           MemEn
    );

    logic MemRead, MemWrite;
    assign MemRead = MemRW[1];
    assign MemWrite = MemRW[0];

    assign IEUAdr = ALUResult;
    assign MemEn  = MemWrite | MemRead;

    always_comb begin
        StoreData   = 32'b0;
        WriteByteEn = 4'b0000;
        if (MemWrite) begin
            case (Funct3)
                3'b000: begin // sb
                    WriteByteEn = 4'b0001 << ALUResult[1:0];
                    case (ALUResult[1:0])
                        2'b00: StoreData = {24'b0,          WriteData[7:0]      };
                        2'b01: StoreData = {16'b0,          WriteData[7:0], 8'b0};
                        2'b10: StoreData = {8'b0,  WriteData[7:0],         16'b0};
                        2'b11: StoreData = {       WriteData[7:0],         24'b0};
                        default: StoreData = 32'b0;
                    endcase
                end
                3'b001: begin // sh
                    WriteByteEn = ALUResult[1] ? 4'b1100        : 4'b0011;
                    StoreData   = ALUResult[1] ? {WriteData[15:0], 16'b0}
                                               : {16'b0, WriteData[15:0]};
                end
                3'b010: begin // sw
                    WriteByteEn = 4'b1111;
                    StoreData   = WriteData;
                end
                default: begin
                    WriteByteEn = 4'b0000;
                    StoreData   = 32'b0;
                end
            endcase
        end
    end

    logic [7:0]  byte_data;
    logic [15:0] half_data;

    always_comb begin
        case (ALUResult[1:0])
            2'b00: byte_data = ReadData[7:0];
            2'b01: byte_data = ReadData[15:8];
            2'b10: byte_data = ReadData[23:16];
            2'b11: byte_data = ReadData[31:24];
            default: byte_data = 8'b0;
        endcase
    end

    assign half_data = ALUResult[1] ? ReadData[31:16] : ReadData[15:0];

    always_comb begin
        case (Funct3)
            3'b000: LoadResult = {{24{byte_data[7]}},  byte_data}; // lb
            3'b001: LoadResult = {{16{half_data[15]}}, half_data}; // lh
            3'b010: LoadResult = ReadData;                          // lw
            3'b100: LoadResult = {24'b0, byte_data};               // lbu
            3'b101: LoadResult = {16'b0, half_data};               // lhu
            default: LoadResult = ReadData;
        endcase
    end

endmodule
