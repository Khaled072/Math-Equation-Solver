.data 


question: .asciiz "Enter answer"
questionx1forplayer1: .asciiz "Player1: Enter x1:"
questionx2forplayer1: .asciiz "Player1: Enter x2:"
questionx1forplayer2: .asciiz "Player2: Enter x1:"
questionx2forplayer2: .asciiz "Player2: Enter x2:"
questionx3forplayer1: .asciiz "Player1: Enter x3:"
questionx3forplayer2: .asciiz "Player2: Enter x3:"
header: .asciiz "Welcome to Math Bee\nThis game will test your math abilities to the limit\nYou will be presented with an equation with only one guess oppurtunity\nGet ready the question is on the way!!!\n"
s: .asciiz "success!!\n"
w : .asciiz "wrong!!!\n"

#round1
turn: .asciiz "Round 1: Linear:\n"
p1: .asciiz "\nPlayer1 turn:\n"
lin:  .asciiz "x-"
zero: .asciiz "=0"
p2: .asciiz "Player2 turn:\n"
#p21: .asciiz "\nPlayer2: Enter solution\n"

#round2and3
r2: .asciiz "ROUND 2!!\n"
#p11: .asciiz "\nPlayer1: Enter x1:"
#p111: .asciiz "Player1: Enter x2:"
#p22: .asciiz "\nEnter x1:"
#p222: .asciiz "Enter x2:"

r3: .asciiz "ROUND 3!!\n"
quad1: .asciiz "(x^2)-"
quad2: .asciiz "x+"




#round4
r4: .asciiz "ROUND 4!!\n"
#p12: .asciiz "\nPlayer1: Enter x1:"
#p122: .asciiz "Enter x2:"
#p1222: .asciiz "Enter x3:"
#p13: .asciiz "\nPlayer2: Enter x1:"
 
tri1: .asciiz "(x^3)-"
tri2: .asciiz "(x^2)+"
tri3: .asciiz "(x)-"

#final
player2winner: .asciiz "player2 wins!!!\n"
player1winner: .asciiz "player1 wins!!!\n"

scoreplayer2: .asciiz "\nplayer 2 score:"
scoreplayer1: .asciiz "Player1 score:"



bonuspointplayer1: .asciiz "player 1 earns an extra point for answering faster\n"
bonuspointplayer2: .asciiz "player 2 earns an extra point for answering faster\n"

draw: .asciiz "DRAW\n"


#2D array
array: .word 1,2,3,4,5
        .word 6,7,8,9,10
row: .asciiz "Enter row for x1: 0 or 1\n"
row1: .asciiz "Enter row for x2: 0 or 1\n"
column: .asciiz "Enter column between 0 and 4\n"
bonusround: .asciiz "\nBonus Round\n"
newturn: .asciiz "\nPlayer2 Turn"


#sounds
pitch: .byte 45,48,51,55,67,81
	.byte 47,50,53,57,69,83
	.byte 49,52,55,59,71,85

duration: .byte 100
instrument: .byte 58
volume: .byte 100

pitch2: .byte 50,52,49,47,45,43
.byte 43,41,39,37,35,33
.byte 33,31,29,27,25,23


.text 

main:
	li 	$s0,0
	li	$s1,0
	li	$v0, 4 # set up print string syscall
	la	$a0, header
	syscall 
	jal linear #call linear function
	jal quadratic1 #call quadratic function
	jal quadratic2 #call quadratic2 function
	jal cubic #call cubic function
	jal bonusplayer1 #call bonus for player1
	jal bonusplayer2 #call bonus for player2
	jal end
	li 	$v0, 10		# set up exit syscall
	syscall

end:
#compare who has a higher score

	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)
#branch if s0 does not equal s1
	bne $s0,$s1, comparings
	li 	$v0,4
	la 	$a0,draw #print winning comment for player2
	syscall 
	li 	$v0,4
	la 	$a0, scoreplayer1#header for player1 score
	syscall
	li 	$v0,1
	move 	$a0,$s0 #setup print of player1 score 
	syscall
	li 	$v0,4
	la 	$a0, scoreplayer2 #header for player2 score
	syscall
	li 	$v0,1
	move 	$a0,$s1 #setup print of player2 score 
	syscall
	j finish
