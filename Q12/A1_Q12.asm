#printing first N fibonacci numbers using a recursive function.
.data
prompt: 
	.string "Enter the value N : "
prompt2:
	.string "The first N Fibonacci numbers are :  "
space:
	.string " "
number:
	.double 0
	
.text
beq zero, zero, main

Fibo:
#prologue of the multiply_proc function
addi sp, sp, -8
sd ra, 0(sp)
addi sp, sp, -8
sd fp, 0(sp)
addi fp, sp, 8

ld t0, 8(fp)
li t2,1

bne t0, t2, IF2 #if(n==1) return 0
li a0, 0
beq zero, zero, Fibo_return

IF2:
li t2, 2
bne t0, t2, ELSE #if(n==2) return 1
li a0, 1
beq zero, zero, Fibo_return

ELSE:

ld t0, 8(fp)
addi t0, t0, -1
addi sp, sp, -8
sd t0, 0(sp) #storing n-1 as argument onto stack for calling Fibo(n-1)
la t1, Fibo
jalr ra, 0(t1) #calling Fibo(n-1)
sd a0, 0(sp) #storing Fibo(n-1) onto stack

ld t0, 8(fp)
addi t0, t0, -2
addi sp, sp, -8
sd t0, 0(sp) #storing n-2 as argument onto stack for calling Fibo(n-2)
la t1, Fibo
jalr ra, 0(t1)
sd a0, 0(sp)

ld t0, 8(sp) #loading Fibo(n-1)
add a0, a0, t0 #setting a0(return value) Fibo(n-2)+Fibo(n-1)
 
Fibo_return:
#return segment of the multiply_proc function
addi sp, fp, -8
ld fp, 0(sp)
ld ra, 8(sp)
addi sp, sp, 16
jalr zero, 0(ra)

main:

la a0, prompt
li a7, 4
ecall #prints prompt

li a7, 5
ecall #inputs value of N

la t1, number
sd a0, 0(t1) #stores nummber in main memory
li s1, 0
addi s2, a0, 0

la a0, prompt2
li a7, 4
ecall #prints prompt2 

addi sp, sp, -8

LOOP:
addi s1, s1, 1
sd s1, 0(sp)
la t1, Fibo
jalr ra, 0(t1)

li a7, 1
ecall
la a0, space
li a7, 4
ecall

bne s1, s2 LOOP
