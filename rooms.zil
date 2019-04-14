"ROOMS for ANTHILL: (C)1986 Infocom, Inc. All rights reserved."	

<OBJECT NOTE
	(IN PLAYER)
	(DESC "note")
	(LDESC
"The personal journal of Belboz the Necromancer is lying here.")
	(SYNONYM NOTE PAPER)
	(ADJECTIVE WHITE)
	(FLAGS TAKEBIT)
	(SIZE 5)
	(ACTION NOTE-F)>

<ROUTINE NOTE-F ()
	 <COND (<VERB? READ EXAMINE LOOK-INSIDE>
		<COND (<NOT <FSET? ,NOTE ,READBIT>>
		       <FSET ,NOTE ,READBIT>
		       <SETG CUPID-KEY <PICK-ONE ,CUPID-COMBS>>)>
	        <TELL
"Dearie,
The magic number is \"" N <GET ,CUPID-KEY 0> ".\"
Love, Aunt Hildegard" CR>
	       <RTRUE>)>>

<OBJECT FLASHLIGHT
	(IN PLAYER)
	(SYNONYM FLASHLIGHT LIGHT TORCH LAMP)
	(ADJECTIVE FLASH)
	(DESC "flashlight")
	(FLAGS TIEBIT TAKEBIT) 
	(SIZE 5)
	(VALUE 0)
	(ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,FLASHLIGHT ,WETBIT>
		       <TELL 
"The soggy flashlight is switched on, but isn't working." CR>)
		      (T
         	       <TELL "The " D ,FLASHLIGHT " is turned ">
         	       <COND (<FSET? ,FLASHLIGHT ,ONBIT>
			      <TELL "on">)
	       		     (T
			      <TELL "off">
			      <TELL "." CR>)>)>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,FLASHLIGHT ,WETBIT>
		       <TELL
"You can't turn it on now, it's ruined. You took it in the water!" CR>)
                      (<FSET? ,FLASHLIGHT ,ONBIT>
		       <TELL "It's already on." CR>)
		      (T
		       <FSET ,FLASHLIGHT ,ONBIT>
		       <TELL "Okay," T ,FLASHLIGHT " is now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT T>
			      <CRLF>
			      <V-LOOK>)>)>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,FLASHLIGHT ,WETBIT>
                       <TELL
"It's wet. It's ruined. Who cares if it's on or off?">)
                      (<FSET? ,FLASHLIGHT ,ONBIT>
		       <FCLEAR ,FLASHLIGHT ,ONBIT>
		       <TELL "Okay," T ,FLASHLIGHT " is now off." CR>)
		      (T
		       <TELL "It's already off." CR>)>
		<RTRUE>)>>

<OBJECT STAIRS ;"front porch steps, cellar stairs"
	(IN LOCAL-GLOBALS)
	(DESC "stairs")
	(SYNONYM STAIRS STAIRCASE STEPS)
	(ADJECTIVE STEEP)
	(FLAGS NDESCBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? PUSH-DOWN>
		<MOVE-OBJ-DOWN>)
	       (<VERB? SKI>
		<DO-WALK ,P?DOWN>)>>

"--- Inside House ---"
"--- Foyer ---"

