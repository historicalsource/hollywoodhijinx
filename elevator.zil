"ELEVATOR for ANTHILL (C)1986 Infocom Inc. All rights reserved."


"--- Closet Stuff ---"

<ROOM CLOSET
      (IN ROOMS)
      (DESC "Closet")
      (NORTH PER CLOSET-EXIT-F)
      (OUT PER CLOSET-EXIT-F)
      (FLAGS RLANDBIT)
      (GLOBAL CLOSET-REF FOYER-CD CELLAR-CD UPSTAIRS-CD)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION CLOSET-F)
      (THINGS <PSEUDO (<> HOLE CLOSET-HOLE-PSEUDO)>)>

<ROUTINE CLOSET-HOLE-PSEUDO ()
	 <COND (<VERB? PUT>
		<COND (<PRSO? ,PEG-0>
		       <SETG SCORE <+ ,SCORE 10>>
		       <ROB ,PLAYER ,HEART-OF-MAZE> ;"SEM"
		       <COND (<FSET? ,RING ,WORNBIT>
			      <MOVE ,RING ,PLAYER>)>
		       <COND (<FSET? ,TOUPEE ,WORNBIT>
			      <MOVE ,TOUPEE ,PLAYER>)>
		       <COND (<FSET? ,MASK ,WORNBIT>
			      <MOVE ,MASK ,PLAYER>)>
		       <DEQUEUE I-SANDS-OF-TIME>
		       <DEQUEUE I-NOISE>
		       <QUEUE I-AUNT 2>
		       <TELL

"You put" T ,PEG-0 " in the hole and the closet door slams shut. Without
warning, the floor drops out from under you! You fall for several seconds
then land with a bone-crunching thud, dropping everything you're
holding. You slide down a twisting, slippery slide and are dumped into a
room filled with props.~
~
You look around the room and can't believe what your eyes are seeing.
There is Aunt Hildegarde! She's tied to the conveyor belt of a whirling
buzz saw and a man is standing over her. Aunt Hildegarde sees you and
screams. The man turns and you immediately recognize your childhood
nemesis: Cousin Herman." CR CR>
		       <QUEUE I-HERMAN-ATTACK 2>
		       <GOTO ,PROP-VAULT>)
		(T
		 <TELL "The " D ,PRSO " won't fit in the hole." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You see nothing but darkness." CR>)>>

<ROUTINE CLOSET-F (RARG "AUX" DOOR)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<SET DOOR <WHICH-DOOR?>>
		<TELL
"You're in a small closet. Mounted at an angle on the back wall of the
closet are three coat pegs. To the left of the first peg there is a hole
the size of a peg. To the right of the third peg there is a peg which has been
sawed-off, flush with the wall. The door to the north is ">
		<COND (<FSET? .DOOR ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ".">)>>

<OBJECT PEG-5
	(IN CLOSET)
	(DESC "sawed-off peg")
	(SYNONYM PEG)
	(ADJECTIVE SAWED OFF FOURTH COAT WOODEN)
	(FLAGS NDESCBIT)
	(ACTION PEG-5-F)>

<ROUTINE PEG-5-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's what's left of a coat peg. It looks as if someone sawed off
the peg." CR>)
	       (<VERB? PULL>
		<TELL
"There's nothing to pull -- it's sawed-off." CR>)>>

<ROUTINE CLOSET-EXIT-F ("AUX" DOOR)
	 <SET DOOR <WHICH-DOOR?>>
	 <COND (<NOT <FSET? .DOOR ,OPENBIT>>
		<THIS-IS-IT .DOOR>
		<ITS-CLOSED .DOOR>
		<RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CELLAR>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,FOYER>)
	       (T
		<RETURN ,UPSTAIRS-HALL-MIDDLE>)>>

<ROUTINE WHICH-DOOR? ()
	 <COND (<EQUAL? ,HERE ,CLOSET>
		<COND (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		       <RETURN ,CELLAR-CD>)
		      (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		       <RETURN ,FOYER-CD>)
		      (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>
		       <RETURN ,UPSTAIRS-CD>)
		      (T
		       <RETURN ,ATTIC-CD>)>)
 	       (T ;"Here is Closet Top"
		<COND (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		       <RETURN ,FOYER-CD>)
		      (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		       <RETURN ,UPSTAIRS-CD>)
		      (T
		       <RETURN ,ATTIC-CD>)>)>>

<ROOM PROP-VAULT
      (IN ROOMS)
      (DESC "Prop Vault")
      (DOWN PER TO-CHUTE)
      (EAST PER TO-CHUTE)
      (FLAGS RLANDBIT ONBIT)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION PROP-VAULT-F)>

<ROUTINE PROP-VAULT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a vault filled with props. You can see Aunt Hildegarde tied to
a buzz saw. Cousin Herman is here, thinking of something rotten to do to
you. To the east there is a chute.">)>>

<OBJECT CHUTE  ;"PSEUDO-CANDIDATE"
	(IN PROP-VAULT)
	(DESC "chute")
	(SYNONYM CHUTE)
	(FLAGS NDESCBIT)
	(ACTION CHUTE-F)>

<ROUTINE CHUTE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The chute leads down into darkness." CR>)
	       (<VERB? ENTER>
		<DO-WALK P?DOWN>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CHUTE>>
		<REMOVE ,PRSO>
		<TELL "You toss" T ,PRSO " in the chute." CR>)>>

<ROUTINE TO-CHUTE ()
	 <COND (,HERMAN-DOWN
		<TELL "Haven't you forgotten something?" CR>
		<RFALSE>)
	       (T
		<TELL
"Cousin Herman jumps in front of the chute then punches you in
the stomach." CR>
		<RFALSE>)>>

<OBJECT CLOSET-REF
	(IN LOCAL-GLOBALS)
	(DESC "closet")
	(SYNONYM CLOSET)
	(ADJECTIVE COAT)
	(ACTION CLOSET-REF-F)>

<ROUTINE CLOSET-REF-F ()
         <COND (<AND <VERB? LOOK-INSIDE ENTER SEARCH>
	             <EQUAL? ,HERE ,CLOSET-TOP>>
		<TELL "You can't enter the closet from here." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <EQUAL? ,HERE ,CLOSET>>
		<V-LOOK>)
	       (<AND <VERB? LOOK-INSIDE SEARCH>
		     <NOT <EQUAL? ,HERE ,CLOSET>>>
		<COND (<EQUAL? ,CLOSET-FLOOR ,HERE>
		       <TELL "You'll have to enter the closet first." CR>)
		      (T
		       <TELL "You see an empty shaft." CR>)>)
	       (<VERB? SEARCH>
		<PERFORM ,V?SEARCH ,GLOBAL-ROOM>
		<RTRUE>)
	       (<VERB? OPEN>
		<PERFORM ,V?OPEN <COND (<EQUAL? ,HERE ,CLOSET>
		       		        <WHICH-DOOR?>)
				       (<EQUAL? ,HERE ,FOYER>
		       		        ,FOYER-CD)
				       (<EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
		       			,UPSTAIRS-CD)
				       (<EQUAL? ,HERE ,CELLAR>
		       			,CELLAR-CD)
				       (T
					,ATTIC-CD)>>
		<RTRUE>)
	       (<VERB? CLOSE>
		<PERFORM ,V?CLOSE <COND (<EQUAL? ,HERE ,CLOSET>
		       		        <WHICH-DOOR?>)
				       (<EQUAL? ,HERE ,FOYER>
		       		        ,FOYER-CD)
				       (<EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
		       			,UPSTAIRS-CD)
				       (<EQUAL? ,HERE ,CELLAR>
		       			,CELLAR-CD)
				       (T
					,ATTIC-CD)>>
		<RTRUE>)
	       (<VERB? DISEMBARK EXIT>
		<DO-WALK ,P?OUT>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <TELL "Look around." CR>)
		      (T
		       <DO-WALK ,P?IN>)>)>>


