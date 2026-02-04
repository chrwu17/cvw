.section .text.init
.globl fir
fir:
    addi sp, sp, -40
    sd s0, 0(sp)
    sd s1, 8(sp)
    sd s2, 16(sp)
    sd s3, 24(sp)

    mv s0, a0
    mv s1, a2
    addi s2, a3, -3

    lw a4, 0(a1)
    lw a5, 4(a1)
    lw a6, 8(a1)
    lw a7, 12(a1)

.loop:
    beqz s2, .done
    lw a0, 0(s0)
    lw a1, 4(s0)
    lw a2, 8(s0)
    lw a3, 12(s0)

    li s3, 0

    mul a3, a4, a3
    slli a3, a3, 1
    srai a3, a3, 32
    addw s3, s3, a3

    mul     a3, a5, a2
    slli    a3, a3, 1
    srai    a3, a3, 32
    addw    s3, s3, a3

    mul     a3, a6, a1
    slli    a3, a3, 1
    srai    a3, a3, 32
    addw    s3, s3, a3

    mul     a3, a7, a0
    slli    a3, a3, 1
    srai    a3, a3, 32
    addw    s3, s3, a3

    sw      s3, 0(s1)

    addi    s0, s0, 4
    addi    s1, s1, 4
    addi    s2, s2, -1
    j       .loop

.done:
    ld      s0, 0(sp)
    ld      s1, 8(sp)
    ld      s2, 16(sp)
    ld      s3, 24(sp)
    addi    sp, sp, 40
    ret
