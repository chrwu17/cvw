// slt_slti_test.S
.extern return_slt_slti_test
.extern fail

.section .text.init
.globl slt_slti_test
.type slt_slti_test, @function

slt_slti_test:
test1:
    li t0, 3
    li t1, 5
    slt t2, t0, t1
    li t3, 1
    beq t2, t3, test2
    j Fail_SLT_0

test2:
    li t0, 5
    li t1, 3
    slt t2, t0, t1
    li t3, 0
    beq t2, t3, test3
    j Fail_SLT_1

test3:
    li t0, -1
    li t1, 0
    slt t2, t0, t1
    li t3, 1
    beq t2, t3, test4
    j Fail_SLT_2

test4:
    li t0, 0
    li t1, -1
    slt t2, t0, t1
    li t3, 0
    beq t2, t3, test5
    j Fail_SLT_3

test5:
    li t0, -10
    li t1, -2
    slt t2, t0, t1
    li t3, 1
    beq t2, t3, test6
    j Fail_SLT_4

test6:
    li t0, 7
    li t1, 7
    slt t2, t0, t1
    li t3, 0
    beq t2, t3, test7
    j Fail_SLT_5

test7:
    li t0, 4
    slti t2, t0, 10
    li t3, 1
    beq t2, t3, test8
    j Fail_SLT_6

test8:
    li t0, 10
    slti t2, t0, 10
    li t3, 0
    beq t2, t3, test9
    j Fail_SLT_7

test9:
    li t0, -5
    slti t2, t0, -1
    li t3, 1
    beq t2, t3, test10
    j Fail_SLT_8

test10:
    li t0, 0
    slti t2, t0, -1
    li t3, 0
    beq t2, t3, pass
    j Fail_SLT_9

pass:
    j return_slt_slti_test

Fail_SLT_0: li gp, 900; j fail
Fail_SLT_1: li gp, 901; j fail
Fail_SLT_2: li gp, 902; j fail
Fail_SLT_3: li gp, 903; j fail
Fail_SLT_4: li gp, 904; j fail
Fail_SLT_5: li gp, 905; j fail
Fail_SLT_6: li gp, 906; j fail
Fail_SLT_7: li gp, 907; j fail
Fail_SLT_8: li gp, 908; j fail
Fail_SLT_9: li gp, 909; j fail
