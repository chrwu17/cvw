// sw_test.S
// 10 tests for sw (600-609): store then load back
// Buffer placed in .text.init to avoid .bss/.data mapping/init issues.

.extern return_sw_test
.extern fail

.section .text.init
.globl sw_test
.type  sw_test, @function

sw_test:
    la   t0, sw_buf

test1:
    li   t1, 0x00000000
    sw   t1, 0(t0)
    lw   t2, 0(t0)
    beq  t1, t2, test2
    j    Fail_SW_0

test2:
    li   t1, 0x00000001
    sw   t1, 4(t0)
    lw   t2, 4(t0)
    beq  t1, t2, test3
    j    Fail_SW_1

test3:
    li   t1, -1
    sw   t1, 8(t0)
    lw   t2, 8(t0)
    beq  t1, t2, test4
    j    Fail_SW_2

test4:
    li   t1, 0x7FFFFFFF
    sw   t1, 12(t0)
    lw   t2, 12(t0)
    beq  t1, t2, test5
    j    Fail_SW_3

test5:
    li   t1, 0x80000000
    sw   t1, 16(t0)
    lw   t2, 16(t0)
    beq  t1, t2, test6
    j    Fail_SW_4

test6:
    li   t1, 0x12345678
    sw   t1, 20(t0)
    lw   t2, 20(t0)
    beq  t1, t2, test7
    j    Fail_SW_5

test7:
    li   t1, 0x87654321
    sw   t1, 24(t0)
    lw   t2, 24(t0)
    beq  t1, t2, test8
    j    Fail_SW_6

test8:
    li   t1, 0x00FF00FF
    sw   t1, 28(t0)
    lw   t2, 28(t0)
    beq  t1, t2, test9
    j    Fail_SW_7

test9:
    li   t1, 0xFF00FF00
    sw   t1, 32(t0)
    lw   t2, 32(t0)
    beq  t1, t2, test10
    j    Fail_SW_8

test10:
    li   t1, 0x0F0F0F0F
    sw   t1, 36(t0)
    lw   t2, 36(t0)
    beq  t1, t2, pass
    j    Fail_SW_9

pass:
    j return_sw_test

Fail_SW_0:  li gp, 600; j fail
Fail_SW_1:  li gp, 601; j fail
Fail_SW_2:  li gp, 602; j fail
Fail_SW_3:  li gp, 603; j fail
Fail_SW_4:  li gp, 604; j fail
Fail_SW_5:  li gp, 605; j fail
Fail_SW_6:  li gp, 606; j fail
Fail_SW_7:  li gp, 607; j fail
Fail_SW_8:  li gp, 608; j fail
Fail_SW_9:  li gp, 609; j fail

// Put the buffer in the loaded section (NOT .bss).
.balign 4
sw_buf:
    .word 0,0,0,0,0,0,0,0,0,0    // 10 words = 40 bytes
