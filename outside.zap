

	.FUNCT	HOUSE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's dark, but you can make out a stately two-story home with chimneys near the east and west ends of the house. Hardly anything has changed since you were last here several years ago, though you always remember the house as full of life, and now it is deserted and silent."
?ELS5:	EQUAL?	PRSA,V?ENTER \FALSE
	CALL	DO-WALK,P?IN
	RSTACK	


	.FUNCT	SOUTH-JUNCTION-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	INC	'SOUTH-JUNCTION-VISITS
	RETURN	SOUTH-JUNCTION-VISITS


	.FUNCT	TO-FRONT-PORCH
	FSET?	SOUTH-JUNCTION,BLACK-CAT-BIT \?ELS5
	PRINTI	"As you walk toward the house, a large black cat scurries across the path, heading toward Johnny Carson's house."
	CRLF	
	CRLF	
	FCLEAR	SOUTH-JUNCTION,BLACK-CAT-BIT
	RETURN	FRONT-PORCH
?ELS5:	RETURN	FRONT-PORCH


	.FUNCT	COMPASS-ROSE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The compass rose encircles the base of the statue."


	.FUNCT	BAZOOKA-F
	EQUAL?	PRSA,V?TURN,V?MOVE,V?PUSH \?ELS5
	CALL	PERFORM,PRSA,BUCK,PRSI
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTI	"The bazooka is pointing to the "
	CALL	SAY-BUCK-DIR
	PRINTR	"."
?ELS7:	EQUAL?	PRSA,V?SHOOT \FALSE
	PRINTR	"It's a stone gun, you geek."


	.FUNCT	TO-&-FROM-SOUTH-JUNCTION,NEW-ROOM
	PRINTI	"You follow the stone walkway as it turns "
	EQUAL?	HERE,SOUTHEAST-JUNCTION \?ELS3
	SET	'NEW-ROOM,SOUTH-JUNCTION
	PRINTI	"west"
	JUMP	?CND1
?ELS3:	EQUAL?	HERE,SOUTHWEST-JUNCTION \?ELS5
	SET	'NEW-ROOM,SOUTH-JUNCTION
	PRINTI	"east"
	JUMP	?CND1
?ELS5:	PRINTI	"north"
	EQUAL?	PRSO,P?WEST \?ELS10
	SET	'NEW-ROOM,SOUTHWEST-JUNCTION
	JUMP	?CND1
?ELS10:	SET	'NEW-ROOM,SOUTHEAST-JUNCTION
?CND1:	PRINTI	" around the corner of the house, arriving at..."
	CRLF	
	CRLF	
	RETURN	NEW-ROOM


	.FUNCT	TO-&-FROM-TOP-LANDING
	FSET?	NORTHEAST-JUNCTION,EVERYBIT \?ELS3
	FCLEAR	NORTHEAST-JUNCTION,EVERYBIT
	PRINTI	"As you walk along the path you hear footsteps running south along the stone walkway."
	CRLF	
	CRLF	
	JUMP	?CND1
?ELS3:	PRINTI	"You walk a short distance along the grass path, arriving at..."
	CRLF	
	CRLF	
?CND1:	EQUAL?	HERE,NORTHEAST-JUNCTION \?ELS10
	RETURN	TOP-LANDING
?ELS10:	EQUAL?	HERE,TOP-LANDING \FALSE
	RETURN	NORTHEAST-JUNCTION


	.FUNCT	PATIO-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a large fieldstone patio spanning the entire width of the back of the house. In the daytime you can look out onto Aunt Hildegarde's beautiful garden, said to be the envy of the Malibu colony. This is where Uncle Buddy and Aunt Hildegarde would often entertain.

Standing here you remember the time at one of their parties when you swiped one of Uncle Buddy's big Hollywood cigars and smoked it, then got sick on a rose bush in the garden. You snicker a little bit thinking about that poor rose bush now and the goofy things you did as a child. To the north a stone pathway leads to the garden. Steps lead down off to the east and west, and there is a"
	FSET?	PATIO-DOOR,OPENBIT \?ELS8
	PRINTI	"n open"
	JUMP	?CND6
?ELS8:	PRINTI	" closed"
?CND6:	PRINTI	" door to the south."
	RTRUE	


	.FUNCT	GARDEN-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"This garden was Aunt Hildegarde's pride and joy. "
	GRTR?	MOVES,535 /?ELS8
	PRINTI	"By the moonlight you can see the outline of"
	JUMP	?CND6
?ELS8:	PRINTI	"You can see"
?CND6:	PRINTR	" dozens of fancy varieties of flowers and shrubs. Several small trees dot the garden, giving shade during the day to the more delicate blossoms. Stone walkways lead through the garden. A stone wall surrounds the garden with entrances north and south."
?ELS5:	EQUAL?	PRSA,V?ENTER \FALSE
	PRINTR	"You can only enter the garden from the north or south of the garden."


	.FUNCT	GARDEN-WALLS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"The stone wall surrounds the entire garden, with entrances to the north and south of the garden."
?ELS5:	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB-ON,V?CLIMB /?THN8
	EQUAL?	PRSA,V?CLIMB-OVER \FALSE
?THN8:	PRINTR	"Aunt Hildegarde would paddle your fanny if she saw you do that."


	.FUNCT	ROSE-BUSH-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"You remember this rose bush from many summers ago. It's the one you got sick on after smoking one of Uncle Buddy's cigars."
?ELS5:	EQUAL?	PRSA,V?SMELL \?ELS7
	PRINTR	"No doubt the fragrance would be sweeter had you not thrown-up on it many years ago."
?ELS7:	EQUAL?	PRSA,V?WATER \FALSE
	PRINTR	"Driven by guilt, you splash some water on the bush. It looks better already."


	.FUNCT	FLORAL-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's the lovely flora you would expect in Aunt Hildegarde's reknowned garden."
?ELS5:	EQUAL?	PRSA,V?SMELL \FALSE
	PRINTR	"Hmmm. What a lovely scent."


	.FUNCT	POND-F
	EQUAL?	PRSA,V?PUT \?ELS5
	EQUAL?	PRSI,POND \?ELS5
	PRINTI	"You drop"
	CALL	TPRINT,PRSO
	PRINTI	" in"
	CALL	TPRINT,POND
	GETP	PRSO,P?SIZE
	GRTR?	STACK,5 \?CND8
	PRINTI	" with a splash"
?CND8:	PRINTC	46
	MOVE	PRSO,POND
	CALL	ALL-WET,PRSO
	CALL	BLOW-OUT-ALL-IN,PRSO,STR?189
	EQUAL?	PRSO,BUCKET \?CND11
	FIRST?	PRSO \?CND11
	CALL	ROB,BUCKET,POND
	PRINTI	" The contents of the bucket sink to the bottom of the shallow pond."
?CND11:	EQUAL?	PRSO,FLASHLIGHT \?CND16
	FSET?	FLASHLIGHT,ONBIT \?CND16
	FCLEAR	FLASHLIGHT,ONBIT
	FSET	FLASHLIGHT,WETBIT
	PRINTI	" The flashlight goes out."
?CND16:	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?ENTER \?ELS22
	PRINTR	"How soon they forget. Don't you remember the summer Aunt Hildegarde caught you wading in the pond and paddled your behind?"
?ELS22:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	CANT-OPEN-CLOSE
	RSTACK	


	.FUNCT	BLOW-OUT-ALL-IN,OBJ,STR=0
	ZERO?	STR \?CND1
	SET	'STR,STR?190
?CND1:	
?PRG4:	ZERO?	OBJ /TRUE
	FSET?	OBJ,FLAMEBIT \?CND11
	FCLEAR	OBJ,FLAMEBIT
	FCLEAR	OBJ,ONBIT
	PRINTI	" The "
	CALL	DPRINT,OBJ
	PRINTI	" goes out"
	PRINT	STR
	PRINTC	46
	EQUAL?	OBJ,RED-CANDLE \?ELS16
	CALL	STOP-RED-BURNING
	JUMP	?CND11
?ELS16:	EQUAL?	OBJ,WHITE-CANDLE \?ELS18
	CALL	STOP-WHITE-BURNING
	JUMP	?CND11
?ELS18:	EQUAL?	OBJ,BLUE-CANDLE \?ELS20
	CALL	STOP-BLUE-BURNING
	JUMP	?CND11
?ELS20:	EQUAL?	OBJ,GREEN-MATCH,RED-MATCH \?CND11
	CALL	DEQUEUE,I-MATCH-BURN
?CND11:	FIRST?	OBJ \?CND23
	FIRST?	OBJ /?KLU26
?KLU26:	CALL	BLOW-OUT-ALL-IN,STACK,STR
?CND23:	NEXT?	OBJ >OBJ /?PRG4
	JUMP	?PRG4


	.FUNCT	TO-&-FROM-CANNON,NEW-ROOM
	PRINTI	"You follow the walkway as it turns "
	EQUAL?	HERE,NORTHWEST-JUNCTION \?ELS3
	SET	'NEW-ROOM,CANNON-EMPLACEMENT
	PRINTI	"east"
	JUMP	?CND1
?ELS3:	EQUAL?	HERE,NORTHEAST-JUNCTION \?ELS5
	SET	'NEW-ROOM,CANNON-EMPLACEMENT
	PRINTI	"west"
	JUMP	?CND1
?ELS5:	PRINTI	"south"
	EQUAL?	PRSO,P?WEST \?ELS10
	SET	'NEW-ROOM,NORTHWEST-JUNCTION
	JUMP	?CND1
?ELS10:	SET	'NEW-ROOM,NORTHEAST-JUNCTION
?CND1:	PRINTI	" around the hedge leading to..."
	CRLF	
	CRLF	
	RETURN	NEW-ROOM


	.FUNCT	CANNON-EMPLACEMENT-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a cannon emplacement complete with a Civil War-style cannon and a neatly stacked pyramid of cannon balls. During the day this area affords a spectacular view of the coastline. Stone walkways lead east and west, and a steep path leads down."
	RTRUE	


	.FUNCT	TO-CLIFF
	FSET?	SKIS,WORNBIT \?ELS5
	CALL	JIGS-UP,STR?192
	RSTACK	
?ELS5:	PRINTI	"You attempt to walk down, but end up sliding most of the way to a cliff below."
	CRLF	
	CRLF	
	RETURN	CLIFF


	.FUNCT	CLIFF-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This cliff affords the same spectacular view as from the cannon emplacement above. Far below you and stretching east, are the white sands of a beach"
	GRTR?	MOVES,535 /?CND6
	PRINTI	", illuminated by the moon's glow"
?CND6:	PRINTI	". You can hear the faint sound of waves lapping at the shore. Nearby in the ground is a"
	FSET?	HATCH,OPENBIT \?ELS13
	PRINTI	"n open hatch, forming a hole which leads down."
	RTRUE	
?ELS13:	PRINTI	" closed hatch."
	RTRUE	


	.FUNCT	CLIFF-PSEUDO
	EQUAL?	PRSA,V?LEAP \FALSE
	CALL	JIGS-UP,STR?193
	RSTACK	


	.FUNCT	TO-CANNON-EMPLACEMENT
	PRINTI	"You slip and slide in the loose rock, "
	CALL	ULTIMATELY-IN?,LADDER
	ZERO?	STACK /?ELS5
	PRINTI	"unable to climb up the cliff because of the weight of the ladder."
	CRLF	
	RFALSE	
?ELS5:	PRINTI	"but manage to make your way up to the cannon emplacement."
	CRLF	
	CRLF	
	RETURN	CANNON-EMPLACEMENT


	.FUNCT	TO-&-FROM-BOMB-SHELTER
	FSET?	HATCH,OPENBIT /?ELS5
	PRINT	YOU-CANT
	PRINTI	"go through the closed hatch."
	CRLF	
	RFALSE	
?ELS5:	FSET?	HATCH,OPENBIT \?ELS7
	FSET?	SKIS,WORNBIT \?ELS7
	PRINTI	"You can't fit through the opening wearing the skis."
	CRLF	
	RFALSE	
?ELS7:	FSET?	LADDER,HUNG-BIT \?ELS11
	EQUAL?	HERE,BOMB-SHELTER \?ELS16
	PRINTI	"You climb up the ladder to the cliff."
	CRLF	
	CRLF	
	MOVE	LADDER,CLIFF
	RETURN	CLIFF
?ELS16:	PRINTI	"You climb down the ladder to the bomb shelter."
	CRLF	
	CRLF	
	MOVE	LADDER,BOMB-SHELTER
	RETURN	BOMB-SHELTER
?ELS11:	EQUAL?	HERE,BOMB-SHELTER \?ELS25
	PRINTI	"You'll have to figure that out for yourself."
	CRLF	
	RFALSE	
?ELS25:	PRINTI	"You drop into the hole, managing to land on your feet."
	CRLF	
	CRLF	
	RETURN	BOMB-SHELTER


	.FUNCT	LADDER-F
	EQUAL?	HERE,CLIFF \?ELS5
	FSET?	LADDER,HUNG-BIT \?ELS5
	FSET?	HATCH,OPENBIT /?ELS5
	CALL	CANT-SEE-ANY,LADDER
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS9
	PRINTR	"This straight ladder is made of heavy-duty steel bars. It resembles a ladder you might find on a fire escape."
