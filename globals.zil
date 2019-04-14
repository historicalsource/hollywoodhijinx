"GLOBALS for ANTHILL (C)1986 Infocom Inc. All Rights Reserved."

<DIRECTIONS NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<GLOBAL HERE <>>

<GLOBAL LIT T>

<GLOBAL MOVES 0>
<GLOBAL SCORE 0>

; <GLOBAL INDENTS
	  <PTABLE ""
	          "  "
	          "    "
	          "      "
	          "        "
	          "          ">>

<OBJECT GLOBAL-OBJECTS         ;"      BITS      FLAGS    "
   
   (FLAGS EVERYBIT  INVISIBLE  TOUCHBIT  SURFACEBIT  TRYTAKEBIT
          OPENBIT   SEARCHBIT  TRANSBIT  WEARBIT     VOWELBIT
          ONBIT     RLANDBIT   ACTORBIT  TAKEBIT     NARTICLEBIT
          NDESCBIT  LOCKEDBIT  WORNBIT   INDOORSBIT  TOOLBIT
	  WETBIT    DOORBIT    FLAMEBIT  VEHBIT      OUTDOORSBIT
	  ;FURNITBIT CAVEBIT    READBIT   CONTBIT     LIGHTBIT)
   (THINGS 0)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZZP)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "L")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(SIZE 0)
	;(TEXT "")
	(CAPACITY 0)>

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT NDESCBIT TOUCHBIT)>

;<ROUTINE TO-DO-THING-USE (STR1 STR2)
	 <TELL "(To " .STR1 " something, use the command: " 
	       .STR2 " THING.)" CR>>

<ROUTINE CANT-USE (PTR "AUX" BUF) 
	;#DECL ((PTR BUF) FIX)
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<TELL "[This story can't understand the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
	<GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" when you use it that way.]" CR>>

<ROUTINE DONT-UNDERSTAND ()
	<TELL
"[That sentence didn't make sense. Please reword it or try something else.]" CR>>

<ROUTINE NOT-IN-SENTENCE (STR)
	 <TELL "[There aren't " .STR " in that sentence!]" CR>>

<OBJECT LIGHTS
	(IN GLOBAL-OBJECTS)
	(DESC "lights")
	(FLAGS NDESCBIT)
	(SYNONYM LIGHT LIGHTS)
	(ACTION LIGHTS-F)>

<ROUTINE LIGHTS-F ()
	 <COND (<OR <FSET? ,HERE ,OUTDOORSBIT>
		    <FSET? ,HERE ,CAVEBIT>
		    <EQUAL? ,HERE ,CRAWL-SPACE-NORTH ,CRAWL-SPACE-SOUTH
			          ,FIRST-SECRET-ROOM ,FIREPLACE
				  ,CHIMNEY-1 ,CHIMNEY-2 ,CHIMNEY-3>>
		<CANT-SEE-ANY ,LIGHTS>)
	       (<VERB? LAMP-ON>
		<TELL
"You flip the switch but nothing happens. It seems the light bulbs are
missing." CR>)>> 	

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
        (DESC "ground")
	(SYNONYM GROUND FLOOR)
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND ;(<NOT <FSET? ,HERE ,INDOORSBIT>>
		<CANT-SEE-ANY ,WALLS>
		<RFATAL>)
	       (<OR <GETTING-INTO?>
		    <VERB? LOOK-BEHIND>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<VERB? LOOK-UNDER>
		<TELL "Nothing but dirt." CR>)
	       (<OR <HURT? ,GROUND>
		    <MOVING? ,GROUND>>
		<SAY-THE ,GROUND>
		<TELL " is not affected." CR>)
	       (<OR <TALKING-TO? ,GROUND>
		    <VERB? YELL>>
		<TELL "Talking to" T ,GROUND>
		<SIGN-OF-COLLAPSE>
		<RFATAL>)
	       ;(T
		<YOU-DONT-NEED ,GROUND>
		<RFATAL>)>>

<OBJECT MAZE-HOLE           ;"should this or could this be a real container?"
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE GROUND)
	(FLAGS NDESCBIT)
        (ACTION MAZE-HOLE-F)>

<ROUTINE MAZE-HOLE-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "There's nothing but dirt in the hole." CR>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>

