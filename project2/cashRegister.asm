# Michael Adams
# M/W 11:00am
.data
header: .asciiz "\n            CS0447\n  Bad Wine & Tipsy Spirits\n  University of Pittsburgh\n"
cabernet: .asciiz "\nCabernet Sauvignon  $15.00"
merlot: .asciiz "\nMerlot              $12.00"
syrah: .asciiz "\nSyrah                $7.00"
cashSeg: .asciiz "\nCash:               $"
pinot: .asciiz "\nPinot Noir           $9.00"
malbec: .asciiz "\nMalbec              $11.00"
zinfandel: .asciiz "\nZinfandel            $8.00"
changeSeg: .asciiz "\nChange:              $"
chardonnay: .asciiz "\nChardonnay          $10.00"
sauvignon: .asciiz "\nSauvignon Blanc     $11.00"
riesling: .asciiz "\nRiesling             $9.00"
buffer: .asciiz "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
buffer1: .asciiz "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
buffer2: .asciiz "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
total: .asciiz "\n\nTotal:              $"



.text
one:
	addi $s0, $zero, 0	# $total = 0
	addi $t8, $zero, 0	# $disp = 0
	addi $t9, $zero, 0
	la $a0, header
	lui $a1, 0xffff
	ori $a1, $a1, 0x8000
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strCopy
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
		
loop0:
	addi $t0, $zero, 11
	slt $t1, $t9, $t0
	beq $t1, 1, loop0
	addi $t0, $zero, 20
	slt $t1, $t9, $t0
	beq $t1, 1, two
	j loop0
two:
	beq $t9, 11, cabernet0
	beq $t9, 12, merlot0
	beq $t9, 13, syrah0
	beq $t9, 14, pinot0
	beq $t9, 15, malbec0
	beq $t9, 16, zinfandel0
	beq $t9, 17, chardonnay0
	beq $t9, 18, sauvignon0
	beq $t9, 19, riesling0
cabernet0:
	addi $t8, $zero, 15	# display = price
	addi $s0, $s0, 15	# total = total + price
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, cabernet
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
merlot0:
	addi $t8, $zero, 12
	addi $s0, $s0, 12
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, merlot
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
syrah0:
	addi $t8, $zero, 7
	addi $s0, $s0, 7
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, syrah
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
pinot0:
	addi $t8, $zero, 9
	addi $s0, $s0, 9
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, pinot
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
malbec0:
	addi $t8, $zero, 11
	addi $s0, $s0, 11
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, malbec
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
zinfandel0:
	addi $t8, $zero, 8
	addi $s0, $s0, 8
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, zinfandel
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
chardonnay0:
	addi $t8, $zero, 10
	addi $s0, $s0, 10
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, chardonnay
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
sauvignon0:
	addi $t8, $zero, 11
	addi $s0, $s0, 11
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, sauvignon
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
riesling0:
	addi $t8, $zero, 9
	addi $s0, $s0, 9
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, riesling
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strConcat
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	addi $t9, $zero, 0
	j loop1
loop1:
	#addi $t9, $zero, 0
	addi $t0, $zero, 11
	slt $t1, $t9, $t0
	beq $t1, 1, loop1
	addi $t0, $zero, 20
	slt $t1, $t9, $t0
	beq $t1, 1, two
	beq $t9, 21, one
	beq $t9, 22, three
	j loop1
three:
	add $t8, $zero, $s0	# $disp = $total
	add $a0, $zero, $s0
	addi $t9, $zero, 0
	la $a1, buffer
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _numToPriceString
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	la $a0, total
	la $a1, buffer
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, total
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	
loop2:
	beq $t9, 21, one	# one if user cancels
	addi $t0, $zero, 11	# wait for user to press numeric button
	slt $t1, $t9, $t0
	beq $t1, 1, four
	j loop2
four:
	#add $t8, $zero, $t9	# display the numeric value entered
	addi $t0, $zero, 10
	sll $t2, $s1, 3
	add $t2, $t2, $s1
	add $t2, $t2, $s1
	add $s1, $zero, $t2 
	#mult $s1, $t0	# cash = (cash * 10)
	beq $t9, 10, fix10
rightback:	add $s1, $s1, $t9	# cash = cash + value entered 
	
	add $t8, $zero, $s1	# display new cash value
	addi $t9, $zero, 0	# reset button to 0
loop3b:
	#addi $t9, $zero, 0	# reset button to 0
	beq $t9, $zero, loop3b
	beq $t9, 21, one	# one if user cancels
	addi $t0, $zero, 11	# wait for user to press numeric button
	slt $t1, $t9, $t0
	beq $t1, 1, four
	beq $t9, 23, five	# go to five if cash is pressed
	j loop3b
fix10:
	addi $t9, $zero, 0	# reset button to 0
	j rightback
five:
	add $a0, $zero, $s1	# a0 = cash value
	la $a1, buffer1
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _numToPriceString
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	la $a0, cashSeg
	la $a1, buffer1
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, cashSeg
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	sub $s2, $s1, $s0
	add $a0, $zero, $s2	# a0 = change value
	la $a1, buffer2
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _numToPriceString
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	la $a0, changeSeg
	la $a1, buffer2
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	
	lui $a0, 0xffff
	ori $a0, $a0, 0x8000
	la $a1, changeSeg
	addi $sp, $sp, -20	# generate activation frame
	sw $ra, 0($sp)	# store return address
	sw $s0, 4($sp)	# store total
	sw $s1, 8($sp)	# store cash
	sw $t8, 12($sp)	# store disp
	sw $t9, 16($sp)	# store button val
	jal _strConcat
	lw $ra, 0($sp)	# load return address
	lw $s0, 4($sp)	# load total
	lw $s1, 8($sp)	# load cash
	lw $t8, 12($sp)	# load disp
	lw $t9, 16($sp)	# load button val
	addi $sp, $sp, 20	# degenerate activation frame
	add $t8, $zero, $s2
	addi $t9, $zero, 0
	
loop4:
	addi $t0, $zero, 11
	slt $t1, $t9, $t0
	beq $t1, 1, loop4
	addi $t0, $zero, 20
	slt $t1, $t9, $t0
	beq $t1, 1, six
	j loop4
	# wait for user to press a wine button, six
six:
	addi $s0, $zero, 0	# $total = 0
	addi $t8, $zero, 0	# $disp = 0
	#addi $t9, $zero, 0
	la $a0, header
	lui $a1, 0xffff
	ori $a1, $a1, 0x8000
	addi $sp, $sp, -12	# generate activation frame
	sw $s0, 0($sp)	# store return address
	sw $t8, 4($sp)
	sw $t9, 8($sp)
	jal _strCopy
	lw $s0, 0($sp)
	lw $t8, 4($sp)
	lw $t9, 8($sp)	# restore return address
	addi $sp, $sp, 12	# degenerate activation frame
	j two
	# $total = 0
	# display header on recepit
	# j two
	
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