comparings:
#branch if s0 is bigger than s1 that is player1 has a higher score
	bgt 	$s0,$s1,result
	li 	$v0,4
	la 	$a0,player2winner #print winning comment for player2
	syscall 
	li 	$v0,4
	la 	$a0, scoreplayer1#header for player1 score
	syscall
	li 	$v0,1
	move 	$a0,$s0 #setup print of player1 score 
	syscall
	li 	$v0,4
	la 	$a0, scoreplayer2 #header for player2 score
	syscall
	li 	$v0,1
	move 	$a0,$s1 #setup print of player2 score 
	syscall
	j finish

result: 
	li 	$v0, 4 # set up print string syscall
	la 	$a0, player1winner #print player1 win statement
	syscall
	li 	$v0,4
	la 	$a0, scoreplayer1 #header for player1 score
	syscall
	li 	$v0,1
	move 	$a0,$s0 #setup print of player1 score 
	syscall
	li 	$v0,4
	la 	$a0, scoreplayer2 #header for player2 score
	syscall
	li 	$v0,1
	move 	$a0,$s1 #setup print of player2 score 
	syscall
	j finish
	
finish:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr $ra



#function to increase player1 score 
increaseby1forplayer1:
	addi	$sp,$sp,-4
	sw 	$ra,0($sp)
	addi 	$s0,$s0,1
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr	$ra 

#function to increase player2 score 
increaseby1forplayer2:
	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)
	addi 	$s1,$s1,1
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra    


#fucntion to produce win sound
winsound:
	la 	$a1, duration
	la 	$a2, instrument 
	la 	$a3, volume
	li 	$v0,31
	la 	$t1, pitch
	li 	$t6,6
	li 	$t7,1
music:#loop
	beq 	$t7,$t6,wine
	lb 	$a0,0($t1)
	syscall
	addi 	$t7,$t7,1
	addi 	$t1,$t1,1
	j music	
wine:
	jr 	$ra 


#fucntion to produce lose sound
losesound:
	la 	$a1, duration
	la 	$a2, instrument 
	la 	$a3, volume

	li 	$v0,31
	la 	$t1, pitch2

	li 	$t6,6
	li 	$t7,1

musicc:#loop
	beq 	$t7,$t6,wines
	lb 	$a0,0($t1)
	syscall
	addi 	$t7,$t7,1
	addi 	$t1,$t1,1
	j musicc
wines:
	jr $ra 



#this code is from the TA
RAND4:
	move 	$t0, $s5 ### R1 and R2 
	move 	$t1, $s5
#srl $t0, $t0, 0 ### x1 
	andi 	$t0, $t0, 1 ### R4 R3 R2 R1 & 1 = 0 0 0 R1
	srl 	$t1, $t1, 1 ##### R4 R3 R2 R1 >> 1 = 0 R4 R3 R2
	andi 	$t1, $t1, 1 ### 0 R4 R3 R2 & 1 = 0 0 0 R2
	xor 	$t2, $t1, $t0 #### y = R2 xor R1
	bnez 	$t2, else ### Y 0
### y ==0 
	srl 	$s5, $s5 , 1 ### 0 X4 X3 X2 : final number
	move 	$v0, $s5
	jr 	$ra 
else:
###y ==1 
	srl 	$s5, $s5, 1 ### X >> 1 :  0 X4 X3 X2
	sll 	$t2,$t2, 3 ### Y << 3:   Y 0  0  0
	or 	$s5, $t2, $s5 ### Xnew :    Y X4 X3 X2 final number
	move 	$v0, $s5
	jr 	$ra 
		

bonusplayer1:
	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)

	li 	$v0, 4 # set up print string syscall
	la	$a0, bonusround
	syscall
#get x1:

#Address(a[i][j]) = B. A. + (i * n + j) * size
	la 	$t1,array

	li 	$v0, 4 # set up print string syscall
	la $a0, row
	syscall 

#row i is $t0
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t0,$v0


	li 	$v0, 4 # set up print string syscall
	la 	$a0, column
	syscall 

#column j is $t2
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t2,$v0

#n 
	li 	$t3,5

	mul 	$t4,$t0,$t3
	add 	$t4,$t4,$t2

	sll 	$t4,$t4,2 #multiplying t4 by 4
	add 	$t4,$t4,$t1 
	lw 	$a0,0($t4)


	move 	$s4,$a0 #x1

	li 	$v0, 4 # set up print string syscall
	la 	$a0, row1
	syscall 

#row i is $t0
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t0,$v0


	li 	$v0, 4 # set up print string syscall
	la 	$a0, column
	syscall 

#column j is $t2
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t2,$v0

#n 
	li 	$t3,5

	mul 	$t4,$t0,$t3
	add 	$t4,$t4,$t2

	sll 	$t4,$t4,2 #multiplying t4 by 4
	add 	$t4,$t4,$t1 
	lw 	$a0,0($t4)


	move 	$s5,$a0 #x2

#compute function values	
	mul 	$t3, $s4, $s5
	add 	$t2,$s4,$s5

#sw $t2, mid
#sw $t3, c

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 

	move 	$a0, $t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move 	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0, 4 # set up print string syscall
	la	$a0, zero
	syscall 
	
	li 	$v0,51
	la 	$a0,questionx1forplayer1
	syscall
	move 	$t4,$a0
	
	bne 	$t4, $s4, neeer
	ccchekcr:
	jal increaseby1forplayer1
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall
	j fr 
	neeer:
	bne	$t4,$s5,finalthirdr
	j ccchekcr
	finalthirdr:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	fr:

	li	$v0,51
	la	$a0,questionx2forplayer1
	syscall
	move	$t4,$a0

	bne $t4, $s5, latw
	checkagainw:
	jal increaseby1forplayer1
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j deew
	latw: 
	bne $t4,$s4,lsow
	j checkagainw
	lsow:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	deew:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra


bonusplayer2:

	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)

	li 	$v0, 4 # set up print string syscall
	la	$a0, bonusround
	syscall
#get x1:

#Address(a[i][j]) = B. A. + (i * n + j) * size
	la 	$t1,array

	li 	$v0, 4 # set up print string syscall
	la $a0, row
	syscall 

#row i is $t0
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t0,$v0


	li 	$v0, 4 # set up print string syscall
	la 	$a0, column
	syscall 

#column j is $t2
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t2,$v0

#n 
	li 	$t3,5

	mul 	$t4,$t0,$t3
	add 	$t4,$t4,$t2

	sll 	$t4,$t4,2 #multiplying t4 by 4
	add 	$t4,$t4,$t1 
	lw 	$a0,0($t4)


	move 	$s4,$a0 #x1

	li 	$v0, 4 # set up print string syscall
	la 	$a0, row1
	syscall 

#row i is $t0
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t0,$v0


	li 	$v0, 4 # set up print string syscall
	la 	$a0, column
	syscall 

#column j is $t2
	li 	$v0,5
	syscall
#number will be used in V0
	move 	$t2,$v0

#n 
	li 	$t3,5

	mul 	$t4,$t0,$t3
	add 	$t4,$t4,$t2

	sll 	$t4,$t4,2 #multiplying t4 by 4
	add 	$t4,$t4,$t1 
	lw 	$a0,0($t4)


	move 	$s5,$a0 #x2
	
	#compute function values	
	mul 	$t3, $s4, $s5
	add 	$t2,$s4,$s5

#sw $t2, mid
#sw $t3, c

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 

	move 	$a0, $t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move 	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0, 4 # set up print string syscall
	la	$a0, zero
	syscall 

        	
	li 	$v0,51
	la 	$a0,questionx1forplayer2
	syscall
	move 	$t4,$a0
	
	bne 	$t4, $s4, neeerq
	ccchekcrq:
	jal increaseby1forplayer2
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall
	j frq 
	neeerq:
	bne	$t4,$s5,finalthirdrq
	j ccchekcrq
	finalthirdrq:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	frq:

	li	$v0,51
	la	$a0,questionx2forplayer2
	syscall
	move	$t4,$a0

	bne $t4, $s4, latwq
	checkagainwq:
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j deewq
	latwq: 
	bne $t4,$s5,lsowq
	j checkagainwq
	lsowq:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	deewq:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra
	

linear: 
	addi 	$sp,$sp,-4 
	sw 	$ra,0($sp)

	li	$v0, 4 # set up print string syscall
	la 	$a0, turn
	syscall 
	li 	$v0, 4 # set up print string syscall
	la 	$a0, lin
	syscall 
        
        #create seed for random number generator
  	li 	$v0,30
	syscall
	move $s5,$a0
	andi $s5,$s5,7 #1-7 range 
	
	
        
	jal RAND4
	move 	$a0,$v0 #move randim number into $a0
	li 	$v0, 1  
	move 	$t1,$a0
	syscall     
	
	li 	$v0, 4 # set up print string syscall
	la 	$a0, zero
	syscall 



	li 	$v0, 4 # set up print string syscall
	la 	$a0, p1
	
	#recorded current time on computer in miliseconds in $a0
	li 	$v0,30
	syscall
	move 	$s6,$a0 
	li 	$v0,51
	la 	$a0,question
	syscall
	move 	$t0,$a0
	li 	$v0,30
	syscall
	move 	$s7,$a0 
	#li $v0,5
	#syscall
	sub 	$s3, $s7, $s6 #time it took user to guess in mili seconds
	#number will be used in V0
	
	
	#move $t0,$v0

	#s3 hold time for player 1 to answer


	#compare the input to the random number
	bne 	$t0, $t1, After
	jal increaseby1forplayer1
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j a
After: 
	jal losesound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	syscall

#player2 turn
	a:	

	li 	$v0, 4 # set up print string syscall for player2 turn
	la 	$a0, p2
	syscall 
	li 	$v0, 4 # set up print string syscall "x-"
	la 	$a0, lin
	syscall 
	
	#create seed for random number generator
	li 	$v0,30
	syscall
	move $s5,$a0
	andi $s5,$s5,7
	
	
	#li 	$s5, 3 ## seed
	jal RAND4
	move 	$a0,$v0
	li 	$v0, 1   # 1 is the system call code to show an int number
	move	$t1,$a0
	syscall     # as I said your generated number is at $a0, so it will be printed
	
	
	li	$v0, 4 # set up print string syscall
	la	$a0, zero
	syscall 

	 
#recorded current time on computer in miliseconds in $a0
	li 	$v0,30
	syscall
	move 	$s6,$a0 
	li 	$v0,51
	la 	$a0,question
	syscall
	move 	$t0,$a0
	li 	$v0,30
	syscall
	move 	$s7,$a0 
	sub 	$s4, $s7, $s6 #time it took user to guess in mili seconds
	#number will be used in V0
	#move 	$t0,$v0

#s4 will have the time it took for player2 to answer

#compare input to number 
	bne 	$t0, $t1, next
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j b
next: 
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	syscall 
	jal losesound

b:
	bgt 	$s3,$s4,player1time
	jal 	increaseby1forplayer2
	li 	$v0,4
	la 	$a0,bonuspointplayer2
	syscall 
	j bb
player1time:
	jal increaseby1forplayer1
	li 	$v0,4
	la 	$a0,bonuspointplayer1
	syscall 
bb:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra



quadratic1:

	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)

	li 	$v0, 4 # set up print string syscall
	la 	$a0, r2
	syscall




 #create seed for random number generator
  	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	jal RAND4
	#store random value in $t8
	move 	$t8,$v0
	

	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	jal RAND4
	#store random value in $t9
	move 	$t9,$v0



	#compute function values	
	mul 	$t3, $t8, $t9
	add 	$t2,$t8,$t9


	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 

	move 	$a0, $t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move 	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0,4
	la 	$a0, zero
	syscall 


	li 	$v0,51
	la 	$a0,questionx1forplayer1
	syscall
	move 	$t4,$a0


#compare
	bne 	$t4, $t8, neet
	gooddies:
	jal increaseby1forplayer1
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j ceet
	neet: 
	bne 	$t4, $t9, hfeet
	j 	gooddies
	hfeet:
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	jal losesound
	syscall 

#prompt to enter x2
ceet:
#start timer
	li 	$v0,51
	la 	$a0,questionx2forplayer1
	syscall
	move 	$t4,$a0

#compare
	bne $t4,$t8, lateree
	goodddies:
	jal increaseby1forplayer1
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j d
	lateree:
	bne $t4,$t9,later
	j goodddies
	later: 
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	syscall
	jal losesound
	
#player2 turn	
	d:
	#player2 turn
	li 	$v0, 4 # set up print string syscall
	la 	$a0, p2
	syscall

#create seed for random number generator
  	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	jal RAND4
	#store random value in $t8
	move 	$t8,$v0
	

	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	jal RAND4
	#store random value in $t9
	move 	$t9,$v0

	mul 	$t3, $t9, $t8
	add 	$t2,$t9,$t8



	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 

	move	$a0,$t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move 	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0,4
	la 	$a0, zero
	syscall

        #start timer
	li	$v0,51
	la	$a0,questionx1forplayer2
	syscall
	move	$t4,$a0
	
	#number will be used in V0
	#move $t0,$v0


#compare
	bne 	$t4, $t8, net
	onecheck:
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j e
	net: 
	bne	$t4,$t9,losing
	j onecheck
	losing:
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	jal losesound
	syscall 

