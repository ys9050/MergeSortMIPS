######################
#                    #
# Project Submission #
#                    #
######################

# Partner1: Callaway, Corey (A10633600)
# Partner2: Shin, Yoonsoo (A10164206)

# Linked list structure
# int data 4 bytes
# node next_address 4 bytes

	.data
printIntro:	.asciiz "The linked list contains:\n"
printSorted:	.asciiz "The sorted linked list contains:\n"
printNL:	.asciiz "\n"
printComma:	.asciiz ", "
arrLen:		.word 500
randnums:	.word 3859,-4698,2684,3580,-107,4685,2850,-2449,-850,-1513,-2140,105,2233,-2255,-4245,2723,4385,-4781,1573,2270,3205,2186,-3573,-4601,-3505,2872,3146,4352,-3905,117,-3086,2223,323,-578,-1371,1228,-585,3545,848,-2233,672,1070,-551,2185,540,-2147,3327,-2468,-1561,4438,146,-4290,-3697,2505,-1186,3404,2836,2229,-3906,3931,-2162,4472,-2467,-301,-46,1628,4990,-2767,-4455,741,-2150,-291,-371,2066,-4070,-3566,-4225,3741,-1629,-4965,643,-2242,-3023,1547,-232,3631,988,-3355,-2687,3596,-1731,1559,3179,3211,-1577,-194,1671,-2274,3655,4451,1322,-3859,-3260,-1541,3965,-1357,-125,3344,-1702,1550,4705,2725,45,569,-1192,-4556,1392,-2905,3719,2989,3775,3113,3894,3698,-4001,3399,-4575,-412,1496,1488,-3,-2256,2242,-3827,-3535,-2522,2837,-3307,-2331,-2763,4856,3323,-4800,646,1505,4187,-4171,4142,693,4669,-3651,-811,-3186,-4490,3600,3045,-1797,-4572,-1617,3526,-1744,1903,4634,-2280,-582,1586,2787,-577,1382,3537,3886,1956,-620,-1354,2237,1787,4546,-3845,-2873,-1088,2101,4266,-2527,1995,3105,-2350,-2009,-4175,-1033,3710,-1355,-1208,-3800,-1142,-964,3603,-1383,-2622,-314,-4221,2203,553,-3585,3100,-1399,2588,678,-195,1262,-2534,-4298,-2759,-448,4708,414,4627,-1304,-4573,-4881,4181,-4279,2012,4711,2137,2329,2828,-1125,2214,-166,883,1649,4519,-3457,294,4509,2569,-4022,2888,-2342,2348,3657,2679,3581,3570,1919,4868,-4985,4343,1466,214,-849,1027,4047,-460,3345,855,31,375,2566,-3337,-1989,1146,708,-1239,-3117,-3220,-3083,3817,1964,4139,2201,-407,2692,-1464,-4887,-799,-355,3591,-3423,-67,-3839,1622,-4733,383,-1414,1740,-3761,4154,-1704,4398,1355,-4219,658,4790,-3878,-4422,-3606,3062,-2250,-4841,3799,-2976,602,761,-4849,819,1295,-2700,-3514,-3681,-4707,-131,-4738,4663,3801,849,-2896,-573,3883,4100,1709,-3075,-509,-1499,-4793,-4260,-1290,-36,4875,-2380,2002,1521,-2604,-4867,-2710,4857,-2835,2838,-498,4226,-239,3732,4169,928,3060,4344,4821,4439,-4033,4,-4528,1857,-4866,2834,-2407,-1537,-3042,-1062,3094,-4874,2287,2083,-4503,-116,1170,86,3216,4567,-745,-863,-3680,3670,-2206,-333,3348,4814,1017,357,-2792,1345,577,845,4444,3625,-2703,3840,498,-433,4683,4935,-1569,-3901,-1263,-2236,-4606,-4844,-4603,4516,3663,4297,-2744,-3746,-2926,-2367,-1039,2527,4102,3666,-1473,-4128,-2794,-2807,-8,2366,-1990,-2311,1940,2150,4499,-3286,-2287,1548,-3892,2084,2498,1873,1503,-3804,3171,2108,1088,-2292,3137,-3214,-2851,-4695,996,-2770,3731,1095,1714,1743,2668,2259,3662,-1416,810,4832,-127,-3842,4355,-3812,801,1432,-3109,-570,814,-2559,4568,-2563,3954,2533,-218,922,-1103,293,-4535,3676,1657,1315,-3545,2621,2113,2475,-3247,4964,-3469,3333,-918,-2469,-1246,2429,-4675,3789,-640,-3135,797,-4116,506,1400,-2750,-3174,22,3193,3358,40,1103,-1830,574,1752

	.globl main
	.globl root
	.globl push
	.globl mergeSort
	.globl mergeUp
	.globl splitHalf
	.globl printList
	.globl importList

	.text
############
#   main   #
############

main:

	# (your code here)
	la $a0, randnums 	# grab array starting memory address 
	
	la $t1, arrLen		# grab the array length from memory
	lw $a1, 0($t1)
	
	#addi $a1, $zero, 20 	# load the first 20 elements for testing

	addi $sp, $sp, -4 	# shift stack register and push 
	sw $ra, 0($sp)	  	# $ra onto it

	jal importList 		# import the list from the given array
	
	addu $s7, $v0, $0 	#save linked list head
	
	la $a0, printIntro 	# print out preamble to printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0 	# restore $a0 to linked list header
			  	# before calling printList

	jal printList

	addu $a0, $s7, $0 	# no guarantees printList didn't affect
			  	# $a0, so reload from saved point
	jal mergeSort


	addu $s7, $v0, $0 	#save the new linked list head 
	
	la $a0, printSorted 	# print out preamble to sorted printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0 	# restore $a0 to linked list header
			  	# before calling printList

	jal printList
	
	lw $ra, 0($sp)	  	# pop the stack to restore $ra 
	addi $sp, $sp, 4  	# increment stack pointer to release memory for reuse
	
	# return to caller
	jr 	$ra



#################
#   root_node   #
#################

root:
	# (Establishes the original node)
	# $a0 holds the value to store
	# use sbrk to find the next free part of heap 
	# $v0 returns the new head of the linked list
	
	addiu $t0, $a0, 0 		#stores element of the array into $t0 so that $a0 can be used by syscall
	
	addiu $v0, $zero, 9 		#instruciont code for sbrk(memory allocation)
	addiu $a0, $zero, 8 		#instruction to creat 8 bytes of free memory
	syscall				#1) Allocate memory for node via sbrk
	
	sw $t0, 0($v0) 			#storing the value to be placed in node to data
	sw $zero, 4($v0) 		#Storing NULL as the next address of the linked list
					#2) The value of node->next should be NULL

	# return to caller
	jr 	$ra


#################
#   push_node   #
#################

push:

	# Pushes a new node on to the top of the linked list
	# use sbrk to find the next free part of heap 
	# $a0 holds the value to store
	# $a1 holds the head of the linked list
	# $v0 holds the new head of the linked list
	
	addiu $t0, $a0, 0		#Storing the element of the array into $t0 so that $a0 can be used by syscall
	
	addiu $v0, $zero, 9 		#instruciont code for sbrk(memory allocation)
	addiu $a0, $zero, 8 		#instruction to creat 8 bytes of free memory
	syscall				#1) Allocate memory for node via sbrk

	sw $t0, 0($v0) 			#storing the value to be placed in node to data
	sw $a1, 4($v0)			#storing the head address of the linked list
					#2) The value of node->next should be the linked list old head address
	# return to caller
	jr 	$ra


#################
#  Merge_Sort   #
#################

mergeSort:

	# Break linked list into fragments recursively and then
	# reassemble nodes into sequentially increasing linked list
	# This sort must maintain stability
	# $a0 holds the address of the top of the linked list
	# $v0 holds the header of the sorted merge
	
	#Stack organization
	addiu $sp, $sp, -32
 	sw $ra, 20($sp)
 	sw $fp, 16($sp)
 	addiu $fp, $sp, 32
	
	#1) if(head = NULL OR head-> = NULL) return head
	beq $a0, $zero, NULLmS 
	lw $t0, 4($a0)
	beq $t0, $zero, NULLmS

	#2.1) Call splitHalf
	jal splitHalf
	
	#2.2) Returns the two heads of the now-split linked list
	addi $a0, $v0, 0		#head of list A = a0
	addi $s0, $v1, 0		#head of list B = s0
	
	#Stack organization to save the head of the list B
	addiu $sp, $sp, -32
 	sw $fp, 16($sp)
 	sw $s0, 12($sp)
 	addi $fp, $sp, 32

	#3) Call mergeSort on first sub-list 
	jal mergeSort 			#output v0 = head address of the first sub-list
	
	#Stack organization to restore the head of the list B
  	lw $fp, 16($sp)
 	lw $s0, 12($sp)
 	addiu $sp, $sp, 32

	#Organzing registers to call mergeSort on second sub-list	
	addi $t0, $s0, 0		#temporarily storing second head address to $t0
	addi $a0, $s0, 0		#setting up second head list as $a0 for another mergeSort
	addi $s0, $v0, 0		#storing the first sorted head of the linked list
	
	#Stack organization to save the head of the list A	
	addiu $sp, $sp, -32
 	sw $fp, 16($sp)
 	sw $s0, 12($sp)
 	addi $fp, $sp, 32
	
 	#4) Call mergeSort on second sub-list
	jal mergeSort 			#output a v0 = head address of the second sub-list
	
  	#Stack organizations to restore the head of the list A
	lw $fp, 16($sp)
 	lw $s0, 12($sp)
 	addiu $sp, $sp, 32

	#Organizing registers to call mergeUp	
	addi $a0, $s0, 0		#a0 = head address of the first sub-list
	addi $a1, $v0, 0		#a1 = head address of the second sub-list
	
	#5) Call mergeUp on the two sub-list
	jal mergeUp
	
	#6) Return head of merged list
	j endmS

NULLmS:
	addi $v0, $a0, 0		#returns head

endmS:
	
	#pull out orginal RA
	lw $ra, 20($sp)
 	lw $fp, 16($sp)
 	addiu $sp, $sp, 32
	
	# return to caller
	jr 	$ra

###################
#     mergeUp     #
###################

mergeUp:
	# Merges the two sublists into a single sorted list
	# $a0 contains head address of first sub-list (A)
	# $a1 contains head address of second sub-list (B)
	# $v0 returns the head address of the combined list
	

	beq $a0, $zero, retB	 	#1) if(A = NULL) return B
	beq $a1, $zero, retA 		#2) else if(B = NULL) return A
	
	#3) if(A-Data <= B-data)	
	lw $t0, 0($a0) 			#$t0 = A-data
	lw $t1, 0($a1) 			#$t1 = B-data
	
	bne $t0, $t1, setlessthan 	#if A-data and B-Data are not equal, continue to slt
	
	addi $t2, $zero, 1 		#if A-data and B-Data are equal, then set $t2 is 1
	j passlessthan 			#if a-data == B-data go next element of A
	
setlessthan:
	slt $t2, $t0, $t1 		#if $t0 < $t1, $t2 is 1.
	beq $t2, $zero, else 		#if A-data is not less than or equal to B-data, then go to else 
	
