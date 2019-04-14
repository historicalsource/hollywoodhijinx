

	.FUNCT	NOTE-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?READ \FALSE
	FSET?	NOTE,READBIT /?CND6
	FSET	NOTE,READBIT
	CALL	PICK-ONE,CUPID-COMBS >CUPID-KEY
?CND6:	PRINTI	"Dearie, The magic number is """
	GET	CUPID-KEY,0
	PRINTN	STACK
	PRINTR	"."" Love, Aunt Hildegard"


	.FUNCT	FLASHLIGHT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	FSET?	FLASHLIGHT,WETBIT \?ELS10
	PRINTR	"The soggy flashlight is switched on, but isn't working."
?ELS10:	PRINTI	"The "
	CALL	DPRINT,FLASHLIGHT
	PRINTI	" is turned "
	FSET?	FLASHLIGHT,ONBIT \?ELS21
	PRINTI	"on"
	RTRUE	
?ELS21:	PRINTI	"off"
	PRINTC	46
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LAMP-ON \?ELS31
	FSET?	FLASHLIGHT,WETBIT \?ELS34
	PRINTR	"You can't turn it on now, it's ruined. You took it in the water!"
?ELS34:	FSET?	FLASHLIGHT,ONBIT \?ELS38
	PRINTR	"It's already on."
?ELS38:	FSET	FLASHLIGHT,ONBIT
	PRINTI	"Okay,"
	CALL	TPRINT,FLASHLIGHT
	PRINTI	" is now on."
	CRLF	
	ZERO?	LIT \TRUE
	SET	'LIT,TRUE-VALUE
	CRLF	
	CALL	V-LOOK
	RTRUE	
?ELS31:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	FSET?	FLASHLIGHT,WETBIT \?ELS52
	PRINTI	"It's wet. It's ruined. Who cares if it's on or off?"
	RTRUE	
?ELS52:	FSET?	FLASHLIGHT,ONBIT \?ELS56
	FCLEAR	FLASHLIGHT,ONBIT
	PRINTI	"Okay,"
	CALL	TPRINT,FLASHLIGHT
	PRINTR	" is now off."
?ELS56:	PRINTR	"It's already off."


	.FUNCT	STAIRS-F
	EQUAL?	PRSA,V?PUSH-DOWN \?ELS5
	CALL	MOVE-OBJ-DOWN
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?SKI \FALSE
	CALL	DO-WALK,P?DOWN
	RSTACK	


	.FUNCT	FOYER-STAIRS-F
	EQUAL?	PRSA,V?PUSH-DOWN \?ELS5
	CALL	MOVE-OBJ-DOWN
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The stairs"
	ZERO?	RAMP /?ELS12
	PRINTI	", or what used to be the stairs is now a ramp"
	JUMP	?CND10
?ELS12:	PRINTI	" look like stairs and need a better desc"
?CND10:	PRINTC	46
	CRLF	
	RTRUE	


	.FUNCT	TO-UPSTAIRS-HALL
	FSET?	KNUEL,TOUCHBIT /?ELS5
	PRINTI	"You start to go up but suddenly the staircase flattens out and you slide back down the flatten stairs."
	CRLF	
	SET	'RAMP,TRUE-VALUE
	FSET	KNUEL,TOUCHBIT
	RFALSE	
?ELS5:	ZERO?	RAMP /?ELS9
	PRINTI	"You start to go up the flatten stairs but slide back down."
	CRLF	
	RFALSE	
?ELS9:	RETURN	UPSTAIRS-HALL


	.FUNCT	KNUEL-F
	EQUAL?	PRSA,V?TURN \FALSE
	PRINTI	"You turn"
	CALL	TPRINT,KNUEL
	PRINTI	" and the "
	FSET	KNUEL,TOUCHBIT
	ZERO?	RAMP /?ELS10
	PRINTI	"ramp becomes stairs"
	SET	'RAMP,FALSE-VALUE
	JUMP	?CND8
?ELS10:	PRINTI	"stairs become a ramp"
	SET	'RAMP,TRUE-VALUE
?CND8:	PRINTC	46
	CRLF	
	RTRUE	


	.FUNCT	FOYER-CLOSET-ENTER-F
	FSET?	FOYER-CD,OPENBIT /?ELS5
	CALL	ITS-CLOSED,FOYER-CD
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS7
	RETURN	CLOSET
?ELS7:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS9
	RETURN	CLOSET-TOP-2
?ELS9:	CALL	JIGS-UP,STR?81
	RFALSE	


	.FUNCT	ARMOR-F,OARG=0
	ZERO?	OARG /?ELS5
	PRINTI	"Standing demurely in the corner is a suit or armor, somewhat reminiscent of the suits of armor that once graced the castle of Winston Churchill. It is currrently in the position that Masters and Johnson described as "
	GET	ARMOR-DESCS,ARMOR-DESC-NUM
	PRINT	STACK
	PRINTC	46
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	ARMOR-F,M-OBJDESC
	RSTACK	


	.FUNCT	I-ARMOR-MOVE
	EQUAL?	HERE,FOYER \?ELS3
	CALL	QUEUE,I-ARMOR-MOVE,2
	RFALSE	
?ELS3:	INC	'ARMOR-DESC-NUM
	EQUAL?	ARMOR-DESC-NUM,7 \FALSE
	SET	'ARMOR-DESC-NUM,0
	RFALSE	


	.FUNCT	CELLAR-RAMP-F
	EQUAL?	PRSA,V?PUSH-DOWN \FALSE
	CALL	MOVE-OBJ-DOWN
	RSTACK	


	.FUNCT	CELLAR-CLOSET-ENTER-F
	FSET?	CELLAR-CD,OPENBIT /?ELS5
	CALL	ITS-CLOSED,CELLAR-CD
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS7
	RETURN	CLOSET
?ELS7:	RETURN	SHAFT-BOTTOM


	.FUNCT	TO-FOYER-F
	ZERO?	RAMP /?ELS5
	PRINTI	"You slide down the flattened stairs."
	CRLF	
	RETURN	FOYER
?ELS5:	RETURN	FOYER


	.FUNCT	UPSTAIRS-CLOSET-ENTER-F
	FSET?	UPSTAIRS-CD,OPENBIT /?ELS5
	CALL	ITS-CLOSED,UPSTAIRS-CD
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL \?ELS7
	RETURN	CLOSET
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	RETURN	CLOSET-TOP-3
?ELS9:	CALL	JIGS-UP,STR?91
	RSTACK	


	.FUNCT	CLOSET-EXIT-F,DOOR
	CALL	WHICH-DOOR? >DOOR
	FSET?	DOOR,OPENBIT /?ELS5
	CALL	ITS-CLOSED,CLOSET-DOOR
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS7
	RETURN	CELLAR
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	RETURN	FOYER
?ELS9:	RETURN	UPSTAIRS-HALL


	.FUNCT	WHICH-DOOR?
	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS5
	RETURN	CELLAR-CD
?ELS5:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS7
	RETURN	FOYER-CD
?ELS7:	RETURN	UPSTAIRS-CD


	.FUNCT	CLOSET-REF-F
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE \FALSE
	EQUAL?	HERE,FOYER \?ELS8
	CALL	LOOK-IN-CLOSET,FOYER-CD
	RTRUE	
?ELS8:	EQUAL?	HERE,UPSTAIRS-HALL \?ELS10
	CALL	LOOK-IN-CLOSET,UPSTAIRS-CD
	RTRUE	
?ELS10:	CALL	LOOK-IN-CLOSET,CELLAR-CD
	RTRUE	


	.FUNCT	LOOK-IN-CLOSET,DOOR
	FSET?	DOOR,OPENBIT /?ELS5
	CALL	ITS-CLOSED,DOOR
	RSTACK	
?ELS5:	EQUAL?	CLOSET-FLOOR,HERE \?ELS7
	PRINTI	"You see "
	CALL	DESCRIBE-CONTENTS,CLOSET,-1
	PRINTC	46
	CRLF	
	RTRUE	
?ELS7:	PRINTR	"You see a dark shaft."


	.FUNCT	PEGS-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"You see three rather worn coat pegs."


	.FUNCT	PEG-3-F
	EQUAL?	PRSA,V?PUSH,V?PULL,V?MOVE /?THN6
	EQUAL?	PRSA,V?RUB,V?LOWER,V?RAISE \FALSE
?THN6:	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL \?ELS10
	CALL	HUM
	JUMP	?CND8
?ELS10:	PRINTI	"The closet moves up "
	EQUAL?	CLOSET-FLOOR,FOYER \?ELS17
	PRINTI	"a floor"
	JUMP	?CND15
?ELS17:	PRINTI	"two floors"
?CND15:	PRINTI	" to the upstairs hall."
	CRLF	
	SET	'CLOSET-FLOOR,UPSTAIRS-HALL
?CND8:	FSET?	UPSTAIRS-CD,OPENBIT \?ELS28
	FSET	CLOSET-DOOR,OPENBIT
	RTRUE	
?ELS28:	FCLEAR	CLOSET-DOOR,OPENBIT
	RTRUE	


	.FUNCT	PEG-2-F
	EQUAL?	PRSA,V?PUSH,V?PULL,V?MOVE /?THN6
	EQUAL?	PRSA,V?RUB,V?LOWER,V?RAISE \FALSE
?THN6:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS10
	CALL	HUM
	JUMP	?CND8
?ELS10:	PRINTI	"The closet moves "
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL \?ELS17
	PRINTI	"down a floor"
	JUMP	?CND15
?ELS17:	PRINTI	"up a floor"
?CND15:	PRINTI	" to the front hall."
	CRLF	
	SET	'CLOSET-FLOOR,FOYER
?CND8:	FSET?	FOYER-CD,OPENBIT \?ELS28
	FSET	CLOSET-DOOR,OPENBIT
	RTRUE	
?ELS28:	FCLEAR	CLOSET-DOOR,OPENBIT
	RTRUE	


	.FUNCT	PEG-1-F
	EQUAL?	PRSA,V?PUSH,V?PULL,V?MOVE /?THN6
	EQUAL?	PRSA,V?RUB,V?LOWER,V?RAISE \FALSE
?THN6:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS10
	CALL	HUM
	JUMP	?CND8
?ELS10:	PRINTI	"The closet moves down "
	EQUAL?	CLOSET-FLOOR,FOYER \?ELS17
	PRINTI	"a floor"
	JUMP	?CND15
?ELS17:	PRINTI	"two floors"
?CND15:	PRINTI	" to the cellar."
	CRLF	
	SET	'CLOSET-FLOOR,CELLAR
?CND8:	FSET?	CELLAR-CD,OPENBIT \?ELS28
	FSET	CLOSET-DOOR,OPENBIT
	RTRUE	
?ELS28:	FCLEAR	CLOSET-DOOR,OPENBIT
	RTRUE	


	.FUNCT	HUM
	PRINTR	"You hear a humming noise."


	.FUNCT	VERTICAL-MAP-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?ELS5
	PRINTR	"You see the following:~  
       
   
   
            
    
   
~ 
     
 
 
 
 
 
 
 
  
 
   
  
 
 
 
~ 
     
 
 
   
   
 
         
 
   
 
~ 
     
 
 
         
 
     
 
 
   
 
~ 
     
   
 
     
 
 
 
 
 
 
 
 
 
 
~ 
 
         
       
 
 
 
 
   
 
 
 
~ 
 
 
   
     
 
   
 
 
 
 
 
 
 
 
 
~ 
 
 
 
 
     
 
 
   
 
   
 
 
 
   
~ 
 
 
 
 
         
 
 
       
       
~ 
 
             
 
 
 
             
 
~ 
       
       
   
         
 
 
 
 
~ 
   
 
 
 
   
 
 
 
 
 
     
 
 
 
 
~ 
 
 
 
 
 
 
 
 
 
   
 
     
   
 
 
~ 
 
 
 
   
 
 
 
 
       
         
 
~ 
 
 
 
 
 
 
 
 
 
 
     
 
   
     
~ 
 
   
 
 
     
 
         
 
 
     
~ 
 
   
 
         
 
   
   
 
 
     
~ 
 
 
 
  
   
 
  
 
 
 
 
 
 
 
     
