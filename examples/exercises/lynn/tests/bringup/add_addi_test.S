// add_addi_test.S
// 10 tests for add/addi (700-709)
// Bringup-safe: only small immediates, no LUI required.

.extern return_add_addi_test
.extern fail

.section .text.init
.globl add_addi_test
.type  add_addi_test, @function

add_addi_test:

test1:
    li   t0, 5
    li   t1, 7
    add  t2, t0, t1
    li   t3, 12
    beq  t2, t3, test2
    j    Fail_ADD_0

test2:
    li   t0, -3
    li   t1, 10
    add  t2, t0, t1
    li   t3, 7
    beq  t2, t3, test3
    j    Fail_ADD_1

test3:
    li   t0, 0
    li   t1, 99
    add  t2, t0, t1
    li   t3, 99
    beq  t2, t3, test4
    j    Fail_ADD_2

test4:
    li   t0, 100
    addi t2, t0, 23
    li   t3, 123
    beq  t2, t3, test5
    j    Fail_ADD_3

test5:
    li   t0, 100
    addi t2, t0, -23
    li   t3, 77
    beq  t2, t3, test6
    j    Fail_ADD_4

test6:
    li   t0, 0
    addi t2, t0, -1
    li   t3, -1
    beq  t2, t3, test7
    j    Fail_ADD_5

test7:
    li   t0, 1024
    li   t1, 1023
    add  t2, t0, t1
    li   t3, 2047
    beq  t2, t3, test8
    j    Fail_ADD_6

test8:
    li   t0, -1024
    li   t1, -1023
    add  t2, t0, t1
    li   t3, -2047
    beq  t2, t3, test9
    j    Fail_ADD_7

test9:
    li   t0, 123
    li   t1, -123
    add  t2, t0, t1
    li   t3, 0
    beq  t2, t3, test10
    j    Fail_ADD_8

test10:
    li   t0, 1
    addi t0, t0, 2      // 3
    li   t1, 4
    add  t2, t0, t1     // 7
    li   t3, 7
    beq  t2, t3, pass
    j    Fail_ADD_9

pass:
    j return_add_addi_test

Fail_ADD_0: li gp, 700; j fail
Fail_ADD_1: li gp, 701; j fail
Fail_ADD_2: li gp, 702; j fail
Fail_ADD_3: li gp, 703; j fail
Fail_ADD_4: li gp, 704; j fail
Fail_ADD_5: li gp, 705; j fail
Fail_ADD_6: li gp, 706; j fail
Fail_ADD_7: li gp, 707; j fail
Fail_ADD_8: li gp, 708; j fail
Fail_ADD_9: li gp, 709; j fail
