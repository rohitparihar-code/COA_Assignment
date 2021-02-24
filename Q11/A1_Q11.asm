# Sorting array (Bubble Sort)
	.data
array: .dword 10, 5 ,21, 42, 1, 3
msg1: .asciz "\nArray used: "
msg2: .asciz "\nSorted Array: "
space: .asciz " "

	.text
main:
	la	t0, array	# load base address of array into t0
	li	t1, 6	# size of the array

	li	t5, 0	# init i = 0
	li	t6, 0	# init j = 0

	la	a0, msg1
	li	a7, 4
	ecall
printarr:
	ld	a0, 0(t0)
	li	a7, 1	# printInt
	ecall
	la	a0, space
	li	a7, 4	# printStr
	ecall
	addi	t0, t0, 8	# move the pointer to next address
	addi	t5, t5, 1	# increment i by 1
	blt	t5, t1, printarr # if i< n, printarr
	bnez	t6, end	# if j != 0, finish prgm ( used after printing sorted array )
	
	la	t0, array
	addi	t2, t1, -1	# t2 = n-1 
iloop:
	li	t6, 0	# init j = 0
	sub	t3, t2, t5	# t3 = n-1-i
jloop:
	ld	s0, 0(t0)	# s0 = a[j]
	ld	s1, 8(t0)	# s1 = a[j+1]
	blt	s0, s1, noswap	# if s0 < s1, skip swap
swap:
	sd	s1, 0(t0)	# a[j] = (s1 = a[j+1])
	sd	s0, 8(t0)	# a[j+1] = (s0 = a[j])
noswap:
	addi	t0, t0, 8	# Move pointer to next address
	addi	t6, t6, 1	# j++
	blt	t6, t3, jloop	# if j < n-i-1, jloop
iend:
	addi	t5, t5, 1	# i++
	blt	t5, t2, iloop	# if i < n-1, iloop

	la	t0, array	# move the pointer back to starting point
	li	t5, 0	# init i = 0
	la	a0, msg2
	li	a7, 4
	ecall
	j	printarr
end: