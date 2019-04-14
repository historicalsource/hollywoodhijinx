

	.FUNCT	CLOSET-HOLE-PSEUDO
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSO,PEG-0 \?ELS10
	ADD	SCORE,10 >SCORE
	CALL	ROB,PLAYER,HEART-OF-MAZE
	FSET?	RING,WORNBIT \?CND11
	MOVE	RING,PLAYER
?CND11:	FSET?	TOUPEE,WORNBIT \?CND14
	MOVE	TOUPEE,PLAYER
?CND14:	FSET?	MASK,WORNBIT \?CND17
	MOVE	MASK,PLAYER
?CND17:	CALL	DEQUEUE,I-SANDS-OF-TIME
	CALL	DEQUEUE,I-NOISE
	CALL	QUEUE,I-AUNT,2
	PRINTI	"You put"
	CALL	TPRINT,PEG-0
	PRINTI	" in the hole and the closet door slams shut. Without warning, the floor drops out from under you! You fall for several seconds then land with a bone-crunching thud, dropping everything you're holding. You slide down a twisting, slippery slide and are dumped into a room filled with props.

You look around the room and can't believe what your eyes are seeing. There is Aunt Hildegarde! She's tied to the conveyor belt of a whirling buzz saw and a man is standing over her. Aunt Hildegarde sees you and screams. The man turns and you immediately recognize your childhood nemesis: Cousin Herman."
	CRLF	
	CRLF	
	CALL	QUEUE,I-HERMAN-ATTACK,2
	CALL	GOTO,PROP-VAULT
	RSTACK	
?ELS10:	PRINTI	"The "
	CALL	DPRINT,PRSO
	PRINTR	" won't fit in the hole."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"You see nothing but darkness."


	.FUNCT	CLOSET-F,RARG,DOOR
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	WHICH-DOOR? >DOOR
	PRINTI	"You're in a small closet. Mounted at an angle on the back wall of the closet are three coat pegs. To the left of the first peg there is a hole the size of a peg. To the right of the third peg there is a peg which has been sawed-off, flush with the wall. The door to the north is "
	FSET?	DOOR,OPENBIT \?ELS8
	PRINTI	"open"
	JUMP	?CND6
?ELS8:	PRINTI	"closed"
?CND6:	PRINTC	46
	RTRUE	


	.FUNCT	PEG-5-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's what's left of a coat peg. It looks as if someone sawed off the peg."
?ELS5:	EQUAL?	PRSA,V?PULL \FALSE
	PRINTR	"There's nothing to pull -- it's sawed-off."


	.FUNCT	CLOSET-EXIT-F,DOOR
	CALL	WHICH-DOOR? >DOOR
	FSET?	DOOR,OPENBIT /?ELS5
	CALL	THIS-IS-IT,DOOR
	CALL	ITS-CLOSED,DOOR
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS7
	RETURN	CELLAR
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	RETURN	FOYER
?ELS9:	RETURN	UPSTAIRS-HALL-MIDDLE


	.FUNCT	WHICH-DOOR?
	EQUAL?	HERE,CLOSET \?ELS5
	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS10
	RETURN	CELLAR-CD
?ELS10:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS12
	RETURN	FOYER-CD
?ELS12:	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS14
	RETURN	UPSTAIRS-CD
?ELS14:	RETURN	ATTIC-CD
?ELS5:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS23
	RETURN	FOYER-CD
?ELS23:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS25
	RETURN	UPSTAIRS-CD
?ELS25:	RETURN	ATTIC-CD


	.FUNCT	PROP-VAULT-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a vault filled with props. You can see Aunt Hildegarde tied to a buzz saw. Cousin Herman is here, thinking of something rotten to do to you. To the east there is a chute."
	RTRUE	


	.FUNCT	CHUTE-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?ELS5
	PRINTR	"The chute leads down into darkness."
?ELS5:	EQUAL?	PRSA,V?ENTER \?ELS7
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS7:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,CHUTE \FALSE
	REMOVE	PRSO
	PRINTI	"You toss"
	CALL	TPRINT,PRSO
	PRINTR	" in the chute."


	.FUNCT	TO-CHUTE
	ZERO?	HERMAN-DOWN /?ELS5
	PRINTI	"Haven't you forgotten something?"
	CRLF	
	RFALSE	
?ELS5:	PRINTI	"Cousin Herman jumps in front of the chute then punches you in the stomach."
	CRLF	
	RFALSE	


	.FUNCT	CLOSET-REF-F
	EQUAL?	PRSA,V?SEARCH,V?ENTER,V?LOOK-INSIDE \?ELS5
	EQUAL?	HERE,CLOSET-TOP \?ELS5
	PRINTR	"You can't enter the closet from here."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?ELS9
	EQUAL?	HERE,CLOSET \?ELS9
	CALL	V-LOOK
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE \?ELS13
	EQUAL?	HERE,CLOSET /?ELS13
	EQUAL?	CLOSET-FLOOR,HERE \?ELS20
	PRINTR	"You'll have to enter the closet first."
?ELS20:	PRINTR	"You see an empty shaft."
?ELS13:	EQUAL?	PRSA,V?SEARCH \?ELS24
	CALL	PERFORM,V?SEARCH,GLOBAL-ROOM
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?OPEN \?ELS26
	EQUAL?	HERE,CLOSET \?ELS31
	CALL	WHICH-DOOR?
	JUMP	?CND27
