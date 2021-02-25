# Convert infix expression to Postfix and Prefix expression.
	.data
infix:	.asciz "(a+b)*(c-d)"
postfix: .space 10 	# allocates 10 bytes of space in data segment
prefix: .space 10	# allocates 10 bytes of space in data segment
input: .asciz "The Infix Expression is: "
output1: .asciz "\nPostfix Expression is: "
output2: .asciz "\nPrefix Expression is: "

	.text
main:
	la	a0, infix
	li	a7, 4
	ecall