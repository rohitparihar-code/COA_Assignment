# Prints the sum of N numbers, N is arbitrary (Given By Programmer)
	.data
nValue: .asciz "N = "
sumValue: .asciz "\nSum: "

	.globl N_sum
	.text
main:
	li	t0, 2 # Arbitrary value of N
	li	t1, 0 # sum variable initiated to zero
	
	la	a0, nValue
	li	a7, 4
	ecall # Prints "N = "
	
	add	a0, x0, t0 # Copy value of N to a0 to print it
	li	a7, 1
	ecall # Prints N value
	
	la	a0, sumValue
	li	a7, 4
	ecall # Prints "Sum = "
	
N_sum:
	add	t1, t1, t0 # sum = sum + N
	addi	t0, t0, -1 # Decrease value of N by 1
	bgtz	t0, N_sum
	
exit:
	add	a0, x0, t1
	li	a7, 1
	ecall	# Prints sum value
