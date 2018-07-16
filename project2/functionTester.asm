# Michael Adams
# M/W 11:00am

# this .data section was provided by the instructor
.data
	buffer1:	.asciiz	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	buffer2:	.asciiz	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	buffer3:	.asciiz	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	buffer4:	.asciiz	"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	prompt1:	.asciiz	"Please enter a string: "
	prompt2:	.asciiz	"Please enter another string: "
	prompt3:	.asciiz	"Please enter a positive integer: "
	test1:		.asciiz	"Test function _strCopy\n"
	enter1:		.asciiz	"You just entered  : "
	result1:	.asciiz	"Result of _strCopy: "
	check1:		.asciiz	"If both strings are identical, your _strCopy works properly.\n\n"
	test2:		.asciiz	"Test function _strConcat\n"
	str1msg:	.asciiz "String 1: "
	str2msg:	.asciiz	"String 2: "
	result2:	.asciiz "Result of _strConcat: "
	check2:		.asciiz "\nIf the result looks fine, your _strConcat works properly.\n\n"
	test3:		.asciiz "Test function _getNumDigits\n"
	result3:	.asciiz "Your _getNumDigits says "
	result4:	.asciiz " has "
	result5:	.asciiz	" digits."
	check3:		.asciiz "\nIf the number of digits is correct, your function _getNumDigits works correctly.\n\n"
	test4:		.asciiz "Test function _numToPriceString\n"
	result6:	.asciiz "The output string from _numToPriceString with the number "
	result7:	.asciiz " as the argument is the string \""
	check4:		.asciiz "\"\nIf the output string looks correct, your function _numToPriceString works properly.\n"
	test5:		.asciiz "Test function _div10\n"
	result8:	.asciiz "From your _div10, "
	result9:	.asciiz " divided by 10 is "
	result10:	.asciiz	" and the remainder is "
	check5:		.asciiz "\nIf the quotient and the reminder are correct, your function _div10 works properly.\n\n"
.text
	#################
	# Test _strCopy #
	#################
	
	la   $a0, test1
	addi $v0, $zero, 4
	syscall			# print "Test function _strCopy"
	la   $a0, prompt1
	addi $v0, $zero, 4
	syscall			# print "Please enter a string: "
	la   $a0, buffer1
	addi $a1, $zero, 62
	addi $v0, $zero, 8
	syscall			# Read a string into buffer1
	addi $s0, $zero, 10	# Ascii 10 '\n'
	# Get rid of '\n'
	la   $s1, buffer1
mpLoop1:
	lb   $s2, 0($s1)
	beq  $s0, $s2, mpDone1
	addi $s1, $s1, 1
	j    mpLoop1
mpDone1:
	sb   $zero, 0($s1)
	# print the string user entered
	la   $a0, enter1
	addi $v0, $zero, 4
	syscall			# Print "You just entered:   "
	la   $a0, buffer1
	addi $v0, $zero, 4
	syscall			# Print the string user just entered
	addi $a0, $zero, 10
	addi $v0, $zero, 11
	syscall			# Print '\n'
	# Call _strCopy
	la   $a0, buffer1	# Source string
	la   $a1, buffer2	# Destination buffer
	jal  _strCopy		# Call the function _strCopy
	la   $a0, result1
	addi $v0, $zero, 4
	syscall			# Print "Result of _strCopy: "
	la   $a0, buffer2
	addi $v0, $zero, 4
	syscall			# Print the result of _strCopy
	addi $a0, $zero, 10
	addi $v0, $zero, 11
	syscall			# Print '\n'
	la   $a0, check1
	addi $v0, $zero, 4
	syscall			# Print check1

	###################
	# Test _strConcat #
	###################

	la   $a0, prompt2
	addi $v0, $zero, 4
	syscall			# print "Please enter another string: "
	la   $a0, buffer3
	addi $a1, $zero, 62
	addi $v0, $zero, 8
	syscall			# Read a string into buffer1
	addi $s0, $zero, 10	# Ascii 10 '\n'
	# Get rid of '\n'
	la   $s1, buffer3
mpLoop2:
	lb   $s2, 0($s1)
	beq  $s0, $s2, mpDone2
	addi $s1, $s1, 1
	j    mpLoop2