<ROUTINE WALLS-F ()
	 <COND (<FSET? ,HERE ,OUTDOORSBIT>
		<CANT-SEE-ANY ,WALLS>
		<RFATAL>)
	       (<OR <GETTING-INTO?>
		    <VERB? LOOK-BEHIND>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<VERB? LOOK-UNDER>
		<TELL "There's a floor there." CR>)
	       (<OR <HURT? ,WALLS>
		    <MOVING? ,WALLS>>
		<COND (<AND <VERB? THROW>
		      	    <PRSO? ,FINCH>>
		       <RFALSE>)>
		<SAY-THE ,WALLS>
		<TELL " is not affected." CR>)
	       (<OR <TALKING-TO? ,WALLS>
		    <VERB? YELL>>
		<TELL "Talking to walls">
		<SIGN-OF-COLLAPSE>
		<RFATAL>)
	       (<NOT <VERB? EXAMINE>>
		<YOU-DONT-NEED ,WALLS>
		<RFATAL>)>
	 ;<RTRUE>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<FSET? ,HERE ,OUTDOORSBIT>
		<CANT-SEE-ANY ,CEILING>
		<RFATAL>)
	       (<VERB? LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(DESC "your hand")
	(SYNONYM HAND HANDS)
	(ADJECTIVE MY BARE)
	(FLAGS TOOLBIT TOUCHBIT NARTICLEBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?REACH-IN ,PRSI>
		<RTRUE>)>>

<OBJECT YOUR-FEET
	(IN GLOBAL-OBJECTS)
	(DESC "your feet")
	(SYNONYM FOOT FEET)
	(ADJECTIVE MY)
	(FLAGS NARTICLEBIT)
	(ACTION YOUR-FEET-F)>

<ROUTINE YOUR-FEET-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,SKIS>>
		<PERFORM ,V?WEAR ,SKIS>
		<RTRUE>)>>

<OBJECT PLAYER
	(SYNONYM PLAYER)
	(DESC "yourself")
	(FLAGS NDESCBIT NARTICLEBIT INVISIBLE ACTORBIT)
	(ACTION 0)
	(SIZE 0)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF)
	(DESC "yourself")
	(FLAGS ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F ("OPTIONAL" (CONTEXT <>) "AUX" OLIT) 
	 <COND (<VERB? ALARM>
		<TELL "You're already wide awake." CR>
		<RTRUE>)
	       (<OR <TALKING-TO? ,ME>
		    <VERB? YELL>>
		<TALK-TO-SELF>
		<RFATAL>)
	       (<VERB? LISTEN>
		<TELL ,YOU-CANT "help doing that." CR>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<COND (<ULTIMATELY-IN? ,PRSO>
		       <TELL "You already have it." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>)>
		<RTRUE>)
	       (<VERB? KILL>
		<TELL "Desperate? Call the Samaritans." CR>
		<RTRUE>)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>
		<RTRUE>)
	       (<HURT? ,ME>
		<TELL "Punishing yourself that way won't help matters." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TALK-TO-SELF ()
	 <TELL "Talking to yourself">
	 <SIGN-OF-COLLAPSE>
	 <PCLEAR>>

<ROUTINE SIGN-OF-COLLAPSE ()
	 <TELL " is said to be a sign of impending mental collapse." CR>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM AREA PLACE)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? ENTER DROP EXIT>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<TELL "You find nothing new." CR>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the area reveals nothing new.~
~
(If you want to go somewhere, just type a direction.)" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE ALREADY-IN (PLACE "OPTIONAL" (NOT? <>))
	 <TELL "But you're ">
	 <COND (.NOT?
		<TELL "not">)
	       (T
		<TELL "already">)>
	 <TELL " in" T .PLACE "!" CR>>

; <ROUTINE CANT-MAKE-OUT-ANYTHING ()
	 <TELL ,YOU-CANT "make out anything inside." CR>>

<ROUTINE CANT-SEE-ANY ("OPTIONAL" (THING <>) (STRING? <>))
	 <YOU-CANT-SEE>
	 <COND (.STRING?
		<TELL .THING>)
	       (.THING
		<COND (<NOT <FSET? .THING ,NARTICLEBIT>>
		       <TELL "any ">)>
		<TELL D .THING>)
	       (T
		<TELL "that">)>
	 <TELL " here!" CR>>

<ROUTINE YOU-CANT-SEE ()
	 <SETG CLOCK-WAIT T>
	 <PCLEAR>
	 <TELL ,YOU-CANT "see ">>

