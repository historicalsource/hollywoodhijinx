

	.FUNCT	UPSTAIRS-HALL-MIDDLE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the middle of the upstairs hall. The hall stretches to the east and the west. To the south there is a"
	FSET?	UPSTAIRS-CD,OPENBIT \?ELS8
	PRINTI	"n open"
	JUMP	?CND6
?ELS8:	PRINTI	" closed"
?CND6:	PRINTI	" closet door. "
	FSET?	ATTIC-DOOR,OPENBIT \?ELS13
	PRINTI	"There is pull-down ladder extending from the floor into an open panel in the ceiling here."
	JUMP	?CND11
?ELS13:	PRINTI	"In the ceiling above you see the outline of a panel."
?CND11:	PRINTI	" You notice an unusual newel next to the stairs leading down."
	RTRUE	


	.FUNCT	UPSTAIRS-HALL-EAST-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the eastern end of the upstairs hall, which stretches west. Doorways lead north and south. There is a"
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT \?ELS8
	PRINTI	"n open"
	JUMP	?CND6
?ELS8:	PRINTI	" closed"
?CND6:	PRINTI	" window here"
	ZERO?	SACK-IN-WINDOW /?CND11
	PRINTI	". A blue velvet sack is barely visible, sticking out from beneath the closed window"
?CND11:	PRINTC	46
	RTRUE	


	.FUNCT	UPSTAIRS-HALL-EAST-EXIT-F
	FSET?	SACK,HAND-ON-SACK-BIT \?ELS5
	ZERO?	SACK-IN-WINDOW /?ELS5
	PRINTI	"You'll have to let go of the sack first."
	CRLF	
	RFALSE	
?ELS5:	EQUAL?	PRSO,P?NORTH \?ELS14
	RETURN	BEDROOM-2
?ELS14:	EQUAL?	PRSO,P?SOUTH \?ELS16
	RETURN	BEDROOM-3
?ELS16:	RETURN	UPSTAIRS-HALL-MIDDLE


	.FUNCT	FINCH-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's the Maltese finch"
	FSET?	FINCH,BROKEN-BIT \?CND6
	PRINTI	", well, pieces of the Maltese finch"
?CND6:	PRINTR	" from Uncle Buddy's knockoff of ""The Maltese Falcon."" In Uncle Buddy's updated version, a Humphrey Bogart look-alike plays the part of a pet shop owner."
?ELS5:	EQUAL?	PRSA,V?MUNG,V?THROW \FALSE
	FSET?	FINCH,BROKEN-BIT /FALSE
	CALL	ULTIMATELY-IN?,FINCH
	ZERO?	STACK /FALSE
	EQUAL?	PRSO,FINCH \FALSE
	CALL	SPECIAL-DROP
	ZERO?	STACK \FALSE
	MOVE	FINCH,HERE
	CALL	BREAK-FINCH
	RSTACK	


	.FUNCT	BREAK-FINCH,DONT-TELL=0
	FSET?	FINCH,BROKEN-BIT /FALSE
	PUTP	FINCH,P?VALUE,0
	FSET	FINCH,BROKEN-BIT
	ZERO?	DONT-TELL \?CND4
	PRINTI	"As your hand releases"
	CALL	TPRINT,PRSO
	PRINTI	", the sound of it smashing onto"
	CALL	TPRINT,GROUND
	PRINTI	" is masked only slightly by the almost inaudible sound of someone rolling over in his grave. Uncle Buddy perhaps?"
	CRLF	
?CND4:	FSET	FINCH,NARTICLEBIT
	PUTP	FINCH,P?SDESC,STR?138
	RTRUE	


	.FUNCT	SACK-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT /?ELS5
	ZERO?	SACK-IN-WINDOW /?ELS5
	PRINTI	"The "
	CALL	DPRINT,SACK
	PRINTI	" is just visible, stuck beneath the closed "
	CALL	DPRINT,SACK-WINDOW
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS9
	ZERO?	SACK-IN-WINDOW /?ELS9
	FSET?	SACK,HAND-ON-SACK-BIT /?ELS16
	FSET	SACK,HAND-ON-SACK-BIT
	PRINTR	"You grab hold of the top of the sack, but the rest of it is still under the closed window."