<ROOM FOYER
      (IN ROOMS)
      (DESC "Foyer")
      (LDESC "This is the foyer of a large, aged house. To the south
is the front door. There is a closet here.")
      (SOUTH TO FRONT-PORCH IF OAK-DOOR IS OPEN)
      (IN PER FOYER-CLOSET-ENTER-F)
      (EAST TO OUTSIDE-PARLOR)
      (UP PER TO-UPSTAIRS-HALL)
      (DOWN TO CELLAR) ;"for testing only"
      (NORTH TO GAME-ROOM) ;"for testing only"
      (WEST TO LIVING-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL OAK-DOOR FOYER-CD CLOSET-REF FOYER-STAIRS KNUEL)>

<OBJECT FOYER-CD
	(IN LOCAL-GLOBALS)
	(DESC "foyer closet door")
        (SYNONYM DOOR)
	(ADJECTIVE FOYER CLOSET)
        (FLAGS DOORBIT NDESCBIT)>

<OBJECT FOYER-STAIRS
	(IN LOCAL-GLOBALS)
	(DESC "stairs")
	(SYNONYM STAIRS STAIRCASE STEPS)
	(ADJECTIVE FOYER)
	(FLAGS NDESCBIT)
	(ACTION FOYER-STAIRS-F)>

<ROUTINE FOYER-STAIRS-F ()
	 <COND (<VERB? PUSH-DOWN>
		<MOVE-OBJ-DOWN>)
	       (<VERB? EXAMINE>
		<TELL "The stairs"> ;"need to mention knuel here"
		<COND (,RAMP
		       <TELL
", or what used to be the stairs is now a ramp">)
		      (T
		       <TELL " look like stairs and need a better desc">)>
		<TELL "." CR>)>>

<ROUTINE TO-UPSTAIRS-HALL ()
         <COND (<NOT <FSET? ,KNUEL ,TOUCHBIT>>
		<TELL
"You start to go up but suddenly the staircase flattens out and you slide back
down the flatten stairs." CR>
		<SETG RAMP T>
		<FSET ,KNUEL ,TOUCHBIT>
	        <RFALSE>)
               (,RAMP
		<TELL
"You start to go up the flatten stairs but slide back down." CR>
		<RFALSE>)
               (T 
                <RETURN ,UPSTAIRS-HALL>)>>

<OBJECT KNUEL
	(IN LOCAL-GLOBALS)
	(DESC "knuel")
	(SYNONYM KNUEL)
	(ADJECTIVE BROWN)
	(FLAGS NDESCBIT)
	(ACTION KNUEL-F)>

<GLOBAL RAMP <>>

<ROUTINE KNUEL-F ()
	 <COND (<VERB? TURN>
		<TELL "You turn" T ,KNUEL " and the ">
		<FSET ,KNUEL ,TOUCHBIT>
                <COND (,RAMP
		       <TELL "ramp becomes stairs">
		       <SETG RAMP <>>)
		      (T
		       <TELL "stairs become a ramp">
		       <SETG RAMP T>)>
		<TELL "." CR>)>>

<GLOBAL CLOSET-FLOOR <>>                                   ;"starts at foyer-2"

<ROUTINE FOYER-CLOSET-ENTER-F ()
	 <COND (<NOT <FSET? ,FOYER-CD ,OPENBIT>>
		<ITS-CLOSED ,FOYER-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,CLOSET>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CLOSET-TOP-2>)
	       (T
		<JIGS-UP
"You step into the shaft and plunge down a floor, landing at the bottom of the
shaft. As you lie in the shaft bottom regaining your wits you hear a humming
noise. You look up to see the closet you were expecting, slowly descending. The
last thing you see is the cellar door to the closet swinging shut, assuring
you a closed-casket service.">     ;"what if you don't have light?"
		       <RFALSE>)>>

<OBJECT ARMOR
	(IN FOYER)
	(DESC "suit of armor")
	(SYNONYM SUIT ARMOR)
	(ADJECTIVE METAL STEEL)
	(FLAGS TRYTAKEBIT)
	(DESCFCN ARMOR-F)
	(ACTION ARMOR-F)>

<ROUTINE ARMOR-F ("OPTIONAL" (OARG <>))
	  <COND (.OARG
		 <TELL
"Standing demurely in the corner is a suit or armor, somewhat reminiscent
of the suits of armor that once graced the castle of Winston Churchill.
It is currrently in the position that Masters and Johnson described as "
<GET ,ARMOR-DESCS ,ARMOR-DESC-NUM> ".">)
		(<VERB? EXAMINE>
		 <ARMOR-F ,M-OBJDESC>
		 ;<TELL
"The suit of armour " <GET ,ARMOR-DESCS ,ARMOR-DESC-NUM> "." CR>)>>

<GLOBAL ARMOR-DESC-NUM 0>

<ROUTINE I-ARMOR-MOVE ()
	 <COND (<EQUAL? ,HERE ,FOYER>
	        <QUEUE I-ARMOR-MOVE 2>)
	       (T
		<SETG ARMOR-DESC-NUM <+ ,ARMOR-DESC-NUM 1>>
                <COND (<EQUAL? ,ARMOR-DESC-NUM 7>
		       <SETG ARMOR-DESC-NUM 0>)>)>
	 <RFALSE>>

<GLOBAL ARMOR-DESCS
        <TABLE
"Desc 0"
"Desc 1"
"Desc 2"
"Desc 3"
"Desc 4"
"Decs 5"
"Desc 6">>

"--- Cellar ---"

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Cellar")
      (LDESC
"This is the cellar. A ramp leads up to the north. There's lots of creepy
stuff here from the old movies.")       
      (IN PER CELLAR-CLOSET-ENTER-F)
      (WEST PER CELLAR-CLOSET-ENTER-F)
      ;(NORTH TO BACKYARD IF WHITE-CELLAR-DOOR IS OPEN)
      (EAST TO PANTRY)
      (UP TO FOYER) ;"for testing only"
      ;(UP "Both the ramp and the stairs lead up. Use a direction.")
      (GLOBAL CELLAR-RAMP STAIRS WHITE-CELLAR-DOOR CELLAR-CD CLOSET-REF)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT CELLAR-CD
	(IN LOCAL-GLOBALS)
	(DESC "cellar closet door")
        (SYNONYM DOOR)
	(ADJECTIVE CLOSET)
	(FLAGS DOORBIT NDESCBIT)>

<OBJECT WHITE-CELLAR-DOOR ;"to backyard"
	(IN LOCAL-GLOBALS)
	(DESC "white cellar door")
        (SYNONYM DOOR)
	(ADJECTIVE WHITE)
	(FLAGS DOORBIT NDESCBIT)>

<OBJECT CELLAR-RAMP
	(IN LOCAL-GLOBALS)
	(DESC "cellar ramp")
	(SYNONYM RAMP)
	(ADJECTIVE CELLAR)
	(FLAGS NDESCBIT)
	(ACTION CELLAR-RAMP-F)>

<ROUTINE CELLAR-RAMP-F ()
	 <COND (<VERB? PUSH-DOWN>
		<MOVE-OBJ-DOWN>)>>

<ROUTINE CELLAR-CLOSET-ENTER-F ()
     	 <COND (<NOT <FSET? ,CELLAR-CD ,OPENBIT>>
		<ITS-CLOSED ,CELLAR-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CLOSET>)
	       (T
		<RETURN ,SHAFT-BOTTOM>)>>


"--- Upstairs Hall ---"

<ROOM UPSTAIRS-HALL
      (IN ROOMS)
      (DESC "Upstairs Hall")
      (LDESC "This is the upstairs hall. Stairs lead down.")
      (IN PER UPSTAIRS-CLOSET-ENTER-F)
      (WEST PER UPSTAIRS-CLOSET-ENTER-F)
      (DOWN PER TO-FOYER-F)
      (SOUTH PER TO-FOYER-F)
      (GLOBAL UPSTAIRS-CD CLOSET-REF FOYER-STAIRS KNUEL)
      (FLAGS RLANDBIT ONBIT)>

<OBJECT UPSTAIRS-CD
	(IN LOCAL-GLOBALS)
	(DESC "upstairs closet door")
        (SYNONYM DOOR)
	(ADJECTIVE UPSTAIRS CLOSET)
        (FLAGS DOORBIT NDESCBIT)>

<ROUTINE TO-FOYER-F ()
	 <COND (,RAMP
		<TELL "You slide down the flattened stairs." CR> ;"could be funnier"
	        <RETURN ,FOYER>)
	       (T
                <RETURN ,FOYER>)>>

<ROUTINE UPSTAIRS-CLOSET-ENTER-F ()
	 <COND (<NOT <FSET? ,UPSTAIRS-CD ,OPENBIT>>
		<ITS-CLOSED ,UPSTAIRS-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL>
		<RETURN ,CLOSET>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN CLOSET-TOP-3>)
               (T
                <JIGS-UP
"You step into a shaft and plunge down slowing ever so slightly as your body
crashes through the top of the closet then abrubtly comes to a stop on the
floor of the closet.">)>>


"--- Closet Stuff ---"

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Closet")
      (LDESC "This is closet with a set of coat pegs.")
      (EAST PER CLOSET-EXIT-F)
      (OUT PER CLOSET-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CLOSET-REF)>

<OBJECT CLOSET-DOOR
	(IN CLOSET)
        (DESC "closet door")
	(SYNONYM DOOR)
	(ADJECTIVE CLOSET)
	(FLAGS DOORBIT NDESCBIT)>

<ROUTINE CLOSET-EXIT-F ("AUX" DOOR)
	 <SET DOOR <WHICH-DOOR?>>
	 <COND (<NOT <FSET? .DOOR ,OPENBIT>>
		<ITS-CLOSED ,CLOSET-DOOR>
		<RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CELLAR>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,FOYER>)
	       (T
	        <RETURN ,UPSTAIRS-HALL>)>>

<ROUTINE WHICH-DOOR? ()
	 <COND (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CELLAR-CD>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,FOYER-CD>)
	       (T
	        <RETURN ,UPSTAIRS-CD>)>>

;<ROUTINE CLOSET-ENTER-F ()
	 <COND (<AND <EQUAL? ,HERE ,FOYER>
		     <NOT <FSET? ,FOYER-CD ,OPENBIT>>>
		<ITS-CLOSED ,FOYER-CD>
		<RFALSE>)
	       (<AND <EQUAL? ,HERE ,CELLAR>
		     <NOT <FSET? ,CELLAR-CD ,OPENBIT>>>
		<ITS-CLOSED ,CELLAR-CD>
		<RFALSE>)
	       (<AND <EQUAL? ,HERE ,UPSTAIRS-HALL>
		     <NOT <FSET? ,UPSTAIRS-CD ,OPENBIT>>>
		<ITS-CLOSED ,UPSTAIRS-CD>
		<RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <RETURN ,CLOSET>)
		      (<EQUAL? ,HERE ,FOYER>
		       <RETURN ,CLOSET-TOP-2>)
		      (T
		       <JIGS-UP
"You step into a shaft and plunge down slowing ever so slightly as
your body crashes through the top of the closet then abrubtly comes to a stop
on the floor of the closet.">
		       <RFALSE>)>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
	        <COND (<EQUAL? ,HERE ,CELLAR>
		       <RETURN ,SHAFT-BOTTOM>)
		      (<EQUAL? ,HERE ,FOYER>
		       <RETURN ,CLOSET>)
		      (T
		       <RETURN ,CLOSET-TOP-3>)>)
	       (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <RETURN ,SHAFT-BOTTOM>)
                      (<EQUAL? ,HERE , FOYER>
                       <JIGS-UP
"You step into the shaft and plunge down a floor, landing at the bottom of the
shaft. As you lie in the shaft bottom regaining your wits you hear a humming
noise. You look up to see the closet you were expecting, slowly descending. The
last thing you see is the cellar door to the closet swinging shut, assuring
you a closed-casket service.">     ;"what if you don't have light?"
		       <RFALSE>)
	              (T
		       <RETURN ,CLOSET>)>)>>

<OBJECT CLOSET-REF
	(IN LOCAL-GLOBALS)
	(DESC "closet")
	(SYNONYM CLOSET)
	(ACTION CLOSET-REF-F)>

<ROUTINE CLOSET-REF-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
		<COND (<EQUAL? ,HERE ,FOYER>
		       <LOOK-IN-CLOSET ,FOYER-CD>)
		      (<EQUAL? ,HERE ,UPSTAIRS-HALL>
		       <LOOK-IN-CLOSET ,UPSTAIRS-CD>)
		      (T
		       <LOOK-IN-CLOSET ,CELLAR-CD>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE LOOK-IN-CLOSET (DOOR)
	 <COND (<NOT <FSET? .DOOR ,OPENBIT>>
		<ITS-CLOSED .DOOR>)
	       (<EQUAL? ,CLOSET-FLOOR ,HERE>
		<TELL "You see ">
		<DESCRIBE-CONTENTS ,CLOSET -1>
		<TELL "." CR>)
	       (T
		<TELL "You see a dark shaft." CR>)>> ;"or elevator top"


"--- Peg Stuff ---"

<OBJECT PEGS
	(IN CLOSET)
	(DESC "set of coat pegs")
	(SYNONYM PEGS)
	(ADJECTIVE COAT)
        (FLAGS NDESCBIT)
	(ACTION PEGS-F)>

<ROUTINE PEGS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "You see three rather worn coat pegs." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PEG-3
	(IN CLOSET)
	(DESC "third peg")
	(SYNONYM PEG)
	(ADJECTIVE THIRD)
        (FLAGS NDESCBIT)
	(ACTION PEG-3-F)>

<ROUTINE PEG-3-F ()
	 <COND (<VERB? MOVE PULL PUSH RAISE LOWER RUB>
		<COND (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL>
		       <HUM>)
		      (T		      
		       <TELL "The closet moves up ">
		       <COND (<EQUAL? ,CLOSET-FLOOR ,FOYER>
			      <TELL "a floor">)
			     (T
			      <TELL "two floors">)>
		       <TELL " to the upstairs hall." CR>
		       <SETG CLOSET-FLOOR ,UPSTAIRS-HALL>)>
		       <COND (<FSET? ,UPSTAIRS-CD ,OPENBIT>
			      <FSET ,CLOSET-DOOR ,OPENBIT>)
			     (T
			      <FCLEAR ,CLOSET-DOOR ,OPENBIT>)>
		 <RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PEG-2
	(IN CLOSET)
	(DESC "second peg")
	(SYNONYM PEG)
	(ADJECTIVE SECOND)
        (FLAGS NDESCBIT)
	(ACTION PEG-2-F)>

<ROUTINE PEG-2-F ()
	 <COND (<VERB? MOVE PULL PUSH RAISE LOWER RUB>
		<COND (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		       <HUM>)
		      (T		      
		       <TELL "The closet moves ">
		       <COND (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL>
			      <TELL "down a floor">)
			     (T
			      <TELL "up a floor">)>
		       <TELL " to the front hall." CR>
		       <SETG CLOSET-FLOOR ,FOYER>)>
		       <COND (<FSET? ,FOYER-CD ,OPENBIT>
			      <FSET CLOSET-DOOR ,OPENBIT>)
			     (T
			      <FCLEAR ,CLOSET-DOOR ,OPENBIT>)>
                <RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT PEG-1
	(IN CLOSET)
	(DESC "first peg")
	(SYNONYM PEG)
	(ADJECTIVE FIRST)
        (FLAGS NDESCBIT)
	(ACTION PEG-1-F)>

<ROUTINE PEG-1-F ()
	 <COND (<VERB? MOVE PULL PUSH RAISE LOWER RUB>
		<COND (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		       <HUM>)
		      (T		      
		       <TELL "The closet moves down ">
		       <COND (<EQUAL? ,CLOSET-FLOOR ,FOYER>
			      <TELL "a floor">)
			     (T
			      <TELL "two floors">)>
		       <TELL " to the cellar." CR>
		       <SETG CLOSET-FLOOR ,CELLAR>)>
		       <COND (<FSET? ,CELLAR-CD ,OPENBIT>
			      <FSET CLOSET-DOOR ,OPENBIT>)
			     (T
			      <FCLEAR ,CLOSET-DOOR ,OPENBIT>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HUM ()
	 <TELL "You hear a humming noise." CR>>


"--- Elevator Rooms ---"

<ROOM SHAFT-BOTTOM
      (IN ROOMS)
      (DESC "Shaft Bottom")
      (LDESC "This is the shaft bottom.")
      (EAST TO CELLAR IF CELLAR-CD IS OPEN)
      (OUT TO CELLAR IF CELLAR-CD IS OPEN)
      (GLOBAL CELLAR-CD)
      (FLAGS RLANDBIT)>

<ROOM CLOSET-TOP-2
      (IN ROOMS)
      (DESC "Top of Closet")
      (LDESC "You are on top of the closet.")
      (EAST TO FOYER IF FOYER-CD IS OPEN)
      (OUT TO FOYER IF FOYER-CD IS OPEN)
      (GLOBAL FOYER-CD)
      (FLAGS RLANDBIT ONBIT)>

<ROOM CLOSET-TOP-3
      (IN ROOMS)
      (DESC "Top of Closet")
      (LDESC "You are on top of the closet.")
      (EAST TO UPSTAIRS-HALL IF UPSTAIRS-CD IS OPEN)
      (OUT TO UPSTAIRS-HALL IF UPSTAIRS-CD IS OPEN)
      (GLOBAL UPSTAIRS-CD)
      (FLAGS RLANDBIT ONBIT)>


"--- Living room ---"

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (LDESC "This is the living room. It has a high ceiling. There is a
fireplace and a chandelier here.")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO KITCHEN) 
      (EAST TO FOYER)>

;<OBJECT CHANDELIER
	(IN LIVING-ROOM)
	(DESC "antique chandelier")
	(SYNONYM CHANDELIER)
	(ADJECTIVE ANTIQUE)
	(FLAGS NDESCBIT)
	(ACTION CHANDELIER-F)>

;<ROUTINE CHANDELIER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "With the light from">
                <COND (<AND <HELD? ,FLASHLIGHT>
			    <FSET? ,FLASHLIGHT ,ONBIT>>
                       <TELL T ,FLASHLIGHT>)
                      (T
		       <TELL "flame">)>
                <TELL
"you can see" T ,CHANDELIER " is made of cut glass with many
thing-a-ma-gigs that hang from a chandelier hanging from the bowl of the
chandelier.">
                <COND (<AND <HELD? ,FLASHLIGHT>
			    <FSET? ,FLASHLIGHT ,ONBIT>>
                       <TELL
" As you pan" T ,CHANDELIER " you notice something in the bowl of the
chandelier." CR>)
		      (T
		       <TELL
"Its true beauty cannot be seen in this light." CR>)>)>
	       ;(<AND <VERB? SHOOT>
                     <PRSI? ,POKER>>
		<SHATTER>)>

;<ROUTINE SHATTER ()
	 <TELL
"You put the poker between the strings of the harp, pull back and fire it. 
The poker rockets up and across the living room striking the bowl of the
chandelier shattering it. Pieces of glass fall to the ground along with 
a piece of paper." CR>
         <REMOVE ,BOWL>
         ;<MOVE ,VERTICAL-MAP ,LIVING-ROOM>>

<OBJECT VERTICAL-MAP
	(IN FRONT-JUNCTION)
        (DESC "yellowed piece of paper")
	(SYNONYM PAPER MAP)
	(ADJECTIVE WHITE YELLOWED)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION VERTICAL-MAP-F)>

0<ROUTINE VERTICAL-MAP-F ()
	 <COND (<VERB? READ EXAMINE>
	       %<COND (<GASSIGNED? ZILCH>
		      '<TELL "You see the following:~

|       |   |   |            |    |   |~
|     | | | | | | | |  | |   |  | | | |~
|     | | |   |   | |         | |   | |~
|     | | |         | |     | | |   | |~
|     |   | |     | | | | | | | | | | |~
| |         |       | | | | |   | | | |~
| | |   |     | |   | | | | | | | | | |~
| | | | |     | | |   | |   | | | |   |~
| | | | |         | | |       |       |~
| |             | | | |             | |~
|       |       |   |         | | | | |~
|   | | | |   | | | | | |     | | | | |~
| | | | | | | | | |   | |     |   | | |~
| | | |   | | | | |       |         | |~
| | | | | | | | | | |     | |   |     |~
| |   | | |     | |         | | |     |~
| |   | |         | |   |   | | |     |~
| | | |  |   | |  | | | | | | | |     |~
|   |    |            |   |   |       |~" CR>)
		      (T
		       <TELL "You see the following:

|       |   |   |            |    |   |
|     | | | | | | | |  | |   |  | | | |
|     | | |   |   | |         | |   | |
|     | | |         | |     | | |   | |                              
|     |   | |     | | | | | | | | | | |
| |         |       | | | | |   | | | |
| | |   |     | |   | | | | | | | | | |
| | | | |     | | |   | |   | | | |   |
| | | | |         | | |       |       |
| |             | | | |             | |
|       |       |   |         | | | | |
|   | | | |   | | | | | |     | | | | |
| | | | | | | | | |   | |     |   | | |
| | | |   | | | | |       |         | |
| | | | | | | | | | |     | |   |     |
| |   | | |     | |         | | |     |
| |   | |         | |   |   | | |     |
| | | |  |   | |  | | | | | | | |     |
|   |    |            |   |   |       |">)>)
	       (<VERB? PUT-ON>
		<WHOLE-MAP>)>>

<OBJECT HORIZONTAL-MAP
        (IN FRONT-JUNCTION)
        (DESC "soiled piece of paper")
	(SYNONYM MAP PAPER)
        (ADJECTIVE PAPER SOILED)
	(FLAGS TAKEBIT READBIT)
	(SIZE 1)
	(ACTION HORIZONTAL-MAP-F)>

<ROUTINE HORIZONTAL-MAP-F ()
	 <COND (<VERB? READ EXAMINE>
	       %<COND (<GASSIGNED? ZILCH>
                      '<TELL "You see the following:~

_______________________________________~
  _____             __   ___   __~
 ____                __   ___ _~
  ____     ___ ___    _______    ___~
 ____         ___ __    ___~
  ____ _ _    ___~
    ________ __ ___~
          ___     __~
         __ __   _  __   ___       ___~
       _  _______  x   _______ ______~
   _____________ _ _   ______ ___~
 ____     _____   __ __ ___ __~
                          ___~
                    __   _____ ___~
                      ___   __ _____~
             _     _  ___         ____~
   ___     _____    ________     ____~
         _____ ___                ____~
       _   __    _               ____~
 ___ ____ _________ __ ___ ___ _______~" CR>)
		      (T
		       <TELL "You see the following:
_______________________________________
  _____             __   ___   __
 ____                __   ___ _
  ____     ___ ___    _______    ___
 ____         ___ __    ___                              
  ____ _ _    ___
    ________ __ ___
          ___     __
         __ __   _  __   ___       ___
       _  _______      _______ ______
   _____________ _ _   ______ ___
 ____     _____   __ __ ___ __
                          ___
                    __   _____ ___
                      ___   __ _____
             _     _  ___         ____
   ___     _____    ________     ____
         _____ ___                ____
       _   __    _               ____
 ___ ____ _________ __ ___ ___ _______ ">)>)
	       (<VERB? PUT-ON>
		<WHOLE-MAP>)>>

<ROUTINE WHOLE-MAP ()
         <TELL "You see the following:~

_______________________________________~
| _____ |   |   |   __   ___ | __ |   |~
|____ | | | | | | | |__| |___|_ | | | |~
| ____| | |___|___| | _______ | |___| |~
|____ | | |   ___ __| | ___ | | |   | |~
| ____|_ _| | ___ | | | | | | | | | | |~
| | ________|__ ___ | | | | |   | | | |~
| | |   | ___ | | __| | | | | | | | | |~
| | | | |__ __| |_| __| |___| | | |___|~
| | | |_| _______ |x| |_______|______ |~
| |_____________|_|_| |______ ___   | |~
|____   | _____ | __|__ ___ __| | | | |~
|   | | | |   | | | | | | ___ | | | | |~
| | | | | | | | | | __| |_____|___| | |~
| | | |   | | | | |   ___ | __ _____| |~
| | | | | | |_| | |_| ___ | |   | ____|~
| |___| | |_____| | ________| | |____ |~
| |   | |_____ ___| |   |   | | | ____|~
| | | |_ | __| | _| | | | | | | |____ |~
|___|____|_________ __|___|___|_______|~">>


<OBJECT BOWL
	(IN LIVING-ROOM)
	(DESC "chandelier bowl")
	(SYNONYM BOWL)
	(ADJECTIVE CHANDELIER)
        (FLAGS NDESCBIT)
        (ACTION BOWL-F)>

<ROUTINE BOWL-F ()
	 <COND (<VERB? EXAMINE>
	        <COND (<AND <HELD? ,FLASHLIGHT>
			    <FSET? ,FLASHLIGHT ,ONBIT>>
                       <TELL
"You shine your light on the bowl of the chandelier. Its thick, slick surface,
covered with a rose-like pattern, reflects a rose colored light around the
room. You can see a square shape in the bottom of the bowl." CR>)
		      (T
		       <TELL
"The light from the flame reflects off the thick, slick surface of the 
chandelier's bowl. You can barely make out a rose-like pattern on the bowl."
CR>)>)
	       ;(<AND <VERB? SHOOT>
                     <PRSI? ,POKER>>
		<SHATTER>)>>


"--- Kitchen ---"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (LDESC "This is the kitchen. South to exit. The pantry is to the west.")
      (FLAGS RLANDBIT ONBIT)
      (WEST TO PANTRY) 
      (SOUTH TO LIVING-ROOM)>

<ROOM PANTRY
	(IN ROOMS)
	(DESC "Pantry")
	(LDESC
"This is the pantry. A doorway leads east and stairs lead down." CR)
	(SYNONYM PANTRY)
	(ADJECTIVE SMALL)
	(DOWN TO CELLAR)
	(WEST TO CELLAR)
	(EAST TO KITCHEN)
        (FLAGS DOORBIT NDESCBIT)
        (GLOBAL STAIRS)>

"--- Game Room ---" 

<ROOM GAME-ROOM
      (IN ROOMS)
      (DESC "Game Room")
      (LDESC "The focus of this room is a hand-carved, teak pool table.
Strange, but the 8 ball is set apart from the rest. A stained glass,
rectangular light illuminates the pool table top. Shelves on the east wall
hold an assortment of games. A somewhat archaic record player is in a teak
cabinet on the north wall. Doorways lead north and south.")
      (FLAGS RLANDBIT ONBIT)
      (NORTH TO PATIO)
      (SOUTH TO FOYER)>

<OBJECT 8-BALL
        (IN LIVING-ROOM)
	(DESC "eight ball")
	(SYNONYM BALL)
        (ADJECTIVE BLACK EIGHT)
	(FLAGS TAKEBIT NDESCBIT VOWELBIT)
	(SIZE 5)
        (ACTION 8-BALL-F)>

<ROUTINE 8-BALL-F ()
	 <COND (<VERB? TURN>
		<TELL 
"Looking into the bottom of the eight ball you the message" "\""
<PICK-ONE ,EIGHTISMS> ".\"" CR>
	        <RTRUE>)>>

<GLOBAL EIGHTISMS
        <LTABLE 0
         "No tap dancing in the fish pond"
	 "Hollywood was here"
	 "Never lick a gift whore in the mouth"
	 "What do you think this is, 'Dark Shadows'?"
	 "Look behind the painting in the bedroom">>


"--- Pool Table ---"

<OBJECT POOL-TABLE
	(IN GAME-ROOM)
	(DESC "pool table")
	(SYNONYM TABLE)
	(ADJECTIVE POOL)
	(FLAGS SURFACEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 100)
	(ACTION POOL-TABLE-F)>

<ROUTINE POOL-TABLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The pool table is made of the finest wood and on the table is">
		<DESCRIBE-SENT ,POOL-TABLE>
		<CRLF>)>>

<OBJECT POCKET
	(IN GAME-ROOM)
	(DESC "ball pocket")
	(SYNONYM POCKET)
	(ADJECTIVE BALL POOL TABLE SIDE CORNER)
	(FLAGS CONTBIT OPENBIT NDESCBIT SEARCHBIT)
	(CAPACITY 5)
	;(ACTION POCKET-F)>

;<ROUTINE POCKET-F ()
	 <RFALSE>>

<OBJECT BALL-RETURN
	(IN GAME-ROOM)
        (DESC "ball return")
	(SYNONYM RETURN)
	(ADJECTIVE BALL)
	(FLAGS CONTBIT OPENBIT NDESCBIT SEARCHBIT)
	(CAPACITY 5) ;"HUMMMMM"
	;(ACTION BALL-RETURN-F)>

;<ROUTINE BALL-RETURN-F ()>

<OBJECT CUE-BALL
	(IN POOL-TABLE)
	(DESC "cue ball")
	(SYNONYM BALL)
	(ADJECTIVE WHITE CUE)
	(FLAGS TAKEBIT)
	(SIZE 5)
	(ACTION CUE-BALL-F)>

<ROUTINE CUE-BALL-F ()
	 <COND (<AND <VERB? PUT DROP SHOOT>
		     <PRSI? ,POCKET>>
                <COND (<VERB? SHOOT>
		       <COND (<NOT <HELD? ,POOL-CUE>>
			      <TELL
"You're not holding" TR ,POOL-CUE>
			      <RTRUE>)
			     (<NOT <IN? ,CUE-BALL ,POOL-TABLE>>
			      <TELL
"The " D ,CUE-BALL " isn't on" TR ,POOL-TABLE>)
			     (T
                              <TELL
"The ball speeds across the smooth, green surface into" T ,POCKET ". You">)>)
                      (T
		       <TELL "You ">
		       <PRINTB ,P-PRSA-WORD>
		       <TELL T ,CUE-BALL " in" T ,POCKET " and">)>
		<TELL
" hear it roll towards" T ,BALL-RETURN ". As" T ,CUE-BALL " drops into the
return, a panel on the east wall swings open." CR>
		;<FSET ,PANEL ,OPENBIT>
		<MOVE ,CUE-BALL ,BALL-RETURN>)>>

<OBJECT RACKED-BALLS
	(IN POOL-TABLE)
	(DESC "racked balls")
	(SYNONYM BALLS)
	(ADJECTIVE RACKED)
	(FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 40)
	(ACTION RACKED-BALLS-F)>

<ROUTINE RACKED-BALLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "You see a set of pool balls ">
		<COND (<HELD? ,RACKED-BALLS> 
                       <TELL "all glued to one another ">)>
		<TELL "in a triangle shape." CR>)>>                

<OBJECT RACK
	 (IN GAME-ROOM)
	 (DESC "rack")
	 (SYNONYM RACK)
	 (ADJECTIVE POOL)
	 (FLAGS TAKEBIT)
	 (SIZE 5)> 

<OBJECT POOL-CUE
	(IN GAME-ROOM)
	(DESC "pool cue")
	(SYNONYM CUE STICK)
	(ADJECTIVE POOL)
	(FLAGS TAKEBIT)
	(SIZE 15)>


"--- Misc ---"

<ROUTINE I-LIGHTS-DIM ()
	 <COND (<FSET? ,HERE ,OUTDOORSBIT>
		<TELL
"The sun is rapidly sinking into west. It's getting dark out here." CR>)
	       (T
		<COND (<FSET? ,HERE ,ONBIT>
		       <TELL
"The sun is going down. It's getting dark in here." CR>)>)>
	 <QUEUE I-LIGHTS-OUT 10>>

<ROUTINE I-LIGHTS-OUT ()
	 <FCLEAR ,FOYER, ONBIT>
         <FCLEAR ,CLOSET ,ONBIT>
         <FCLEAR ,CELLAR, ONBIT>
	 <TELL "The sun has set. ">
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (T
		<CRLF>)>>


<OBJECT SACK
	(DESC "cloth sack")
	(SYNONYM TOP SACK BAG)
	(ADJECTIVE CLOTH)
        (FLAGS TAKEBIT CONTBIT)
        (SIZE 20)
	;(ACTION SACK-F)>

;<ROUTINE SACK-F ()
          <COND (<VERB? EXAMINE>
                 <TELL "">)>>

<OBJECT WINDOW
	(IN LIVING-ROOM)
	(DESC "window")
        (SYNONYM WINDOW)
	(FLAGS NDESCBIT RMUNGBIT) ;"rmung: means you are holding sack top"
	(ACTION WINDOW-F)>

<GLOBAL SACK-IN-WINDOW T>
 
<ROUTINE WINDOW-F ()
	 <COND (<VERB? EXAMINE>
	        <COND (<AND ,SACK-IN-WINDOW
			    <NOT <FSET? ,WINDOW ,OPENBIT>>>
		       <TELL
"The window is closed on a cloth which is tied in a knot. " CR>)
;"Underneath the closed D ,WINDOW  you see the top of a cloth tied in a knot."
;"Beneath the sash of the closed D ,WINDOW  is a cloth tied in a knot. The rest of the cloth is outside."

                      (T
		       <TELL "The " D ,WINDOW " is ">
		       <COND (<FSET? ,WINDOW ,OPENBIT>
			      <TELL "open.">)
			     (T
			      <TELL "closed">)>
		       <TELL "." CR>)>)
               (<VERB? OPEN>
		<COND (<FSET? ,WINDOW ,OPENBIT>
		       <ALREADY-OPEN>)
		      (,SACK-IN-WINDOW
		       <TELL
"As you lift up the window, the sack slides off the window ceil and falls to
the ground with a decided thud." CR>
		       <FSET ,WINDOW ,OPENBIT>
		       <SETG SACK-IN-WINDOW <>>)
		      (<FSET? ,WINDOW ,RMUNGBIT> ;"rmung: you are holding sack"
		       <TELL
"With one hand you lift the window and with the other you pull the sack inside.
" CR>
		       <MOVE ,SACK ,PLAYER>
		       <FSET? ,WINDOW ,OPENBIT>
		       <SETG SACK-IN-WINDOW <>>)
		      (T
		       <TELL "You open the window." CR>
		       <FSET ,WINDOW ,OPENBIT>
		       <SETG SACK-IN-WINDOW <>>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,WINDOW ,OPENBIT>>
		       <ALREADY-CLOSED>)
		      (T
		       <TELL "You close" TR ,WINDOW>)>)>>  

"--- Junk Yard ---"

;<OBJECT HARP
	(IN LIVING-ROOM)
        (DESC "harp")
	(SYNONYM HARP)
	(ADJECTIVE PRETTY)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(SIZE 80)
	(ACTION HARP-F)>

;<ROUTINE HARP-F ()
	 <COND (<VERB? TAKE>
		<SPINACH>)
               (<VERB? EXAMINE>
                <TELL
"The harp is made of a fine wood and covered with dust as are the strings."
CR>)
               (<VERB? PLAY>
                <TELL
"You begin to pluck the strings. The sound is somewhat like a piano being
pushed down 20 flights of stairs. Its obvious you didn't spend your summers
here practicing the harp." CR>)>>

<OBJECT THE-ROOM
	(IN ROOMS)
	(DESC "Room")
	(FLAGS ONBIT RLANDBIT)
	(NORTH TO OTHER-ROOM)
	(NE TO OTHER-ROOM)
	(EAST TO OTHER-ROOM)
	(SE TO OTHER-ROOM)
	(SOUTH TO OTHER-ROOM)
	(SW TO OTHER-ROOM)
	(WEST TO OTHER-ROOM)
	(NW TO OTHER-ROOM)
	(IN TO OTHER-ROOM)
	(OUT TO OTHER-ROOM)
	(UP TO OTHER-ROOM)
	(DOWN TO OTHER-ROOM)>

<OBJECT OTHER-ROOM
	(IN ROOMS)
	(DESC "Room")
	(FLAGS ONBIT RLANDBIT)
	(NORTH TO THE-ROOM)
	(NE TO THE-ROOM)
	(EAST TO THE-ROOM)
	(SE TO THE-ROOM)
	(SOUTH TO THE-ROOM)
	(SW TO THE-ROOM)
	(WEST TO THE-ROOM)
	(NW TO THE-ROOM)
	(IN TO THE-ROOM)
	(OUT TO THE-ROOM)
	(UP TO THE-ROOM)
	(DOWN TO THE-ROOM)>
 