"--- Peg Stuff ---"

<OBJECT PEGS
	(IN CLOSET)
	(DESC "set of coat pegs")
	(SYNONYM PEGS)
	(ADJECTIVE COAT WOODEN)
        (FLAGS NDESCBIT)
	(ACTION PEGS-F)>

<ROUTINE PEGS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"There are three pegs mounted at an angle to the wall. To the left of
the first peg is a hole the size of a peg. To the right of the third peg
you can see where a peg has been sawed-off, flush with the wall." CR>
		<RTRUE>)
	       (<VERB? MOVE PULL PUSH LOWER PUSH-DOWN>
	        <TELL
"You try to pull down all three pegs at once. They won't budge, but
the closet makes a grinding noise." CR>)
	       (T
		<RFALSE>)>>  ;"why rfalse??"

<OBJECT PEG-3
	(IN CLOSET)
	(DESC "third coat peg")
	(SYNONYM PEG)
	(ADJECTIVE THIRD COAT WORN WOODEN)
        (FLAGS NDESCBIT)
	(ACTION PEG-F)>

<OBJECT PEG-2
	(IN CLOSET)
	(DESC "second coat peg")
	(SYNONYM PEG)
	(ADJECTIVE SECOND COAT WORN WOODEN)
        (FLAGS NDESCBIT)
	(ACTION PEG-F)>

<OBJECT PEG-1
	(IN CLOSET)
	(DESC "first coat peg")
	(SYNONYM PEG)
	(ADJECTIVE FIRST COAT WORN WOODEN)
        (FLAGS NDESCBIT)
	(ACTION PEG-F)>

<ROUTINE PEG-F ()
	 <COND (<VERB? MOVE PULL PUSH LOWER PUSH-DOWN>
		<COND (<AND <EQUAL? ,PRSO ,BUCKET-PEG>
			    <FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>>
		       <TELL
"The bucket is already holding" T ,PRSO " down." CR>)
	       	      (T
		       <TELL
"You pull the peg down to a horizontal position.">
		       <COND (<FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
			      ;"a peg's being held down"
			      <TELL " You hear a grinding noise.">)>
		       <TELL CR CR
"As you release the peg, it pops back into its
original 45-degree position.">
		       <COND (<FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
			      <CRLF>)
			     (T
			      <TELL " ">
			      <ELEVATOR-OPERATOR ,PRSO>)>)>)
	       (<AND <VERB? HANG-UP>
		     <PRSI? ,PEG-1 ,PEG-2 ,PEG-3>
		     <NOT <PRSO? ,BUCKET>>>
		<MOVE ,PRSO ,HERE>
		<TELL "The " D ,PRSO " slips off and falls to the floor." CR>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
		       <TELL
"The " D ,PRSO " is in a horizontal position with a bucket hanging on it.">)
		      (<EQUAL? ,PRSO ,BUCKET-PEG>
		       <TELL
"The " D ,PRSO " is pointing up at an angle with a bucket hanging on it.">)
		      (T
		       <TELL
"You see a worn coat peg mounted at an angle.">)>
		<CRLF>)>>

<OBJECT PEG-0
	(DESC "chipped peg")
	(SYNONYM PEG)
	(ADJECTIVE COAT CHIPPED WORN WOODEN)
        (FLAGS TAKEBIT)
	(SIZE 3)
        (ACTION PEG-0-F)>

<ROUTINE PEG-0-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's a worn coat peg." CR>)>>