?ELS16:	PRINTR	"You already have your hand on it."
?ELS9:	EQUAL?	PRSA,V?DROP \?ELS20
	FSET?	SACK,HAND-ON-SACK-BIT \?ELS20
	CALL	PERFORM,V?LET-GO,SACK
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?LET-GO \?ELS24
	FSET?	SACK,HAND-ON-SACK-BIT \?ELS24
	FCLEAR	SACK,HAND-ON-SACK-BIT
	PRINTR	"You let go of the sack."
?ELS24:	EQUAL?	PRSA,V?OPEN \?ELS28
	ZERO?	SACK-IN-WINDOW /?ELS33
	PRINTI	"You can't open"
	CALL	TPRINT,SACK
	PRINTI	" when it's stuck in"
	CALL	TRPRINT,SACK-WINDOW
	RSTACK	
?ELS33:	GETP	FINCH,P?VALUE
	ZERO?	STACK /FALSE
	FSET	SACK,OPENBIT
	CALL	BOKS-BIG-ONE,FINCH
	ZERO?	STACK /?CND37
	EQUAL?	TREASURES-FOUND,10 /TRUE
?CND37:	PRINTI	"Opening the sack reveals"
	CALL	APRINT,FINCH
	PRINTR	"."
?ELS28:	EQUAL?	PRSA,V?THROW \?ELS43
	IN?	FINCH,SACK \?ELS43
	FSET?	FINCH,BROKEN-BIT /?ELS43
	CALL	BREAK-FINCH
	EQUAL?	HERE,ROOF-1,ROOF-2 \?ELS50
	MOVE	SACK,PATIO
	RTRUE	
?ELS50:	MOVE	SACK,HERE
	RTRUE	
?ELS43:	EQUAL?	PRSA,V?PULL \?ELS54
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT /?ELS54
	FSET?	SACK,HAND-ON-SACK-BIT \?ELS61
	PRINTR	"It's stuck under the window."
?ELS61:	PRINTI	"You pull on"
	CALL	TPRINT,SACK
	PRINTR	", but it's stuck under the window sill."
?ELS54:	EQUAL?	PRSA,V?PUT \FALSE
	FSET?	PRSO,FLAMEBIT \FALSE
	PRINTI	"Shouldn't you put out"
	CALL	TPRINT,PRSO
	PRINTR	" first?"


	.FUNCT	SACK-WINDOW-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	ZERO?	SACK-IN-WINDOW /?ELS10
	PRINTR	"The window is closed on the top of a cloth sack."
?ELS10:	PRINTI	"The "
	CALL	DPRINT,SACK-WINDOW
	PRINTI	" is "
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT \?ELS16
	PRINTI	"open"
	JUMP	?CND14
?ELS16:	PRINTI	"closed"
?CND14:	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS20
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT \?ELS23
	CALL	ALREADY-OPEN
	RTRUE	
?ELS23:	ZERO?	SACK-IN-WINDOW /?ELS25
	FSET?	SACK,HAND-ON-SACK-BIT \?ELS29
	FCLEAR	SACK,HAND-ON-SACK-BIT
	MOVE	SACK,PLAYER
	SET	'SACK-IN-WINDOW,FALSE-VALUE
	FSET	SACK-WINDOW,WINDOW-OPEN-BIT
	PRINTI	"With one hand you lift"
	CALL	TPRINT,SACK-WINDOW
	PRINTI	" and with the other you pull"
	CALL	TPRINT,SACK
	PRINTI	" inside."
	CRLF	
	JUMP	?CND27
?ELS29:	MOVE	SACK,SOUTHEAST-JUNCTION
	CALL	BREAK-FINCH,TRUE-VALUE
	PRINTI	"As you lift up"
	CALL	TPRINT,SACK-WINDOW
	PRINTC	44
	CALL	TPRINT,SACK
	PRINTI	" slides off"
	CALL	TPRINT,SACK-WINDOW
	PRINTI	" sill and falls to"
	CALL	TPRINT,GROUND
	PRINTI	" with a decided thud."
	CRLF	
?CND27:	FSET	SACK-WINDOW,WINDOW-OPEN-BIT
	FCLEAR	SACK,NDESCBIT
	FCLEAR	SACK,TRYTAKEBIT
	SET	'SACK-IN-WINDOW,FALSE-VALUE
	RTRUE	
