#multiply two numbers using RV64I instructions
.data
prompt:
	.string "Enter the two numbers to be multiplied : "
prompt2:
	.string "Product of two numbers = "
number1:
	.double 0
number2: 
	.double 0
product:
	.double 0
.text
beq zero, zero, main
multiply_proc:
#prologue of the multiply_proc function
addi sp, sp, -8
sd ra, 0(sp)
addi x2, x2, -8
sd fp, 0(sp)
addi fp, sp, 8

ld t1, 8(fp)
ld t2, 16(fp)
li a0, 0

LOOP:
beq t1, zero, LOOP_END
add a0, a0, t2
addi, t1, t1, -1
beq zero, zero, LOOP
LOOP_END:

la t3, product
sd a0, 0(t3)

#return segment of the multiply_proc function
addi sp, fp, -8
ld fp, 0(sp)
ld ra, 8(sp)
addi sp, sp, 16
jalr zero, 0(ra)

main:

#prologue of the main function
addi sp, sp, -8
sd ra, 0(sp)
addi sp, sp, -8
sd fp, 0(sp)
addi fp, sp, 8

la, a0, prompt
li a7, 4
ecall #prints prompt

li a7, 5

ecall #inputs number 1
la t1, number1
sd a0, 0(t1)
addi sp, sp, -8
sd a0, 0(sp)

ecall #inputs number 2
la t1, number2
sd a0, 0(t1)
addi sp, sp, -8
sd a0, 0(sp)

la a0, prompt2
li a7, 4
ecall

la t1, multiply_proc
jalr ra, 0(t1)

li a7, 1
ecall

#return segment of the main function
li a0, 0
addi sp, fp, -8
ld fp, 0(sp)
ld ra, 8(sp)
addi sp, sp, 16