?ELS9:	EQUAL?	PRSA,V?UNTIE,V?TAKE \?ELS11
	FSET?	LADDER,HUNG-BIT \?ELS11
	EQUAL?	HERE,CLIFF \?ELS18
	PRINTR	"It's too heavy to lift out of the hole."
?ELS18:	CALL	ITAKE
	ZERO?	STACK /TRUE
	FCLEAR	LADDER,HUNG-BIT
	PRINTR	"Taken."
?ELS11:	EQUAL?	PRSA,V?HANG-UP \?ELS29
	EQUAL?	HERE,BOMB-SHELTER \?ELS29
	ZERO?	PRSI \?ELS29
	CALL	PERFORM,V?HANG-UP,LADDER,HOOKS
	RTRUE	
?ELS29:	EQUAL?	PRSA,V?CLIMB-DOWN,V?CLIMB,V?CLIMB-UP \FALSE
	FSET?	LADDER,HUNG-BIT \?ELS38
	EQUAL?	HERE,CLIFF \?ELS43
	EQUAL?	PRSA,V?CLIMB-UP \?ELS48
	PRINTR	"The ladder only leads down, through the open hatch."
?ELS48:	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS43:	EQUAL?	PRSA,V?CLIMB-DOWN \?ELS57
	PRINTR	"The ladder only leads up, through the open hatch."
?ELS57:	CALL	DO-WALK,P?UP
	RSTACK	
?ELS38:	CALL	ULTIMATELY-IN?,LADDER
	ZERO?	STACK /?ELS61
	PRINTR	"You're holding the ladder!"
?ELS61:	PRINTR	"You can't climb a ladder that's lying down."


	.FUNCT	HOOKS-F
	EQUAL?	PRSA,V?TIE,V?PUT-ON,V?HANG-UP \FALSE
	EQUAL?	PRSO,LADDER \?ELS10
	PRINTI	"You hang the ladder from"
	CALL	TRPRINT,HOOKS
	MOVE	LADDER,HERE
	FSET	LADDER,NDESCBIT
	FSET	LADDER,HUNG-BIT
	RTRUE	
?ELS10:	PRINTR	"You can't reach the hooks."


	.FUNCT	HATCH-HOLE-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?ELS5
	PRINTI	"The hole is about the size of a manhole"
	EQUAL?	HERE,CLIFF \?CND6
	PRINTI	". The "
	CALL	DPRINT,HATCH-HOLE
	PRINTI	" descends down into "
	CALL	LIT?,BOMB-SHELTER
	ZERO?	STACK /?ELS11
	PRINTI	"the bomb shelter"
	JUMP	?CND9
?ELS11:	PRINTI	"darkness"
?CND9:	FSET?	LADDER,HUNG-BIT \?CND6
	PRINTI	". A "
	CALL	DPRINT,LADDER
	PRINTI	" in the hole leads down"
?CND6:	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?ENTER \?ELS18
	EQUAL?	HERE,CLIFF \?ELS23
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS23:	PRINTR	"You can't reach it."
?ELS18:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	HERE,CLIFF \FALSE
	EQUAL?	PRSI,HATCH-HOLE \FALSE
	PRINTI	"You drop"
	CALL	TPRINT,PRSO
	PRINTI	" in"
	CALL	TPRINT,HATCH-HOLE
	PRINTI	" and a second later hear it hit the ground."
	CRLF	
	EQUAL?	PRSO,BLUE-CANDLE,WHITE-CANDLE,RED-CANDLE \?CND30
	FSET?	PRSO,FLAMEBIT \?CND30
	CALL	BLOW-OUT-CANDLE,PRSO
?CND30:	EQUAL?	PRSO,FINCH \?ELS41
	FSET?	FINCH,BROKEN-BIT \?THN38
?ELS41:	CALL	ULTIMATELY-IN?,FINCH,PRSO
	ZERO?	STACK /?CND35
	FSET?	FINCH,BROKEN-BIT /?CND35
