// or_ori_test.S
.extern return_or_ori_test
.extern fail

.section .text.init
.globl or_ori_test
.type or_ori_test, @function

or_ori_test:

test1:
    li t0, 0x55
    li t1, 0xAA
    or t2, t0, t1
    li t3, 0xFF
    beq t2, t3, test2
    j Fail_OR_0

test2:
    li t0, 0x3C
    li t1, 0xC3
    or t2, t0, t1
    li t3, 0xFF
    beq t2, t3, test3
    j Fail_OR_1

test3:
    li t0, 0
    li t1, 123
    or t2, t0, t1
    li t3, 123
    beq t2, t3, test4
    j Fail_OR_2

test4:
    li t0, -1
    li t1, 0
    or t2, t0, t1
    li t3, -1
    beq t2, t3, test5
    j Fail_OR_3

test5:
    li  t0, 0x700
    ori t2, t0, 0x0FF
    li  t3, 0x7FF
    beq t2, t3, test6
    j Fail_OR_4

test6:
    li  t0, 0
    ori t2, t0, 0x123
    li  t3, 0x123
    beq t2, t3, test7
    j Fail_OR_5

test7:
    li t0, 0x123
    li t1, 0x456
    or t2, t0, t1
    li t3, 0x577
    beq t2, t3, test8
    j Fail_OR_6

test8:
    li  t0, 0x0F0
    ori t2, t0, 0x00F
    li  t3, 0x0FF
    beq t2, t3, test9
    j Fail_OR_7

test9:
    li t0, 0x555
    li t1, 0x2AA
    or t2, t0, t1
    li t3, 0x7FF
    beq t2, t3, test10
    j Fail_OR_8

test10:
    li t0, 0x000
    li t1, 0x000
    or t2, t0, t1
    li t3, 0
    beq t2, t3, pass
    j Fail_OR_9

pass:
    j return_or_ori_test

Fail_OR_0: li gp, 1100; j fail
Fail_OR_1: li gp, 1101; j fail
Fail_OR_2: li gp, 1102; j fail
Fail_OR_3: li gp, 1103; j fail
Fail_OR_4: li gp, 1104; j fail
Fail_OR_5: li gp, 1105; j fail
Fail_OR_6: li gp, 1106; j fail
Fail_OR_7: li gp, 1107; j fail
Fail_OR_8: li gp, 1108; j fail
Fail_OR_9: li gp, 1109; j fail