?ELS31:	EQUAL?	HERE,FOYER \?ELS33
	PUSH	FOYER-CD
	JUMP	?CND27
?ELS33:	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS35
	PUSH	UPSTAIRS-CD
	JUMP	?CND27
?ELS35:	EQUAL?	HERE,CELLAR \?ELS37
	PUSH	CELLAR-CD
	JUMP	?CND27
?ELS37:	PUSH	ATTIC-CD
?CND27:	CALL	PERFORM,V?OPEN,STACK
	RTRUE	
?ELS26:	EQUAL?	PRSA,V?CLOSE \?ELS41
	EQUAL?	HERE,CLOSET \?ELS46
	CALL	WHICH-DOOR?
	JUMP	?CND42
?ELS46:	EQUAL?	HERE,FOYER \?ELS48
	PUSH	FOYER-CD
	JUMP	?CND42
?ELS48:	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS50
	PUSH	UPSTAIRS-CD
	JUMP	?CND42
?ELS50:	EQUAL?	HERE,CELLAR \?ELS52
	PUSH	CELLAR-CD
	JUMP	?CND42
?ELS52:	PUSH	ATTIC-CD
?CND42:	CALL	PERFORM,V?CLOSE,STACK
	RTRUE	
?ELS41:	EQUAL?	PRSA,V?EXIT,V?DISEMBARK \?ELS56
	CALL	DO-WALK,P?OUT
	RSTACK	
?ELS56:	EQUAL?	PRSA,V?ENTER \FALSE
	EQUAL?	HERE,CLOSET \?ELS63
	PRINTR	"Look around."
?ELS63:	CALL	DO-WALK,P?IN
	RSTACK	


	.FUNCT	PEGS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"There are three pegs mounted at an angle to the wall. To the left of the first peg is a hole the size of a peg. To the right of the third peg you can see where a peg has been sawed-off, flush with the wall."
?ELS5:	EQUAL?	PRSA,V?PUSH,V?PULL,V?MOVE /?THN8
	EQUAL?	PRSA,V?PUSH-DOWN,V?LOWER \FALSE
?THN8:	PRINTR	"You try to pull down all three pegs at once. They won't budge, but the closet makes a grinding noise."


	.FUNCT	PEG-F
	EQUAL?	PRSA,V?PUSH,V?PULL,V?MOVE /?THN6
	EQUAL?	PRSA,V?PUSH-DOWN,V?LOWER \?ELS5
?THN6:	EQUAL?	PRSO,BUCKET-PEG \?ELS12
	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?ELS12
	PRINTI	"The bucket is already holding"
	CALL	TPRINT,PRSO
	PRINTR	" down."
?ELS12:	PRINTI	"You pull the peg down to a horizontal position."
	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?CND17
	PRINTI	" You hear a grinding noise."
?CND17:	CRLF	
	CRLF	
	PRINTI	"As you release the peg, it pops back into its original 45-degree position."
	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?ELS24
	CRLF	
	RTRUE	
?ELS24:	PRINTC	32
	CALL	ELEVATOR-OPERATOR,PRSO
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?HANG-UP \?ELS28
	EQUAL?	PRSI,PEG-3,PEG-2,PEG-1 \?ELS28
	EQUAL?	PRSO,BUCKET /?ELS28
	MOVE	PRSO,HERE
	PRINTI	"The "
	CALL	DPRINT,PRSO
	PRINTR	" slips off and falls to the floor."
?ELS28:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?ELS35
	PRINTI	"The "
	CALL	DPRINT,PRSO
	PRINTI	" is in a horizontal position with a bucket hanging on it."
	JUMP	?CND33
?ELS35:	EQUAL?	PRSO,BUCKET-PEG \?ELS37
	PRINTI	"The "
	CALL	DPRINT,PRSO
	PRINTI	" is pointing up at an angle with a bucket hanging on it."
	JUMP	?CND33
?ELS37:	PRINTI	"You see a worn coat peg mounted at an angle."
?CND33:	CRLF	
	RTRUE	


	.FUNCT	PEG-0-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's a worn coat peg."


	.FUNCT	ELEVATOR-OPERATOR,PEG
	EQUAL?	HERE,FOYER,CELLAR,UPSTAIRS-HALL-MIDDLE /?THN4
	EQUAL?	HERE,ATTIC,SHAFT-BOTTOM \?CND1
?THN4:	PRINTI	"The closet door swings shut by itself."
	CRLF	
?CND1:	EQUAL?	PEG,PEG-1 \?ELS12
	EQUAL?	CLOSET-FLOOR,CELLAR /?THN9
?ELS12:	EQUAL?	PEG,PEG-2 \?ELS14
	EQUAL?	CLOSET-FLOOR,FOYER /?THN9
?ELS14:	EQUAL?	PEG,PEG-3 \?ELS8
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS8
?THN9:	EQUAL?	HERE,CLOSET,CLOSET-TOP \?CND6
	EQUAL?	HERE,CLOSET \?ELS22
	CALL	WHICH-DOOR?
	FSET?	STACK,OPENBIT \?ELS25
	PRINTI	"The closet door swings shut and you"
	JUMP	?CND20
?ELS25:	PRINTI	"You"
	JUMP	?CND20
?ELS22:	CALL	WHICH-DOOR?
	FSET?	STACK,OPENBIT \?ELS32
	PRINTI	"The shaft door swings shut and you"
	JUMP	?CND20
?ELS32:	PRINTI	"You"
?CND20:	PRINTI	" feel the closet"
	EQUAL?	HERE,CLOSET /?CND35
	PRINTI	" ceiling"
?CND35:	PRINTI	" vibrate, then stop."
	CRLF	
	JUMP	?CND6
?ELS8:	EQUAL?	HERE,CLOSET,CLOSET-TOP \?ELS42
	EQUAL?	HERE,CLOSET /?CND43
	CRLF	
?CND43:	PRINTI	"The closet "
	EQUAL?	HERE,CLOSET-TOP \?CND46
	PRINTI	"ceiling "
?CND46:	PRINTI	"begins to shake and rattle a bit"
	EQUAL?	HERE,CLOSET,CLOSET-TOP \?CND49
	CALL	WHICH-DOOR?
	FSET?	STACK,OPENBIT \?CND49
	PRINTI	" as the door swings shut"
?CND49:	PRINTI	". You feel your stomach "
	EQUAL?	PEG,PEG-3 \?ELS56
	PRINTI	"drop to your knees as the closet "
	EQUAL?	HERE,CLOSET /?ELS59
	PRINTI	"moves up. You enter the top of the shaft, then the closet stops."
	CRLF	
	CRLF	
	CALL	GOTO,CLOSET-TOP
	JUMP	?CND6
?ELS59:	PRINTI	"moves up, then stops."
	CRLF	
	JUMP	?CND6
?ELS56:	EQUAL?	PEG,PEG-2 \?ELS63
	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS63
	PRINTI	"drop to your knees as the closet "
	EQUAL?	HERE,CLOSET /?CND66
	PRINTI	"floor "
?CND66:	PRINTI	"moves up, then stops."
	CRLF	
	EQUAL?	HERE,CLOSET /?CND6
	CRLF	
	CALL	GOTO,CLOSET-TOP
	JUMP	?CND6
?ELS63:	EQUAL?	PEG,PEG-2 \?ELS73
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS73
	PRINTI	"rising to your throat as the closet "
	EQUAL?	HERE,CLOSET /?CND76
	PRINTI	"floor "
?CND76:	PRINTI	"moves down, then stops."
	CRLF	
	EQUAL?	HERE,CLOSET /?CND6
	CRLF	
	CALL	GOTO,CLOSET-TOP
	JUMP	?CND6
?ELS73:	PRINTI	"rising to your throat as the closet "
	EQUAL?	HERE,CLOSET /?CND84
	PRINTI	"floor "
?CND84:	PRINTI	"moves down, then stops."
	CRLF	
	EQUAL?	HERE,CLOSET /?CND6
	CRLF	
	CALL	GOTO,CLOSET-TOP
	JUMP	?CND6
?ELS42:	EQUAL?	HERE,SHAFT-BOTTOM \?CND6
	EQUAL?	PEG,PEG-1 \?CND6
	CALL	JIGS-UP,STR?216
?CND6:	EQUAL?	PEG,PEG-1 \?ELS96
	SET	'CLOSET-FLOOR,CELLAR
	JUMP	?CND94
?ELS96:	EQUAL?	PEG,PEG-2 \?ELS98
	SET	'CLOSET-FLOOR,FOYER
	JUMP	?CND94
?ELS98:	SET	'CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE
?CND94:	FCLEAR	ATTIC-CD,OPENBIT
	FCLEAR	UPSTAIRS-CD,OPENBIT
	FCLEAR	FOYER-CD,OPENBIT
	FCLEAR	CELLAR-CD,OPENBIT
	RTRUE	


	.FUNCT	BUCKET-F,OARG=0,FULL?=0
	IN?	PORTABLE-WATER,BUCKET /?PRD1
	PUSH	0
	JUMP	?PRD2
?PRD1:	PUSH	1
?PRD2:	SET	'FULL?,STACK
	ZERO?	OARG /?ELS7
	ZERO?	BUCKET-PEG /FALSE
	EQUAL?	OARG,M-OBJDESC? /TRUE
	CRLF	
	PRINTI	"A "
	PRINTD	BUCKET
	PRINTI	" is hanging from"
	CALL	TPRINT,BUCKET-PEG
	IN?	PORTABLE-WATER,BUCKET \?CND18
	PRINTI	". The bucket "
	CALL	DESCRIBE-WATER-LEVEL
?CND18:	PRINTC	46
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?HANG-UP,V?PUT-ON \?ELS24
	EQUAL?	PRSI,PEG-3,PEG-2,PEG-1 \?ELS24
	SET	'BUCKET-PEG,PRSI
	FSET	BUCKET,TRYTAKEBIT
	MOVE	BUCKET,HERE
	IN?	PORTABLE-WATER,BUCKET \?CND27
	FSET	PORTABLE-WATER,NDESCBIT
?CND27:	IN?	PORTABLE-WATER,BUCKET \?ELS38
	GRTR?	AMOUNT-OF-WATER,10 /?THN35
?ELS38:	CALL	WEIGHT,BUCKET
	GRTR?	STACK,20 \?ELS34
?THN35:	FSET	BUCKET,BUCKET-PEG-DOWN-BIT
	PRINTI	"As you hang"
	CALL	TPRINT,BUCKET
	PRINTI	" on"
	CALL	TPRINT,PRSI
	PRINTR	", the peg lowers to a horizontal position and you feel the closet begin to vibrate."
?ELS34:	PRINTI	"You hang"
	CALL	TPRINT,BUCKET
	PRINTR	" on the peg."
?ELS24:	EQUAL?	PRSA,V?TAKE \?ELS42
	EQUAL?	PRSO,BUCKET \?ELS42
	FSET?	BUCKET,TRYTAKEBIT \?ELS42
	CALL	ITAKE
	ZERO?	STACK /TRUE
	FSET?	BUCKET,WETBIT \?ELS51
	FCLEAR	BUCKET,WETBIT
	MOVE	PORTABLE-WATER,BUCKET
	SET	'AMOUNT-OF-WATER,26
	PRINTI	"Taken."
	CRLF	
	CALL	QUEUE,I-DRIP,1
	RSTACK	
?ELS51:	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?ELS53
	FCLEAR	BUCKET,TRYTAKEBIT
	FCLEAR	BUCKET,BUCKET-PEG-DOWN-BIT
	FCLEAR	PORTABLE-WATER,NDESCBIT
	PRINTI	"As you remove"
	CALL	TPRINT,BUCKET
	PRINTC	44
	CALL	TPRINT,BUCKET-PEG
	PRINTI	" pops back into its original 45-degree position. "
	CALL	ELEVATOR-OPERATOR,BUCKET-PEG
	SET	'BUCKET-PEG,FALSE-VALUE
	RTRUE	
?ELS53:	FCLEAR	BUCKET,TRYTAKEBIT
	FCLEAR	PORTABLE-WATER,NDESCBIT
	SET	'BUCKET-PEG,FALSE-VALUE
	PRINTR	"Taken."
?ELS42:	EQUAL?	PRSA,V?EXAMINE,V?SEARCH,V?LOOK-INSIDE \?ELS57
	PRINTI	"It's an old metal bucket which is beginning to rust through on the bottom. It has a rusty handle and "
	IN?	PORTABLE-WATER,BUCKET \?ELS62
	CALL	DESCRIBE-WATER-LEVEL
	PRINTR	"."
?ELS62:	FIRST?	BUCKET \?ELS64
	PRINTI	"contains"
	CALL	DESCRIBE-NOTHING
	ZERO?	STACK \TRUE
	RTRUE	
?ELS64:	PRINTR	"it's empty."
?ELS57:	ZERO?	FULL? /?ELS71
	EQUAL?	PRSA,V?THROW \?ELS71
	CALL	PERFORM,V?DROP,PORTABLE-WATER
	MOVE	BUCKET,HERE
	RTRUE	
?ELS71:	EQUAL?	PRSA,V?STAND-ON \?ELS75
	PRINTR	"It wouldn't be a very elevating experience."
?ELS75:	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?ELS77
	ZERO?	FULL? /?ELS82
	CALL	PERFORM,V?DRINK,WATER
	RTRUE	
?ELS82:	CALL	EMPTY-BUCKET
	RSTACK	
?ELS77:	EQUAL?	PRSA,V?EMPTY,V?POUR \?ELS87
	ZERO?	FULL? /?ELS92
	CALL	PERFORM,V?EMPTY,PORTABLE-WATER
	RTRUE	
?ELS92:	CALL	EMPTY-BUCKET
	RSTACK	
?ELS87:	EQUAL?	PRSA,V?PUT \?ELS97
	EQUAL?	PRSI,BUCKET \?ELS97
	ZERO?	BUCKET-PEG /?ELS104
	PRINT	PEG-IN-WAY
	RTRUE	
?ELS104:	EQUAL?	PRSO,WATER,PORTABLE-WATER \?ELS107
	CALL	PERFORM,V?FILL,BUCKET,WATER
	RTRUE	
?ELS107:	ZERO?	FULL? /FALSE
	PRINTI	"But"
	CALL	TPRINT,PRSO
	PRINTR	" would get all wet."
?ELS97:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	CANT-OPEN-CLOSE
	RSTACK	


	.FUNCT	DESCRIBE-WATER-LEVEL
	PRINTI	"is "
	GRTR?	AMOUNT-OF-WATER,21 \?ELS3
	PRINTI	"full"
	JUMP	?CND1
?ELS3:	GRTR?	AMOUNT-OF-WATER,13 \?ELS5
	PRINTI	"more than half full"
	JUMP	?CND1
?ELS5:	GRTR?	AMOUNT-OF-WATER,11 \?ELS7
	PRINTI	"about half full"
	JUMP	?CND1
?ELS7:	GRTR?	AMOUNT-OF-WATER,3 \?ELS9
	PRINTI	"less than half full"
	JUMP	?CND1
?ELS9:	PRINTI	"nearly empty"
?CND1:	PRINTI	" of water"
	RTRUE	


	.FUNCT	I-DRIP
	CALL	QUEUE,I-DRIP,-1
	DEC	'AMOUNT-OF-WATER
	IN?	BUCKET,POND /?THN8
	IN?	BUCKET,PLAYER \?ELS3
	EQUAL?	HERE,INLET,ON-POOL-1,IN-POOL-1 /?THN8
	EQUAL?	HERE,UNDERPASS-1,UNDERPASS-2,IN-POOL-2 /?THN8
	EQUAL?	HERE,ON-POOL-2 \?ELS3
?THN8:	SET	'AMOUNT-OF-WATER,26
	RFALSE	
?ELS3:	ZERO?	AMOUNT-OF-WATER \?CND1
	FCLEAR	PORTABLE-WATER,NDESCBIT
	REMOVE	PORTABLE-WATER
	CALL	DEQUEUE,I-DRIP
?CND1:	CALL	VISIBLE?,BUCKET
	ZERO?	STACK /?CND12
	ZERO?	LIT /?CND12
	CRLF	
	PRINTI	"The water "
	EQUAL?	AMOUNT-OF-WATER,25 \?ELS19
	PRINTI	"begin"
	JUMP	?CND17
?ELS19:	PRINTI	"continue"
?CND17:	PRINTI	"s to dribble out of"
	CALL	TPRINT,BUCKET
	PRINTC	46
	ZERO?	AMOUNT-OF-WATER \?ELS24
	PRINTI	" The bucket is now pretty much empty."
	JUMP	?CND22
?ELS24:	EQUAL?	AMOUNT-OF-WATER,6,12,18 \?CND22
	PRINTI	" The bucket is now around "
	EQUAL?	AMOUNT-OF-WATER,18 \?ELS29
	PRINTI	"three-quarters"
	JUMP	?CND27
?ELS29:	EQUAL?	AMOUNT-OF-WATER,12 \?ELS31
	PRINTI	"half"
	JUMP	?CND27
?ELS31:	PRINTI	"one-quarter"
?CND27:	PRINTI	" full."
?CND22:	CRLF	
?CND12:	FSET?	BUCKET,BUCKET-PEG-DOWN-BIT \?CND34
	LESS?	AMOUNT-OF-WATER,10 \?CND34
	CALL	VISIBLE?,BUCKET
	ZERO?	STACK /?CND39
	PRINTI	"Suddenly"
	CALL	TPRINT,BUCKET-PEG
	PRINTI	" pops back into its original 45-degree position. "
?CND39:	CALL	ELEVATOR-OPERATOR,BUCKET-PEG
	FCLEAR	BUCKET,BUCKET-PEG-DOWN-BIT
	RTRUE	
?CND34:	CALL	VISIBLE?,BUCKET
	ZERO?	STACK \TRUE
	RFALSE	


	.FUNCT	EMPTY-BUCKET,OBJ
	FIRST?	BUCKET >OBJ \?ELS5
	EQUAL?	PRSA,V?DRINK-FROM \?ELS10
	CALL	PERFORM,V?DRINK,OBJ
	RTRUE	
?ELS10:	NEXT?	OBJ \?ELS15
	PRINTI	"The contents of the "
	CALL	DPRINT,BUCKET
	PRINTI	" fall"
	JUMP	?CND13
?ELS15:	PRINTI	"Okay,"
	CALL	TPRINT,OBJ
	PRINTI	" falls"
?CND13:	CALL	ROB,BUCKET,HERE
	PRINTR	" out of it."
?ELS5:	PRINTR	"It's empty."


	.FUNCT	NOT-HOLDING-WATER?
	IN?	PORTABLE-WATER,BUCKET /FALSE
	PRINTR	"You're not carrying any water."


	.FUNCT	SHAFT-BOTTOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You're standing at the bottom of a shaft. The door to the north is "
	FSET?	CELLAR-CD,OPENBIT \?ELS8
	PRINTI	"open"
	JUMP	?CND6
?ELS8:	PRINTI	"closed"
?CND6:	PRINTC	46
	RTRUE	


	.FUNCT	CLOSET-TOP-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You're standing in a shaft on top of the closet. The door to the north is "
	CALL	WHICH-DOOR?
	FSET?	STACK,OPENBIT \?ELS8
	PRINTI	"open"
	JUMP	?CND6
?ELS8:	PRINTI	"closed"
?CND6:	PRINTC	46
	RTRUE	


	.FUNCT	CLOSET-TOP-EXIT,DOOR
	CALL	WHICH-DOOR? >DOOR
	FSET?	DOOR,OPENBIT /?ELS5
	CALL	THIS-IS-IT,DOOR
	CALL	ITS-CLOSED,DOOR
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS7
	RETURN	FOYER
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	RETURN	UPSTAIRS-HALL-MIDDLE
?ELS9:	RETURN	ATTIC


	.FUNCT	ATTIC-CD-F
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	ATTIC-CD,OPENBIT /FALSE
	EQUAL?	CLOSET-FLOOR,ATTIC /FALSE
	EQUAL?	HERE,ATTIC \FALSE
	CALL	OPEN-DOOR-TO-SHAFT
	FSET	ATTIC-CD,OPENBIT
	RTRUE	


	.FUNCT	ATTIC-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a dusty old attic with cobwebs hanging from the ceiling rafters. The attic is empty except for"
	CALL	APRINT,TRUNK
	FSET?	ATTIC-DOOR,OPENBIT \?ELS8
	PRINTI	". A ladder leads down through an opening"
	JUMP	?CND6
?ELS8:	PRINTI	" and a folding ladder attached to a panel"
?CND6:	PRINTI	" in the floor. To the south there is a"
	FSET?	ATTIC-CD,OPENBIT \?ELS13
	PRINTI	"n open"
	JUMP	?CND11
?ELS13:	PRINTI	" closed"
?CND11:	PRINTI	" door."
	RTRUE	


	.FUNCT	TO-&-FROM-ATTIC
	FSET?	ATTIC-DOOR,OPENBIT \?ELS5
	FSET?	SKIS,WORNBIT \?ELS10
	PRINTI	"You can't fit through the opening wearing the skis."
	CRLF	
	RFALSE	
?ELS10:	EQUAL?	HERE,ATTIC \?ELS17
	RETURN	UPSTAIRS-HALL-MIDDLE
?ELS17:	RETURN	ATTIC
?ELS5:	PRINTI	"The "
	CALL	DPRINT,ATTIC-DOOR
	PRINTI	" is closed."
	CRLF	
	RFALSE	


	.FUNCT	ATTIC-CLOSET-ENTER-F
	FSET?	ATTIC-CD,OPENBIT /?ELS5
	CALL	ITS-CLOSED,ATTIC-CD
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS7
	RETURN	CLOSET-TOP
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	PRINTI	"You enter the shaft and plunge down a floor. A bit shaken, you find yourself at..."
	CRLF	
	CRLF	
	RETURN	CLOSET-TOP
?ELS9:	CALL	JIGS-UP,STR?217
	RSTACK	


	.FUNCT	TRUNK-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	TRUNK,TRUNK-LOCKED-BIT \?ELS5
	PRINTR	"It won't budge."
?ELS5:	EQUAL?	PRSA,V?MOVE,V?TAKE \FALSE
	EQUAL?	PRSO,TRUNK \FALSE
	PRINT	SPINACH
	CRLF	
	RTRUE	


	.FUNCT	FIRE-HYDRANT-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"Don't you recognize it? It's a prop "
	CALL	DPRINT,FIRE-HYDRANT
	PRINTR	" from ""Atomic Chihuahuas From Hell."" Uncle Buddy took a lot of heat for that film when two unlikely special interest groups, the Institute for Nuclear Power and the American Chihuahua Breeders Association, joined forces in an effort to have the film banned."


	.FUNCT	ATTIC-DOOR-F
	EQUAL?	PRSA,V?LOWER,V?OPEN,V?PUSH-DOWN /?THN8
	EQUAL?	PRSA,V?PUSH,V?PULL \?ELS5
?THN8:	FSET?	ATTIC-DOOR,OPENBIT /?ELS5
	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS14
	PRINTR	"It won't budge from this side."
?ELS14:	FSET	ATTIC-DOOR,OPENBIT
	FCLEAR	ATTIC-DOOR,LOCKEDBIT
	PRINTI	"The panel in the floor drops downward and the ladder unfolds as it swings down into the upstairs hallway."
	FSET?	TRUNK,OPENBIT /?CND17
	FCLEAR	TRUNK,TRUNK-LOCKED-BIT
	PRINTI	" At the same time you hear a click from under"
	CALL	TPRINT,TRUNK
	PRINTI	"'s lid."
?CND17:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	ATTIC-DOOR,OPENBIT \?ELS26
	PRINTR	"The ladder hangs from an open panel in the ceiling, extended to the floor of the upstairs hallway."
?ELS26:	EQUAL?	HERE,ATTIC \FALSE
	PRINTR	"The wooden ladder is folded in thirds, with the first third attached to a panel in the floor."


	.FUNCT	AUNT-F
	EQUAL?	AUNT,WINNER \?ELS5
	PRINTI	"""Shut up and get me off this buzz saw!"""
	CRLF	
	CALL	PCLEAR
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTR	"She's strapped to the conveyor belt and moving closer to the buzz saw's spinning blade."
?ELS7:	EQUAL?	PRSA,V?CUT \?ELS9
	EQUAL?	PRSI,SWORD \?ELS9
	CALL	PERFORM,V?LAMP-OFF,SAW
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?LET-GO,V?RESCUE,V?UNTIE \FALSE
	EQUAL?	PRSO,AUNT \FALSE
	CALL	PERFORM,V?LAMP-OFF,SAW
	RTRUE	


	.FUNCT	HERMAN-F
	EQUAL?	PRSA,V?TELL /?THN6
	EQUAL?	PRSA,V?ASK-ABOUT \?ELS5
	EQUAL?	PRSO,HERMAN \?ELS5
?THN6:	PRINTI	"Herman never was the talkative type."
	CRLF	
	CALL	PCLEAR
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?KILL \?ELS11
	ZERO?	PRSI \?ELS11
	FIRST?	PLAYER \?ELS18
	PRINTI	"[with the "
	FIRST?	PLAYER /?KLU29
?KLU29:	CALL	DPRINT,STACK
	PRINTC	93
	CRLF	
	FIRST?	PLAYER /?KLU30
?KLU30:	CALL	PERFORM,V?KILL,HERMAN,STACK
	RTRUE	
?ELS18:	PRINTR	"You slug Herman in the gut. It feels good after all these years."
?ELS11:	EQUAL?	PRSA,V?PUSH \?ELS22
	EQUAL?	PRSO,HERMAN \?ELS22
	PRINTR	"He pushes you right back."