?THN38:	CALL	BREAK-FINCH,TRUE-VALUE
?CND35:	MOVE	PRSO,BOMB-SHELTER
	RTRUE	


	.FUNCT	PILE-OF-BALLS-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	CALL	CANT-OPEN-CLOSE
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?TAKE,V?EXAMINE \?ELS7
	IN?	CANNON-BALL,PILE-OF-BALLS /?THN13
	FIRST?	PILE-OF-BALLS /FALSE
?THN13:	PRINTI	"The pile of cannon balls appears to be strictly ornamental. All of the balls are welded together"
	IN?	CANNON-BALL,PILE-OF-BALLS \?CND15
	PRINTI	", except for the ball on the top of the pile"
?CND15:	PRINTR	"."
?ELS7:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	PRINT	YOU-CANT
	PRINTI	"look under"
	CALL	TRPRINT,PILE-OF-BALLS
	RSTACK	


	.FUNCT	GENERIC-BALL-F
	RETURN	CANNON-BALL


	.FUNCT	FUSE-F,OBJ,FLAME
	EQUAL?	PRSA,V?LAMP-ON,V?BURN \?ELS5
	CALL	SET-FLAME-SOURCE
	ZERO?	STACK \TRUE
	FSET?	PRSI,FLAMEBIT /?ELS12
	FSET?	PRSI,BURNBIT \?ELS17
	PRINTI	"You'll have to light"
	CALL	TPRINT,PRSI
	PRINTR	" first."
?ELS17:	PRINTI	"You can't light"
	CALL	TPRINT,PRSO
	PRINTI	" with"
	CALL	ARPRINT,PRSI
	RSTACK	
?ELS12:	REMOVE	FUSE
	FIRST?	CANNON >OBJ /?KLU59
?KLU59:	PRINTI	"You touch the flame to"
	CALL	TPRINT,FUSE
	PRINTI	" and it sizzles. A second later"
	CALL	TPRINT,CANNON
	PRINTI	" fires"
	ZERO?	OBJ \?ELS26
	PRINTR	" with a bang."
?ELS26:	IN?	CANNON-BALL,CANNON \?CND29
	FSET	CANNON,CANNON-MOVED-BIT
	REMOVE	CANNON-BALL
	PRINTI	", pushing it back a couple of feet. "
?CND29:	IN?	FLASHLIGHT,CANNON \?CND32
	FCLEAR	FLASHLIGHT,ONBIT
?CND32:	IN?	RED-CANDLE,CANNON \?CND35
	FCLEAR	RED-CANDLE,FLAMEBIT
	FCLEAR	RED-CANDLE,ONBIT
	CALL	STOP-RED-BURNING
?CND35:	IN?	WHITE-CANDLE,CANNON \?CND38
	FCLEAR	WHITE-CANDLE,FLAMEBIT
	FCLEAR	WHITE-CANDLE,ONBIT
	CALL	STOP-WHITE-BURNING
?CND38:	IN?	BLUE-CANDLE,CANNON \?CND41
	FCLEAR	BLUE-CANDLE,FLAMEBIT
	FCLEAR	BLUE-CANDLE,ONBIT
	CALL	STOP-BLUE-BURNING
?CND41:	FSET?	CANNON,CANNON-MOVED-BIT \?ELS46
	PRINTI	"The "
	CALL	DPRINT,CANNON-BALL
	FIRST?	CANNON \?CND44
	PRINTI	" and pieces of"
	CALL	CLOSE-ALL-IN,CANNON
	CALL	DESCRIBE-CONTENTS,CANNON,-1
	JUMP	?CND44
?ELS46:	FIRST?	CANNON \?CND44
	PRINTI	" and pieces of"
	CALL	CLOSE-ALL-IN,CANNON
	CALL	DESCRIBE-CONTENTS,CANNON,-1
?CND44:	PRINTI	" fl"
	FIRST?	CANNON \?ELS54
	PRINTC	121
	JUMP	?CND52
?ELS54:	PRINTI	"ies"
?CND52:	PRINTI	" from"
	CALL	TPRINT,CANNON
	PRINTI	"'s barrel out to sea."
	CRLF	
	CALL	MOVE-ALL,CANNON
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"It's stuck."


	.FUNCT	CLOSE-ALL-IN,CONT,OBJ
	FIRST?	CONT >OBJ /?KLU6
?KLU6:	
?PRG1:	FCLEAR	OBJ,OPENBIT
	NEXT?	OBJ >OBJ /?KLU7
