// xor_xori_test.S
// Bringup-safe: small immediates only.

.extern return_xor_xori_test
.extern fail

.section .text.init
.globl xor_xori_test
.type xor_xori_test, @function

xor_xori_test:

test1:
    li  t0, 0x55
    li  t1, 0xAA
    xor t2, t0, t1
    li  t3, 0xFF
    beq t2, t3, test2
    j   Fail_XOR_0

test2:
    li  t0, 0x0F
    li  t1, 0xF0
    xor t2, t0, t1
    li  t3, 0xFF
    beq t2, t3, test3
    j   Fail_XOR_1

test3:
    li  t0, 0
    li  t1, 123
    xor t2, t0, t1
    li  t3, 123
    beq t2, t3, test4
    j   Fail_XOR_2

test4:
    li  t0, -1
    li  t1, 0
    xor t2, t0, t1
    li  t3, -1
    beq t2, t3, test5
    j   Fail_XOR_3

test5:
    li   t0, 0x0F0
    xori t2, t0, 0x0FF
    li   t3, 0x00F
    beq  t2, t3, test6
    j    Fail_XOR_4

test6:
    li   t0, 0x00F
    xori t2, t0, 0x00F
    li   t3, 0
    beq  t2, t3, test7
    j    Fail_XOR_5

test7:
    li   t0, 0x555
    xori t2, t0, 0x555
    li   t3, 0
    beq  t2, t3, test8
    j    Fail_XOR_6

test8:
    li  t0, 777
    li  t1, 777
    xor t2, t0, t1
    li  t3, 0
    beq t2, t3, test9
    j   Fail_XOR_7

test9:
    li   t0, -1
    xori t2, t0, 0x0FF
    li   t3, -256        // 0xFFFFFF00
    beq  t2, t3, test10
    j    Fail_XOR_8

test10:
    li  t0, -2048
    li  t1, 2047
    xor t2, t0, t1
    // Just check it's not equal to either operand (basic sanity)
    beq t2, t0, Fail_XOR_9
    beq t2, t1, Fail_XOR_9
    j   pass

pass:
    j return_xor_xori_test

Fail_XOR_0: li gp, 1000; j fail
Fail_XOR_1: li gp, 1001; j fail
Fail_XOR_2: li gp, 1002; j fail
Fail_XOR_3: li gp, 1003; j fail
Fail_XOR_4: li gp, 1004; j fail
Fail_XOR_5: li gp, 1005; j fail
Fail_XOR_6: li gp, 1006; j fail
Fail_XOR_7: li gp, 1007; j fail
Fail_XOR_8: li gp, 1008; j fail
Fail_XOR_9: li gp, 1009; j fail