passlessthan:

	#3a) head = A
	
	#Stack organization to save $a0 and $a1 value
	addiu $sp, $sp, -32
 	sw $ra, 20($sp)
 	sw $fp, 16($sp)
 	sw $a0, 12($sp)
 	sw $a1, 8($sp)
 	addi $fp, $sp, 32

	lw $a0, 4($a0)			#loading head next

	jal mergeUp #v0 will return new head-next

	#Stack organization to load previous $a1 and $a1 value
 	lw $ra, 20($sp)
 	lw $fp, 16($sp)
 	lw $a0, 12($sp)
 	lw $a1, 8($sp)
 	addiu $sp, $sp, 32
	
	#3b) head->next = mergeUp(A,B->next)
	sw $v0, 4($a0)			

 	addi $v0, $a0, 0		#returns $a0, the new head address
 	j endMergeUp

else:
	#4a) head = B 	

	#Stack organization to save $a0 and $a1 value
	addiu $sp, $sp, -32
 	sw $ra, 20($sp)
 	sw $fp, 16($sp)
 	sw $a0, 12($sp)
 	sw $a1, 8($sp)
 	addi $fp, $sp, 32 

	lw $a1, 4($a1)			#loading head next

	jal mergeUp #v0 will return new head-next
	
	#Stack organization to load previous $a0 and $a1 value
 	lw $ra, 20($sp)
 	lw $fp, 16($sp)
 	lw $a0, 12($sp)
 	lw $a1, 8($sp)
 	addiu $sp, $sp, 32

	#4b) head->next = mergeUp(A->next,B)
	sw $v0, 4($a1)			
	
	addi $v0, $a1, 0		#returns $a1, the new head address
 
	j endMergeUp

retB:
 	addi $v0, $a1, 0
 	j endMergeUp
 	
retA:
 	addi $v0, $a0, 0
	endMergeUp:
	#end 
	
	# return to caller
	jr 	$ra

#############
# splitHalf #
#############

splitHalf:

	# Splits a linked list into two equal halves by 
	# advancing through the linked list at two different
	# speeds (fast and slow).
	# $a0 contains head address linked list
	# $v0 returns the head address of first sub-list
	# $v1 returns the head address of second sub-list

	########## USES DIFFERENT ALGORITHM FROM THE PSEUDO CODE ##########

	addi $t0, $zero, 0 		#initialize $t0 as slow current address
	addi $t1, $zero, 0 		#initialize $t1 as slow linked element
 	addi $t2, $zero, 0 		#initialize $t2 as fast current address
 	addi $t3, $zero, 0 		#initialize $t3 as fast linked element

	addi $v0, $a0, 0 		#$a0 is always going to be head address of the first linked list
	addi $t0, $a0, 0 		#starting slow current address
	addi $t2, $a0, 0		#starting fast current address


	#There is counter slow and counter fast in the loop.
	#Counter fast counts twice as fast as the slow, while checking that the next address for both counter does not equal NULL.
	#If the next address equals NULL, 1) Assign $v1 as head of the second head address, 2) Assigns slow->next as NULL (Check last:)
	
loopsH:
	#slow
 	#The first time running this loop, acts as if(head = NULL Or head->next = NULL) return (head, NULL)
	
	beq $t0, $zero, last 		#if head is NULL, go to last, where it will assign $v1 (head address of second sub-list)
 	lw $t1, 4($t0) 			#loads the address of 32bits past first head of address to t1 (Next address into t1)
 	beq $t1, $zero, last 		#if the next address content is NULL, go to last,  where it will assign $v1 (head address of second sub-list)
 		
	#fast
	beq $t2, $zero, last 		#if head is NULL go to last
	lw $t3, 4($t2) 			#loads the address of 32bits past first head of address to t3 (Next address into t3)
	beq $t3, $zero, last 		#if the next address is NULL, go to last, where it will assign $v1 (head address of second sub-list)
	addi $t2, $t3, 0 		#overwrite pointer address from t3 to t2 (Preparing for the next operation)
	lw $t3, 4($t2) 			#loads the address of 32bits past first head of address to t3 (Next address into t3)
	beq $t3, $zero, last 		#Repeat of the last 4 lines, since fast progresses twice as fast as slow
	addi $t2, $t3, 0 		#overwrite pointer address from t3 to t2 (Preparing for the next loop)
	addi $t0, $t1, 0		#overwrite pointer address from t1 to t0 (Preparing for the next loop)
	j loopsH