?KLU7:	ZERO?	OBJ \?PRG1
	RTRUE	


	.FUNCT	SET-FLAME-SOURCE,FLAME
	ZERO?	PRSI \FALSE
	CALL	FIND-IN,PLAYER,FLAMEBIT >FLAME
	ZERO?	FLAME /?ELS8
	SET	'PRSI,FLAME
	PRINTI	"[with"
	CALL	TPRINT,FLAME
	PRINTC	93
	CRLF	
	RFALSE	
?ELS8:	EQUAL?	HERE,BEACH \?ELS10
	SET	'PRSI,FIRE
	PRINTI	"[with the fire]"
	CRLF	
	RFALSE	
?ELS10:	PRINTI	"You have nothing to light"
	CALL	TPRINT,PRSO
	PRINTR	" with."


	.FUNCT	CANNON-F
	EQUAL?	PRSA,V?PUSH-TO,V?PUSH,V?TAKE /?THN8
	EQUAL?	PRSA,V?TURN,V?MOVE,V?PULL /?THN8
	EQUAL?	PRSA,V?EMPTY,V?LOWER,V?RAISE \?ELS5
?THN8:	EQUAL?	PRSO,CANNON \?ELS5
	PRINTR	"The cannon is too heavy for you to move."
?ELS5:	EQUAL?	PRSA,V?SHOOT \?ELS11
	PRINTR	"Try lighting the fuse!"
?ELS11:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTI	"It's a replica Civil War "
	CALL	DPRINT,CANNON
	PRINTI	" pointing out to sea. "
	IN?	FUSE,CANNON-EMPLACEMENT \?CND14
	PRINTI	"There is"
	CALL	APRINT,FUSE
	PRINTI	" sticking up from the cannon. "
?CND14:	FSET?	CANNON,CANNON-MOVED-BIT /?ELS19
	PRINTI	"One of"
	CALL	TPRINT,CANNON
	PRINTI	"'s wheels is on top of a small compartment."
	JUMP	?CND17
?ELS19:	PRINTI	"Right next to"
	CALL	TPRINT,CANNON
	PRINTI	" is"
	CALL	APRINT,COMPARTMENT
	PRINTC	46
?CND17:	PRINTI	" The "
	CALL	DPRINT,CANNON
	PRINTR	" was used in Uncle Buddy's production of ""Dracula Meets the Confederacy."" Uncle Buddy said he always kept it loaded in case those big Hollywood studio types came around."
?ELS13:	EQUAL?	PRSA,V?LAMP-ON,V?BURN \?ELS23
	CALL	PERFORM,V?BURN,FUSE
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?PUT \?ELS25
	EQUAL?	PRSO,BUCKET \?ELS25
	PRINTR	"It won't fit in the cannon."
?ELS25:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	CANT-OPEN-CLOSE
	RSTACK	


	.FUNCT	COMPARTMENT-F
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	CANNON,CANNON-MOVED-BIT /?ELS5
	CALL	PERFORM,V?EXAMINE,COMPARTMENT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	CANNON,CANNON-MOVED-BIT /FALSE
	PRINTI	"One of"
	CALL	TPRINT,CANNON
	PRINTI	"'s wheels is on"
	CALL	TRPRINT,COMPARTMENT
	RSTACK	


	.FUNCT	MOVE-OBJ-DOWN
	FSET?	PRSO,TAKEBIT \FALSE
	PRINTI	"You "
	PRINTB	P-PRSA-WORD
	PRINTI	" the "
	CALL	DPRINT,PRSO
	PRINTI	" and it tumbles down the stairs."
	EQUAL?	UPSTAIRS-HALL-MIDDLE,HERE \?ELS10
	MOVE	PRSO,FOYER
	RTRUE	
?ELS10:	EQUAL?	FRONT-PORCH,HERE \?ELS12
	MOVE	PRSO,SOUTH-JUNCTION
	RTRUE	
?ELS12:	MOVE	PRSO,CELLAR
	RTRUE	


	.FUNCT	DOOR-BELL-F
	EQUAL?	PRSA,V?PUSH \FALSE
	PRINTI	"The "
	CALL	DPRINT,DOOR-BELL
	PRINTI	" plays a tune from one of Uncle Buddy's films. You recognize the "
	CALL	PICK-ONE,DOOR-BELL-TUNES
	PRINT	STACK
	PRINTR	"."""


	.FUNCT	SKIS-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"They're a large pair of downhill snow skis."
?ELS5:	EQUAL?	PRSA,V?WEAR \FALSE
	EQUAL?	HERE,UPPER-BEACH-STAIRS /?THN13
	EQUAL?	HERE,LOWER-BEACH-STAIRS \?ELS12
