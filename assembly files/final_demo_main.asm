#############################################################################################
#
# Montek Singh
# COMP 541 Final Projects
# Apr 5, 2018
#
# This is a MIPS program that tests the MIPS processor and the VGA display,
# using a very simple animation.
#
# This program assumes the memory-IO map introduced in class specifically for the final
# projects.  In MARS, please select:  Settings ==> Memory Configuration ==> Default.
#
# NOTE:  MEMORY SIZES.
#
# Instruction memory:  This program has 150 instructions.  So, make instruction memory
# have a size of at least 256 locations.
#
# Data memory:  Make data memory 64 locations.  This program only uses two locations for data,
# and a handful more for the stack.  Top of the stack is set at the word address
# [0x100100fc - 0x100100ff], giving a total of 64 locations for data and stack together.
# If you need larger data memory than 64 words, you will have to move the top of the stack
# to a higher address.
#
#############################################################################################
#
# THIS VERSION HAS LONG PAUSES:  Suitable for board deployment, NOT for Vivado simulation
#
#############################################################################################


.data 0x10010000 			# Start of data memory

note_sequence: .space 32

notes: .word 0, 382219, 340530, 303370, 286344, 255102, 227273, 202478, 191113

#displays: .word 0, 0x2BED, 0x49EF, 0x3923, 0x6B6E, 0x79E7 ,0x79E4, 0x3ACF, 0x2BED

#display: .word 0x7



.text 0x00400000			# Start of instruction memory

main:
	lui	$sp, 0x1001		# Initialize stack pointer to the 64th location above start of data
	ori 	$sp, $sp, 0x0200	# top of the stack is the word at address [0x100100fc - 0x100100ff]
						                                    			                                    	                                    	                                    
	
key_loop:	

	jal 	get_key			# get a key (if available)
	beq	$v0, $0, key_loop
	move	$s0, $v0
	
	#li 	$t8, 0			#counter stored in t8 set to zero
	#la	$t9, note_sequence
	
	jal	get_accelY		# get left to right tilt angle
	srl	$v0, $v0, 5		# keep leftmost 4 bits out of 9
	li	$a0, 1
	sllv	$a0, $a0, $v0		# calculate 2^v0 (one hot pattern, 2^0 to 2^15)
	jal	put_leds		# one LED will be lit
	
	
	sll 	$t0, $s0, 2
	lw	$a0, notes($t0)
	jal	put_sound
	li	$a0, 10
	jal 	pause
	jal	sound_off					
	
	#sw	$s0, $t8($t9)		#add note to array
	#addi	$t8, $t8, 4		#increment counter by four
	
	#beq 	$t8, 28, playback_sequence
	
	
	beq 	$s0, 1, display_note_1
	beq 	$s0, 2, display_note_2
	beq 	$s0, 3, display_note_3
	beq 	$s0, 4, display_note_4
	beq 	$s0, 5, display_note_5
	beq 	$s0, 6, display_note_6
	beq 	$s0, 7, display_note_7
	beq 	$s0, 8, display_note_8
	
	beq	$s0, 9, reset_note_1
	beq 	$s0, 10, reset_note_2
	beq	$s0, 11, reset_note_3
	beq 	$s0, 12, reset_note_4
	beq	$s0, 13, reset_note_5
	beq 	$s0, 14, reset_note_6
	beq	$s0, 15, reset_note_7
	beq 	$s0, 16, reset_note_8
	
	
	

#playback_sequence:
	#li 	$t6, 0						#t6 = 0
	#beq 	$t6, 8, reset_sequence				# if t6 = 8 reset sequence 
	
	
		

########### function display_note

display_note_1:	
	li 	$a0, 2
	li 	$a1, 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 2					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 3
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

display_note_2:	
	li 	$a0, 2
	li 	$a1, 6
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 7					#slot 2
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 8
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
display_note_3:	
	li 	$a0, 2
	li 	$a1, 11
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 12					#slot 3
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 13
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

display_note_4:	
	li 	$a0, 2
	li 	$a1, 16
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 17					#slot 4
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 18
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

display_note_5:	
	li 	$a0, 2
	li 	$a1, 21
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 22					#slot 5
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 23
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

display_note_6:	
	li 	$a0, 2
	li 	$a1, 26
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 27					#slot 6
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 28
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
display_note_7:	
	li 	$a0, 2
	li 	$a1, 31
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 32					#slot 7
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 33
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
display_note_8:	
	li 	$a0, 2
	li 	$a1, 36
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 37					#slot 8
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 2
	li 	$a1, 38
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
	
#resets
	
reset_note_1:
	li 	$a0, 0
	li 	$a1, 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 2					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 3
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop	

reset_note_2:
	li 	$a0, 0
	li 	$a1, 6
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 7					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 8
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

reset_note_3:
	li 	$a0, 0
	li 	$a1, 11
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 12					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 13
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop

reset_note_4:
	li 	$a0, 0
	li 	$a1, 16
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 17					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 18
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
reset_note_5:
	li 	$a0, 0
	li 	$a1, 21
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 22					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 23
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
reset_note_6:
	li 	$a0, 0
	li 	$a1, 26
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 27					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 28
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
reset_note_7:
	li 	$a0, 0
	li 	$a1, 31
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 32					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 33
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	
reset_note_8:
	li 	$a0, 0
	li 	$a1, 36
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 37					#slot 1
	li	$a2, 28
	jal 	putChar_atXY
	li 	$a0, 0
	li 	$a1, 38
	li	$a2, 28
	jal 	putChar_atXY
	j 	key_loop
	

key1:
	bne	$v0, 1, key2		
	j	key_loop

key2:
	bne	$v0, 2, key3
	j	key_loop

key3:
	bne	$v0, 3, key4
	j	key_loop

key4:
	bne	$v0, 4, key5	
	j	key_loop

key5: 
	bne	$v0, 5, key6
	j	key_loop

key6:
	bne	$v0, 6, key7
	j	key_loop

key7:
	bne	$v0, 7, key8
	j	key_loop

key8:
	bne	$v0, 8, key9
	j	key_loop

key9:
	bne	$v0, 9, key10
	j 	key_loop

key10:
	bne 	$v0, 10, key_loop
	j 	key_loop

			
					
	###############################
	# END using infinite loop     #
	###############################
	
				# program won't reach here, but have it for safety
end:
	j	end          	# infinite loop "trap" because we don't have syscalls to exit


######## END OF MAIN #################################################################################



.include "procs_board.asm"