?ELS25:	PRINTI	"You open"
	CALL	TRPRINT,SACK-WINDOW
	FSET	SACK-WINDOW,WINDOW-OPEN-BIT
	RTRUE	
?ELS20:	EQUAL?	PRSA,V?CLOSE \?ELS35
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT /?ELS40
	CALL	ALREADY-CLOSED
	RSTACK	
?ELS40:	PRINTI	"You close"
	CALL	TRPRINT,SACK-WINDOW
	FCLEAR	SACK-WINDOW,WINDOW-OPEN-BIT
	RTRUE	
?ELS35:	EQUAL?	PRSA,V?PUT \?ELS44
	EQUAL?	PRSI,SACK-WINDOW \?ELS44
	FSET?	SACK-WINDOW,WINDOW-OPEN-BIT \?ELS51
	PRINTI	"You toss"
	CALL	TPRINT,PRSO
	PRINTI	" out"
	CALL	TRPRINT,SACK-WINDOW
	EQUAL?	PRSO,BLUE-CANDLE,WHITE-CANDLE,RED-CANDLE \?CND52
	FSET?	PRSO,FLAMEBIT \?CND52
	CALL	BLOW-OUT-CANDLE,PRSO
?CND52:	EQUAL?	PRSO,FINCH \?ELS63
	FSET?	FINCH,BROKEN-BIT \?THN60
?ELS63:	CALL	ULTIMATELY-IN?,FINCH,SACK
	ZERO?	STACK /?CND57
	FSET?	FINCH,BROKEN-BIT /?CND57
?THN60:	CALL	BREAK-FINCH,TRUE-VALUE
?CND57:	MOVE	PRSO,SOUTHEAST-JUNCTION
	RTRUE	
?ELS51:	PRINTR	"But it's not open!"
?ELS44:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	CALL	PERFORM,V?LOOK-INSIDE,WINDOW
	RTRUE	


	.FUNCT	UPSTAIRS-HALL-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is the western end of the upstairs hall, which stretches east. There are doorways leading to the north and south."
	FSET?	UPSTAIRS-HALL-WEST,EVERYBIT \TRUE
	RANDOM	100
	LESS?	50,STACK /TRUE
	FCLEAR	UPSTAIRS-HALL-WEST,EVERYBIT
	PRINTI	" Hmmm. You have the uneasy feeling that someone is watching you."
	RTRUE	


	.FUNCT	BEDROOM-2-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This was the guest room you shared with Cousin Herman during your summer visits. A quick glance at the bunk beds and you remember all too well the night in the bottom bunk when Cousin Herman got sick in the top bunk. "
	RANDOM	100
	LESS?	50,STACK /?CND6
	PRINTI	"You got even with him later. While he was asleep you squirted honey up his nose. When he ran and told Aunt Hildegarde what you had done, she didn't believe it was honey and told him he shouldn't be out of bed with such a bad cold. "
?CND6:	PRINTI	"A doorway leads south."
	RTRUE	


	.FUNCT	HANDLES-F
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"You grip the handles firmly and imagine one of Uncle Buddy's guests clutching them in a drunken stupor. After a minute, you begin to feel a bit of nausea and let go of the handles."


	.FUNCT	UPSTAIRS-BATHROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"It's a Hollywood bathroom. Everything from the temperature-controlled marble toilet seat to the Oscars for hot and cold water is overdone. The shower has a gold curtain and you can't help but notice the bath mat with Jack Valenti's picture on it"
	FSET?	BATH-MAT,TOUCHBIT \?CND6
	PRINTI	" has been moved"
?CND6:	PRINTC	46
	RTRUE	


	.FUNCT	BATH-PSEUDO
	EQUAL?	PRSA,V?WALK,V?LAMP-ON,V?TAKE /?THN6
	EQUAL?	PRSA,V?USE,V?BOARD,V?ENTER \FALSE
?THN6:	PRINTR	"Sorry, the water has been turned off."


	.FUNCT	BATH-MAT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's a rubber bath mat with a picture of the President of the Academy of Motion Picture Arts and Sciences, Jack Valenti, on it."
?ELS5:	EQUAL?	PRSA,V?PUT-ON \?ELS7
	EQUAL?	PRSI,BATH-MAT \?ELS7
	PRINTR	"Jack wouldn't like that."
