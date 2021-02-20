# Print first N fibonacci Numbers
	.data
inputstr: .asciz "Enter the value of N: "
outputstr: .asciz "The First N Fibonacci Numbers are\n"
space: .asciz " "

	.text
main: 	
	la 	a0, inputstr
	li 	a7, 4 # printStr system call
	ecall
	
	li 	a7, 5 # readint system call
	ecall # Input the value of n
	
	beq a0, x0, return # exit if n==0
	
	addi 	t0, a0, 0 # Copy the value of N to t0 
	li 	t1, 0 # First number of Sequence
	li 	t2, 1 # Second number of Sequence
	li	t3, 2 # i value used in loop iteration
	
	la	a0, outputstr
	li	a7, 4
	ecall 
	
	li	a0, 0
	li 	a7, 1
	ecall # Print the first number i.e. 0
	
	beq t0, t2, return # exit if n==1
		
	la	a0, space
	li	a7, 4
	ecall # Enter space between two numbers

	li	a0, 1
	li 	a7, 1
	ecall # Print the second number i.e. 0

	beq t0, t3, return #if n==2, exit since 1 and 0 are printed
	
	la	a0, space
	li	a7, 4
	ecall # Again enter space between numbers
	
	addi	t3, t3, 1 
	
				
		
	LOOP:	
		add 	a0, t1, t2 # a0 = t1 + t2
		addi 	t1, t2, 0 # t1 = t2
		addi	t2, a0, 0 # t2 = a0
		
		li	a7, 1 # printInt system call, prints the value stored in a0
		ecall
		
		la 	a0, space 
		li 	a7, 4 
		ecall
		addi	t3, t3, 1 # increase the value of i by 1
		ble 	t3, t0, LOOP # branch if equal: if i <= N continue	
		
	return: 