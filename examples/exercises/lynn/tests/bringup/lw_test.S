// lw_test.S
// 10 tests for lw (500-509)
// Data placed in .text.init to avoid linker/.data init issues.

.extern return_lw_test
.extern fail

.section .text.init
.globl lw_test
.type  lw_test, @function

lw_test:
    la   t0, lw_data

test1:
    lw   t1, 0(t0)
    li   t2, 0x00000000
    beq  t1, t2, test2
    j    Fail_LW_0

test2:
    lw   t1, 4(t0)
    li   t2, 0x00000001
    beq  t1, t2, test3
    j    Fail_LW_1

test3:
    lw   t1, 8(t0)
    li   t2, -1
    beq  t1, t2, test4
    j    Fail_LW_2

test4:
    lw   t1, 12(t0)
    li   t2, 0x7FFFFFFF
    beq  t1, t2, test5
    j    Fail_LW_3

test5:
    lw   t1, 16(t0)
    li   t2, 0x80000000
    beq  t1, t2, test6
    j    Fail_LW_4

test6:
    lw   t1, 20(t0)
    li   t2, 0x12345678
    beq  t1, t2, test7
    j    Fail_LW_5

test7:
    lw   t1, 24(t0)
    li   t2, 0x87654321
    beq  t1, t2, test8
    j    Fail_LW_6

test8:
    lw   t1, 28(t0)
    li   t2, 0x00FF00FF
    beq  t1, t2, test9
    j    Fail_LW_7

test9:
    lw   t1, 32(t0)
    li   t2, 0xFF00FF00
    beq  t1, t2, test10
    j    Fail_LW_8

test10:
    lw   t1, 36(t0)
    li   t2, 0x0F0F0F0F
    beq  t1, t2, pass
    j    Fail_LW_9

pass:
    j return_lw_test

Fail_LW_0:  li gp, 500; j fail
Fail_LW_1:  li gp, 501; j fail
Fail_LW_2:  li gp, 502; j fail
Fail_LW_3:  li gp, 503; j fail
Fail_LW_4:  li gp, 504; j fail
Fail_LW_5:  li gp, 505; j fail
Fail_LW_6:  li gp, 506; j fail
Fail_LW_7:  li gp, 507; j fail
Fail_LW_8:  li gp, 508; j fail
Fail_LW_9:  li gp, 509; j fail

// Put data right here in the loaded section:
.balign 4
lw_data:
    .word 0x00000000
    .word 0x00000001
    .word 0xFFFFFFFF
    .word 0x7FFFFFFF
    .word 0x80000000
    .word 0x12345678
    .word 0x87654321
    .word 0x00FF00FF
    .word 0xFF00FF00
    .word 0x0F0F0F0F
