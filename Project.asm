	.data
mat:	.word	1,2,3,4,5,6,7,8,9,10,11,12
endofarray1: .word -61
MATA:    .word   9,8,7,6,5,4,3,2,1,0
endofarray2: .word -61
transArray: .space 100
endofarray3: .word -61
multArray:  .space 100
endofarray4: .word -61

endl:	.asciiz	"\n"
tab:	.asciiz	"\t"

Mat1r: .asciiz "\nEnter the number of rows for the first: "
Mat1c: .asciiz "Enter the number of columns for the first : "

Mat2r: .asciiz "\nEnter the number of rows for the second: "
Mat2c: .asciiz "Enter the number of columns for the second : "

matrA: .asciiz "The first matrix is: \n"
matrB: .asciiz "The second matrix is: \n"
matrBT: .asciiz "The second matrix's TRANSPOSE is: \n"
matrC: .asciiz "Multiplication of matrices is: \n"

ArrBoundError: .asciiz "ERROR: Input array can't fill the Row*Column area, process terminated."

MultError: .asciiz "ERROR: A matrix's COLUMN must be equal to B matrix's COLUMN. Because for product function code take B's TRANSPOSE!"

	.text
main:
	
	la $a0, Mat1r
	li $v0, 4 #String loaded
	syscall

	li $v0, 5 #R1 wanted from user
	syscall
	move $s2, $v0  #Assigned to $s0

	la $a0, Mat1c
	li $v0,4 
	syscall  #String Load
	
	li $v0 5 #Want input
	syscall
	move $s3, $v0 #Save
	
	
	la $a0, matrA
	li $v0, 4 
	syscall
	la	$a0, mat
	move	$s0,$s2	
	move 	$s1,$s3
	jal	mat_print  ##PRINT FOR FIRST
	
	jal 	temp_clear
	
	
	
	#FOR SECOND MATRIX
	la $a0, Mat2r
	li $v0, 4 #String loaded
	syscall

	li $v0, 5 #R1 wanted from user
	syscall
	move $s4, $v0  #Assigned to $s0

	la $a0, Mat2c
	li $v0,4 
	syscall  #String Load
	
	li $v0 5 #Want input
	syscall
	move $s5, $v0 #Save
	
	la $a0, matrB
	li $v0, 4 
	syscall
	la	$a0, MATA
	move 	$s0, $s4
	move 	$s1, $s5	
	jal	mat_print   ##PRINT FOR SECOND

	jal 	temp_clear
	
	la	$a0, MATA
	la 	$a1,transArray   
	jal 	transpose   #TransArray initialized
	
	jal 	temp_clear
		
	la $a0, matrBT
	li $v0, 4 
	syscall
	move	$s6, $s5
	move	$s7, $s4
	la	$a0, transArray	
	move 	$s0, $s5  #Initialized for print fun.
	move 	$s1, $s4
	jal	mat_print	##PRINT FOR TRANSPOSE
	
	jal 	temp_clear
	
	la 	$a0,mat	
	la 	$a1,MATA
	la	$a2,multArray
	
	bne 	$s3,$s5 mulErr	
	beq 	$s3,$s5 multir	

mulErr:
	la $a0, MultError
	li $v0, 4 
	syscall
	
	li	$v0, 10
	syscall	
multir:
	jal 	multi			##CALCULATIONS FOR MULTIP.
	la	$a0, multArray
	move 	$s0, $s2
	move 	$s1, $s4
	jal	mat_print
	
	li	$v0, 10
	syscall	
			
## s0,s1 - print r,c values//  s2,s3 r,c for arr1 // s4,s5 r,c for arr2 // s6,s7 r,c for arr^T	// s4 = s7, s5 = s6
## A's C = B's C = B^T's R       ->   s3 = s5 = s6
## C Matrix's Row: s3      Column: s4
# $a0	Address of matrix's first word
# $a1	Matrix's size

mat_print:	# PRINT FUNC.    (Array = $a0, $s0 = Row, $s1 = Column)
	add	$t3, $zero, $a0
	add	$t0, $zero, $zero			# i = 0

mat_print_while1:	
	add	$t7, $zero, $zero
	slt	$t7, $t0, $s0				# if (i < `COLUMN`) continue
	beq	$t7, $zero, mat_print_end	
	
	add	$t1, $zero, $zero			# j = 0
	
mat_print_while2:
	add	$t6, $zero, $zero
	slt	$t6, $t1, $s1				# if (j < `ROW`) continue
	beq	$t6, $zero, mat_print_end_line	

	mul	$t5, $t0, $s1				
	add	$t5, $t5, $t1				
	sll	$t4, $t5, 2				
	add	$t5, $t4, $t3	    			#t5 has the exact address			
	
	lw	$a0, 0($t5)				
	
	beq $a0, -61,errOutOfBound
	
	li	$v0, 1
	syscall
	
	li	$v0, 4
	la	$a0, tab					# printf("\t")
	syscall
	
	addi	$t1, $t1, 1				# j++
	j	mat_print_while2

mat_print_end_line:					# printf("\n")
	li	$v0, 4
	la	$a0, endl
	syscall
	
	addi	$t0, $t0, 1				# i++
	j	mat_print_while1		
			
mat_print_end:						
	li	$v0, 4
	la	$a0, endl
	syscall	
	jr	$ra
