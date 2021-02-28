#code to simulate binary search on an integer array

.data
array:
	.dword  0, 2, 5, 7, 9, 12, 32, 49, 199, 333, 1077, 1211
search:
	.double 0
position:
	.double 0
space:
	.string " "
newline:
	.string "\n"
prompt:
	.string "Array initialized is as follows : "
prompt1:
	.string "Enter the element to be searched in the array : "
prompt2:
	.string "The element searched is present at position "
prompt3:
	.string "The element searched is not present in the array."
	
.text

main:

la a0, prompt
li a7, 4
ecall

la t0, array
li t1, 0
li t2, 12 #no. of elements in arrayy

LOOP1:
beq t1, t2, LOOP1_END

ld a0, 0(t0)
li a7, 1
ecall
la a0, space
li a7, 4
ecall
addi t1, t1, 1
addi t0, t0, 8

beq zero, zero, LOOP1
LOOP1_END:

la a0, newline
li a7, 4
ecall
la a0, prompt1
li a7, 4
ecall

li a7, 5
ecall

addi sp, sp, -8
sd a0, 0(sp)
addi t0, a0, 0



li t1, 0 #stores lower index of the sub array
li t2, 11 #stores upper index of the sub array
la t3, array

li a0, 0

LOOP2:
blt t2, t1, print_result
add t4, t1, t2 #t4= ll+ul
li t5, 2
div t4, t4, t5 #t4= t4/2= (ll+ul)/2
li t6, 8
mul t5, t4, t6 #t5 = 8*t4= 8*(ul+ll)/2
add t5, t3, t5 #t5 = t3+ t5 = &A[(ll+ul)/2]
ld t6, 0(t5) # load A[(ll+ul)/2]

IF:
bne t0, t6, ELSE_IF1 #if t0==t5 i.e if (searched element== arr[(ul+ll)/2]
addi a0, t4, 1 #sets the postion of searches element as index+1
beq zero, zero, print_result

ELSE_IF1:
bgt t0, t6, ELSE_IF2 #else if (t0<t5) i.e if(searched element < arr[(ul+ll)/2)]
addi t2, t4, -1
beq zero, zero, LOOP2
ELSE_IF2:
addi t1, t4, 1
beq zero, zero, LOOP2

print_result:
beq a0, zero, failed
addi t0, a0, 0
la a0, newline
li a7, 4
#ecall
la a0, prompt2
li a7, 4
ecall
addi a0, t0, 0
li a7, 1
ecall
beq zero, zero, exit

failed:
la a0, newline
li a7, 4
#ecall
la a0, prompt3
li a7, 4
ecall
beq zero, zero, exit


exit:
