.data
infix:
	#.space 100 #use this if you want to take user input
	.string "(a+b)*(c^d)" #please initailize the input expression here
	#PLEASE NOTE THAT THIS PROGRAM TAKES INPUT EXPRESSIONS WITH 1 CHARACTER OPERANDS ONLY
postfix:
	.space 100
prefix:
	.space 100
infix_prompt1:
	.string "\nEnter the Infix expression :"
infix_prompt2:
	.string "\nThe Infix expression is :"
postfix_prompt:
	.string "\nThe Postfix expression is :"
prefix_prompt:
	.string "\nThe Prefix expression is :"

.text

beq zero, zero, main



reverse_string:
#Prologue of the reverse_string function
addi sp, sp, -16
sd ra, 8(sp)
sd fp, 0(sp)
addi fp, sp, 8

ld t0, 8(fp)
addi t1, t0, 0

rev_L1:
lb t3, 0(t1)
beq t3, zero, rev_L1_END
addi t1, t1, 1
beq zero, zero, rev_L1
rev_L1_END:

la t2, prefix

li t4, 40 #store ascii value of '('
li t5, 41 #store ascii value of ')'

rev_L2:
beq t0, t1, rev_L2_END 
addi t1, t1, -1
lb t3, 0(t1)

rev_L2_IF1:
bne t3, t4, rev_L2_ELSE_IF1 #if (t3=='(')
sb t5, 0(t2)
beq zero, zero, rev_L2_IF_ELSE_END
rev_L2_ELSE_IF1:
bne t3, t5, rev_L2_ELSE #else if(t3==')')
sb t4, 0(t2)
beq zero, zero, rev_L2_IF_ELSE_END
rev_L2_ELSE:
sb t3, 0(t2)
rev_L2_IF_ELSE_END:
addi t2, t2, 1
beq zero, zero, rev_L2
rev_L2_END:

sb zero, 0(t2)

#Return segment of reverse_string function
la a0, prefix
addi sp, fp, -8
ld ra, 8(sp)
ld fp, 0(sp)
addi sp, sp, 16
jalr x0, 0(ra)



prefix_func:
#Prologue of the prefix function
addi sp, sp, -16
sd ra, 8(sp)
sd fp, 0(sp)
addi fp, sp, 8

ld t0, 8(fp)
addi sp, sp, -8
sd t0, 0(sp)
la t0, reverse_string
jalr ra, 0(t0)

sd a0, 0(sp)
la t0, postfix_func
jalr ra, 0(t0)

la t0, postfix
sd t0, 0(sp)
la t0, reverse_string
jalr ra, 0(t0)

#Return segment of prefix function
la a0, prefix
addi sp, fp, -8
ld ra, 8(sp)
ld fp, 0(sp)
addi sp, sp, 16
jalr x0, 0(ra)



postfix_func:
#Prologue of the postfix function
addi sp, sp, -16
sd ra, 8(sp)
sd fp, 0(sp)
addi fp, sp, 8

ld t0, 8(fp)
la t1, postfix


POSTFIX_WHILE:
lb t2, 0(t0)
beq t2, zero, POSTFIX_WHILE_END

IF:
li t3, 41
bne t2, t3, ELSE_IF1
#if(t2==')')
#{
	IF_LOOP:
		lb t4, 0(sp) 
		addi sp, sp, 1 #POP operator from stack into t4
		li t5, 40 #t5='('
		beq t4, t5, IF_LOOP_END #if t4='(' then break IF_LOOP(stop popping operator)
		sb t4, 0(t1) #append operator to postfix expression
		addi t1, t1, 1
		li t4, 32 #t4=' '
		sb t4, 0(t1) #append space to postfix expression
		addi t1, t1, 1
		beq zero, zero, IF_LOOP
	IF_LOOP_END: 
#}
beq zero, zero, IF_ELSE_END

ELSE_IF1:
li t3, 40
bne t2, t3, ELSE_IF2
#else if(t2=='(')
#{
	addi sp, sp, -1
	sb  t2, 0(sp) #PUSH '('
#}
beq zero, zero, IF_ELSE_END

ELSE_IF2:
li t3, 94
bne t2, t3, ELSE_IF3
#else if(t2=='^')
#{
	ELSE_IF2_LOOP:
	lb t4, 0(sp)
	li t5, 94 #t4='^'
	bne t4, t5, ELSE_IF2_LOOP_END #if(s->top == '^')
	addi sp, sp, 1 #POP operator from stack
	sb t4, 0(t1)
	addi t1, t1, 1
	li t4, 32 #t4=' '
	sb t4, 0(t1)
	addi t1, t1, 1
	beq zero, zero, ELSE_IF2_LOOP
	ELSE_IF2_LOOP_END:
	addi sp, sp, -1
	sb t2, 0(sp)
#}
beq zero, zero, IF_ELSE_END

ELSE_IF3:
li t3, 47
bne t2, t3, ELSE_IF4
#else if(t2=='/')
#{
	beq zero, zero, ELSE_IF3_LOOP_CONDITION
	ELSE_IF3_LOOP:
	addi sp, sp, 1 #POP operator from stack
	sb t4, 0(t1)
	addi t1, t1, 1 #append operator to postfix expression
	li t4, 32
	sb t4, 0(t1)
	addi t1, t1, 1 #append spaace to postfix expression
	ELSE_IF3_LOOP_CONDITION:
	lb t4, 0(sp)
	li t5, 94
	beq t4, t5, ELSE_IF3_LOOP #if(t4=='^')
	li t5, 47
	beq t4, t5, ELSE_IF3_LOOP #if(t4=='/')
	li t5, 42
	beq t4, t5, ELSE_IF3_LOOP #if(t4=='*')
	addi sp, sp, -1
	sb t2, 0(sp)
#}
beq zero, zero, IF_ELSE_END


ELSE_IF4:
li t3, 42
bne t2, t3, ELSE_IF5
#else if(t2=='*')
#{
	beq zero, zero, ELSE_IF4_LOOP_CONDITION
	ELSE_IF4_LOOP:
	addi sp, sp, 1 #POP operator from stack
	sb t4, 0(t1)
	addi t1, t1, 1 #append operator to postfix expression
	li t4, 32
	sb t4, 0(t1)
	addi t1, t1, 1 #append spaace to postfix expression
	ELSE_IF4_LOOP_CONDITION:
	lb t4, 0(sp)
	li t5, 94
	beq t4, t5, ELSE_IF4_LOOP #if(t4=='^')
	li t5, 47
	beq t4, t5, ELSE_IF4_LOOP #if(t4=='/')
	li t5, 42
	beq t4, t5, ELSE_IF4_LOOP #if(t4=='*')
	addi sp, sp, -1
	sb t2, 0(sp)
#}
beq zero, zero, IF_ELSE_END


ELSE_IF5:
li t3, 45
bne t2, t3, ELSE_IF6
#else if(t2=='-')
#{
	beq zero, zero, ELSE_IF5_LOOP_CONDITION
	ELSE_IF5_LOOP:
	addi sp, sp, 1 #POP operator from stack
	sb t4, 0(t1)
	addi t1, t1, 1 #append operator to postfix expression
	li t4, 32
	sb t4, 0(t1)
	addi t1, t1, 1 #append spaace to postfix expression
	ELSE_IF5_LOOP_CONDITION:
	lb t4, 0(sp)
	li t5, 94
	beq t4, t5, ELSE_IF5_LOOP #if(t4=='^')
	li t5, 47
	beq t4, t5, ELSE_IF5_LOOP #if(t4=='/')
	li t5, 42
	beq t4, t5, ELSE_IF5_LOOP #if(t4=='*')
	li t5, 45
	beq t4, t5, ELSE_IF5_LOOP #if(t4=='-')
	li t5, 43
	beq t4, t5, ELSE_IF5_LOOP #if(t4=='+')
	addi sp, sp, -1
	sb t2, 0(sp)
#}
beq zero, zero, IF_ELSE_END


ELSE_IF6:
li t3, 43
bne t2, t3, ELSE
#else if(t2=='+')
#{
	beq zero, zero, ELSE_IF6_LOOP_CONDITION
	ELSE_IF6_LOOP:
	addi sp, sp, 1 #POP operator from stack
	sb t4, 0(t1)
	addi t1, t1, 1 #append operator to postfix expression
	li t4, 32
	sb t4, 0(t1)
	addi t1, t1, 1 #append spaace to postfix expression
	ELSE_IF6_LOOP_CONDITION:
	lb t4, 0(sp)
	li t5, 94
	beq t4, t5, ELSE_IF6_LOOP #if(t4=='^')
	li t5, 47
	beq t4, t5, ELSE_IF6_LOOP #if(t4=='/')
	li t5, 42
	beq t4, t5, ELSE_IF6_LOOP #if(t4=='*')
	li t5, 45
	beq t4, t5, ELSE_IF6_LOOP #if(t4=='-')
	li t5, 43
	beq t4, t5, ELSE_IF6_LOOP #if(t4=='+')
	addi sp, sp, -1
	sb t2, 0(sp)
#}
beq zero, zero, IF_ELSE_END

ELSE:
#else i.e when t2 is an operand
#{
	sb t2, 0(t1) #append operand to postfix expression
	addi t1, t1, 1
	li t2, 32
	sb t2, 0(t1) #append space to postfix expression
	addi t1, t1, 1
#}

IF_ELSE_END:
addi t0, t0, 1
beq zero, zero, POSTFIX_WHILE
POSTFIX_WHILE_END:


addi t3, fp, -8
POSTFIX_LOOP2:
beq sp, t3, POSTFIX_LOOP2_END
lb t4, 0(sp)
addi sp, sp, 1 #POP operator from stack
sb t4, 0(t1) #append operator to postfix expression
addi t1, t1, 1
li t4, 32
sb t4, 0(t1) #append space to postfix expression
addi t1, t1, 1
beq zero, zero, POSTFIX_LOOP2
POSTFIX_LOOP2_END:
sb zero, 0(t1)

#Return segment of postfix function
la a0, postfix
addi sp, fp, -8
ld ra, 8(sp)
ld fp, 0(sp)
addi sp, sp, 16
jalr x0, 0(ra)



main:
#use this commented part if you are taking user input
#la a0, infix_prompt1
#li a7, 4
#ecall
#la a0, infix
#li a1, 50
#li a7, 8
#ecall

la t0, infix
addi sp, sp, -8
sd t0, 0(sp)

li a7, 4

la a0, infix_prompt2
ecall #prints "The Infix expression is :"
la a0, infix
ecall #prints the Infix expression

la a0, postfix_prompt
ecall #printf "The Postfix expression is :"
la t0, postfix_func
jalr ra, 0(t0) #calls postfix_func
ecall #prints the Postfix expression

la a0, prefix_prompt
ecall #printf "The Prefix expression is :"
la t0, prefix_func
jalr ra, 0(t0) #calls postfix_func
ecall #prints the Prefix expression