?THN13:	PRINTR	"You can't put them on while standing on the stairs."
?ELS12:	EQUAL?	HERE,ROOF-1,ROOF-2 \?ELS16
	CALL	JIGS-UP,STR?200
	RSTACK	
?ELS16:	EQUAL?	HERE,INLET,ON-POOL-1,IN-POOL-1 /?THN19
	EQUAL?	HERE,UNDERPASS-1,UNDERPASS-2,IN-POOL-2 /?THN19
	EQUAL?	HERE,ON-POOL-2 \?ELS18
?THN19:	PRINT	DOG-PADDLE
	CRLF	
	RTRUE	
?ELS18:	EQUAL?	HERE,CLOSET,SHAFT-BOTTOM,CLOSET-TOP /?THN23
	EQUAL?	HERE,CHIMNEY-1,CHIMNEY-2,CHIMNEY-3 \?ELS22
?THN23:	PRINTI	"The "
	EQUAL?	HERE,CLOSET \?ELS27
	PRINTI	"closet"
	JUMP	?CND25
?ELS27:	EQUAL?	HERE,CLOSET-TOP,SHAFT-BOTTOM \?ELS29
	PRINTI	"shaft"
	JUMP	?CND25
?ELS29:	PRINTI	"chimney"
?CND25:	PRINTR	" is too small for you to put on the skis."
?ELS22:	EQUAL?	HERE,CRAWL-SPACE-NORTH,CRAWL-SPACE-SOUTH,FIRST-SECRET-ROOM \?ELS33
	PRINT	YOU-CANT
	PRINTR	"quite slip into them in this cramped space."
?ELS33:	LOC	PLAYER
	EQUAL?	STACK,RIGHT-END,LEFT-END \FALSE
	PRINT	YOU-CANT
	PRINTI	"seem to get them on while standing on"
	CALL	TRPRINT,PLANK
	RSTACK	


	.FUNCT	TOP-LANDING-F,ARG
	EQUAL?	ARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	EQUAL?	PRSO,P?NORTH \FALSE
	SET	'PRSO,P?DOWN
	RFALSE	


	.FUNCT	TO-BEACH
	FSET?	SKIS,WORNBIT \?ELS5
	CALL	SKI-DOWN-STAIRS
	RETURN	BEACH
?ELS5:	EQUAL?	HERE,UPPER-BEACH-STAIRS \?ELS12
	CALL	JIGS-UP,STR?203
	RSTACK	
?ELS12:	PRINTI	"You walk down the old, creaking stairs. You stop as you come to a wide gap of missing steps."
	CRLF	
	CRLF	
	RETURN	UPPER-BEACH-STAIRS


	.FUNCT	GAP-F
	EQUAL?	PRSA,V?CROSS,V?LEAP \?ELS5
	PRINTI	"You leap across the gap "
	RANDOM	100
	LESS?	50,STACK /?ELS8
	PRINTI	"and just miss the first step on the other side. For a split second you admire a view of the coastline that few if any have seen before. You then"
	JUMP	?CND6
?ELS8:	PRINTI	"and land on the first step. Unfortunately your weight was a bit too much for the step. It squeals with pain then breaks in half, and you"
?CND6:	CALL	JIGS-UP,STR?204
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS12
	PRINTR	"Far below are sharp rocks."
?ELS12:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?ELS14
	EQUAL?	PRSI,GAP \?ELS14
	REMOVE	PRSO
	PRINTI	"The "
	CALL	DPRINT,PRSO
	PRINTR	" drops to the rocks below."
?ELS14:	EQUAL?	PRSA,V?ENTER \FALSE
	CALL	FROM-LOWER-STAIRS
	RSTACK	


	.FUNCT	SKI-DOWN-STAIRS,CANDLE=0,MATCH=0
	EQUAL?	HERE,TOP-LANDING \FALSE
	FSET?	TOP-LANDING,EVERYBIT \?CND6
	FCLEAR	TOP-LANDING,EVERYBIT
	ADD	SCORE,10 >SCORE
?CND6:	PRINTI	"You shuffle over the edge of the landing, and quickly gain momentum as you sail down the stairs."
	CALL	FIND-IN,PLAYER,FLAMEBIT
	ZERO?	STACK /?CND9
	IN?	RED-CANDLE,PLAYER \?CND12
	FSET?	RED-CANDLE,FLAMEBIT \?CND12
	INC	'CANDLE
	CALL	BLOW-OUT-CANDLE,RED-CANDLE,TRUE-VALUE
