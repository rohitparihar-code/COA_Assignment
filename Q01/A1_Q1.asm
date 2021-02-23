# Print Your Lucky Number and Verify
	.data
msg: .asciz "My Lucky Number is: "
	.text
main:
	la	a0, msg
	li	a7, 4 #printStr
	ecall
	
	li	a0, 2 # 3 is my lucky number
	li	a7, 1 # printInt
	ecall