?ELS22:	EQUAL?	PRSA,V?EXAMINE \?ELS26
	PRINTR	"It's Cousin Herman all right. A little older and a little chubbier. He still wears Batman slip-on tennis shoes."
?ELS26:	EQUAL?	PRSA,V?KICK,V?BITE \FALSE
	PRINTR	"""%*&@#!,"" shouts Herman at the top of his lungs. You are aghast at Herman's profanity in the presence of your Aunt Hildegarde."


	.FUNCT	PROP-F,HERMAN-THING,PLAYER-THING
	FIRST?	HERMAN >HERMAN-THING /?KLU53
?KLU53:	FIRST?	PLAYER >PLAYER-THING /?KLU54
?KLU54:	
?PRG1:	ZERO?	PLAYER-THING /?REP2
	EQUAL?	PLAYER-THING,TOUPEE,MASK,RING \?REP2
	NEXT?	PLAYER-THING >PLAYER-THING /?PRG1
	JUMP	?PRG1
?REP2:	EQUAL?	PRSA,V?TAKE \?ELS14
	EQUAL?	PRSO,HERMAN-THING \?ELS19
	PRINTI	"You reach for"
	CALL	TPRINT,HERMAN-THING
	PRINTI	", but "
	CALL	DPRINT,HERMAN
	PRINTR	" twists away from you."
?ELS19:	ZERO?	PLAYER-THING /?ELS21
	PRINTI	"You're already armed with"
	CALL	ARPRINT,PLAYER-THING
	RSTACK	
?ELS21:	CALL	PICK-REMOVE,PRSO,PROPS
	RFALSE	
?ELS14:	EQUAL?	PRSA,V?THROW,V?SHOOT \?ELS26
	EQUAL?	PRSI,HERMAN \?ELS26
	CALL	PERFORM,V?KILL,HERMAN,PRSO
	RTRUE	
?ELS26:	EQUAL?	PRSA,V?CUT,V?KILL \FALSE
	EQUAL?	PRSO,HERMAN \FALSE
	INC	'HERMAN-HITS
	ZERO?	HERMAN-DOWN /?ELS37
	CALL	DEQUEUE,I-AUNT
	PRINTI	"With the hate of all those summers of his bullying built up, you let Herman have it with"
	CALL	TPRINT,PLAYER-THING
	PRINTI	", killing him. At the same time you hear a scream not unlike one you would hear in an Uncle Buddy movie. As the tone of the saw blade changes you realize your Aunt Hildegarde has just taken her final bow. You stand and cry for a few minutes remembering the good times with your aunt and wishing you had done more to save her.

Later you find your way out of the prop vault. You go next door to Johnny's and call the police. Unfortunately it never occurred to you that with two dead bodies involved they wouldn't believe your story."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS37:	EQUAL?	HERMAN-HITS,3 \?ELS40
	SET	'HERMAN-DOWN,TRUE-VALUE
	SET	'AUNT-COUNT,6
	CALL	QUEUE,I-AUNT,2
	CALL	DEQUEUE,I-HERMAN-ATTACK
	PRINTI	"You "
	EQUAL?	PLAYER-THING,GUN \?ELS43
	PRINTI	"fire"
	CALL	TPRINT,GUN
	PRINTI	" hitting him in the shoulder."
	JUMP	?CND41
?ELS43:	PRINTI	"give it your best, striking Herman."
?CND41:	PRINTR	" He drops to the ground. (Hmm, guess that wasn't a prop after all.) Slowly, he starts to come to his feet. The saw blade is less than an inch from the blue-gray hairs of Aunt Hildegarde's head!"
?ELS40:	PRINTI	"You "
	EQUAL?	PLAYER-THING,GUN \?ELS50
	PRINTI	"fire"
	CALL	TPRINT,GUN
	PRINTI	", blasting Herman with smooth and creamy whipped cream. You toss the gun away in disgust. It sails into the chute."
	CRLF	
	JUMP	?CND48
?ELS50:	PRINTI	"give it your best, striking Herman. The "
	CALL	DPRINT,PLAYER-THING
	PRINTI	" breaks into a hundred pieces. It was only a prop."
	CRLF	
?CND48:	REMOVE	PLAYER-THING
	RTRUE	


	.FUNCT	I-AUNT
	CALL	QUEUE,I-AUNT,1
	INC	'AUNT-COUNT
	EQUAL?	AUNT-COUNT,7 \?ELS5
	CRLF	
	PRINTI	"You hear what sounds like an old woman being run through a buzz saw. Suddenly you realize -- that old woman was your Aunt Hildegarde. Cousin Herman stares at the saw blade in horror then turns and dives into the chute, disappearing. You stand there as the blade continues to cut, wishing you had done more to save her.

Later you find your way out of the prop vault. You go next door to Johnny's and call the police. When they arrive they have a difficult time believing your story. You're advised to call a good lawyer."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS5:	CRLF	
	PRINTI	"Your Aunt Hildegarde, strapped to the conveyor belt, is "
	GET	AUNT-DISTANCE,AUNT-COUNT
	PRINT	STACK
	PRINTI	" the saw blade. "
	ZERO?	HERMAN-HITS /?ELS10
	EQUAL?	AUNT-COUNT,1 \?ELS14
	PRINTI	"""Herman, dear, please turn off the buzz saw and untie me,"" says Aunt Hildegarde politely."
	JUMP	?CND8