~ 
   
    
            
   
   
       
~"
?ELS5:	EQUAL?	PRSA,V?PUT-ON \FALSE
	CALL	WHOLE-MAP
	RSTACK	


	.FUNCT	HORIZONTAL-MAP-F
	EQUAL?	PRSA,V?EXAMINE,V?READ \?ELS5
	PRINTR	"You see the following:~  _______________________________________~   _____             __   ___   __~  ____                __   ___ _~   ____     ___ ___    _______    ___~  ____         ___ __    ___~   ____ _ _    ___~     ________ __ ___~           ___     __~          __ __   _  __   ___       ___~        _  _______  x   _______ ______~    _____________ _ _   ______ ___~  ____     _____   __ __ ___ __~                           ___~                     __   _____ ___~                       ___   __ _____~              _     _  ___         ____~    ___     _____    ________     ____~          _____ ___                ____~        _   __    _               ____~  ___ ____ _________ __ ___ ___ _______~"
?ELS5:	EQUAL?	PRSA,V?PUT-ON \FALSE
	CALL	WHOLE-MAP
	RSTACK	


	.FUNCT	WHOLE-MAP
	PRINTI	"You see the following:~  _______________________________________~ 
 _____ 
   
   
   __   ___ 
 __ 
   
~ 
____ 
 
 
 
 
 
 
 
__
 
___
_ 
 
 
 
~ 
 ____
 
 
___
___
 
 _______ 
 
___
 
~ 
____ 
 
 
   ___ __
 
 ___ 
 
 
   
 
~ 
 ____
_ _
 
 ___ 
 
 
 
 
 
 
 
 
 
 
~ 
 
 ________
__ ___ 
 
 
 
 
   
 
 
 
~ 
 
 
   
 ___ 
 
 __
 
 
 
 
 
 
 
 
 
~ 
 
 
 
 
__ __
 
_
 __
 
___
 
 
 
___
~ 
 
 
 
_
 _______ 
x
 
_______
______ 
~ 
 
_____________
_
_
 
______ ___   
 
~ 
____   
 _____ 
 __
__ ___ __
 
 
 
 
~ 
   
 
 
 
   
 
 
 
 
 
 ___ 
 
 
 
 
~ 
 
 
 
 
 
 
 
 
 
 __
 
_____
___
 
 
~ 
 
 
 
   
 
 
 
 
   ___ 
 __ _____
 
~ 
 
 
 
 
 
 
_
 
 
_
 ___ 
 
   
 ____
~ 
 
___
 
 
_____
 
 ________
 
 
____ 
~ 
 
   
 
_____ ___
 
   
   
 
 
 ____
~ 
 
 
 
_ 
 __
 
 _
 
 
 
 
 
 
 
____ 
~ 
___
____
_________ __
___
___
_______
~"
	RTRUE	


	.FUNCT	BOWL-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	HELD?,FLASHLIGHT
	ZERO?	STACK /?ELS10
	FSET?	FLASHLIGHT,ONBIT \?ELS10
	PRINTR	"You shine your light on the bowl of the chandelier. Its thick, slick surface, covered with a rose-like pattern, reflects a rose colored light around the room. You can see a square shape in the bottom of the bowl."
?ELS10:	PRINTR	"The light from the flame reflects off the thick, slick surface of the  chandelier's bowl. You can barely make out a rose-like pattern on the bowl."


	.FUNCT	8-BALL-F
	EQUAL?	PRSA,V?TURN \FALSE
	PRINTI	"Looking into the bottom of the eight ball you the message"
	PRINTC	34
	CALL	PICK-ONE,EIGHTISMS
	PRINT	STACK
	PRINTR	"."""


	.FUNCT	POOL-TABLE-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"The pool table is made of the finest wood and on the table is"
	CALL	DESCRIBE-SENT,POOL-TABLE
	CRLF	
	RTRUE	


	.FUNCT	CUE-BALL-F
	EQUAL?	PRSA,V?SHOOT,V?DROP,V?PUT \FALSE
	EQUAL?	PRSI,POCKET \FALSE
	EQUAL?	PRSA,V?SHOOT \?ELS10
	CALL	HELD?,POOL-CUE
	ZERO?	STACK \?ELS13
	PRINTI	"You're not holding"
	CALL	TRPRINT,POOL-CUE
	RTRUE	