<OBJECT NOTE
	(DESC "note")
	(SYNONYM NOTE PAPER)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 1)
	(TEXT
"Congratulations Pumpkin! You've found all the \"treasures.\" Now come on
down for a big surprise.~
               Aunt Hildegarde")>

<ROUTINE ELEVATOR-OPERATOR (PEG)
	 <COND (<EQUAL? ,HERE ,FOYER ,CELLAR ,UPSTAIRS-HALL-MIDDLE ,ATTIC
			      ,SHAFT-BOTTOM>
		<TELL "The closet door swings shut by itself." CR>)>
	 <COND (<OR <AND <EQUAL? .PEG ,PEG-1>
			 <EQUAL? ,CLOSET-FLOOR ,CELLAR>>
		    <AND <EQUAL? .PEG ,PEG-2>
			 <EQUAL? ,CLOSET-FLOOR ,FOYER>>
		    <AND <EQUAL? .PEG ,PEG-3>
			 <EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>>>
		<COND (<EQUAL? ,HERE ,CLOSET ,CLOSET-TOP>
		       <COND (<EQUAL? ,HERE ,CLOSET>
			      <COND (<FSET? <WHICH-DOOR?> ,OPENBIT>
			             <TELL
				      "The closet door swings shut and you">)
				    (T
			             <TELL "You">)>)
		      	     (T	
		       	      <COND (<FSET? <WHICH-DOOR?> ,OPENBIT>
			      	     <TELL 
				     "The shaft door swings shut and you">)
			     	    (T
			       	     <TELL "You">)>)>
		       <TELL " feel the closet">
		       <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			      <TELL " ceiling">)>
		       <TELL " vibrate, then stop." CR>)
		     ;(T
		       <CRLF>)>)
	       (T
		<COND (<EQUAL? ,HERE ,CLOSET ,CLOSET-TOP>
		       <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			      <CRLF>)>
		       <TELL "The closet ">
		       <COND (<EQUAL? ,HERE ,CLOSET-TOP>
			      <TELL "ceiling ">)>
		       <TELL
"begins to shake and rattle a bit">
		       <COND (<AND <EQUAL? ,HERE ,CLOSET ,CLOSET-TOP>
			           <FSET? <WHICH-DOOR?> ,OPENBIT>>
			      <TELL " as the door swings shut">)>
		       <TELL ". You feel your stomach ">	               
                       <COND (<EQUAL? .PEG ,PEG-3>
			      <TELL
"drop to your knees as the closet ">
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			             <TELL
"moves up. You enter the top of the shaft, then the closet stops." CR CR>
			             <GOTO ,CLOSET-TOP>) ;"CLOSET-TOP-4"
			            (T
			             <TELL "moves up, then stops." CR ;CR>)>)

			     (<AND <EQUAL? .PEG ,PEG-2>
			           <EQUAL? ,CLOSET-FLOOR ,CELLAR>>
			      <TELL
"drop to your knees as the closet ">
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			             <TELL "floor ">)>
			      <TELL "moves up, then stops." CR>
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
				     <CRLF>
				     <GOTO ,CLOSET-TOP>)>) ;",CLOSET-TOP-3"
			     (<AND <EQUAL? .PEG ,PEG-2>
				   <EQUAL? ,CLOSET-FLOOR
					   ,UPSTAIRS-HALL-MIDDLE>>
			      <TELL
"rising to your throat as the closet ">
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			             <TELL "floor ">)>
			      <TELL "moves down, then stops." CR>
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
				     <CRLF>
				     <GOTO ,CLOSET-TOP>)>) ;",CLOSET-TOP-3"

			     (T ;"prso? peg-1"
                              <TELL
"rising to your throat as the closet ">
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
			             <TELL "floor ">)>
			      <TELL "moves down, then stops." CR>
			      <COND (<NOT <EQUAL? ,HERE ,CLOSET>>
				     <CRLF>
				     <GOTO ,CLOSET-TOP>)>)>) ;",CLOSET-TOP-2"
		      (<AND <EQUAL? ,HERE ,SHAFT-BOTTOM>
			    <EQUAL? .PEG ,PEG-1>>
		       <JIGS-UP
"~
Before you can get out of the shaft, the closet descends, assuring you
a closed-casket service.">)>)>
	 <COND (<EQUAL? .PEG
		,PEG-1> <SETG CLOSET-FLOOR ,CELLAR>)
	       (<EQUAL? .PEG ,PEG-2>
		<SETG CLOSET-FLOOR ,FOYER>)
	       (T
		<SETG CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>)>
	 <FCLEAR ,ATTIC-CD ,OPENBIT>
	 <FCLEAR ,UPSTAIRS-CD ,OPENBIT>
	 <FCLEAR ,FOYER-CD ,OPENBIT>
	 <FCLEAR ,CELLAR-CD ,OPENBIT>>

<OBJECT BUCKET
	(IN CLOSET)
	(DESC "rusty bucket")
       ;(FDESC "There is a rusty bucket lying here.")
	(SYNONYM BUCKET HANDLE PAIL)
	(ADJECTIVE RUSTY LEAKY METAL RUSTED)
	(FLAGS TAKEBIT CONTBIT OPENBIT SEARCHBIT TRYTAKEBIT)
						 ;"so parser doesn't do a take"
	(CAPACITY 20)
	(SIZE 16)
	(DESCFCN BUCKET-F)
	(ACTION BUCKET-F)>

<ROUTINE BUCKET-F ("OPTIONAL" (OARG <>) ;"for DESCFCN" "AUX" (FULL? <>))
	 <SET FULL? <IN? ,PORTABLE-WATER ,BUCKET>>
	 <COND (.OARG
		<COND (,BUCKET-PEG
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL CR
"A " 'BUCKET " is hanging from" T ,BUCKET-PEG>
		       <COND (<IN? ,PORTABLE-WATER ,BUCKET>
			      <TELL ". The bucket ">
			      <DESCRIBE-WATER-LEVEL>)>
		       <TELL ".">)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT-ON HANG-UP>
		     <PRSI? ,PEG-1 ,PEG-2 ,PEG-3>>
		<SETG BUCKET-PEG ,PRSI>
		<FSET ,BUCKET ,TRYTAKEBIT>;"so parser doesn't do a take"
		<MOVE ,BUCKET ,HERE>
		<COND (<IN? ,PORTABLE-WATER ,BUCKET>
		       ;"this prevents redundancy from a LOOK in the closet"
		       <FSET ,PORTABLE-WATER ,NDESCBIT>)>
		<COND (<OR <AND <IN? ,PORTABLE-WATER ,BUCKET>
				<G? ,AMOUNT-OF-WATER 10>>
			   <G? <WEIGHT ,BUCKET> 20>>
		       <FSET ,BUCKET ,BUCKET-PEG-DOWN-BIT>
		       <TELL
"As you hang" T ,BUCKET " on" T ,PRSI ", the peg lowers to a horizontal
position and you feel the closet begin to vibrate." CR>)
		      (T
		       <TELL
"You hang" T ,BUCKET " on the peg." CR>)>)
	        (<AND <VERB? TAKE>
		      <PRSO? ,BUCKET>
		      <FSET? ,BUCKET ,TRYTAKEBIT>>
		 <COND (<NOT <ITAKE>>
			<RTRUE>)
		       (<FSET? ,BUCKET ,WETBIT>
			<FCLEAR ,BUCKET ,WETBIT>
		        <MOVE ,PORTABLE-WATER ,BUCKET>
			<SETG AMOUNT-OF-WATER 26>
			<TELL "Taken." CR>
		        <QUEUE I-DRIP 1>)
		       (<FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
			<FCLEAR ,BUCKET ,TRYTAKEBIT>
		        <FCLEAR ,BUCKET ,BUCKET-PEG-DOWN-BIT>
			<FCLEAR ,PORTABLE-WATER ,NDESCBIT>
			<TELL
"As you remove" T ,BUCKET "," T ,BUCKET-PEG " pops back into
its original 45-degree position. ">
	                <ELEVATOR-OPERATOR ,BUCKET-PEG>
			<SETG BUCKET-PEG <>>
			<RTRUE>)
		       (T
			<FCLEAR ,BUCKET ,TRYTAKEBIT>
			<FCLEAR ,PORTABLE-WATER ,NDESCBIT>
			<SETG BUCKET-PEG <>>
			<TELL "Taken." CR>)>)			    
	       (<VERB? LOOK-INSIDE SEARCH EXAMINE>
                <TELL
"It's an old metal bucket which is beginning to rust through on the bottom.
It has a rusty handle and ">
		<COND (<IN? ,PORTABLE-WATER ,BUCKET>
		       <DESCRIBE-WATER-LEVEL>
		       <TELL "." CR>)
		      (<FIRST? ,BUCKET>
		       <TELL "contains">
		       <COND (<NOT <DESCRIBE-NOTHING>>)>
		       <RTRUE>)
		      (T
		       <TELL "it's empty." CR>)>
	       ;<TELL "." CR>)
	      ;(<AND <VERB? TAKE-WITH>
		     <PRSO? ,WATER ,PORTABLE-WATER>>
		<PERFORM ,V?FILL ,BUCKET ,WATER>
		<RTRUE>)
	       (<AND .FULL?
		     <VERB? THROW>>		
		<PERFORM ,V?DROP ,PORTABLE-WATER>
		<MOVE ,BUCKET ,HERE>
		<RTRUE>)
	       (<VERB? STAND-ON>
		<TELL "It wouldn't be a very elevating experience." CR>)
	       (<VERB? DRINK DRINK-FROM>
		<COND (.FULL?
		       <PERFORM ,V?DRINK ,WATER>
		       <RTRUE>)
		      (T
		       <EMPTY-BUCKET>)>)
	       (<VERB? POUR EMPTY>
		<COND (.FULL?
		       <PERFORM ,V?EMPTY ,PORTABLE-WATER>
		       <RTRUE>)
		      (T
		       <EMPTY-BUCKET>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,BUCKET>>
	        <COND (,BUCKET-PEG
		       <TELL ,PEG-IN-WAY>)
		      (<PRSO? ,PORTABLE-WATER ,WATER>
		       <PERFORM ,V?FILL ,BUCKET ,WATER>
		       <RTRUE>)
		      (.FULL?
		       <TELL "But" T ,PRSO " would get all wet." CR>)>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<ROUTINE DESCRIBE-WATER-LEVEL ()
	 <TELL "is ">
	 <COND (<G? ,AMOUNT-OF-WATER 21>
		<TELL "full">)
	       (<G? ,AMOUNT-OF-WATER 13>
		<TELL "more than half full">)
	       (<G? ,AMOUNT-OF-WATER 11>
		<TELL "about half full">)
	       (<G? ,AMOUNT-OF-WATER 3>
		<TELL "less than half full">)
	       (T
		<TELL "nearly empty">)>
	 <TELL " of water">>

<GLOBAL AMOUNT-OF-WATER 0>

<ROUTINE I-DRIP ()
         <QUEUE I-DRIP -1>
	 <SETG AMOUNT-OF-WATER <- ,AMOUNT-OF-WATER 1>>
	 <COND (<OR <IN? ,BUCKET ,POND>
		    <AND <IN? ,BUCKET ,PLAYER>
			 <EQUAL? ,HERE ,INLET ,ON-POOL-1 ,IN-POOL-1
				 ,UNDERPASS-1 ,UNDERPASS-2
				 ,IN-POOL-2 ,ON-POOL-2>>>
		<SETG AMOUNT-OF-WATER 26>
		<RFALSE>)
	       (<EQUAL? ,AMOUNT-OF-WATER 0>
		<FCLEAR ,PORTABLE-WATER ,NDESCBIT>
		<REMOVE ,PORTABLE-WATER>
		<DEQUEUE I-DRIP>)>
	 <COND (<AND <VISIBLE? ,BUCKET>
		     ,LIT>
		<TELL CR "The water ">
		<COND (<EQUAL? ,AMOUNT-OF-WATER 25>
		       <TELL "begin">)
		      (T
		       <TELL "continue">)>
		<TELL "s to dribble out of" T ,BUCKET ".">
		<COND (<EQUAL? ,AMOUNT-OF-WATER 0>
		       <TELL " The bucket is now pretty much empty.">)
		      (<EQUAL? ,AMOUNT-OF-WATER 6 12 18>
		       <TELL " The bucket is now around ">
		       <COND (<EQUAL? ,AMOUNT-OF-WATER 18>
			      <TELL "three-quarters">)
			     (<EQUAL? ,AMOUNT-OF-WATER 12>
			      <TELL "half">)
			     (T
			      <TELL "one-quarter">)>
		       <TELL " full.">)>
		<CRLF>)>
	 <COND (<AND <FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
		           ;"on bucket peg, peg pulled down"
		     <L? ,AMOUNT-OF-WATER 10>>
		<COND (<VISIBLE? ,BUCKET>
		       <TELL
"Suddenly" T ,BUCKET-PEG " pops back into its original 45-degree
position. ">)>
		<ELEVATOR-OPERATOR ,BUCKET-PEG>
		<FCLEAR ,BUCKET ,BUCKET-PEG-DOWN-BIT>
		<RTRUE>)>
	 <COND (<VISIBLE? ,BUCKET>
		<RTRUE>)>> ;"don't I want to return true no matter what?"

<ROUTINE EMPTY-BUCKET ("AUX" OBJ) ;"of non-water objects"
	 <COND (<SET OBJ <FIRST? ,BUCKET>>
		<COND (<VERB? DRINK-FROM>
		       <PERFORM ,V?DRINK .OBJ>
		       <RTRUE>)
		      (T                   ;"verbs empty, pour"
		       <COND (<NEXT? .OBJ>
			      <TELL "The contents of the " D ,BUCKET " fall">)
			     (T
			      <TELL "Okay," T .OBJ " falls">)>		       
		       <ROB ,BUCKET ,HERE>
		       <TELL " out of it." CR>)>)
	       (T
		<TELL "It's empty." CR>)>>

<ROUTINE NOT-HOLDING-WATER? ()
	 <COND (<NOT <IN? ,PORTABLE-WATER ,BUCKET>>
		<TELL "You're not carrying any water." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL BUCKET-PEG PEG-2>

;<ROUTINE HUM ()
	 <COND (<FSET? ,BUCKET ,BUCKET-PEG-DOWN-BIT>
		<COND (<L? ,AMOUNT-OF-WATER 10>
                       <TELL "Suddenly" T ,BUCKET-PEG>)
		      (T
		       <TELL "You remove the bucket" T ,BUCKET-PEG>)>)
	       (T
		<TELL
"You pull the peg and it lowers to a horizontal position. You hear a faint
humming noise. As you release the peg, it">)>
	 <TELL
" pops back into its original 45-degree position.">>

"--- Elevator Rooms ---"

<ROOM SHAFT-BOTTOM
      (IN ROOMS)
      (DESC "Shaft Bottom")
      (NORTH TO CELLAR IF CELLAR-CD IS OPEN)
      (OUT TO CELLAR IF CELLAR-CD IS OPEN)
      (GLOBAL CELLAR-CD)
      (FLAGS RLANDBIT)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION SHAFT-BOTTOM-F)>

<ROUTINE SHAFT-BOTTOM-F (RARG)
        <COND (<EQUAL? .RARG ,M-LOOK>
               <TELL
"You're standing at the bottom of a shaft. The door to the north is ">
		<COND (<FSET? ,CELLAR-CD ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ".">)>>

<ROOM CLOSET-TOP
      (IN ROOMS)
      (DESC "Top of Closet")
      (NORTH PER CLOSET-TOP-EXIT) ;"TO FOYER IF FOYER-CD IS OPEN"
      (OUT PER CLOSET-TOP-EXIT)  ;"TO FOYER IF FOYER-CD IS OPEN"
      (GLOBAL FOYER-CD UPSTAIRS-CD ATTIC-CD CLOSET-REF)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (FLAGS RLANDBIT)
      (ACTION CLOSET-TOP-F)>

<ROUTINE CLOSET-TOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're standing in a shaft on top of the closet. The door to the north is ">
		<COND (<FSET? <WHICH-DOOR?> ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ".">)>>

;<ROUTINE WHICH-CLOSET-TOP-DOOR? ()
	 <COND (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
			,FOYER-CD)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
			,UPSTAIRS-CD)
	       (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>
			,ATTIC-CD)>> 

<ROUTINE CLOSET-TOP-EXIT ("AUX" DOOR)
	 <SET DOOR <WHICH-DOOR?>>
	 <COND (<NOT <FSET? .DOOR ,OPENBIT>>
		<THIS-IS-IT .DOOR>
		<ITS-CLOSED .DOOR>
		<RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		,FOYER)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		,UPSTAIRS-HALL-MIDDLE)
	       (T
	        ,ATTIC)>>

;<ROOM CLOSET-TOP-3
      (IN ROOMS)
      (DESC "Top of Closet")
      (NORTH TO UPSTAIRS-HALL-MIDDLE IF UPSTAIRS-CD IS OPEN)
      (OUT TO UPSTAIRS-HALL-MIDDLE IF UPSTAIRS-CD IS OPEN)
      (GLOBAL UPSTAIRS-CD)
      (FLAGS RLANDBIT)
      (ACTION CLOSET-TOP-3-F)>

;<ROUTINE CLOSET-TOP-3-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<SHAFT-DOOR ,UPSTAIRS-CD>)>>

;<ROOM CLOSET-TOP-4
      (IN ROOMS)
      (DESC "Top of Closet")
      (NORTH TO ATTIC IF ATTIC-CD IS OPEN)
      (OUT TO ATTIC IF ATTIC-CD IS OPEN)
      (GLOBAL ATTIC-CD)
      (FLAGS RLANDBIT)
      (ACTION CLOSET-TOP-4-F)>

;<ROUTINE CLOSET-TOP-4-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<SHAFT-DOOR ,ATTIC-CD>)>>

<OBJECT ATTIC-CD
	(IN LOCAL-GLOBALS)
	(DESC "closet door")
	(SYNONYM DOOR)
	(ADJECTIVE CLOSET)
	(FLAGS DOORBIT NDESCBIT)
        (GENERIC WHICH-DOOR?)
	(ACTION ATTIC-CD-F)>

<ROUTINE ATTIC-CD-F () 
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,ATTIC-CD ,OPENBIT>>
		     <NOT <EQUAL? ,CLOSET-FLOOR ,ATTIC>>
		     <EQUAL? ,HERE ,ATTIC>>
		<OPEN-DOOR-TO-SHAFT>
		<FSET ,ATTIC-CD ,OPENBIT>)>>

<ROOM ATTIC
      (IN ROOMS)
      (DESC "Attic")
      (FLAGS RLANDBIT LOCKEDBIT) ;"for unlocking attic door"
      (DOWN PER TO-&-FROM-ATTIC)
      (SOUTH PER ATTIC-CLOSET-ENTER-F) 
      (GLOBAL ATTIC-DOOR ATTIC-CD)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION ATTIC-F)>

<ROUTINE ATTIC-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a dusty old attic with cobwebs hanging from the ceiling
rafters. The attic is empty except for" A ,TRUNK>
		<COND (<FSET? ,ATTIC-DOOR ,OPENBIT>
		       <TELL 
". A ladder leads down through an opening">)
		      (T
		       <TELL
" and a folding ladder attached to a panel">)>
		<TELL" in the floor. To the south there is a">
		<COND (<FSET? ,ATTIC-CD ,OPENBIT>
		       <TELL "n open">)
		      (T
		       <TELL " closed">)>
		<TELL " door.">)>>

