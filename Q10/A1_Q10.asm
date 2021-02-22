# Code to add two arrays
	.data
array1:	# array1[4] = {1, 2, 4, -4}
	.word 1
	.word 2
	.word 4
	.word -4

array2:	# array2[4] = {10, -2, 3, 2}
	.word 10
	.word -2
	.word 3
	.word 2

msg: .asciz "Sum of the two arrays: "
space: .asciz " "

	.text
main:
	la	a0, msg
	li	a7, 4	# printStr
	ecall
	
	li	t0, 4	#Size of the arrays
	la	t2, array1	# Load base address of array1
	la	t3, array2	# Load base address of array2
	
	loop:
		lb	t4, 0(t2)	# copy the value stored in t2 to t4
		lb	t5, 0(t3)
		add	a0, t4, t5	# a0 = array1[i] + array2[i]
		li	a7, 1
		ecall	# prints the value stored in a1
		
		addi	t2, t2, 4	# t2 is moved to next address
		addi	t3, t3, 4	# t3 is moved to next address
		
		la	a0, space
		li	a7, 4
		ecall	# prints space
		
		addi	t0, t0, -1	# n = n -1
		bgtz	t0, loop