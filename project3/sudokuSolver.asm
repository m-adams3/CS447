.data
	nextLine: .asciiz "\n"
.text
######################### PRINT SUDOKU #########################################################################
	lui $t0, 0xffff	# load base address into first argument
	ori $t0, $t0, 0x8000	# load base address into first argument
	addi $t2, $zero, 0	# $t2 = rowCounter
	addi $t3, $zero, 0	# $t3 = iterationCounter
	
printSudoku:
	lb $t1, ($t0)	# load int at mem location
	add $t1, $t1, 0x30
	addi $v0, $zero, 11	# Syscall 1: print char
	add $a0, $zero, $t1	
	syscall
	add $t0, $t0, 1	# load address of next int
	addi $t2, $t2, 1	# rowCounter++
	addi $t3, $t3, 1	# iterationCounter++
	beq $t2, 9, printNextLine
	j printSudoku
printNextLine:
	addi $v0, $zero, 4	# Syscall 4: print string
	la $a0, nextLine
	syscall
	addi $t2, $zero, 0
	beq $t3, 81, main 	# jump when done
	j printSudoku

######################### MAKE RECURSIVE CALL #########################################################################
main:
	# SETUP INITIAL ARG VALUES
	addi $s0, $zero, 1	# num = 1
	add $s1, $zero, $zero	# row = 0
	add $s2, $zero, $zero	# col = 0
	add $s3, $zero, $zero	# answer = 0 (true) --- prob unnecessary right here
	lui $s4, 0xffff	# load base address into first argument
	ori $s4, $s4, 0x8000	# load base address into first argument
	# SETUP INITIAL ARGS
	add $a0, $zero, $s0	# first arg - $a0 = num
	add $a1, $zero, $s1	# second arg - $a1 = row
	add $a2, $zero, $s2	# third arg - $a2 = col
	add $a3, $zero, $s4	# fourth arg - $a3 = current address
	# MAKE FIRST/ONLY CALL FROM MAIN
	jal _solveSudoku	
	# TERMINATE PROGRAM
	li $v0, 10
          	syscall
          	

# _solveSudoku:
#
# Recursive function
# 
# Arguments:
#   - a0: num
#   - a1: row
#   - a2: column
#   - a3: current address
# Return Values:
#   - v0: boolean answer
_solveSudoku:
	add $s0, $zero, $a0	# $s0 = num
	add $s1, $zero, $a1	# $s1 = row
	add $s2, $zero, $a2	# $s2 = col
	add $s4, $zero, $a3	# $s4 = current address
	add $s3, $zero, $v0	# $s3 = result of recursive call above current call
	addi $sp, $sp, -24 	# Adjust the stack
	sw $ra, 0($sp) 	# Store $ra in memory
	sw $s0, 4($sp) 	# Store $s0 in memory
	sw $s1, 8($sp) 	# Store $s1 in memory
	sw $s2, 12($sp) 	# Store $s2 in memory
	sw $s3, 16($sp) 	# Store $s3 in memory
	sw $s4, 20($sp)	# Store $s4 in memory
	
	add $s0, $zero, $a0	# $s0 = num
	add $s1, $zero, $a1	# $s1 = row
	add $s2, $zero, $a2	# $s2 = col
	add $s4, $zero, $a3	# $s4 = current address
	#add $s3, $zero, $v0	# $s3 = result of recursive call above current call
	##### CHECK IF CONTENTS != 0 #####
	add $t0, $zero, $zero	# reset $t0
	lb $t0, ($s4)	# $t0 = byte at currAddress
	bne $t0, $zero, ssSkip	# if contents != 0, skip
	###### SET ANSWER = 0 #####
	addi $s3, $zero, 0	# set answer = 0 (true)
	##### CALL CHECKROW #####
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = current address
	jal _checkRow
	add $s3, $zero, $v0	# $s3 = answer (0 = not found, 1 = found)
	beq $s3, 1, ssFalse	# $s3 = row contained number, answer = false
	##### CALL CHECKCOL #####
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddress
	jal _checkColumn
	add $s3, $zero, $v0	# $s3 = answer (0 = not found, 1 = found)
	beq $s3, 1, ssFalse	# $s3 = col contained number, answer = false
	##### CALL CHECKSUBGRID #####
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	jal _checkSubgrid
	add $s3, $zero, $v0	# $s3 = answer (0 = not found, 1 = found)
	beq $s3, 1, ssFalse	# $s3 = subgrid contained number, answer = false
	##### IF WE MADE IT HERE, NUMBER NOT ILLEGAL #####
	j ssTrue		# no functions returned 1, found = true
ssFalse:
	blt $s0, 9, ssFalseRec	# if num < 9, jump to recursive call
ssFalseRet:	
	beq $t8, 1, ssFalseRetS
	add $t0, $zero, $zero	# reset $t0
	#add $t0, $zero, $s0	# $t0 = num (to be stored in grid)	
	sb $t0, ($s4)	# store byte into current mem location
ssFalseRetS:
	add $t8, $zero, $zero	
	add $t0, $zero, $zero	# reset $t0
	add $t0, $zero, $s4
	
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	
	bne $t0, $s4, ssFalseRec
	
	addi $sp, $sp, 24 	# Restore the stack
	#addi $v0, $zero, 1	# return answer = false
	jr $ra
ssFalseRec:
	beq $s0, 9 , ssFalseRet
	add $t0, $zero, $zero	# reset $t0
	#add $t0, $zero, $s0	# $t0 = num (to be stored in grid)	
	sb $t0, ($s4)	# store byte into current mem location
	
	addi $s0, $s0, 1	# num++
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddress
	jal _solveSudoku	# make recursive call
	beq $v0, 1, ssFalseRet	# TESTING BACKTRACKING IDEA
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	#addi $v0, $zero, 0	# return answer = true
	jr $ra
ssTrue:
	blt $s2, 8, ssTrueRec0	# if col < 8, make recursive call (move right 1)
	beq $s1, 8, ssTrueDone	# if row = 8, done (if row = 8, we're at (8,8) so return true)
	j ssTrueRec1	# if row < 8, make recursive call (move down 1)
ssTrueRec1:
	#beq $s3, 1, ssFalse	# TESTING BACKTRACKING IDEA
	add $t0, $zero, $zero	# reset $t0
	add $t0, $zero, $s0	# $t0 = num (to be stored in grid)
	sb $t0, ($s4)	# store byte into current mem location
	# if col = 8, set up arguments
	addi $s0, $zero, 1	# num = 1
	addi $s1, $s1, 1	# row++
	add $s2, $zero, $zero	# col = 0
	addi $s4, $s4, 1	# currAddress++
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddresss
	jal _solveSudoku	# make recursive call
	beq $v0, 1, ssFalseRet	# TESTING BACKTRACKING IDEA
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	addi $v0, $zero, 0	# return answer = true
	jr $ra
ssTrueRec0:
	#beq $s3, 1, ssFalse	# TESTING BACKTRACKING IDEA
	add $t0, $zero, $zero	# reset $t0
	add $t0, $zero, $s0	# $t0 = num (to be stored in grid)
	sb $t0, ($s4)	# store byte into current mem location
	
	addi $s0, $zero, 1	# num = 1	
	#addi $s1, $zero, $zero	# row = 0 NO - keep row same
	addi $s2, $s2, 1	# col++
	addi $s4, $s4, 1	# currAddress++
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddresss
	jal _solveSudoku	# make recursive call
	beq $v0, 1, ssFalseRet	# TESTING BACKTRACKING IDEA
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	addi $v0, $zero, 0	# return answer = true
	jr $ra
	
ssTrueDone:
	#beq $s3, 1, ssFalse	# TESTING BACKTRACKING IDEA
	add $t0, $zero, $zero	# reset $t0
	add $t0, $zero, $s0	# $t0 = num (to be stored in grid)
	sb $t0, ($s4)	# store byte into current mem location
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	addi $v0, $zero, 0	# return answer = true
	jr $ra
ssSkip:
	blt $s2, 8, ssSkipRec0	# if col < 8, make recursive call (move right 1)
	beq $s2, 8, ssSkipRec1	# if col = 8 && row < 8, make recursive call (move down 1)
ssSkipRet:	addi $v0, $zero, 0	# return answer = true
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	addi $v0, $zero, 0	# return answer = false
	jr $ra
ssSkipRec0:
	addi $s0, $zero, 1	# num = 1
	addi $s2, $s2, 1	# col + 1
	addi $s4, $s4, 1	# currAddress + 1
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddresss
	jal _solveSudoku	# make recursive call
	addi $t8, $zero, 1
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	#addi $v0, $zero, 1	# return answer = false
	jr $ra
ssSkipRec1:
	beq $s1, 8, ssSkipRet	# if row = 8 also, at (8,8) so return true
	# if row < 8, (move down 1)
	addi $s0, $zero, 1	# num = 1
	addi $s1, $s1, 1	# row++
	add $s2, $zero, $zero	# col = 0
	addi $s4, $s4, 1	# currAddress + 1
	add $a0, $zero, $s0	# $a0 = num
	add $a1, $zero, $s1	# $a1 = row
	add $a2, $zero, $s2	# $a2 = col
	add $a3, $zero, $s4	# $a3 = currAddresss
	jal _solveSudoku	# make recursive call
	addi $t8, $zero, 1
	lw $ra, 0($sp) 	# Load $ra from memory
	lw $s0, 4($sp) 	# Load $s0 from memory
	lw $s1, 8($sp) 	# Load $s1 from memory
	lw $s2, 12($sp) 	# Load $s2 from memory
	#lw $s3, 16($sp) 	# Load $s3 from memory
	lw $s4, 20($sp)	# Load $s4 from memory
	addi $sp, $sp, 24 	# Restore the stack
	#addi $v0, $zero, 1	# return answer = false
	jr $ra
	
# _checkRow:
#
# Checks whether a given number is already in a given row
# 
# Arguments:
#   - a0: num
#   - a1: row
#   - a2: col
#   - a3: current address
# Return Values:
#   - v0: boolean answer
_checkRow:
	#addi $sp, $sp, -4	# adjust stack
	#sw $ra 0($sp)	# store $ra in mem
	add $t0, $zero, $a3	# $t0 = current address
	sub $t1, $t0, $a2	# $t1 = current address - col (address = start of row)
	add $t0, $zero, $t1	# $t0 = start of row address
	addi $t2, $zero, 0	# $t2 = counter = 0
crLoop:
	lb $t1, ($t0)	# $t1 = byte value at current address
	beq $a0, $t1, crFalse	# if num is found in row, return false
	addi $t2, $t2, 1	# counter++
	beq $t2, 9, crTrue	# iterated through whole row without matching num, return true
	addi $t0, $t0, 1	# currAddress++
	j crLoop
crTrue:
	li $v0, 0		# return true (answer = 0)
	#lw $ra 0($sp)	# load $ra from mem
	#addi $sp, $sp, 4	# restore stack
	jr $ra
crFalse:
	li $v0, 1		# return false (answer = 1)
	#lw $ra 0($sp)	# load $ra from mem
	#addi $sp, $sp, 4	# restore stack
	jr $ra
	