<ROUTINE TO-&-FROM-ATTIC ()
	 <COND (<FSET? ,ATTIC-DOOR ,OPENBIT>
		<COND (<FSET? ,SKIS ,WORNBIT>
		       <TELL
"You can't fit through the opening wearing the skis." CR>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? ,HERE ,ATTIC>
			      ,UPSTAIRS-HALL-MIDDLE)
			     (T
			      ,ATTIC)>)>)
	       (T
		<TELL "The " D ,ATTIC-DOOR " is closed." CR>
		<RFALSE>)>> 

<ROUTINE ATTIC-CLOSET-ENTER-F ()
	 <COND (<NOT <FSET? ,ATTIC-CD ,OPENBIT>>
		<ITS-CLOSED ,ATTIC-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>
		<RETURN ,CLOSET-TOP>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<TELL
"You enter the shaft and plunge down a floor. A bit shaken, you
find yourself at..." CR CR>
		<RETURN ,CLOSET-TOP>)
               (T
                <JIGS-UP
"You step into a shaft and plunge down, slowing ever so slightly as your body
crashes through the top of the closet then abruptly comes to a stop on the
floor of the closet.">)>>

<OBJECT TRUNK
        (IN ATTIC)
	(DESC "dusty trunk")
	(SYNONYM TRUNK)
	(ADJECTIVE DUSTY)
	(CAPACITY 30)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT TRUNK-LOCKED-BIT)
	(ACTION TRUNK-F)>		  ;"cleared when panel opens"

