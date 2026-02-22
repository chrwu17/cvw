// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module cmp(
        input   logic [31:0]    R1, R2,
        output  logic           Eq, LT, LTU
    );

    assign Eq  = (R1 == R2);
    assign LT  = ($signed(R1) < $signed(R2));
    assign LTU = ($unsigned(R1) < $unsigned(R2));

endmodule
