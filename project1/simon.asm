.data
	a: .space 100
.text
loop: 	
	beq $t9, $zero, loop
	bne $t9, 16, loop	# if user presses anything but start game it starts over
	add $t8, $zero, $t9	# make simon play start game sound
	addi $s1, $zero, 0	# "initialize" length to 0
	addi $t1, $zero, 0	# "initialize" index to 0
	addi $s3, $zero, 1	# set 
	
addValue:
	# get rand
	addi $v0, $zero, 42 	# Syscall 42: Random int range
	add $a0, $zero, $zero 	# Set RNG ID to 0
	addi $a1, $zero, 4	# Set upper bound to 4 (exclusive)
	syscall 		# Generate a random number and put it in $a0
	add $t0, $zero, $a0 	# Copy the random number to $t0
	sllv $t0, $s3, $t0
	# add to array[length-1]
	la $s0, a		# load address of a
	sll $t2, $t1, 2	# offset (index * 4)
	add $t3, $s0, $t2	# address of array[index] = start address + offset
	sw $t0, 0($t3)	# store rand into array[index]
	# length++
	addi $s1, $s1, 1	# length++
	addi $s2, $s1, 1	# this is shitty programming to keep s2 greater than s1 by 1
	# index = 0
	addi $t1, $zero, 0	# index = 0
	add  $t9, $t9, $zero
	# j playSequence
	j playSequence

playSequence:
	# prevent process from advancing while $t8 != 0
	bne $t8, $zero, playSequence
	# beq index, length, checkSequence
	beq $t1, $s1, indexReset
	# set $t9 = array[index]
	sll $t2, $t1, 2	# offset (index * 4)
	add $t3, $s0, $t2	# address of array[index] = start address + offset
	lw $t8, 0($t3)	# $t8 = array[index]
	# index++
	addi $t1, $t1, 1	# index++
	# j playSequence
	j playSequence
	
indexReset:
	add $t1, $zero, $zero
	addi $t9, $zero, 0
	j checkSequence
	
checkSequence:
	# prevent progress while buttons are diabled
	beq $t9, $zero, checkSequence
	# bne $t8, array[counter], done
	sll $t2, $t1, 2	# offset (index * 4)
	add $t3, $s0, $t2	# address of array[index] = start address + offset
	lw $t4, 0($t3)	# store value of array[index] in t4
	bne $t9, $t4, done	# if user is wrong they lose
	add $t8, $t9, $zero
	# index++
	addi $t1, $t1, 1	# index++
	add  $t9, $zero, $zero
	# beq index, length, addValue
	beq $t1, $s1, addValue
	# j checkSequence
	j checkSequence
	
done:
	addi $t8, $zero, 15	# play game over stuff
	addi $t9, $zero, 0	# set t9 = 0
	j loop		# take us back to the top and restart
	