?ELS7:	EQUAL?	PRSA,V?RAISE,V?MOVE,V?LOOK-UNDER \?ELS11
	FSET?	RED-CARD,INVISIBLE \?ELS11
	FCLEAR	RED-CARD,INVISIBLE
	PRINTI	"You move"
	CALL	TPRINT,BATH-MAT
	PRINTI	" and see"
	CALL	APRINT,RED-CARD
	PRINTR	" lying on the floor of the bathroom."
?ELS11:	EQUAL?	PRSA,V?TAKE \FALSE
	FSET?	RED-CARD,INVISIBLE \FALSE
	CALL	ITAKE
	ZERO?	STACK /TRUE
	FCLEAR	RED-CARD,INVISIBLE
	PRINTI	"As you take"
	CALL	TPRINT,BATH-MAT
	PRINTI	" you notice"
	CALL	APRINT,RED-CARD
	PRINTR	" lying on the floor of the bathroom."


	.FUNCT	UPSTAIRS-CD-F
	EQUAL?	PRSA,V?OPEN \FALSE
	FSET?	UPSTAIRS-CD,OPENBIT /FALSE
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE /FALSE
	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \FALSE
	CALL	OPEN-DOOR-TO-SHAFT
	FSET	UPSTAIRS-CD,OPENBIT
	RTRUE	


	.FUNCT	OPEN-DOOR-TO-SHAFT
	PRINTI	"You open the door and see the "
	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS9
	EQUAL?	CLOSET-FLOOR,FOYER /?THN6
?ELS9:	EQUAL?	HERE,FOYER \?ELS5
	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS5
?THN6:	PRINTR	"top of the closet at floor level and the shaft continuing upwards."
?ELS5:	EQUAL?	HERE,CELLAR \?ELS17
	EQUAL?	CLOSET-FLOOR,FOYER /?THN14
?ELS17:	EQUAL?	HERE,FOYER \?ELS19
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE /?THN14
?ELS19:	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS13
	EQUAL?	CLOSET-FLOOR,ATTIC \?ELS13
?THN14:	PRINTI	"bottom of the closet at ceiling level"
	EQUAL?	HERE,FOYER,UPSTAIRS-HALL-MIDDLE \?CND22
	PRINTI	" and a shaft below"
?CND22:	PRINTR	"."
?ELS13:	EQUAL?	HERE,CELLAR \?ELS30
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE /?THN27
?ELS30:	EQUAL?	HERE,UPSTAIRS-HALL-MIDDLE \?ELS26
	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS26
?THN27:	EQUAL?	HERE,CELLAR \?ELS35
	PRINTI	"bottom of the closet far above"
	JUMP	?CND33
?ELS35:	PRINTI	"top of the closet far below"
?CND33:	PRINTR	"."
?ELS26:	EQUAL?	HERE,ATTIC \FALSE
	PRINTI	"top of the closet "
	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS42
	PRINTI	"at floor level"
	JUMP	?CND40
?ELS42:	EQUAL?	CLOSET-FLOOR,CELLAR \?ELS44
	PRINTI	"far below"
	JUMP	?CND40
?ELS44:	PRINTI	"below"
?CND40:	PRINTR	"."


	.FUNCT	TO-FOYER-F
	FSET?	NEWEL,NEWEL-TURNED-BIT /?ELS5
	PRINTI	"As you step onto the first step, the staircase flattens and you slide down the flattened stairs"
	RANDOM	100
	LESS?	50,STACK /?CND6
	PRINTI	", experiencing for a split second the euphoria only an Olympic bobsledder can know"
?CND6:	PRINTI	". After you slide into the foyer, the stairs return to normal."
	CRLF	
	CRLF	
	RETURN	FOYER
?ELS5:	FSET?	SKIS,WORNBIT \?ELS13
	PRINT	SNOWPLOW
	CRLF	
	CRLF	
	RETURN	FOYER
?ELS13:	PRINTI	"You walk down the stairs to the..."
	CRLF	
	CRLF	
	RETURN	FOYER


	.FUNCT	UPSTAIRS-CLOSET-ENTER-F
	FSET?	UPSTAIRS-CD,OPENBIT /?ELS5
	CALL	ITS-CLOSED,UPSTAIRS-CD
	RFALSE	