?ELS14:	EQUAL?	AUNT-COUNT,2 \?ELS16
	PRINTI	"""Herman, that's no way to treat your cousin,"" admonishes Aunt Hildegarde."
	JUMP	?CND8
?ELS16:	EQUAL?	AUNT-COUNT,3 \?ELS18
	PRINTI	"""I'm just glad your Uncle Buddy isn't alive to see this,"" says Aunt Hildegarde with resignation."
	JUMP	?CND8
?ELS18:	EQUAL?	AUNT-COUNT,4 \?ELS20
	PRINTI	"""Herman, enough is enough. You are in big trouble, buster. Pumpkin, untie me then run and get your Uncle Buddy's belt,"" orders Aunt Hildegarde."
	JUMP	?CND8
?ELS20:	EQUAL?	AUNT-COUNT,5 \?ELS22
	PRINTI	"""Now you two stop that horseplay and get me off this contraption,"" demands Aunt Hildegarde."
	JUMP	?CND8
?ELS22:	EQUAL?	AUNT-COUNT,6 \?CND8
	PRINTI	"""Pumpkin! Help!"" screams Aunt Hildegarde over the roar of the buzz saw."
	JUMP	?CND8
?ELS10:	PRINTI	"""Herman, stop this silly game this instant and untie me,"" demands Aunt Hildegarde."
?CND8:	CRLF	
	RTRUE	


	.FUNCT	SAW-F,HERMAN-THING
	FIRST?	HERMAN >HERMAN-THING /?KLU21
?KLU21:	EQUAL?	PRSA,V?LAMP-OFF \?ELS5
	ZERO?	HERMAN-DOWN /?ELS10
	ADD	SCORE,20 >SCORE
	PRINTI	"The conveyor belt stops and the buzz saw's blade begins to slow. As you untie your Aunt Hildegarde, Herman races toward the chute and jumps inside, disappearing. You hear his squeaky laugh trail off in the distance. Aunt Hildegarde gets up from the buzz saw rubbing the back of her head. Though a bit shaken, she explains she had been watching you while you searched for the ""treasures.""

""As I followed your progress I began to realize you and I were not the only ones on the estate. My suspicions were confirmed when I received a rap on the skull. The next thing I knew I was being tied to this buzz saw by your Cousin Herman,"" says Aunt Hildegarde. ""I guess he couldn't stand to see you inherit the family fortune. Well, it's all yours now. I knew you could do it,"" says Aunt Hildegarde with satisfaction.

""I'm sorry I put you through all this, Pumpkin, but your Uncle Buddy and I had to be sure that whoever inherited the estate and the studio would be clever enough to handle it all. The only way I could be sure the stipulations in my will would be carried out would be to oversee it myself, so I faked my death,"" says Aunt Hildegarde, hugging you so tight she squeezes the air out of your lungs. ""Tomorrow we'll go see my lawyer and he'll take care of all the paper work. I know you'll take good care of Hildebud and the studio. As for me, I'm sure it won't be long before the press discovers I'm alive. I plan to go to the south of France for a rest while the story leaks out. It will be great publicity for the studio,"" says Aunt Hildegarde. Then she adds, ""And let's hope we've seen the last of your Cousin Herman."""
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS10:	ZERO?	HERMAN-THING /?ELS13
	REMOVE	HERMAN-THING
	PRINTI	"Cousin Herman hits you with"
	CALL	TPRINT,HERMAN-THING
	PRINTI	", driving you away from the buzz saw. The "
	CALL	DPRINT,HERMAN-THING
	PRINTR	" crumbles; it was only a prop."
?ELS13:	PRINTR	"Cousin Herman slugs you in the stomach, pushing you away from the buzz saw."
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS18
	PRINTI	"It's already turned on!"
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It's a large, steel blade that seems to spin faster as Aunt Hildegarde moves closer to it."


	.FUNCT	I-HERMAN-ATTACK,NEXT-PROP,FOO,HERMAN-THING
	FIRST?	HERMAN >HERMAN-THING /?KLU23
?KLU23:	CALL	QUEUE,I-HERMAN-ATTACK,-1
	ZERO?	HERMAN-THING /?ELS5
	REMOVE	HERMAN-THING
	CRLF	
	PRINTI	"Cousin Herman "
	EQUAL?	HERMAN-THING,GUN \?ELS9
	PRINTI	"fires"
	JUMP	?CND7
?ELS9:	EQUAL?	HERMAN-THING,BAG \?ELS11
	PRINTI	"throws"
	JUMP	?CND7
?ELS11:	PRINTI	"swings"
?CND7:	PRINTI	" the "
	CALL	DPRINT,HERMAN-THING
	PRINTI	", "
	EQUAL?	HERMAN-THING,GUN \?ELS18
	PRINTR	"covering you with whipped cream. Herman tosses the gun in the chute."
?ELS18:	PRINTI	"striking you. The "
	CALL	DPRINT,HERMAN-THING
	PRINTR	" crumbles; it was only a prop."
?ELS5:	CALL	PICK-ONE,PROPS
	MOVE	STACK,HERMAN
	FIRST?	HERMAN >HERMAN-THING /?KLU24
?KLU24:	CRLF	
	PRINTI	"Cousin Herman grabs the "
	CALL	DPRINT,HERMAN-THING
	PRINTR	"."

	.ENDI
