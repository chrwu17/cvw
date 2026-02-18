// sub_subi_test.S
// 10 tests for sub and "subi" (800-809)
// Bringup-safe: only small immediates.

.extern return_sub_subi_test
.extern fail

.section .text.init
.globl sub_subi_test
.type  sub_subi_test, @function

sub_subi_test:

test1:
    li   t0, 10
    li   t1, 3
    sub  t2, t0, t1
    li   t3, 7
    beq  t2, t3, test2
    j    Fail_SUB_0

test2:
    li   t0, 3
    li   t1, 10
    sub  t2, t0, t1
    li   t3, -7
    beq  t2, t3, test3
    j    Fail_SUB_1

test3:
    li   t0, -5
    li   t1, -2
    sub  t2, t0, t1
    li   t3, -3
    beq  t2, t3, test4
    j    Fail_SUB_2

test4:
    li   t0, 123
    li   t1, 123
    sub  t2, t0, t1
    li   t3, 0
    beq  t2, t3, test5
    j    Fail_SUB_3

test5:  // "subi"
    li   t0, 50
    addi t2, t0, -20
    li   t3, 30
    beq  t2, t3, test6
    j    Fail_SUB_4

test6:
    li   t0, 10
    addi t2, t0, -25
    li   t3, -15
    beq  t2, t3, test7
    j    Fail_SUB_5

test7:
    li   t0, 0
    li   t1, 77
    sub  t2, t0, t1
    li   t3, -77
    beq  t2, t3, test8
    j    Fail_SUB_6

test8:
    li   t0, 2047
    li   t1, 1
    sub  t2, t0, t1
    li   t3, 2046
    beq  t2, t3, test9
    j    Fail_SUB_7

test9:
    li   t0, -2047
    li   t1, -1
    sub  t2, t0, t1
    li   t3, -2046
    beq  t2, t3, test10
    j    Fail_SUB_8

test10:
    li   t0, 100
    li   t1, 8
    sub  t0, t0, t1      // 92
    addi t2, t0, -2      // 90
    li   t3, 90
    beq  t2, t3, pass
    j    Fail_SUB_9

pass:
    j return_sub_subi_test

Fail_SUB_0: li gp, 800; j fail
Fail_SUB_1: li gp, 801; j fail
Fail_SUB_2: li gp, 802; j fail
Fail_SUB_3: li gp, 803; j fail
Fail_SUB_4: li gp, 804; j fail
Fail_SUB_5: li gp, 805; j fail
Fail_SUB_6: li gp, 806; j fail
Fail_SUB_7: li gp, 807; j fail
Fail_SUB_8: li gp, 808; j fail
Fail_SUB_9: li gp, 809; j fail