mpDone2:
	sb   $zero, 0($s1)
	la   $a0, str1msg
	addi $v0, $zero, 4
	syscall			# Print "String 1: "
	la   $a0, buffer1
	addi $v0, $zero, 4
	syscall			# Print the first string user entered
	addi $a0, $zero, 10
	addi $v0, $zero, 11
	syscall			# Print '\n'
	la   $a0, str2msg
	addi $v0, $zero, 4
	syscall			# Print "String 2: "
	la   $a0, buffer3
	addi $v0, $zero, 4
	syscall			# Print the second string user entered
	addi $a0, $zero, 10
	addi $v0, $zero, 11
	syscall			# Print '\n'
	# Call the function _strConcat
	la   $a0, buffer1
	la   $a1, buffer3
	jal  _strConcat
	# print result
	la   $a0, result2
	addi $v0, $zero, 4
	syscall			# Print "Result of _strConcat: "
	la   $a0, buffer1
	addi $v0, $zero, 4
	syscall			# Print the result string of _strConcat
	la   $a0, check2
	addi $v0, $zero, 4
	syscall			# Print check2

	###############
	# Test _div10 #
	###############
	
	la   $a0, test5
	addi $v0, $zero, 4
	syscall			# Print "Test _div10"
	la   $a0, prompt3
	addi $v0, $zero, 4
	syscall			# Print "Please enter a positive integer: "
	addi $v0, $zero, 5
	syscall			# Read integer
	add  $s3, $zero, $v0	# $s3 is the integer user just entered
	add  $a0, $zero, $s3
	jal  _div10
	add  $s4, $zero, $v0
	add  $s5, $zero, $v1
	la   $a0, result8
	addi $v0, $zero, 4
	syscall			# Print "From your _div10, "
	add  $a0, $zero, $s3
	addi $v0, $zero, 1
	syscall			# Print the integer user entered
	la   $a0, result9
	addi $v0, $zero, 4
	syscall			# Print " divided by 10 is "
	add  $a0, $zero, $s4
	addi $v0, $zero, 1
	syscall			# Print the quotient
	la   $a0, result10
	addi $v0, $zero, 4
	syscall			# Print " and the remainder is "
	add  $a0, $zero, $s5
	addi $v0, $zero, 1
	syscall			# Print the remainder
	la   $a0, check5
	addi $v0, $zero, 4
	syscall
	
	######################
	# Test _getNumDigits #
	######################
	
	la   $a0, test3
	addi $v0, $zero, 4
	syscall			# Print "Test _getNumDigits"
	la   $a0, prompt3
	addi $v0, $zero, 4
	syscall			# Print "Please enter a positive integer: "
	addi $v0, $zero, 5
	syscall			# Read integer
	add  $s3, $zero, $v0	# $s3 is the integer user just entered
	add  $a0, $zero, $s3
	jal  _getNumDigits
	add  $s4, $zero, $v0
	la   $a0, result3
	addi $v0, $zero, 4
	syscall			# Print "Your _getNumDigits says "
	add  $a0, $zero, $s3
	addi $v0, $zero, 1
	syscall			# Print the integer user entered
	la   $a0, result4
	addi $v0, $zero, 4
	syscall			# Print " has "
	add  $a0, $zero, $s4
	addi $v0, $zero, 1
	syscall			# Print the number of digits
	la   $a0, result5
	addi $v0, $zero, 4
	syscall			# Print "digits."
	la   $a0, check3
	addi $v0, $zero, 4
	syscall

	#######################
	# Test _numToPriceString #
	#######################

	la   $a0, test4
	addi $v0, $zero, 4
	syscall			# Print "Test _numToPriceString"
	la   $a0, result6
	addi $v0, $zero, 4
	syscall			# Print "The output ..."
	add  $a0, $zero, $s3
	addi $v0, $zero, 1
	syscall			# Print the integer user entered
	la   $a0, result7
	addi $v0, $zero, 4
	syscall			# Print " as the argument: "
	# Call the function _toPriceString
	add  $a0, $zero, $s3
	la   $a1, buffer4
	jal  _numToPriceString
	la   $a0, buffer4
	addi $v0, $zero, 4
	syscall
	la   $a0, check4
	addi $v0, $zero, 4
	syscall			# Print "\"\nIf..."

	addi $v0, $zero, 10
	syscall






# _strCopy
#
# Copy a null-terminated source string to a destination buffer
#
# Arguments:
#   - $a0: An address of the first character of a source string
#   - $a1: An address of a buffer
# Return Value:
#   - None
_strCopy:
sCloop:
	lb $t0, 0($a0)	# $t0 = char at address a0 (starts at front of string)
	beq $t0, $zero, done	# if $t0 == 0 we're at end of string to copy
copyChar:
	sb $t0, 0($a1)	# store char to buffer
	addi $a0, $a0, 1	# input address++
	addi $a1, $a1, 1	# buffer address++
	j sCloop
done:
	sb $zero, 0($a1)	# store null char to buffer
	jr $ra
