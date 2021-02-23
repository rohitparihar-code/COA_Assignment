# Code to add two arrays
	.data
array1: .word 3, 5, 9, -1, 94, 16, 12, -38, -64, 1966
array2: .word 8, 8, 4, -1, 43, 72, -4, 100, 90, 2002

msg: .asciz "\nSum of the two arrays: "
arr1: .asciz "Array 1: "
arr2: .asciz "\nArray 2: "
space: .asciz " "

	.text
main:
	
	li	t0, 10	#Size of the arrays
	la	t2, array1	# Load base address of array1
	la	t3, array2	# Load base address of array2
	
	li	t6, 0	# init i = 0
	
	la	a0, arr1
	li	a7, 4	#printsStr
	ecall

	printarr1:
		lw	a0, 0(t2)
		li	a7, 1
		ecall
		la	a0, space
		li	a7, 4
		ecall
		addi	t2, t2, 4	# t2 is moved to next address
		addi	t6, t6, 1	# increment i by 1
		blt	t6, t0, printarr1	# if i<n
	
	la	a0, arr2	#printStr
	li	a7, 4
	ecall
	li	t6, 0
	printarr2:
		lw	a0, 0(t3)
		li	a7, 1
		ecall
		la	a0, space
		li	a7, 4
		ecall
		addi	t3, t3, 4
		addi	t6, t6, 1	# increment i by 1
		blt	t6, t0, printarr2
		
	la	t2, array1	# Load base address of array1
	la	t3, array2	# Load base address of array2
		
	la	a0, msg
	li	a7, 4	# printStr
	ecall
	
	loop:
		lw	t4, 0(t2)	# copy the value stored in t2 to t4
		lw	t5, 0(t3)
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
