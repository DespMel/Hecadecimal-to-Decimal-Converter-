#MELAKI DESPOINA 3140116

.data
	enterTheNumber: .asciiz "\n Enter the number: "
	theNumberIs: .asciiz "\n The number after the conversion is: "





.text
.globl main

main:

		#prints "enter the number:"
		li $v0, 4
		la $a0,enterTheNumber 
		syscall
		
		#reads the first char
		li $v0,12
		syscall
		
		#store the first char that the user enters in $t0
		move $t0,$v0 
		
		#reads the second char
		li $v0,12 
		syscall
		
		#store the second char that the user enters in $t6
		move $t6,$v0 
		
		#Sll $t0 3 bytes(24 bit) and store the result in $s0
		sll $s0,$t0,24
		
		#Sll $t6 2 bytes (16 bit) and store the result in $s1 
		sll $s1,$t6,16
		
		#or to registers $s0 and $s1 and store in $t7
		# So, $t7 has first and second char now in his first 16bits
		or $t7,$s0,$s1
		
		#reads the third char
		li $v0,12 
		syscall
		
		#store the third char tha the user enters in $t3
		move $t3,$v0 
		
		#reads the fourth char
		li $v0,12 
		syscall
		
		#store the fourth char that the user enters in $t4
		move $t4,$v0 
		
		#Sll $t3 1 byte (8 bit) and store the result in $s2
		sll $s2,$t3,8
		
		#or to registers $s2 and $t4 and store the result in $t5
		#So, $t5 has third and fourth char now in his last 16bits
		or $t5,$s2,$t4
		
		#Final or to pack the 4 characters that the user enters in register $t1
		or  $t1,$t7,$t5
		
		# $t0=0, $t8=0
		li $t0,0
		li $t8,0
		
		#It's a loop.
		#Repetition 4 times
		#When the loop is branch to label finalResult
		#else do the instructions below :
firstLoop:	bgt $t0,3,finalResult
		
		#store tha last byte of $t1 in register $t2 using and with mask 255
		and $t2,$t1,255 
		
		#Srl $t1 8bits (1 byte)
		srl $t1,$t1,8 
		
numberOrLetter:	
		#if $t2 is greater than 58, it means that the value in $t2 is a letter 
		#So, if it's true, branch to label isALetter
		bgt $t2,58,isALetter
		#else if it is not true,($t2<58), it means that the value in $t2 is a number.
		#So,we have to subtract 48 from register $t2 and store the result in $t2
		sub $t2,$t2,48 
		j calculate
		
isALetter:	#The value in $t2 is a letter, so we subtract 55 from register $t2 and store the result in $t2
		sub $t2,$t2,55

next:
		#$t4=1 , $t5=1
		li $t4,1 
		li $t5,1 
		
calculate:	#calculate the powers of 16 with loop
		bgt $t4,$t0,multiply
		mul $t5,$t5,16
		
		add $t4,$t4,1 # $t4+=1
		j calculate
		
	      #after the multiplication of powers, store the sum in $t8
multiply:      mul $t3,$t2,$t5
	       add $t8,$t8,$t3
	       add $t0,$t0,1 #$t0+=1
	       j firstLoop
             
finalResult: 		
 		#prints "the number after the conversion is:"
 		li $v0, 4
		la $a0,theNumberIs 
		syscall
 
 		#prints the final result of the conversion of the number
 		li $v0,1
  	        move $a0,$t8
 		syscall
 		 
 		#exit the program
		li $v0,10
		syscall

 		 
 		 
 		 
 		 
 		
		
		
	
		
	
		
		
		
	
		
		
						
		
		
		
