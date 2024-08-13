# 一、What is the ISA?

> `instruction set` The vocabulary of commands understood by a given architecture.

指令集架构风格主要分为复杂指令集（Complex Instruction Set Computer，CISC）和精简指令集（Reduced Instruction Set Computer，RISC）。除了 CISC 与 RISC 之分，处理器指令集架构的位数也被分为 8 位、16 位、32 位和 64 位。

常用指令集架构：
| ISA | Types | 
| :--: | :--: |
| MIPS <br/>(Microprocessor without Interlocked Piped Stages Architecture) | RISC |
| x86 | CISC |
| ARM | RISC |

> [MIPS Reference Data](https://booksite.elsevier.com/9780124077263/downloads/COD_5e_Greencard.pdf)

![](./images/MIPS%20operands%20and%20assembly%20language.png)



# 二、The Components of an ISA

> The three elements of an ISA: its register set, its addressing modes, and its instruction formats.

## 1. Register set

MIPS has a classic 32-bit load-and-store ISA and 32 general-purpose registers.


MIPS Register Naming Convertions
| Name | MIPS Name | Assembly Name | Function |
| :--: | :--:| :--: | :--: |
| r0 | $0 | $zero | Constant 0 |
| r1 | $1 | $at | Reserved for assembler |
| r2 | $2 | $v0 | Expression evaluation and results of a function |
| r3 | $3 | $v1 | Expression evaluation and results of a function |
| r4 | $4 | $a0 | Argument 1 |
| r5 | $5 | $a1 | Argument 2 |
| r6 | $6 | $a2 | Argument 3 |
| r7 | $7 | $a3 | Argument 4 |
| r8 | $8 | $t0 | Temporary (not preserved across call) |
| r9 | $9 | $t1 | Temporary (not preserved across call) |
| r10 | $10 | $t2 | Temporary (not preserved across call) |
| r11 | $11 | $t3 | Temporary (not preserved across call) |
| r12 | $12 | $t4 | Temporary (not preserved across call) |
| r13 | $13 | $t5 | Temporary (not preserved across call) |
| r14 | $14 | $t6 | Temporary (not preserved across call) |
| r15 | $15 | $t7 | Temporary (not preserved across call) |
| r16 | $16 | $s0 | Saved temporary (preserved across call) |
| r17 | $17 | $s1 | Saved temporary (preserved across call) |
| r18 | $18 | $s2 | Saved temporary (preserved across call) |
| r19 | $19 | $s3 | Saved temporary (preserved across call) |
| r20 | $20 | $s4 | Saved temporary (preserved across call) |
| r21 | $21 | $s5 | Saved temporary (preserved across call) |
| r22 | $22 | $s6 | Saved temporary (preserved across call) |
| r23 | $23 | $s7 | Saved temporary (preserved across call) |
| r24 | $24 | $t8 | Temporary (not preserved across call) |
| r25 | $25 | $t9 | Temporary (not preserved across call) |
| r26 | $26 | $k0 | Reserved for OS kernel |
| r27 | $27 | $k1 | Reserved for OS kernel |
| r28 | $28 | $gp | Pointer to global area |
| r29 | $29 | $sp | Stack pointer |
| r30 | $30 | $fp | Frame pointer |
| r31 | $31 | $ra | Return adress (used by function call) |

## 2. Addressing modes

stored-program: The idea that instructions and data of many types can be stored in memory as numbers.

指令的数字形式称为机器语言



## 3. Instruction formats