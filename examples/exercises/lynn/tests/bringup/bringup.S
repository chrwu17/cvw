// bringup_step10.S
// Full chain: original + lw + sw + add_addi + sub_subi + slt_slti + xor_xori + or_ori + and_andi + beq + jal

.extern add_test
.extern or_test
.extern and_test
.extern sub_test
.extern lw_test
.extern sw_test
.extern add_addi_test
.extern sub_subi_test
.extern slt_slti_test
.extern xor_xori_test
.extern or_ori_test
.extern and_andi_test
.extern beq_test
.extern jal_test
.extern pass

.section .text.init
.globl main
.globl return_add_test
.globl return_or_test
.globl return_and_test
.globl return_sub_test
.globl return_lw_test
.globl return_sw_test
.globl return_add_addi_test
.globl return_sub_subi_test
.globl return_slt_slti_test
.globl return_xor_xori_test
.globl return_or_ori_test
.globl return_and_andi_test
.globl return_beq_test
.globl return_jal_test

.type main, @function
main:
    j add_test

return_add_test:
    j or_test

return_or_test:
    j and_test

return_and_test:
    j sub_test

return_sub_test:
    j lw_test

return_lw_test:
    j sw_test

return_sw_test:
    j add_addi_test

return_add_addi_test:
    j sub_subi_test

return_sub_subi_test:
    j slt_slti_test

return_slt_slti_test:
    j xor_xori_test

return_xor_xori_test:
    j or_ori_test

return_or_ori_test:
    j and_andi_test

return_and_andi_test:
    j beq_test

return_beq_test:
    j jal_test

return_jal_test:
    j pass
