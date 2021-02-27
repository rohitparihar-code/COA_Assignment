.data
prompt:
	.string "Enter the number whose factorial is to be found : "
prompt2:
	.string "Factorial of the number = "
number:
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

LOOP1:
beq t1, zero, LOOP1_END
add a0, a0, t2
addi, t1, t1, -1
beq zero, zero, LOOP1
LOOP1_END:

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

la a0, prompt
li a7, 4
ecall #prints the prompt

li a7, 5
ecall #inputs n
la t1, number
sd a0, 0(t1)

addi s6, a0, 0 

la a0, prompt2
li a7, 4
ecall #prints prompt2

li a0, 1
LOOP2:
addi sp, sp, -8
sd a0, 0(sp)
addi sp, sp, -8
sd s6, 0(sp) 
la t1, multiply_proc
jalr ra, 0(t1)
addi s6, s6, -1
bne s6, zero, LOOP2
LOOP2_END:

li a7, 1
ecall

#return segment of the main function
li a0, 0
addi sp, fp, -8
ld fp, 0(sp)
ld ra, 8(sp)
addi sp, sp, 16
