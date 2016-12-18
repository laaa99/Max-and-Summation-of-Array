# Lucy Tran
# 9-30-16
# Hw 5: Array

		.data
# Initialization of array
theArray: .word 11, 12, -10, 13,  9, 12, 14, 15, -20

# intialization of phrases to console
phrase:	 .asciiz "The maximum is "
phrase2: .asciiz "\nThe summation is "

		.text
main:
	li  $a2, 9                  # a2 = 9 = array length
	
	 la $t0, theArray	        # put address of array into $t0
	
	 # Print address of array
	 # li $v0, 1                 # load appropriate system call code into register $v0;
	 # move $a0, $t0 		     # move integer to be printed into $a0:  $a0 = $t0
	 # syscall

	# Print out phrase for FindMaxValue output
	li	$v0, 4 					# print_string $a0 = string
	la	$a0, phrase				# Print to console
	syscall 					# call operating system to perform print operation
	
	#Call FindMaxValue
	li	 $t1, 0			 		# t1 = 0: index i
	li   $a1, 0                 # a1 = 0 = maxVal
	j FindMaxValue  			# jump to FindMaxValue

Exit:
	# Print maxVal
	li $v0, 1                   # load appropriate system call code into register $v0;
	move $a0, $a1 		        # move integer to be printed into $a0:  $a0 = $t6
	syscall
	
	# Print out phrase for Summation output
	li	$v0, 4 					# print_string $a0 = string
	la	$a0, phrase2			# Print to console
	syscall 					# call operating system to perform print operation
	
	# Call Summation
	li   $t1, 0                 # t1 restore back to 0
	li   $a1, 0                 # a1 = 0 = sumVal
	j Summation

Exit2:
	# Print sumVal
	li $v0, 1                   # load appropriate system call code into register $v0;
	move $a0, $a1               # move integer to be printed into $a0:  $a0 = $a1
	syscall
	
	# Exit whole program
	li   $v0, 10                # system call code for exit = 10
	syscall				        # call operating sys
	
FindMaxValue:
	beq  $t1, $a2, Exit	        # Exit loop if t1 = arrayLen
	la	 $t0, theArray	 		# put address of array into $t0
	sll	 $t2, $t1, 2		 	# t2 = t1 * 4
	add  $t0, $t0, $t2          # t0 address of array[t2]
	lw   $t3, 0($t0)            # t3 = array[t2]
	
	li   $t4, 1           		# t4 = 1
	slt  $t5, $a1, $t3 		    # t5 = 1 if a1 < t3
	addi $t1, $t1, 1        	# Increment t1 by 1: i += 1
	
	beq  $t4, $t5, SetValue		# jump if t4 = t5
	j FindMaxValue
	
SetValue:
	move $a1, $t3			    # a1 = t3
	j FindMaxValue				# jump back to FindMaxValue
	
Summation:
	beq  $t1, $a2, Exit2        # Exit loop if t1 = arrayLen
	la   $t0, theArray          # Put address of array into $t0
	sll  $t2, $t1, 2            # t2 = t1 * 4
	add  $t0, $t0, $t2          # t0 address of array[t2]
	lw   $t3, 0($t0)            # t3 = array[t0]
	
	add  $a1, $t3, $a1		    # a1 = t3 + a1
	addi $t1, $t1, 1            # t1 += 1
	j Summation					# Jump back to Summation to loop
	