#prompt to enetr x2
e:

	li	$v0,51
	la	$a0,questionx2forplayer2
	syscall
	move	$t4,$a0

	bne $t4, $t8, lat
	checkagain:
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j dee
	lat: 
	bne $t4,$t9,lso
	j checkagain
	lso:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

dee:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra


#I'm on line 825
quadratic2:
	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)


	li 	$v0, 4 # set up print string syscall
	la	$a0, r3
	syscall
	
	li	$v0,30
	syscall
	move	$s5,$a0
	andi	$s5,$s5,15
	jal RAND4
	move	$t8,$v0
	
	li	$v0,30
	syscall
	move	$s5,$a0
	andi	$s5,$s5,15
	jal RAND4
	move	$t9,$v0


	mul 	$t3,$t9,$t8
	add 	$t2,$t9,$t8

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 
	
	move	$a0,$t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0,4
	la 	$a0, zero
	syscall
	

	li 	$v0,51
	la 	$a0,questionx1forplayer1
	syscall
	move	$t4,$a0
	

#compare
	bne 	$t4, $t8, neee
	ccchekc:
	jal increaseby1forplayer1
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall
	j f 
	neee:
	bne	$t4,$t9,finalthird
	j ccchekc
	finalthird:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

#enter x2
f:

	li 	$v0,51
	la 	$a0,questionx2forplayer1
	syscall
	move	$t4,$a0
	

	bne 	$t4, $t8, late
	onechecks:
	jal increaseby1forplayer1
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	j g
	syscall 
	late: 
	bne 	$t4, $t9, finals
	j onechecks
	finals:
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	syscall 


g:
#player2 turn
	li 	$v0, 4 # set up print string syscall
	la 	$a0, p2
	syscall

	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,15 #1-7 range 
	jal RAND4
	#store random value in $t8
	move 	$t8,$v0
	

	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,15 #1-7 range 
	jal RAND4
	#store random value in $t9
	move 	$t9,$v0

	mul 	$t3, $t9, $t8
	add 	$t2,$t9,$t8



	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad1
	syscall 

	move	$a0,$t2
	li 	$v0, 1 
	syscall

	li 	$v0, 4 # set up print string syscall
	la 	$a0, quad2
	syscall 

	move 	$a0, $t3
	li 	$v0, 1 
	syscall
	
	li	$v0,4
	la 	$a0, zero
	syscall

        #start timer
	li	$v0,51
	la	$a0,questionx1forplayer2
	syscall
	move	$t4,$a0


	bne 	$t4, $t8,  neeee
	onecheckss:
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j h
	neeee: 
	bne	$t4,$t9,losingss
	j onecheckss
	losingss:
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	jal losesound
	syscall 

h:
	li	$v0,51
	la	$a0,questionx2forplayer2
	syscall
	move	$t4,$a0
	
	bne 	$t4, $t8,  neeeeg
	onecheckssg:
	jal increaseby1forplayer2
	jal winsound
	li 	$v0, 4 # set up print string syscall
	la 	$a0, s
	syscall 
	j hg
	neeeeg: 
	bne	$t4,$t9,losingssg
	j onecheckssg
	losingssg:
	li 	$v0, 4 # set up print string syscall
	la 	$a0, w
	jal losesound
	syscall 
	
	hg:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr $ra




#im on this line
cubic:

	addi 	$sp,$sp,-4
	sw 	$ra,0($sp)