last: 
	#now return v1 (middle address) and save null under pointer address
	addi $v1, $t1, 0 		#v1 returns head of the second head address
	sw $0, 4($t0)			#slow->next is now NULL
	
	# return to caller
	jr $ra

################
#  print_list  #
################

printList:

	# Prints the data in list from head to tail
	# $a0 contains head address of list

	addu $t0, $a0, $zero 		# since $a0 is used for syscalls, 
					# move pointer to temp register

printloop:

	beq $t0, $zero, printDone  	# jump out once end of list found
	lw $t1, 4($t0)		   	# grab next pointer and store in $t1
	lw $a0, 0($t0)		   	# grab value at present node
	addiu $v0, $zero, 1	   	# prepare to print integer
	syscall
	
	la $a0, printComma	   	# load comma and print string
	addiu $v0, $zero, 4
	syscall
	
	addu $t0, $t1, $zero	  	# move next pointer into $t0 for next loop
	j printloop

printDone:
	la $a0, printNL			# load newling character and print
	addiu $v0, $zero, 4
	syscall

	# return to caller
	jr 	$ra

#################
#  import_list  #
#################

importList:
	
	# $a0 holds array address
	# $a1 holds array length
	# $v0 returns header to linked list
	
	addi $sp, $sp, -4 		#Stack organization by 4 bits
	sw $ra, 0($sp) 			#Save $ra to the stack
	addi $fp, $sp, 4		#Stack organization by 4 bits

	#1) if(Address = NULL OR size = 0) return NULL
	beq $a0, $zero, NULLiL 		#if the address of the array is 0, skip to NULLiL
	beq $a0, $zero, NULLiL 		#if the size of the array is 0, skip to NULLiL	

	#stack saves address of the array
	addiu $sp, $sp, -32
	sw $ra, 20($sp)
	sw $fp, 16($sp)
	sw $a0, 8($sp)
 	addi $fp, $sp, 32

	#2.1) Grab first element in the array
	lw $a0, 0($a0) 			#grab the first element into $a0
	
	#2.2) Decrement the size counter
	addiu $a1, $a1, -1		

	#3) Calls root to start linked list	
	jal root			
	
	#Reloading the stack elements	
	lw $ra, 20($sp)
	lw $fp, 16($sp)
	lw $a0, 8($sp)
	addiu $sp, $sp, 32
	
	#a0 hold the address of the array
	addi $t0, $a1, 0 		#change the counter register to $t0
	

	#4) while(Size>0)
loopiL:
	
	addi $a1, $v0, 0		#change the head of the linked list to $a1
	addi $a0, $a0, 4		#array add address by 4 bytes
		
	#stack saves address of the array
	addi $sp, $sp, -32
	sw $a1, 24($sp)
	sw $a0, 20($sp)
	sw $t0, 16($sp)
	sw $ra, 12($sp)
	sw $fp, 8($sp)
 	addi $fp, $sp, 32	

	#4a) Grab the next element in the array
	lw $a0, 0($a0)	

	#4b) Push element onto the linked list
	jal push	

	#5) return head of linked list

	#Reloading the stack elements	
	lw $a1, 24($sp)
	lw $a0, 20($sp)
	lw $t0, 16($sp)
	lw $ra, 12($sp)
	lw $fp, 8($sp)
	addi $sp, $sp, 32
		
	#4c) Decrement Size
	addi $t0, $t0, -1 		#decrement size counter
	
	#while (Size > 0), loopiL
	bne $t0, $zero, loopiL		#while size>0, loop
		
	j endish
	


NULLiL:
	addi $v0, $zero, 0 		#if address is NULL or size is zero, return NULL to $v0
	
endish:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	addi $fp, $sp, -4
	# return to caller
	jr $ra

	