# _strConcat
#
# Concatenate the second string to the end of the first string
#
# Arguments:
#   - $a0: The address of the first string
#   - $a1: The address of the second string
# Return Value:
#   - None
_strConcat:
	addi $sp, $sp, -4	# generate activation frame
	sw $ra, 0($sp)	# store return address
	add $t0, $zero, $a0	# t0 = a0
sConloop:
	lb $t1, 0($t0)	# t1 = char in source string
	beq $t1, $zero, found	# loop till find null char
	addi $t0, $t0, 1	# string address++
	j sConloop
found:
	add $a0, $zero, $zero	# restore a0 = 0
	add $a0, $a1, $zero	# second source string is first source string for _strCopy
	add $a1, $zero, $zero	# restore a1 = 0
	add $a1, $t0, $zero	# end of first source string is now start of buffer for _strCopy
	jal _strCopy
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra		# return to caller
# _div10
#
# Return the result of a given number divided by 10
#
# Arguments:
#   - $a0: A positive integer number
# Return Values:
#   - $v0: Quotient
#   - $v1: Remainder
_div10:
	addi $t0, $zero, 10	# divisor is 10
	div  $a0, $t0       	# $a0/10
 	mflo $s0            	# $s0 = quotient
  	mfhi $s1            	# s1 = remainder  
  	add $v0, $zero, $s0
  	add $v1, $zero, $s1
  	jr $ra 
# _getNumDigits
#
# Returns the number of digits of a given positive integer
#
# Argument:
#   - $a0: a positive integer
# Return Value:
#   - $v0: the number of digits of a given positive integer
_getNumDigits:
	addi $sp, $sp, -4	# generate activation frame
	sw $ra, 0($sp)	# store return address
	
	addi $t3, $zero, 10
	slt $t1, $a0, $t3
	beq $t1, 1, gNDdone1
	
	addi $t3, $zero, 100
	slt $t1, $a0, $t3
	beq $t1, 1, gNDdone2
	
	addi $t3, $zero, 1000
	slt $t1, $a0, $t3
	beq $t1, 1, gNDdone3
	
	addi $t3, $zero, 10000
	slt $t1, $a0, $t3
	beq $t1, 1, gNDdone4
	
	addi $t3, $zero, 100000
	slt $t1, $a0, $t3
	beq $t1, 1, gNDdone5
gNDdone1:
	addi $v0, $zero, 1
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra
gNDdone2:
	addi $v0, $zero, 2
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra
gNDdone3:
	addi $v0, $zero, 3
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra	
gNDdone4:
	addi $v0, $zero, 4
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra
gNDdone5:
	addi $v0, $zero, 5
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra	
# _numToPriceString
#
# Convert a given positive integer into string of the form $xx.00
#
# Argument
#   - $a0: A positive integer
#   - $a1: An address of a buffer
# Return Value
#   - None
_numToPriceString:
.data
	msg0: .asciiz "stupidShit"
	msg1: .asciiz ".00"
.text
	addi $sp, $sp, -4	# generate activation frame
	sw $ra, 0($sp)	# store return address
	jal _getNumDigits
	add $t0, $zero, $v0	# t0 = number of digits
	add $t4, $a1, $t0	# t4 is start address + offset for numDigits
	addi $t0, $t0, -1	# t0-- for loop
	addi $t1, $zero, 0	# t1 is a counter
	add $t3, $zero, $a1	# t3 is start address of buffer
	add $t3, $t3, $t0	# t3 is start address + offset for numDigits-1
	beq $t0, $zero, done2b
loop3:
	beq $t1, $t0, done2	# done if counter = digits-1
	jal _div10
	add $t2, $zero, $v1	# t2 is remainder from _div10
	addi $t2, $t2, 0x30	# convert t2 to char
	add $a0, $zero, $v0	# a0 is quotient from _div10
	addi $t1, $t1, 1	# counter++
	sb $t2, 0($t3)	# store byte in memory
	addi $t3, $t3, -1	# move to next spot in buffer
	j loop3
done2:
	sb $zero, 0($t4)	# add null-term to buffer string
	la $a0, ($a1)
	la $a1, msg1
	
	jal _strConcat
	
	#la $a0, msg0
	#la $a1, ($a0)
	#jal _strConcat
		
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra	
done2b:
	jal _div10
	add $t2, $zero, $v1	# t2 is remainder from _div10
	addi $t2, $t2, 0x30	# convert t2 to char
	sb $t2, 0($t3)	# store byte in memory
	sb $zero, 0($t4)	# add null-term to buffer string
	la $a0, ($a1)
	la $a1, msg1
	
	jal _strConcat
	lw $ra, 0($sp)	# restore return address
	addi $sp, $sp, 4	# degenerate activation frame
	jr $ra	