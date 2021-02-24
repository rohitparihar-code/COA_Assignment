# Print sum of N numbers, N is input
	.data
inputN: .asciz "Enter the value of N: "
output: .asciz "\nSum: "

	.text
main :
	la	a0, inputN
	li	a7, 4 #printInt
	ecall
	li	a7, 5 #readInt
	ecall # Tends to receive input from user
	
	add	t0, x0, a0 # Copy the received input to t0 (N)
	li	t1, 0 #initialize sum variable to zero
	
N_sum:
	add	t1, t1, t0 # Sum = sum + N
	addi	t0, t0, -1 # N = N -1
	bgtz	t0, loop # While (N > 0)
	
exit:
	la	a0, output
	li	a7, 4 # printStr
	ecall
	add	a0, x0, t1
	li	a7, 1 # printInt
	ecall # Prints the value of sum