# _checkColumn:
#
# Checks whether a given number is already in a given column
# 
# Arguments:
#   - a0: num
#   - a1: row
#   - a2: col
#   - a3: currAddress++
# Return Values:
#   - v0: boolean answer
_checkColumn:
	add $t0, $zero, $a3	# $t0 = current address
	addi $t2, $zero, 9	# $t2 = 9
	mult $t2, $a1	# 9 x row
	mflo $t3		# $t3 = 9 x row
	sub $t1, $t0, $t3	# $t1 = current address - 9xrow = start of column address
	add $t0, $zero, $t1	# $t0 = start of col address
	addi $t2, $zero, 0	# $t2 = counter = 0
ccLoop:
	lb $t1, ($t0)	# $t3 = byte
	beq $t1, $a0, ccFalse	# if num is found in row, return false
	addi $t2, $t2, 1	# counter++
	beq $t2, 9, ccTrue	# iterated through whole col without matching num, return true
	addi $t0, $t0, 9	# currAddress + 9
	j ccLoop
ccTrue:
	li $v0, 0		# return true (answer = 0)
	jr $ra
ccFalse:
	li $v0, 1		# return false (answer = 1)
	jr $ra
	
# _checkSubgrid:
#
# Checks whether a number is already in a subgrid where a given row/column is located
# 
# Arguments:
#   - a0: num
#   - a1: row
#   - a2: col
# Return Values:
#   - v0: boolean answer
_checkSubgrid:
	add $t4, $zero, $zero	# set $t4 = address = 0
	add $t5, $zero, $zero	# set $t5 = (address) = 0
	blt $a1, 3, csG1	# if top 1/3 of grid
	blt $a1, 6, csG2	# else if mid 1/3 of grid
	j csG3		# else bottom 1/3 of grid
csG1:
	blt $a2, 3, csG1C1	# if top, left
	blt $a2, 6, csG1C2	# if top, mid
	j csG1C3		# if top, right
csG2:
	blt $a2, 3, csG2C1	# if mid, left
	blt $a2, 6, csG2C2	# if mid, mid
	j csG2C3		# if mid, right
csG3:
	blt $a2, 3, csG3C1	# if bottom, left
	blt $a2, 6, csG3C2	# if bottom, mid
	j csG3C3		# if bottom, right
csG1C1:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8000	# load start address of specific grid
	j csTest		# jump to testing block
csG1C2:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8003	# load start address of specific grid
	j csTest		# jump to testing block
csG1C3:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8006	# load start address of specific grid
	j csTest		# jump to testing block	
csG2C1:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x801b	# load start address of specific grid
	j csTest		# jump to testing block	
csG2C2:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x801e	# load start address of specific grid
	j csTest		# jump to testing block	
csG2C3:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8021	# load start address of specific grid
	j csTest		# jump to testing block	
csG3C1:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8036	# load start address of specific grid
	j csTest		# jump to testing block	
csG3C2:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x8039	# load start address of specific grid
	j csTest		# jump to testing block	
csG3C3:
	lui $t4, 0xffff	# load start address of specific grid
	ori $t4, 0x803C	# load start address of specific grid
	j csTest		# jump to testing block	
csTest:	
	###### location 1 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 1	# currAddress + 1 (move right 1)
	###### location 2 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 1	# currAddress + 1 (move right 1)
	###### location 3 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 9	# currAddress + 9 (move down 1)
	###### location 4 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, -1	# currAddress - 1 (move left 1)
	###### location 5 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, -1	# currAddress - 1 (move left 1)
	###### location 6 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 9	# currAddress + 9 (move down 1)
	###### location 7 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 1	# currAddress + 1 (move right 1)
	###### location 8 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 1	# currAddress + 1 (move right 1)
	###### location 9 ##########
	lb $t5, ($t4)	# load byte at currAddress
	beq $a0, $t5, csFalse	# if num is found, return false (answer = -1)
	addi $t4, $t4, 1	# currAddress + 1 (move right 1)
	j csTrue		# num not found in subgrid, return true (answer = 0)
csFalse:
	add $v0, $zero, 1	# return false (answer = 1)
	jr $ra
csTrue:
	add $v0, $zero, 0	# return true (answer = 0)
	jr $ra
