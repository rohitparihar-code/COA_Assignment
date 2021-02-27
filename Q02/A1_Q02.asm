# Print Hello World message
	.data
msg: .asciz " Hello, World!\n"

	.text
main:
	la	a0, msg
	li	a7, 4
	ecall

