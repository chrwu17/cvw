// beq_test.S
.extern return_beq_test
.extern fail

.section .text.init
.globl beq_test
.type beq_test, @function

beq_test:

test1:
    li t0, 5
    li t1, 5
    beq t0, t1, test2
    j  Fail_BEQ_0

test2:
    li t0, 5
    li t1, 6
    beq t0, t1, Fail_BEQ_1
    j  test3

test3:
    li t0, 0
    li t1, 0
    beq t0, t1, test4
    j  Fail_BEQ_2

test4:
    li t0, -7
    li t1, -7
    beq t0, t1, test5
    j  Fail_BEQ_3

test5:
    li t0, -1
    li t1, 1
    beq t0, t1, Fail_BEQ_4
    j  test6

test6:
    li t0, 2047
    li t1, 2047
    beq t0, t1, test7
    j  Fail_BEQ_5

test7:
    li t0, -2048
    li t1, 0
    beq t0, t1, Fail_BEQ_6
    j  test8

test8:
    li t0, 123
    li t1, 123
    beq t0, t1, test9
    j  Fail_BEQ_7

test9:
    li t0, 1
    li t1, 2
    beq t0, t1, Fail_BEQ_8
    j  test10

test10:
    li t0, 999
    beq t0, t0, pass
    j  Fail_BEQ_9

pass:
    j return_beq_test

Fail_BEQ_0: li gp, 1300; j fail
Fail_BEQ_1: li gp, 1301; j fail
Fail_BEQ_2: li gp, 1302; j fail
Fail_BEQ_3: li gp, 1303; j fail
Fail_BEQ_4: li gp, 1304; j fail
Fail_BEQ_5: li gp, 1305; j fail
Fail_BEQ_6: li gp, 1306; j fail
Fail_BEQ_7: li gp, 1307; j fail
Fail_BEQ_8: li gp, 1308; j fail
Fail_BEQ_9: li gp, 1309; j fail
