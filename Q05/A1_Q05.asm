#function to convert an integer to its equivalent ascii string.
.data
prompt: 
	.string "Enter the int to be converted into string : " 
prompt2:
	.string "Equivalent string after conversion is :"
result: #result ascii string of the number
	.double 0
	.double 0
	.double 0
	.double 0 
number: #thee number that is converted into string
	.double


.text
beq zero, zero, main

print_int:
#prologue of the print_int function
addi sp, sp, -8
sd ra, 0(sp)
addi x2, x2, -8
sd fp, 0(sp)
addi fp, sp, 8

ld t2, 8(fp) #stores input argument number into t2
li t3, 10 #stores 10 into t3

addi sp, sp, -1
sb zero, 0(sp)#storing the EOS character of the string.

LOOP1:
beq t2, zero, LOOP1_END #while t2!=0

rem t4, t2, t3 #rem(t4)=n%10
addi t4, t4, 48 
addi sp, sp, -1
sb t4, 0(sp) #stores the ascii character of that digit
div t2, t2, t3
beq zero, zero, LOOP1

LOOP1_END:

la t0, result

LOOP2:

lb t1, 0(sp)
addi sp, sp, 1
sb t1, 0(t0)
addi t0, t0, 1
bne t1, zero, LOOP2

LOOP2_END:


#return segment of the print_int function
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
ecall #prints "Enter the int to be converted into string : "

li a7, 5
ecall #reads int and stores into a0

add t1, a0, x0
la t2, number
sd a0, 0(t2)

addi sp, sp, -8
sd t1, 0(sp)
la t2, print_int
jalr ra, 0(t2)

li a7, 4
la a0, prompt2
ecall
li a7, 4
la a0, result
ecall #prints thee equivalent string of the integer.

#return segment of the main function
li a0, 0
addi sp, fp, -8
ld fp, 0(sp)
ld ra, 8(sp)
addi sp, sp, 16
