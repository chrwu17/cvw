// and_andi_test.S
.extern return_and_andi_test
.extern fail

.section .text.init
.globl and_andi_test
.type and_andi_test, @function

and_andi_test:

test1:
    li  t0, 0x55
    li  t1, 0xAA
    and t2, t0, t1
    li  t3, 0
    beq t2, t3, test2
    j   Fail_AND_0

test2:
    li  t0, 0x3C
    li  t1, 0xC3
    and t2, t0, t1
    li  t3, 0
    beq t2, t3, test3
    j   Fail_AND_1

test3:
    li  t0, 0xFF
    li  t1, 0x0F
    and t2, t0, t1
    li  t3, 0x0F
    beq t2, t3, test4
    j   Fail_AND_2

test4:
    li   t0, 0x7FF
    andi t2, t0, 0x0FF
    li   t3, 0x0FF
    beq  t2, t3, test5
    j    Fail_AND_3

test5:
    li   t0, 0x0F0
    andi t2, t0, 0x0FF
    li   t3, 0x0F0
    beq  t2, t3, test6
    j    Fail_AND_4

test6:
    li   t0, 0x123
    andi t2, t0, 0x000
    li   t3, 0
    beq  t2, t3, test7
    j    Fail_AND_5

test7:
    li  t0, 0x777
    li  t1, 0x0F0
    and t2, t0, t1
    li  t3, 0x070
    beq t2, t3, test8
    j   Fail_AND_6

test8:
    li  t0, -1
    andi t2, t0, 0x0FF
    li  t3, 0x0FF
    beq t2, t3, test9
    j   Fail_AND_7

test9:
    li t0, 0x555
    li t1, 0x2AA
    and t2, t0, t1
    li t3, 0x000
    beq t2, t3, test10
    j Fail_AND_8

test10:
    li t0, 0x7FF
    li t1, 0x7FF
    and t2, t0, t1
    li t3, 0x7FF
    beq t2, t3, pass
    j Fail_AND_9

pass:
    j return_and_andi_test

Fail_AND_0: li gp, 1200; j fail
Fail_AND_1: li gp, 1201; j fail
Fail_AND_2: li gp, 1202; j fail
Fail_AND_3: li gp, 1203; j fail
Fail_AND_4: li gp, 1204; j fail
Fail_AND_5: li gp, 1205; j fail
Fail_AND_6: li gp, 1206; j fail
Fail_AND_7: li gp, 1207; j fail
Fail_AND_8: li gp, 1208; j fail
Fail_AND_9: li gp, 1209; j fail
