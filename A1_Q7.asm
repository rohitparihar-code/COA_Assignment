# GCD Program using Euclid's GCD Algorithm
	.data
values: .asciz "(A,B) = ("
comma: .asciz ","
cBrac: .asciz ")\nGCD = " # Closing Bracket

	.text
main:
	li	t1, 100	# Value of A
	li	t2, 40	# Value of B (B < A), (t2 < t1)
	li	t0, 0	# remainder r
	
	# Below Lines prints --> (A,B) = (10, 2)\nGCD = , where 10 and 2 are values of A and B
	la	a0, values
	li	a7, 4
	ecall

	addi	a0, t1, 0
	li	a7, 1
	ecall

	la	a0, comma
	li	a7, 4
	ecall
	
	addi	a0, t2, 0
	li	a7, 1
	ecall
	
	la	a0, cBrac
	li	a7, 4
	ecall
	# Output completes here
	
gcd:
	rem	t0, t1, t2	# r = A%B
	addi	t1, t2, 0	# A = B
	addi	t2, t0, 0	# B = r
	bgtz	t0, gcd

exit:
	addi	a0, t1, 0
	li	a7, 1
	ecall	#Prints the GCD of A, B