<ROUTINE YOU-ALREADY ()
         <TELL "You already did that." CR>>

; <ROUTINE NOTHING-EXCITING ()
	 <TELL "Nothing exciting happens." CR>>

<ROUTINE HOW? ()
	 <TELL "How do you intend to do that?" CR>>

<GLOBAL I-ASSUME "[Presumably, you mean">

<ROUTINE PRESUMABLY-YOU-WANT-TO (STR "OPTIONAL" (THING <>))
	 <TELL ,I-ASSUME " " .STR " ">
	 <COND (.THING
		<TELL D .THING>) ;"space bug here i think"
	       (T
		<TELL "it">)>
	 <TELL ".]" CR>>
	 
; <ROUTINE TOO-LARGE (THING "OPTIONAL" (SMALL? <>))
	 <BUT-THE .THING>
	 <TELL "is much too ">
	 <COND (.SMALL?
		<TELL "small">)
	       (T
		<TELL "large">)>
	 <TELL "!" CR>>
			      
<ROUTINE NOT-LIKELY (THING STR)
	 <TELL "It" <PICK-ONE ,LIKELIES> " that" T .THING " " .STR "." CR>>

<GLOBAL LIKELIES 
	<LTABLE 0
	 " isn't likely"
	 " seems doubtful"
	 " seems unlikely"
	 "'s unlikely"
	 "'s not likely"
	 "'s doubtful">>

<ROUTINE YOUD-HAVE-TO (STR THING)
	 <TELL "You'd have to " .STR T .THING " to do that." CR>>

; <ROUTINE CLOSED-AND-LOCKED ()
	 <TELL " closed and locked." CR>>

; <ROUTINE VPRINT ("AUX" TMP)
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<==? .TMP 0> <TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>>

; <ROUTINE NOT-HERE (OBJ)
	 <SETG CLOCK-WAIT T>
	 <TELL ,YOU-CANT "see ">
	 <COND (<NOT <FSET? .OBJ ,NARTICLEBIT>> <TELL "any ">)>
	 <TELL D .OBJ " here." CR>>

<OBJECT HER
	(IN GLOBAL-OBJECTS)
	(SYNONYM SHE HER ; WOMAN ; GIRL ; LADY)
	(DESC "her")
	(FLAGS NARTICLEBIT)>

<OBJECT HIM
	(IN GLOBAL-OBJECTS)
	(SYNONYM HE HIM ; MAN ;BOY)
	(DESC "him")
	(FLAGS NARTICLEBIT)>

<OBJECT THEM
	(IN GLOBAL-OBJECTS)
	(SYNONYM THEY THEM)
	(DESC "them")
	(FLAGS NARTICLEBIT)>

;<GLOBAL CANT "You can't ">

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECTION)
	(ADJECTIVE NORTH EAST SOUTH WEST ;UP ;DOWN NE NW SE SW)
    	;(NE 0)
	;(SE 0)
	;(SW 0)
	;(NW 0)>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW GLASS)
	(FLAGS NDESCBIT)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? ,HERE ,PROJECTION-BOOTH>>
		<TELL
"Uncle Buddy's screening room isn't packing in much of a crowd tonight.
A viewing screen dominates the room." CR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? ,HERE ,DINING-ROOM>>
		<COND (<NOT <G? ,MOVES 535>>
		       <TELL "By the moonlight you can see the outline of">)
		      (T
		       <TELL "You can see">)>
		<TELL " Aunt Hildegarde's lush garden." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You see the ">
		<COND (<EQUAL? ,HERE ,SCREENING-ROOM>
		       <TELL "projection booth of">)
		      (<FSET? ,HERE ,OUTDOORSBIT>
		       <TELL "interior of">)
		      (T
		       <TELL "grounds outside">)>
		<TELL " Uncle Buddy's house." CR>)
	       (<AND <VERB? OPEN>
		     <NOT <EQUAL? ,HERE ,PROJECTION-BOOTH ,SCREENING-ROOM>>>
		<TELL "That would let in all the smog!" CR>)
	       (<VERB? CLOSE ENTER>
	        <TELL "The window isn't open." CR>)>>

;"default for things that are too heavy to carry"
<GLOBAL SPINACH
	"It's too heavy. Maybe if you'd eaten your spinach as Aunt
Hildegarde told you.">