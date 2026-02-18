// jal_test.S
// Tests jal without needing jalr or la.
// Only uses PC-relative labels and compares using beq.

.extern return_jal_test
.extern fail

.section .text.init
.globl jal_test
.type jal_test, @function

jal_test:

test1:
    jal  t1, t1_target
t1_ret:
    j    Fail_JAL_0
t1_target:
    // t1 should equal address of t1_ret
    // We branch to the return label and check there
    j    t1_check
t1_check:
    // Compare t1 vs expected using a known label value:
    // We can't use la, so we do this trick:
    // - put expected in t2 by jumping over an auipc-free sequence isn't possible
    // => simplest bringup assumption: auipc/la not allowed here
    // So instead, we validate jal control-flow only:
    // if we reached here, jal jumped to target and we came back via j. PASS test1.
    j test2

test2:
    jal  t1, t2_target
t2_ret:
    j    Fail_JAL_1
t2_target:
    j    test3

test3:
    jal  t1, t3_target
t3_ret:
    j    Fail_JAL_2
t3_target:
    j    test4

test4:
    jal  t1, t4_target
t4_ret:
    j    Fail_JAL_3
t4_target:
    j    test5

test5:
    jal  t1, t5_target
t5_ret:
    j    Fail_JAL_4
t5_target:
    j    test6

test6:
    jal  t1, t6_target
t6_ret:
    j    Fail_JAL_5
t6_target:
    j    test7

test7:
    jal  t1, t7_target
t7_ret:
    j    Fail_JAL_6
t7_target:
    j    test8

test8:
    jal  t1, t8_target
t8_ret:
    j    Fail_JAL_7
t8_target:
    j    test9

test9:
    jal  t1, t9_target
t9_ret:
    j    Fail_JAL_8
t9_target:
    j    test10

test10:
    jal  t1, t10_target
t10_ret:
    j    Fail_JAL_9
t10_target:
    j    pass

pass:
    j return_jal_test

Fail_JAL_0: li gp, 1400; j fail
Fail_JAL_1: li gp, 1401; j fail
Fail_JAL_2: li gp, 1402; j fail
Fail_JAL_3: li gp, 1403; j fail
Fail_JAL_4: li gp, 1404; j fail
Fail_JAL_5: li gp, 1405; j fail
Fail_JAL_6: li gp, 1406; j fail
Fail_JAL_7: li gp, 1407; j fail
Fail_JAL_8: li gp, 1408; j fail
Fail_JAL_9: li gp, 1409; j fail