?ELS13:	IN?	CUE-BALL,POOL-TABLE /?ELS17
	PRINTI	"The "
	CALL	DPRINT,CUE-BALL
	PRINTI	" isn't on"
	CALL	TRPRINT,POOL-TABLE
	JUMP	?CND8
?ELS17:	PRINTI	"The ball speeds across the smooth, green surface into"
	CALL	TPRINT,POCKET
	PRINTI	". You"
	JUMP	?CND8
?ELS10:	PRINTI	"You "
	PRINTB	P-PRSA-WORD
	CALL	TPRINT,CUE-BALL
	PRINTI	" in"
	CALL	TPRINT,POCKET
	PRINTI	" and"
?CND8:	PRINTI	" hear it roll towards"
	CALL	TPRINT,BALL-RETURN
	PRINTI	". As"
	CALL	TPRINT,CUE-BALL
	PRINTI	" drops into the return, a panel on the east wall swings open."
	CRLF	
	MOVE	CUE-BALL,BALL-RETURN
	RTRUE	


	.FUNCT	RACKED-BALLS-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"You see a set of pool balls "
	CALL	HELD?,RACKED-BALLS
	ZERO?	STACK /?CND8
	PRINTI	"all glued to one another "
?CND8:	PRINTR	"in a triangle shape."


	.FUNCT	I-LIGHTS-DIM
	FSET?	HERE,OUTDOORSBIT \?ELS3
	PRINTI	"The sun is rapidly sinking into west. It's getting dark out here."
	CRLF	
	JUMP	?CND1
?ELS3:	FSET?	HERE,ONBIT \?CND1
	PRINTI	"The sun is going down. It's getting dark in here."
	CRLF	
?CND1:	CALL	QUEUE,I-LIGHTS-OUT,10
	RSTACK	


	.FUNCT	I-LIGHTS-OUT
	FCLEAR	FOYER,ONBIT
	FCLEAR	CLOSET,ONBIT
	FCLEAR	CELLAR,ONBIT
	PRINTI	"The sun has set. "
	CALL	LIT?,HERE >LIT
	ZERO?	LIT \?ELS7
	CALL	TOO-DARK
	RSTACK	
?ELS7:	CRLF	
	RTRUE	


	.FUNCT	WINDOW-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	ZERO?	SACK-IN-WINDOW /?ELS10
	FSET?	WINDOW,OPENBIT /?ELS10
	PRINTR	"The window is closed on a cloth which is tied in a knot. "
?ELS10:	PRINTI	"The "
	CALL	DPRINT,WINDOW
	PRINTI	" is "
	FSET?	WINDOW,OPENBIT \?ELS21
	PRINTI	"open."
	JUMP	?CND19
?ELS21:	PRINTI	"closed"
?CND19:	PRINTC	46
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS31
	FSET?	WINDOW,OPENBIT \?ELS36
	CALL	ALREADY-OPEN
	RSTACK	
?ELS36:	ZERO?	SACK-IN-WINDOW /?ELS38
	PRINTI	"As you lift up the window, the sack slides off the window ceil and falls to the ground with a decided thud."
	CRLF	
	FSET	WINDOW,OPENBIT
	SET	'SACK-IN-WINDOW,FALSE-VALUE
	RETURN	SACK-IN-WINDOW
?ELS38:	FSET?	WINDOW,RMUNGBIT \?ELS43
	PRINTI	"With one hand you lift the window and with the other you pull the sack inside. "
	CRLF	
	MOVE	SACK,PLAYER
	FSET?	WINDOW,OPENBIT
	SET	'SACK-IN-WINDOW,FALSE-VALUE
	RETURN	SACK-IN-WINDOW
?ELS43:	PRINTI	"You open the window."
	CRLF	
	FSET	WINDOW,OPENBIT
	SET	'SACK-IN-WINDOW,FALSE-VALUE
	RETURN	SACK-IN-WINDOW
?ELS31:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	WINDOW,OPENBIT /?ELS56
	CALL	ALREADY-CLOSED
	RSTACK	
?ELS56:	PRINTI	"You close"
	CALL	TRPRINT,WINDOW
	RSTACK	

	.ENDI
