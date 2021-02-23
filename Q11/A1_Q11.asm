# Sorting array (Selection Sort)
	.data
array: .word 10, 5 ,21, 42, 1, 3

	.text
main:
	la	t0, array #load base address to t0
	li	t1, 6	#size of the array
	li	t2, 0	# init i = 0
	
	iloop:
		addi	t3, t2, 1  #init j = i+1
		
		
	