#################################	
temp_clear:
	add $t1 , $zero,$zero
	add $t2 , $zero,$zero
	add $t3 , $zero,$zero
	add $t4 , $zero,$zero
	add $t5 , $zero,$zero
	add $t6 , $zero,$zero
	add $t7 , $zero,$zero
	add $t8 , $zero,$zero
	add $t9 , $zero,$zero
	jr $ra
#########################################
errOutOfBound:
li	$v0, 4
la	$a0, ArrBoundError
syscall
			
li	$v0, 10
syscall									
#########################################	
transpose:
	add	$t3, $zero, $a0			#Array in $t3
	add	$t8, $zero, $a1			#Transpose in $t8
	add	$t0, $zero, $zero		# i = 0

transpose_row_while:	
	add	$t7, $zero, $zero		#Checker,   1/0
	slt	$t7, $t0, $s0			# if (i < `ROW`) continue
	beq	$t7, $zero, trans_print_end	# if not, we've finished printing the whole matrix
	
	add	$t1, $zero, $zero		# j = 0
transpose_column_while:
	add	$t6, $zero, $zero		#Checker, 1/0
	slt	$t6, $t1, $s1			# if (j < `COLUMN`) continue
	beq	$t6, $zero, trans_end_line 
#LOAD ADDRESS CALCULATION ---->     baseAdr + (Row_Index * colSize + colIndex) * dataSize
# 				$a0 + ($t0 * $s1 + $t1 ) * 4
	mul	$t5, $t0, $s1
	add	$t5, $t5, $t1
	sll	$t4, $t5, 2	
	add	$t5, $t4, $t3	# t5 has the address
	

	lw	$a0, 0($t5)	#a0 has the element


#SAVE ADDRESS CALCULATION ---->  baseAdr + (Col_Index * rowSize + rowIndex) * dataSize
#                                  $a1 + ($t1 * $s0 + $t0) * 4

	mul	$t5, $t1, $s0
	add	$t5, $t5, $t0
	sll	$t4, $t5, 2	
	add	$t5, $t4, $t8
	
	sw 	$a0,0($t5)

	li	$v0, 4
	la	$a0, tab					
	syscall
	
	addi	$t1, $t1, 1				# j++
	j	transpose_column_while

trans_end_line:					
	li	$v0, 4
	la	$a0, endl
	syscall
	
	addi	$t0, $t0, 1				# i++
	j	transpose_row_while
trans_print_end:						
	li	$v0, 4
	la	$a0, endl
	syscall	
	jr	$ra
	
#######################################
#######################################

multi:
	add	$t0, $zero, $a0			#t0 address of first Array
	add	$t1, $zero, $a1			#t1 address of transpose array of second
	add	$t2, $zero, $zero		# i = 0

loop_i:	
	add	$t3, $zero, $zero			
	slt	$t3, $t2, $s2				
	beq	$t3, $zero, end	
	
	add	$t4, $zero, $zero		# k = 0
loop_k:	
	add	$t5, $zero, $zero			
	slt	$t5, $t4, $s5				
	beq	$t5, $zero, next_row	
	
	add	$t6, $zero, $zero		# j = 0
loop_j:	
	add	$t7, $zero, $zero			
	slt	$t7, $t6, $s3				
	beq	$t7, $zero, next_col
	
	#A's ADDRESS CALC.     baseAdr + (Row_Index * colSize + colIndex) * dataSize
	#                         t0 +   (  t2      * s3 +   t6) * 4
	mul	$t8, $t2, $s3				   
	add	$t8, $t8, $t6				
	sll	$t8, $t8, 2				
	add	$t8, $t8, $t0				
	
	lw	$a0, 0($t8)				#  $a0 = A[i][j]
	move 	$t3,$a0					# Assigned to t3 [TEMPORARY]
	#B^T's ADDRESS CALC.     baseAdr + (Col_Index * RowSize + RowIndex) * dataSize
	#                             t1 + (t4 * s6 + t6) * 4
	mul	$t8, $t4, $s7				
	add	$t8, $t8, $t6				
	sll	$t8, $t8, 2				
	add	$t8, $t8, $t1	
	
	lw	$a0, 0($t8)				# $a0= B^T[K][J]
	move 	$t5, $a0				# Assigned to t5 [TEMPORARY]
	mul 	$t9, $t5, $t3				# A[Ý][J] * B^T[K][J] = $t9
	#C's ADDRESS CALC.	baseAdr + (Row_Index * colSize + colIndex) * dataSize
	#			t7    +   (t2 * s5 + t4) *4
	add 	$t7, $zero,$a2	#C Array's base adress in t7 [TEMP]
	
	mul	$t8, $t2, $s5				
	add	$t8, $t8, $t4				
	sll	$t8, $t8, 2				
	add	$t8, $t8, $t7
	
	lw	$a0, 0($t8)
	move 	$t5, $a0
	add 	$t9, $t9, $t5
	
	sw 	$t9, 0($t8)     #Assigned to C[Ý][K]

	
	addi	$t6, $t6, 1				# j++
	j	loop_j

next_col:
	li	$v0, 4
	la	$a0, tab					
	syscall
	
	addi	$t4, $t4, 1				# k++
	j	loop_k
	
next_row:
	li	$v0, 4
	la	$a0, endl					
	syscall
	
	addi	$t2, $t2, 1				# i++
	j	loop_i

end:						
	li	$v0, 4
	la	$a0, endl
	syscall	
	jr	$ra