?ELS5:	EQUAL?	CLOSET-FLOOR,UPSTAIRS-HALL-MIDDLE \?ELS7
	RETURN	CLOSET
?ELS7:	EQUAL?	CLOSET-FLOOR,FOYER \?ELS9
	RETURN	CLOSET-TOP
?ELS9:	PRINTI	"You enter the shaft and plunge down a floor. A bit shaken, you find yourself at..."
	CRLF	
	CRLF	
	RETURN	CLOSET-TOP


	.FUNCT	PHONE-F
	EQUAL?	PRSA,V?REPLY \?ELS5
	PRINTR	"It wasn't ringing."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS7
	FSET?	PHONE,PHONE-DEAD-BIT \?ELS12
	PRINTR	"You don't hear a dial tone. The line is dead."
?ELS12:	PRINTR	"You hear a dial tone."
?ELS7:	EQUAL?	PRSA,V?PHONE \?ELS16
	EQUAL?	PRSO,PHONE \?ELS16
	PRINTR	"You should dial a number, such as 911."
?ELS16:	EQUAL?	PRSA,V?HANG-UP \FALSE
	PRINTR	"You replace the receiver."


	.FUNCT	THERE-DOESNT-SEEM
	PRINTI	"There doesn't seem to be"
	RTRUE	


	.FUNCT	V-PHONE
	CALL	GLOBAL-IN?,PHONE,HERE
	ZERO?	STACK \?ELS5
	CALL	THERE-DOESNT-SEEM
	CALL	APRINT,PHONE
	PRINTR	" here."
?ELS5:	ZERO?	PRSI /?ELS7
	EQUAL?	PRSI,PHONE /?ELS7
	PRINTI	"Too bad"
	CALL	TPRINT,PRSI
	PRINTR	" isn't a telephone."
?ELS7:	FSET?	PHONE,PHONE-DEAD-BIT \?ELS11
	PRINTR	"You don't hear a dial tone. The line is dead."
?ELS11:	EQUAL?	PRSO,INTNUM \?ELS13
	GRTR?	P-EXCHANGE,999 /?THN19
	GRTR?	P-NUMBER,9999 \?ELS18
?THN19:	PRINTR	"You dialed too many numbers. Remember what Aunt Hildegarde thought about guests making long distance calls!"
?ELS18:	ZERO?	P-EXCHANGE \?ELS26
	ZERO?	P-NUMBER /?THN23
?ELS26:	EQUAL?	P-EXCHANGE,555 \?ELS28
	EQUAL?	P-NUMBER,1212 /?THN23
?ELS28:	ZERO?	P-EXCHANGE \?ELS22
	EQUAL?	P-NUMBER,411 \?ELS22
?THN23:	PRINTR	"You hear a lazy voice come on the line. ""You have reached the Malibu phone company. Our operator is busy now. Mellow out and try your call again later."""
?ELS22:	ZERO?	P-EXCHANGE \?ELS32
	EQUAL?	P-NUMBER,911 \?ELS32
	PRINTR	"A police officer answers the phone in mid-snore saying he'll send a car right over, then hangs up and goes back to sleep."
?ELS32:	EQUAL?	P-EXCHANGE,492 \?ELS36
	EQUAL?	P-NUMBER,6000 \?ELS36
	PRINTR	"You hear voice talking at a fast pace trying to announce all the information necessary in 30 seconds. The voice says, ""Thank you for calling Infocom. We are closed now. Please call back during regular business hours, Monday through Friday, 9 a.m. to 6 p.m., Eastern Standard Time."" Then the voice speeds up even more, giving information for technical problems and the special numbers to call. Finally you hear the voice take a deep breath and say, ""Have a nice (BEEP),"" and the message ends."
?ELS36:	EQUAL?	P-EXCHANGE,576 \?ELS40
	EQUAL?	P-NUMBER,1851 \?ELS40
	PRINTI	"A nerdish voice answers"
	CALL	TPRINT,PHONE
	PRINTR	" saying, ""Hello, this is Roy G. Biv, Computer Service and Repair. Our office is closed now. Please call back during our regular business hours."""