#player 1 turn
	li 	$v0, 4 # set up print string syscall
	la 	$a0, r4

	#create seed 
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	#call random function
	jal RAND4
	move 	$s4,$v0
	
        #create seed 
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	
	jal RAND4
	move 	$s6,$v0
        
        
        #seed
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	jal RAND4
	move 	$s7,$v0


	#random values are stored in s5,s6,s7
	add 	$t3,$s4,$s6
	add 	$t3,$t3,$s7
	#value in $t3
 
 	
	mul 	$t4,$s4,$s6
	mul 	$t5,$s6,$s7
	mul	$t6,$s4,$s7
	
	add	$t7,$t4,$t5
	add	$t7,$t7,$t6
	#value in $t7

	
        
	mul $t8,$s4,$s6
	mul $t8,$t8,$s7
	#value in $t8
	
	

	li $v0, 4 # set up print string syscall
	la $a0, tri1
	syscall 

	move $a0, $t3
	li $v0, 1 
	syscall


	li $v0, 4 # set up print string syscall
	la $a0, tri2
	syscall 

	move $a0, $t7
	li $v0, 1 
	syscall

	li $v0, 4 # set up print string syscall
	la $a0, tri3
	syscall 

	move $a0, $t8
	li $v0, 1 
	syscall
	
	li	$v0,4
	la 	$a0, zero
	syscall



	li $v0,51
	la $a0, questionx1forplayer1
	syscall 
	move $t0,$a0
      
	


	bne $t0, $s4, t
	tts:
	jal increaseby1forplayer1
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j k
	t:
	bne $t0, $s6, ttso
	j tts
	ttso:
	bne $t0, $s7,losingsss
	j tts
	losingsss:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	k:


	li $v0,51
	la $a0, questionx2forplayer1
	syscall 
	move $t0,$a0
 

	bne $t0, $s4, tee
	ttse:
	jal increaseby1forplayer1
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j l
	tee:
	bne $t0, $s6, ttsoe
	j ttse
	ttsoe:
	bne $t0, $s7,losingssse
	j ttse
	losingssse:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

l:

	li $v0,51
	la $a0, questionx3forplayer1
	syscall 
	move $t0,$a0
 

	bne $t0, $s4, teett
	ttsett:
	jal increaseby1forplayer1
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j mee
	teett:
	bne $t0, $s6, ttsoett
	j ttsett
	ttsoett:
	bne $t0, $s7,losingsssett
	j ttsett
	losingsssett:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound


#player2 turn 
mee:
	#create seed 
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	#call random function
	jal RAND4
	#store random value in $s4
	move 	$s4,$v0
	
        #create seed 
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	
	jal RAND4
	#store random value in $s6
	move 	$s6,$v0
        
        
        #seed
	li 	$v0,30
	syscall
	move 	$s5,$a0
	andi 	$s5,$s5,7 #1-7 range 
	
	jal RAND4
	#store random value in $s7
	move 	$s7,$v0


	#random values are stored in s4,s6,s7
	add 	$t3,$s4,$s6
	add 	$t3,$t3,$s7
	#value in $t3
 
 	
	mul 	$t4,$s4,$s6
	mul 	$t5,$s6,$s7
	mul	$t6,$s4,$s7
	
	add	$t7,$t4,$t5
	add	$t7,$t7,$t6
	#value in $t7

	
        
	mul $t8,$s4,$s6
	mul $t8,$t8,$s7
	#value in $t8
	
	

	li $v0, 4 # set up print string syscall
	la $a0, tri1
	syscall 

	move $a0, $t3
	li $v0, 1 
	syscall


	li $v0, 4 # set up print string syscall
	la $a0, tri2
	syscall 

	move $a0, $t7
	li $v0, 1 
	syscall

	li $v0, 4 # set up print string syscall
	la $a0, tri3
	syscall 

	move $a0, $t8
	li $v0, 1 
	syscall
	
	li $v0, 4 # set up print string syscall
	la $a0, zero
	syscall 


	li $v0,51
	la $a0, questionx1forplayer2
	syscall 
	move $t0,$a0



	bne $t0, $s4, tu
	ttsu:
	jal increaseby1forplayer2
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j ku
	tu:
	bne $t0, $s6, ttsou
	j ttsu
	ttsou:
	bne $t0, $s7,losingsssu
	j tts
	losingsssu:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

	ku:


	li $v0,51
	la $a0, questionx2forplayer2
	syscall 
	move $t0,$a0
   

	bne $t0, $s4, teeu
	ttseu:
	jal increaseby1forplayer2
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j lu
	teeu:
	bne $t0, $s6, ttsoeu
	j ttseu
	ttsoeu:
	bne $t0, $s7,losingssseu
	j ttseu
	losingssseu:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound

lu:

	li $v0,51
	la $a0, questionx3forplayer2
	syscall 
	move $t0,$a0
     

	bne $t0, $s4, teettu
	ttsettu:
	jal increaseby1forplayer2
	jal winsound
	li $v0, 4 # set up print string syscall
	la $a0, s
	syscall 
	j meeu
	teettu:
	bne $t0, $s6, ttsoettu
	j ttsettu
	ttsoettu:
	bne $t0, $s7,losingsssettu
	j ttsettu
	losingsssettu:
	li $v0, 4 # set up print string syscall
	la $a0, w
	syscall 
	jal losesound
meeu:
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr $ra