?CND12:	IN?	WHITE-CANDLE,PLAYER \?CND17
	FSET?	WHITE-CANDLE,FLAMEBIT \?CND17
	INC	'CANDLE
	CALL	BLOW-OUT-CANDLE,WHITE-CANDLE,TRUE-VALUE
?CND17:	IN?	BLUE-CANDLE,PLAYER \?CND22
	FSET?	BLUE-CANDLE,FLAMEBIT \?CND22
	INC	'CANDLE
	CALL	BLOW-OUT-CANDLE,BLUE-CANDLE,TRUE-VALUE
?CND22:	EQUAL?	CANDLE,1,2,3 \?CND27
	PRINTI	" The candle"
	EQUAL?	CANDLE,2,3 \?CND30
	PRINTC	115
?CND30:	PRINTI	" in your hand blow"
	EQUAL?	CANDLE,1 \?CND33
	PRINTC	115
?CND33:	PRINTI	" out."
?CND27:	IN?	RED-MATCH,PLAYER \?CND36
	FSET?	RED-MATCH,FLAMEBIT \?CND36
	INC	'MATCH
	FCLEAR	RED-MATCH,ONBIT
	FCLEAR	RED-MATCH,FLAMEBIT
	REMOVE	RED-MATCH
	CALL	DEQUEUE,I-MATCH-BURN
?CND36:	IN?	GREEN-MATCH,PLAYER \?CND41
	FSET?	GREEN-MATCH,FLAMEBIT \?CND41
	INC	'MATCH
	FCLEAR	GREEN-MATCH,ONBIT
	FCLEAR	GREEN-MATCH,FLAMEBIT
	REMOVE	GREEN-MATCH
	CALL	DEQUEUE,I-MATCH-BURN
?CND41:	EQUAL?	MATCH,1,2 \?CND9
	PRINTI	" The match"
	EQUAL?	MATCH,2 \?CND49
	PRINTC	115
?CND49:	PRINTI	" in your hand blow"
	EQUAL?	MATCH,1 \?CND52
	PRINTC	115
?CND52:	PRINTI	" out and you drop "
	EQUAL?	MATCH,1 \?ELS57
	PRINTI	"it."
	JUMP	?CND9
?ELS57:	PRINTI	"them."
?CND9:	PRINTI	" Ahead of you is the gap in the stairs. Racing into the gap, your skis bow slightly, but your forward momentum pulls you across the gap. You hit the landing at the bottom of the stairs but don't stop. You continue down a short flight of stairs then sail onto the sandy beach. You quickly stop with the drag of the sand and a feeble attempt to snow plow."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	FROM-LOWER-STAIRS
	CALL	JIGS-UP,STR?206
	RFALSE	


	.FUNCT	WALKWAY-TO-BOAT-DOCK
	PRINTI	"You follow the wooden planking as it turns "
	EQUAL?	HERE,BOTTOM-LANDING \?ELS5
	PRINTI	"left and enters a cave arriving at..."
	CRLF	
	CRLF	
	RETURN	BOAT-DOCK
?ELS5:	PRINTI	"right and exits the cave arriving at..."
	CRLF	
	CRLF	
	RETURN	BOTTOM-LANDING


	.FUNCT	FIRE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's"
	CALL	APRINT,FIRE
	PRINTR	" in a shallow pit in the sand, probably left here by Morgan Fairchild and a friend earlier in the evening."
?ELS5:	EQUAL?	PRSA,V?RUB,V?MOVE,V?TAKE /?THN8
	EQUAL?	PRSA,V?LAMP-OFF \?ELS7
?THN8:	PRINTR	"You'd burn your hands, and besides, it might upset Morgan."
?ELS7:	EQUAL?	PRSA,V?POUR \?ELS11
	REMOVE	FIRE
	PRINTR	"With the skill of a seasoned firefighter, you extinguish the fire."
?ELS11:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?ELS13
	CALL	PERFORM,V?BURN,PRSO,FIRE
	RTRUE	
?ELS13:	EQUAL?	PRSA,V?ENTER \?ELS15
	PRINT	PYRO
	RTRUE	
?ELS15:	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	CANT-OPEN-CLOSE
	RSTACK	


	.FUNCT	SAND-F
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"It slips through your hands."

	.ENDI