?ELS40:	EQUAL?	P-EXCHANGE,576 \?ELS44
	EQUAL?	P-NUMBER,3190 \?ELS44
	FSET?	TOUPEE,CARDS-RIGHT-BIT \?ELS51
	FSET	PHONE,PHONE-DEAD-BIT
	MOVE	TOUPEE,HOPPER
	PRINTR	"An answering machine comes on the line. It sounds like Aunt Hildegarde's voice saying, ""I can't come to the phone right now. I'm dead. Don't forget to look in the hopper."" Then the line goes dead."
?ELS51:	PRINTR	"You get a busy signal."
?ELS44:	RANDOM	100
	LESS?	60,STACK /?ELS55
	PRINTI	"The "
	CALL	DPRINT,PHONE
	PRINTR	" rings and rings, but no one answers."
?ELS55:	PRINTI	"The "
	CALL	DPRINT,PHONE
	PRINTR	" is answered, ""Hello? Hello? Hey, what is this, a crank call? You made my wife cry the last time you called, you pervert."" You hear the receiver slammed down."
?ELS13:	PRINTI	"There's no sense in phoning"
	CALL	ARPRINT,PRSO
	RSTACK	


	.FUNCT	TOILET-F
	EQUAL?	PRSO,TOILET \FALSE
	EQUAL?	PRSA,V?SIT,V?USE,V?WALK \?ELS10
	PRINTR	"You'll have to hold it in. The water's been shut off, remember?"
?ELS10:	EQUAL?	PRSA,V?SMELL,V?LOOK-INSIDE \?ELS12
	PRINTR	"The toilet is immaculate. Nosey, aren't you?"
?ELS12:	EQUAL?	PRSA,V?FLUSH \FALSE
	PRINTR	"You pull the handle, but nothing happens. The water has been shut off."


	.FUNCT	SEAT-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	EQUAL?	PRSO,SEAT \?ELS5
	PRINT	RIDICULOUS
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS9
	EQUAL?	PRSI,SEAT,SOFA \?ELS9
	FCLEAR	PRSO,WEARBIT
	MOVE	PRSO,HERE
	PRINTI	"It seems a shame to mar"
	CALL	TPRINT,PRSI
	PRINTI	" with"
	CALL	APRINT,PRSO
	PRINTR	", so you put it on the floor instead."
?ELS9:	EQUAL?	PRSA,V?SIT,V?BOARD,V?CLIMB-ON /?THN14
	EQUAL?	PRSA,V?ENTER \FALSE
?THN14:	PRINTR	"You sit down and relax for a moment. Soon your mind begins to ponder your Aunt's wealth and you jump to your feet, ready to continue."


	.FUNCT	BED-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	EQUAL?	PRSO,BED \?ELS5
	PRINT	RIDICULOUS
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?BOARD,V?CLIMB-ON,V?LIE-DOWN /?THN10
	EQUAL?	PRSA,V?ENTER,V?SIT \?ELS9
?THN10:	PRINTR	"You get into bed and relax for a moment. Soon your mind begins to ponder your Aunt's wealth and you jump to your feet, ready to continue."
?ELS9:	EQUAL?	PRSA,V?PUT-ON,V?PUT \?ELS13
	EQUAL?	PRSI,BED \?ELS13
	MOVE	PRSO,HERE
	PRINTI	"Rather than marring the bed's fine linen with"
	CALL	APRINT,PRSO
	PRINTR	", you put it on the floor."
?ELS13:	EQUAL?	PRSA,V?PUSH-TO,V?PUSH \FALSE
	PRINT	RIDICULOUS
	CRLF	
	RTRUE	


	.FUNCT	I-SANDS-OF-TIME,X=0,MINUTES,CNT=0,TCNT=0,TNUM,FOLLOW-THE-LAWYER=0
	ADD	MOVES,1260 >MINUTES
	EQUAL?	MINUTES,1859 \?ELS3
	SET	'X,60
	CALL	MICKEY-MOUSE,2,STR?144
	JUMP	?CND1
?ELS3:	EQUAL?	MINUTES,1919 \?ELS5
	SET	'X,30
	CALL	MICKEY-MOUSE,1,STR?145
	JUMP	?CND1
?ELS5:	EQUAL?	MINUTES,1949 \?ELS7
	SET	'X,30
	CALL	MICKEY-MOUSE,30,STR?146
	JUMP	?CND1