<ROUTINE TRUNK-F ()
         <COND (<AND <VERB? OPEN>
		     <FSET? ,TRUNK ,TRUNK-LOCKED-BIT>>
		<TELL "It won't budge." CR>)
	       (<AND <VERB? TAKE MOVE>
		     <PRSO? ,TRUNK>> ;"SEM"
		<TELL ,SPINACH CR>)>>

<OBJECT FIRE-HYDRANT
	(IN TRUNK)
	(DESC "fire hydrant")
	(SYNONYM HYDRANT)
	(ADJECTIVE FIRE)
	(VALUE 10)
	(SIZE 20)
	(FLAGS TAKEBIT)
	(ACTION FIRE-HYDRANT-F)>

<ROUTINE FIRE-HYDRANT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Don't you recognize it? It's a prop " D ,FIRE-HYDRANT " from \"Atomic
Chihuahuas From Hell.\" Uncle Buddy took a lot of heat for that film
when two unlikely special interest groups, the Institute for Nuclear
Power and the American Chihuahua Breeders Association, joined forces in
an effort to have the film banned." CR>)>>

<OBJECT ATTIC-DOOR
        (IN LOCAL-GLOBALS)
        (DESC "panel")
	(SYNONYM PANEL LADDER)
	(ADJECTIVE FOLDING ATTIC)
	(FLAGS NDESCBIT LOCKEDBIT DOORBIT)
	(ACTION ATTIC-DOOR-F)>

<ROUTINE ATTIC-DOOR-F ()
	 <COND (<AND <VERB? PUSH-DOWN OPEN LOWER PULL PUSH>
		     <NOT <FSET? ,ATTIC-DOOR ,OPENBIT>>>
		<COND (<EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
		       <TELL "It won't budge from this side." CR>)
		      (T
		       <FSET ,ATTIC-DOOR ,OPENBIT>
		       <FCLEAR ,ATTIC-DOOR ,LOCKEDBIT>
		       <TELL
"The panel in the floor drops downward and the ladder unfolds as it swings down
into the upstairs hallway.">
		       <COND (<NOT <FSET? ,TRUNK ,OPENBIT>>
			     ;<FSET ,TRUNK ,OPENBIT>
			      <FCLEAR ,TRUNK ,TRUNK-LOCKED-BIT>
			      <TELL
" At the same time you hear a click from under" T ,TRUNK "'s lid.">)>
		       <CRLF>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,ATTIC-DOOR ,OPENBIT>
		       <TELL
"The ladder hangs from an open panel in the ceiling, extended to the floor of
the upstairs hallway." CR>)
		      (T
		       <COND (<EQUAL? ,HERE ,ATTIC>
			      <TELL
"The wooden ladder is folded in thirds, with the first third attached to a
panel in the floor." CR>)>)>)>>

;"end game" 

<OBJECT AUNT
	(IN PROP-VAULT)
	(DESC "Aunt Hildegarde")
	(SYNONYM AUNT HILDEG BURBAN)
	(ADJECTIVE AUNT)
	(FLAGS ACTORBIT NDESCBIT NARTICLEBIT)
	(ACTION AUNT-F)>

<ROUTINE AUNT-F ()
	 <COND (<EQUAL? ,AUNT ,WINNER>
		<TELL "\"Shut up and get me off this buzz saw!\"" CR>
		<PCLEAR>)
	       (<VERB? EXAMINE>
		<TELL
"She's strapped to the conveyor belt and moving closer to the buzz saw's
spinning blade." CR>)
	       (<AND <VERB? CUT>
		     <PRSI? ,SWORD>>
		<PERFORM ,V?LAMP-OFF ,SAW>
		<RTRUE>)
	       (<AND <VERB? UNTIE RESCUE LET-GO>
		     <PRSO? ,AUNT>>
		<PERFORM ,V?LAMP-OFF ,SAW>
		<RTRUE>)>>

<OBJECT HERMAN
        (IN PROP-VAULT)
	(DESC "Cousin Herman")
	(SYNONYM HERMAN BEAUMONT)
	(ADJECTIVE COUSIN)
	(FLAGS ACTORBIT NDESCBIT NARTICLEBIT)
	(ACTION HERMAN-F)>

<ROUTINE HERMAN-F ()
	 <COND (<OR <VERB? TELL>
		    <AND <VERB? ASK-ABOUT>
			 <PRSO? ,HERMAN>>>
		<TELL "Herman never was the talkative type." CR>
		<PCLEAR>)
	       (<AND <VERB? KILL>
		     <NOT ,PRSI>>
		<COND (<FIRST? ,PLAYER>
		       <TELL
"[with the " D <FIRST? ,PLAYER> "]" CR>
		       <PERFORM ,V?KILL ,HERMAN <FIRST? ,PLAYER>>
		       <RTRUE>)
		      (T
		       <TELL
"You slug Herman in the gut. It feels good after all these years." CR>)>)
	       (<AND <VERB? PUSH>
		     <PRSO? ,HERMAN>>
		<TELL "He pushes you right back." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's Cousin Herman all right. A little older and a little chubbier.
He still wears Batman slip-on tennis shoes." CR>)
	       (<VERB? BITE KICK>
		<TELL
"\"%*&@#!,\" shouts Herman at the top of his lungs. You are aghast at
Herman's profanity in the presence of your Aunt Hildegarde." CR>)>>

<OBJECT CLUB
        (IN PROP-VAULT)
	(DESC "hairy club")
	(SYNONYM CLUB)
	(ADJECTIVE HAIRY)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION PROP-F)>

<OBJECT STICK
	(IN PROP-VAULT)
	(DESC "big stick")
	(SYNONYM STICK)
	(ADJECTIVE BIG)
        (FLAGS TAKEBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<OBJECT GUN
	(IN PROP-VAULT)
	(DESC "gun")
	(SYNONYM GUN)
	(ADJECTIVE WHIP WHIPPED CREAM)
        (FLAGS TAKEBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<OBJECT MOP
	(IN PROP-VAULT)
	(DESC "glowing mop")
	(SYNONYM MOP)
	(ADJECTIVE GLOWING)
        (FLAGS TAKEBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<OBJECT BAG
	(IN PROP-VAULT)
	(DESC "boomerang mail bag")
	(SYNONYM BAG MAILBAG)
	(ADJECTIVE BOOMERANG MAIL)
        (FLAGS TAKEBIT)
	(SIZE 10)
	(ACTION PROP-F)>

<OBJECT CLIPPERS
	(IN PROP-VAULT)
	(DESC "giant nail clippers")
	(SYNONYM CLIPPERS)
	(ADJECTIVE GIANT NAIL)
        (FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<OBJECT SHEARS
	(IN PROP-VAULT)
	(DESC "salivating hedge shears")
	(SYNONYM SHEARS)
	(ADJECTIVE SALAVATING HEDGE)
        (FLAGS TAKEBIT NARTICLEBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<OBJECT SWORD
 	(IN PROP-VAULT)
	(DESC "elvish sword of great antiquity")
	(SYNONYM SWORD)
	(ADJECTIVE ELVISH)
        (FLAGS TAKEBIT VOWELBIT)
	(SIZE 10)
        (ACTION PROP-F)>

<ROUTINE PROP-F ("AUX" HERMAN-THING PLAYER-THING)
	 <SET HERMAN-THING <FIRST? ,HERMAN>>
	 <SET PLAYER-THING <FIRST? ,PLAYER>>
	 <REPEAT ()
		  <COND (<ZERO? .PLAYER-THING>
			 <RETURN>)
		        (<EQUAL? .PLAYER-THING ,TOUPEE ,MASK ,RING>
			 <SET PLAYER-THING <NEXT? .PLAYER-THING>>)
		        (T
			 <RETURN>)>>
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? ,PRSO .HERMAN-THING>
		       <TELL
"You reach for" T .HERMAN-THING ", but " D ,HERMAN " twists away
from you." CR>)
		      (.PLAYER-THING
		       <TELL
"You're already armed with" AR .PLAYER-THING>)
		      (T
		       <PICK-REMOVE ,PRSO ,PROPS>
		       <RFALSE>)>)
	       (<AND <VERB? SHOOT THROW>
		     <EQUAL? ,PRSI ,HERMAN>>
		<PERFORM ,V?KILL ,HERMAN ,PRSO>
		<RTRUE>)
	       (<AND <VERB? KILL CUT>
		     <EQUAL? ,PRSO ,HERMAN>>
	    	<SETG HERMAN-HITS <+ ,HERMAN-HITS 1>>
		<COND (,HERMAN-DOWN
		       <DEQUEUE I-AUNT>
		       <TELL
"With the hate of all those summers of his bullying built up, you let
Herman have it with" T .PLAYER-THING ", killing him. At the same time
you hear a scream not unlike one you would hear in an Uncle Buddy movie.
As the tone of the saw blade changes you realize your Aunt Hildegarde
has just taken her final bow. You stand and cry for a few minutes
remembering the good times with your aunt and wishing you had done more
to save her.~
~
Later you find your way out of the prop vault. You go next door to Johnny's and
call the police. Unfortunately it never occurred to you that with two dead
bodies involved they wouldn't believe your story." CR>
		       <FINISH>)
                      (<EQUAL? ,HERMAN-HITS 3>
		       <SETG HERMAN-DOWN T>
		       <SETG AUNT-COUNT 6>
		       <QUEUE I-AUNT 2> ;"SEM?"
		       <DEQUEUE I-HERMAN-ATTACK>
		       <TELL "You "> 
		       <COND (<EQUAL? .PLAYER-THING ,GUN>
			      <TELL
"fire" T ,GUN " hitting him in the shoulder.">)
			     (T
			      <TELL
"give it your best, striking Herman.">)>
		       <TELL
" He drops to the ground. (Hmm, guess that wasn't a prop after all.)
Slowly, he starts to come to his feet. The saw blade is less than an inch
from the blue-gray hairs of Aunt Hildegarde's head!" CR>)
		      (T
		       <TELL "You ">
		       <COND (<EQUAL? .PLAYER-THING ,GUN>
			      <TELL
"fire" T ,GUN ", blasting Herman with smooth and creamy whipped cream. You toss
the gun away in disgust. It sails into the chute." CR>)
			     (T
			      <TELL
"give it your best, striking Herman. The " D .PLAYER-THING " breaks into
a hundred pieces. It was only a prop." CR>)>
     		       <REMOVE .PLAYER-THING>)>)>>

<GLOBAL AUNT-COUNT 0>

<ROUTINE I-AUNT ()
	 <QUEUE I-AUNT 1>
         <SETG AUNT-COUNT <+ ,AUNT-COUNT 1>>
	 <COND (<EQUAL? ,AUNT-COUNT 7>
		<TELL CR
"You hear what sounds like an old woman being run through a buzz saw.
Suddenly you realize -- that old woman was your Aunt Hildegarde. Cousin
Herman stares at the saw blade in horror then turns and dives into the
chute, disappearing. You stand there as the blade continues to cut,
wishing you had done more to save her.~
~
Later you find your way out of the prop vault. You go next door to Johnny's
and call the police. When they arrive they have a difficult time believing
your story. You're advised to call a good lawyer." CR>
		<FINISH>)
	       (T
	        <TELL CR
"Your Aunt Hildegarde, strapped to the conveyor belt, is "
<GET ,AUNT-DISTANCE ,AUNT-COUNT> " the saw blade. ">
	       <COND (,HERMAN-HITS
		      <COND (<EQUAL? ,AUNT-COUNT 1>
		             <TELL
"\"Herman, dear, please turn off the buzz saw and untie me,\" says Aunt
Hildegarde politely.">)
	                    (<EQUAL? ,AUNT-COUNT 2>
		       	     <TELL
"\"Herman, that's no way to treat your cousin,\" admonishes Aunt Hildegarde.">)
		            (<EQUAL? ,AUNT-COUNT 3>
		             <TELL
"\"I'm just glad your Uncle Buddy isn't alive to see this,\" says Aunt
Hildegarde with resignation.">)
		            (<EQUAL? ,AUNT-COUNT 4>
		             <TELL
"\"Herman, enough is enough. You are in big trouble, buster. Pumpkin, untie me
then run and get your Uncle Buddy's belt,\" orders Aunt Hildegarde.">)
		            (<EQUAL? ,AUNT-COUNT 5>
		             <TELL
"\"Now you two stop that horseplay and get me off this contraption,\"
demands Aunt Hildegarde.">)
		            (<EQUAL? ,AUNT-COUNT 6>
		             <TELL
"\"Pumpkin! Help!\" screams Aunt Hildegarde over the roar of the buzz saw.">)>)
		     (T
		      <TELL
"\"Herman, stop this silly game this instant and untie me,\" demands
Aunt Hildegarde.">)>
	       <CRLF>)>>

<GLOBAL AUNT-DISTANCE
	<TABLE
	""
	"about a foot from"
	"slowly moving closer to"
	"now only about half a foot from"
	"slowly approaching"
	"about three or four inches away from"
	"less than an inch away from">>

<OBJECT SAW
	(IN PROP-VAULT)
	(DESC "buzz saw")
	(SYNONYM SAW BLADE BELT)
	(ADJECTIVE SAW BUZZ LARGE STEEL CONVEYOR)
	(FLAGS NDESCBIT)
	(ACTION SAW-F)>

<ROUTINE SAW-F ("AUX" HERMAN-THING)
	 <SET HERMAN-THING <FIRST? ,HERMAN>>
	 <COND (<VERB? LAMP-OFF>
		<COND (,HERMAN-DOWN
		       <SETG SCORE <+ ,SCORE 20>>
		       <TELL "The conveyor belt stops and the buzz saw's
blade begins to slow. As you untie your Aunt Hildegarde, Herman races
toward the chute and jumps inside, disappearing. You hear his squeaky
laugh trail off in the distance. Aunt Hildegarde gets up from the buzz
saw rubbing the back of her head. Though a bit shaken, she explains she
had been watching you while you searched for the \"treasures.\"~
~
\"As I followed your progress I began to realize you and I were not the
only ones on the estate. My suspicions were confirmed when I received a
rap on the skull. The next thing I knew I was being tied to this buzz
saw by your Cousin Herman,\" says Aunt Hildegarde. \"I guess he couldn't
stand to see you inherit the family fortune. Well, it's all yours now. I
knew you could do it,\" says Aunt Hildegarde with satisfaction.~
~
\"I'm sorry I put you through all this, Pumpkin, but your Uncle Buddy and
I had to be sure that whoever inherited the estate and the studio would
be clever enough to handle it all. The only way I could be sure the
stipulations in my will would be carried out would be to oversee it
myself, so I faked my death,\" says Aunt Hildegarde, hugging you so
tight she squeezes the air out of your lungs. \"Tomorrow we'll go see my
lawyer and he'll take care of all the paper work. I know you'll take
good care of Hildebud and the studio. As for me, I'm sure it won't be
long before the press discovers I'm alive. I plan to go to the south of
France for a rest while the story leaks out. It will be great publicity
for the studio,\" says Aunt Hildegarde. Then she adds, \"And let's hope
we've seen the last of your Cousin Herman.\"" CR>
                       <FINISH>)
		      (.HERMAN-THING
		       <REMOVE .HERMAN-THING>
		       <TELL
"Cousin Herman hits you with" T .HERMAN-THING ", driving you away from the
buzz saw. The " D .HERMAN-THING " crumbles; it was only a prop." CR>)
		      (T
		       <TELL
"Cousin Herman slugs you in the stomach, pushing you away from the
buzz saw." CR>)>)
	       (<VERB? LAMP-ON>
		<TELL "It's already turned on!">)
	       (<VERB? EXAMINE>
		<TELL
"It's a large, steel blade that seems to spin faster as Aunt Hildegarde
moves closer to it." CR>)>>

<GLOBAL HERMAN-DOWN <>>

<GLOBAL HERMAN-HITS 0>

<ROUTINE I-HERMAN-ATTACK ("AUX" NEXT-PROP FOO HERMAN-THING)
         <SET HERMAN-THING <FIRST? ,HERMAN>>
	 <QUEUE I-HERMAN-ATTACK -1>
	 <COND (.HERMAN-THING
		<REMOVE .HERMAN-THING>
		<TELL CR "Cousin Herman ">
		<COND (<EQUAL? .HERMAN-THING ,GUN>
		       <TELL "fires">)
		      (<EQUAL? .HERMAN-THING ,BAG>
		       <TELL "throws">)
		      (T
		       <TELL "swings">)>
		<TELL " the " D .HERMAN-THING ", ">
	        <COND (<EQUAL? .HERMAN-THING ,GUN>
		       <TELL
"covering you with whipped cream. Herman tosses the gun in the chute." CR>)
		      (T
		       <TELL
"striking you. The " D .HERMAN-THING " crumbles; it was only a prop." CR>)>)
	       (T
		<MOVE <PICK-ONE ,PROPS> ,HERMAN>
		<SET HERMAN-THING <FIRST? ,HERMAN>>
	 	<TELL CR "Cousin Herman grabs the " D .HERMAN-THING "." CR>)>> 

;"rubber, paper mache, plaster? etc"

<GLOBAL PROPS
	<LTABLE 0
		CLUB
		STICK
		GUN
		MOP
		BAG
		CLIPPERS
		SHEARS
		SWORD>>