?ELS7:	EQUAL?	MINUTES,1979 \?CND1
	EQUAL?	HERE,FOYER,FRONT-PORCH,SOUTH-JUNCTION \?CND10
	FSET	LIVING-ROOM,ONBIT
	SET	'FOLLOW-THE-LAWYER,TRUE-VALUE
	CRLF	
	PRINT	OUT-OF-NOWHERE
	PRINTI	"""Ah, there you are. Let's go into the living room and talk,"" says the lawyer. You follow him to the living room."
	CRLF	
	CRLF	
	CALL	GOTO,LIVING-ROOM
	CRLF	
?CND10:	IN?	PLAYER,LIVING-ROOM \?ELS15
	ZERO?	FOLLOW-THE-LAWYER \?CND16
	CRLF	
	PRINT	OUT-OF-NOWHERE
?CND16:	PRINTI	"""Well, let's wrap this up quickly, I've got to be in court for the LaFlank divorce this afternoon,"" the lawyer snaps. He pauses for a moment, glancing around the room"
	GET	TREASURE-TABLE,0 >TNUM
?PRG19:	IGRTR?	'CNT,TNUM /?REP20
	GET	TREASURE-TABLE,CNT >X
	CALL	VISIBLE?,X
	ZERO?	STACK /?PRG19
	INC	'TCNT
	JUMP	?PRG19
?REP20:	ZERO?	TCNT \?ELS29
	PRINTI	". ""Uhh, I don't see any 'treasures.'"
	JUMP	?CND27
?ELS29:	EQUAL?	TCNT,10 \?ELS31
	PRINTI	" then at a small note pad in his hand. He congratulates you for finding all the ""treasures."" ""But you didn't follow your aunt's instructions in the note."
	JUMP	?CND27
?ELS31:	PRINTI	" then at a small note pad in his hand. ""Uhh, I only count "
	GET	NUMWORDS,TCNT
	PRINT	STACK
	PRINTI	" 'treasure"
	EQUAL?	TCNT,1 /?CND34
	PRINTC	115
?CND34:	PRINTI	"' here."
?CND27:	PRINTI	" I'm sorry, but you won't be inheriting Mrs. Burbank's estate after all,"" says the lawyer. He turns and leaves as his words echo in your head. Then you feel a sharp pain in your backside, as you kick yourself for not having "
	EQUAL?	TCNT,10 \?ELS39
	PRINTI	"followed the instructions in the note"
	JUMP	?CND37
?ELS39:	EQUAL?	TREASURES-FOUND,10 \?ELS41
	PRINTI	"brought all the ""treasures"" you found to the living room"
	JUMP	?CND37
?ELS41:	ZERO?	TREASURES-FOUND \?ELS43
	PRINTI	"found any of the ""treasures"""
	JUMP	?CND37
?ELS43:	PRINTI	"found all the ""treasures"" in time"
?CND37:	PRINTC	46
	CRLF	
	JUMP	?CND13
?ELS15:	PRINTI	"Your time is up! "
	EQUAL?	TREASURES-FOUND,10 \?ELS50
	PRINTI	"You did a good job by finding all the ""treasures,"" but you didn't meet the lawyer at 9 a.m."
	JUMP	?CND48
?ELS50:	GRTR?	TREASURES-FOUND,0 \?ELS52
	PRINTI	"You only found "
	GET	NUMWORDS,TREASURES-FOUND
	PRINT	STACK
	PRINTI	" of the ten ""treasures."""
	JUMP	?CND48
?ELS52:	PRINTI	"What a bozo! You didn't find any ""treasures."" You're not fit to be fertilizer for the family tree! Are you sure you're a Burbank? I'd go on but there is only so much room on a disk."
?CND48:	PRINTI	" You can't help but think about how disappointed Aunt Hildegarde and Uncle Buddy would have been with you right now. Never mind your own disappointment of missing out on inheriting a fortune."
?CND13:	SET	'MOVES,720
	USL	
	CALL	FINISH
?CND1:	CALL	QUEUE,I-SANDS-OF-TIME,X
	RSTACK	


	.FUNCT	MICKEY-MOUSE,NUM,STRING
	CRLF	
	PRINTI	"[Hurry up, you only have "
	PRINTN	NUM
	PRINTC	32
	PRINT	STRING
	PRINTR	" left!]"

	.ENDI
