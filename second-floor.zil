"SECOND-FLOOR for ANTHILL (C)1986 Infocom Inc. All Rights Reserved."

"--- Upstairs Hall ---"

<ROOM UPSTAIRS-HALL-MIDDLE
      (IN ROOMS)
      (DESC "Upstairs Hall, Middle")
      (EAST TO UPSTAIRS-HALL-EAST)
      (WEST TO UPSTAIRS-HALL-WEST)
      (DOWN PER TO-FOYER-F)
      (SOUTH PER UPSTAIRS-CLOSET-ENTER-F)
      (IN PER UPSTAIRS-CLOSET-ENTER-F)
      (UP PER TO-&-FROM-ATTIC)
      (GLOBAL FOYER-STAIRS ATTIC-DOOR UPSTAIRS-CD CLOSET-REF)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (FLAGS RLANDBIT)
      (ACTION UPSTAIRS-HALL-MIDDLE-F)>

<ROUTINE UPSTAIRS-HALL-MIDDLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the middle of the upstairs hall. The hall stretches to the east and
the west. To the south there is a">
		<COND (<FSET? ,UPSTAIRS-CD ,OPENBIT>
		       <TELL "n open">)
		      (T
		       <TELL " closed">)>
		<TELL " closet door. ">
		<COND (<FSET? ,ATTIC-DOOR ,OPENBIT>
		       <TELL
"There is pull-down ladder extending from the floor into an open panel in
the ceiling here.">)
		      (T
		       <TELL
"In the ceiling above you see the outline of a panel.">)>
		<TELL
" You notice an unusual newel next to the stairs leading down.">)>>

<ROOM UPSTAIRS-HALL-EAST
      (IN ROOMS)
      (DESC "Upstairs Hall, East")
      (WEST PER UPSTAIRS-HALL-EAST-EXIT-F)
      (NORTH PER UPSTAIRS-HALL-EAST-EXIT-F)
      (SOUTH PER UPSTAIRS-HALL-EAST-EXIT-F)
      (FLAGS RLANDBIT)
      (ACTION UPSTAIRS-HALL-EAST-F)>

<ROUTINE UPSTAIRS-HALL-EAST-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
	        <TELL
"This is the eastern end of the upstairs hall, which stretches west. Doorways
lead north and south. There is a">
		<COND (<FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>
		       <TELL "n open">)
		      (T
		       <TELL " closed">)>
		<TELL " window here">
		<COND (,SACK-IN-WINDOW
		       <TELL
". A blue velvet sack is barely visible, sticking out from beneath the
closed window">)>
		<TELL ".">)>>

<ROUTINE UPSTAIRS-HALL-EAST-EXIT-F ()
	 <COND (<AND <FSET? ,SACK ,HAND-ON-SACK-BIT>
		     ,SACK-IN-WINDOW>
		<TELL "You'll have to let go of the sack first." CR>
		<RFALSE>)
	       (T
		<COND (<EQUAL? ,PRSO ,P?NORTH>
		       ,BEDROOM-2)
		      (<EQUAL? ,PRSO ,P?SOUTH>
		       ,BEDROOM-3)
		      (T
		       ,UPSTAIRS-HALL-MIDDLE)>)>>

<OBJECT FINCH
        (IN SACK)
        (SDESC "Maltese finch")
	(SYNONYM PIECES FINCH BIRD)
	(ADJECTIVE MALTESE)
	(FLAGS TAKEBIT)
	(SIZE 15) ;(SIZE 20)
	(VALUE 10)
	(ACTION FINCH-F)>

<ROUTINE FINCH-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's the Maltese finch">
		<COND (<FSET? ,FINCH ,BROKEN-BIT>
                       <TELL ", well, pieces of the Maltese finch">)>
		<TELL
" from Uncle Buddy's knockoff of \"The Maltese Falcon.\" In Uncle Buddy's
updated version, a Humphrey Bogart look-alike plays the part of a pet
shop owner." CR>)
	       (<AND <VERB? THROW MUNG>
		     <NOT <FSET? ,FINCH ,BROKEN-BIT>>
		     <ULTIMATELY-IN? ,FINCH>
		     <PRSO? ,FINCH>
		     <NOT <SPECIAL-DROP>>>
		<MOVE ,FINCH ,HERE>
		<BREAK-FINCH>)>>

<ROUTINE BREAK-FINCH ("OPTIONAL" (DONT-TELL <>))
	 <COND (<FSET? ,FINCH ,BROKEN-BIT>
		<RFALSE>)>
	 <PUTP ,FINCH ,P?VALUE 0>
         <FSET ,FINCH ,BROKEN-BIT>
	 <COND (<NOT .DONT-TELL>
	 	<TELL
"As your hand releases" T ,PRSO ", the sound of it smashing onto" T, GROUND "
is masked only slightly by the almost inaudible sound of someone rolling over
in his grave. Uncle Buddy perhaps?" CR>)>
	 <FSET ,FINCH ,NARTICLEBIT>
	 <PUTP ,FINCH ,P?SDESC "pieces of the Maltese finch">
	 <RTRUE>>

<OBJECT SACK
        (IN UPSTAIRS-HALL-EAST)
        (DESC "cloth sack")
	(SYNONYM SACK BAG)
	(ADJECTIVE CLOTH BLUE VELVET)
        (FLAGS TAKEBIT TRYTAKEBIT CONTBIT NDESCBIT SEARCHBIT)
	(CAPACITY 15)
        (SIZE 10)
	(ACTION SACK-F)>

<ROUTINE SACK-F ()
          <COND (<AND <VERB? EXAMINE>
		      <NOT <FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>>
		      ,SACK-IN-WINDOW>
                 <TELL
"The " D ,SACK " is just visible, stuck beneath the closed "
D ,SACK-WINDOW "." CR>)
		(<AND <VERB? TAKE>
		      ,SACK-IN-WINDOW
		     ;<NOT <FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>>
		     ;<EQUAL? ,HERE ,UPSTAIRS-HALL-EAST>>
		      <COND (<NOT <FSET? ,SACK ,HAND-ON-SACK-BIT>>
		             <FSET ,SACK ,HAND-ON-SACK-BIT>
			     <TELL
"You grab hold of the top of the sack, but the rest of it is still
under the closed window." CR>)
			    (T
			     <TELL "You already have your hand on it." CR>)>)
		(<AND <VERB? DROP>
		      <FSET? ,SACK ,HAND-ON-SACK-BIT>>
		 <PERFORM ,V?LET-GO ,SACK>
		 <RTRUE>)
                (<AND <VERB? LET-GO>
		      <FSET? ,SACK ,HAND-ON-SACK-BIT>>
		 <FCLEAR ,SACK ,HAND-ON-SACK-BIT>
		 <TELL "You let go of the sack." CR>)
		(<VERB? OPEN>
		 <COND (,SACK-IN-WINDOW
		        <TELL
"You can't open" T ,SACK " when it's stuck in" TR ,SACK-WINDOW>)
		       (<NOT <EQUAL? <GETP ,FINCH ,P?VALUE> 0>>
			<FSET ,SACK ,OPENBIT>
			<COND (<AND <BOKS-BIG-ONE ,FINCH>
				    <EQUAL? ,TREASURES-FOUND 10>>
			       <RTRUE>)>
			<TELL "Opening the sack reveals" A ,FINCH "." CR>)>)
		(<AND <VERB? THROW>
		      <IN? ,FINCH ,SACK>
		      <NOT <FSET? ,FINCH ,BROKEN-BIT>>>
		 <BREAK-FINCH>
		 <COND (<EQUAL? ,HERE ,ROOF-1 ,ROOF-2>
			<MOVE ,SACK ,PATIO>)
		       (T
			<MOVE ,SACK ,HERE>)>)
		(<AND <VERB? PULL>
		      <NOT <FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>>>
		 <COND (<FSET? ,SACK ,HAND-ON-SACK-BIT>
			<TELL "It's stuck under the window." CR>)
		       (T
			<TELL
"You pull on" T ,SACK ", but it's stuck under the window sill." CR>)>)
		(<AND <VERB? PUT>
		      <FSET? ,PRSO ,FLAMEBIT>>
		 <TELL "Shouldn't you put out" T ,PRSO " first?" CR>)>>

<OBJECT SACK-WINDOW
	(IN UPSTAIRS-HALL-EAST)
        (DESC "window")
        (SYNONYM WINDOW)
	(FLAGS NDESCBIT) ;(SEARCHBIT CONTBIT SEARCHBIT)
       ;(CAPACITY 21) 
	(ACTION SACK-WINDOW-F)>

<GLOBAL SACK-IN-WINDOW T>

<ROUTINE SACK-WINDOW-F ()
	 <COND (<VERB? EXAMINE>
	        <COND (,SACK-IN-WINDOW
		       <TELL
"The window is closed on the top of a cloth sack." CR>)
                      (T
		       <TELL "The " D ,SACK-WINDOW " is ">
		       <COND (<FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>
			      <TELL "open">)
			     (T
			      <TELL "closed">)>
		       <TELL "." CR>)>)
               (<VERB? OPEN>
		<COND (<FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>
		       <ALREADY-OPEN>)
		      (,SACK-IN-WINDOW
		       <COND (<FSET? ,SACK ,HAND-ON-SACK-BIT>
			      <FCLEAR ,SACK ,HAND-ON-SACK-BIT>
		              <MOVE ,SACK ,PLAYER>
			      <SETG SACK-IN-WINDOW <>>
			      <FSET ,SACK-WINDOW ,WINDOW-OPEN-BIT>
			      <TELL
"With one hand you lift" T ,SACK-WINDOW " and with the other you pull"
T ,SACK " inside." CR>)
			     (T
			      <MOVE ,SACK ,SOUTHEAST-JUNCTION>
			      <BREAK-FINCH T>
			      <TELL
"As you lift up" T ,SACK-WINDOW "," T ,SACK " slides off" T ,SACK-WINDOW " sill
and falls to" T ,GROUND " with a decided thud." CR>)>
		       <FSET ,SACK-WINDOW ,WINDOW-OPEN-BIT>
		       <FCLEAR ,SACK ,NDESCBIT>
		       <FCLEAR ,SACK ,TRYTAKEBIT>
		       <SETG SACK-IN-WINDOW <>>)
		      (T
		       <TELL "You open" TR ,SACK-WINDOW>
		       <FSET ,SACK-WINDOW ,WINDOW-OPEN-BIT>)>
		<RTRUE>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>>
		       <ALREADY-CLOSED>)
		      (T
		       <TELL "You close" TR ,SACK-WINDOW>
		       <FCLEAR ,SACK-WINDOW ,WINDOW-OPEN-BIT>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,SACK-WINDOW>> ;"SEM PUT THE RIGHT VERB HERE?"
		<COND (<FSET? ,SACK-WINDOW ,WINDOW-OPEN-BIT>
		       <TELL
"You toss" T ,PRSO " out" TR ,SACK-WINDOW>
		       <COND (<AND <PRSO? ,RED-CANDLE ,WHITE-CANDLE
					  ,BLUE-CANDLE>
			       <FSET? ,PRSO ,FLAMEBIT>>
			      <BLOW-OUT-CANDLE ,PRSO>)>
		       <COND (<OR <AND <PRSO? ,FINCH>
			               <NOT <FSET? ,FINCH ,BROKEN-BIT>>>
		                  <AND <ULTIMATELY-IN? ,FINCH ,SACK>          
				       <NOT <FSET? ,FINCH ,BROKEN-BIT>>>>
		       <BREAK-FINCH T>)>
		       <MOVE ,PRSO ,SOUTHEAST-JUNCTION>)
		      (T
		       <TELL "But it's not open!" CR>)>) 
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-INSIDE ,WINDOW>
		<RTRUE>)>>

<ROOM UPSTAIRS-HALL-WEST
      (IN ROOMS)
      (DESC "Upstairs Hall, West")
      (EAST TO UPSTAIRS-HALL-MIDDLE)
      (NORTH TO BEDROOM-1)
      (SOUTH TO UPSTAIRS-BATHROOM)
      (CAPACITY 10) ;"NO WINDOW"
      (FLAGS RLANDBIT EVERYBIT) ;"someone watching you"
      (ACTION UPSTAIRS-HALL-F)>

<ROUTINE UPSTAIRS-HALL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the western end of the upstairs hall, which stretches east.
There are doorways leading to the north and south.">
		<COND (<FSET? ,UPSTAIRS-HALL-WEST ,EVERYBIT>
		       <COND (<PROB 50>
			      <FCLEAR ,UPSTAIRS-HALL-WEST ,EVERYBIT>
			      <TELL
" Hmmm. You have the uneasy feeling that someone is watching you.">)>)>
		<RTRUE>)>> 

<ROOM BEDROOM-1
      (IN ROOMS)
      (DESC "Master Bedroom")
      (LDESC
"This is Aunt Hildegarde and Uncle Buddy's bedroom. There is a thick,
round bed here, typical of Uncle Buddy trying to be a Hollywood type.
Next to the bed is a chair and a phone. A doorway leads south.")
      (SOUTH TO UPSTAIRS-HALL-WEST)
      (GLOBAL WINDOW SEAT BED PHONE)
      (CAPACITY 20) ;"Tell--sun coming up"
      (FLAGS RLANDBIT)>

<ROOM BEDROOM-2
      (IN ROOMS)
      (DESC "Bedroom")
      (SOUTH TO UPSTAIRS-HALL-EAST)
      (GLOBAL WINDOW SEAT BED)
      (FLAGS RLANDBIT)
      (CAPACITY 20) ;"Tell--sun coming up"
      (ACTION BEDROOM-2-F)>

<ROUTINE BEDROOM-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This was the guest room you shared with Cousin Herman during your
summer visits. A quick glance at the bunk beds and you remember all too
well the night in the bottom bunk when Cousin Herman got sick in the top
bunk. ">
		<COND (<PROB 50>
		       <TELL
"You got even with him later. While he was asleep you squirted honey up his
nose. When he ran and told Aunt Hildegarde what you had done, she didn't
believe it was honey and told him he shouldn't be out of bed with
such a bad cold. ">)>
		<TELL "A doorway
leads south.">)>>

<ROOM BEDROOM-3
      (IN ROOMS)
      (DESC "Guest Room")
      (LDESC 
"This is a spare bedroom where guests would stay if they couldn't drive
home after one of the parties. The bed is big and fluffy and all the
furniture is padded well. Uncle Buddy put two brass handles on the floor so
guests would have something to hang onto when the room began to spin.
A doorway leads north.")
      (NORTH TO UPSTAIRS-HALL-EAST)
      (GLOBAL WINDOW SEAT BED)
      (CAPACITY 20) ;"Tell--sun coming up"
      (FLAGS RLANDBIT)>

<OBJECT HANDLES
	(IN BEDROOM-3)
	(DESC "brass handles")
        (SYNONYM HANDLE)
	(ADJECTIVE BRASS)	
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION HANDLES-F)>

<ROUTINE HANDLES-F ()
	 <COND (<VERB? TAKE>
		<TELL
"You grip the handles firmly and imagine one of Uncle Buddy's guests
clutching them in a drunken stupor. After a minute, you begin to feel a
bit of nausea and let go of the handles." CR>)>>

<ROOM UPSTAIRS-BATHROOM
      (IN ROOMS)
      (DESC "Upstairs Bathroom")
      (NORTH TO UPSTAIRS-HALL-WEST)
      (GLOBAL WINDOW WATER TOILET)
      (CAPACITY 20) ;"Tell--sun coming up"
      (FLAGS RLANDBIT)
      (ACTION UPSTAIRS-BATHROOM-F)
      (THINGS <PSEUDO (<> BATH BATH-PSEUDO)
		      (<> SHOWER BATH-PSEUDO)>)>

<ROUTINE UPSTAIRS-BATHROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"It's a Hollywood bathroom. Everything from the temperature-controlled
marble toilet seat to the Oscars for hot and cold water is overdone. The
shower has a gold curtain and you can't help but notice the bath mat
with Jack Valenti's picture on it">
		<COND (<FSET? ,BATH-MAT ,TOUCHBIT> ;"SEM"
		       <TELL " has been moved">)>
		<TELL ".">)>>

<ROUTINE BATH-PSEUDO ()
	 <COND (<VERB? TAKE LAMP-ON WALK ENTER BOARD USE>
		<TELL
"Sorry, the water has been turned off." CR>)>>

<OBJECT BATH-MAT
	(IN UPSTAIRS-BATHROOM)
	(DESC "Jack Valenti bath mat")
	(SYNONYM MAT)
	(ADJECTIVE BATH JACK VALENTI)
	(SIZE 10)
	(FLAGS TAKEBIT NDESCBIT TRYTAKE) ;"so no impliciet take occurs"
	(ACTION BATH-MAT-F)>

<ROUTINE BATH-MAT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a rubber bath mat with a picture of the President of the Academy
of Motion Picture Arts and Sciences, Jack Valenti, on it." CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,BATH-MAT>>
		<TELL "Jack wouldn't like that." CR>)
	       (<AND <VERB? LOOK-UNDER MOVE RAISE>
		     <FSET? ,RED-CARD ,INVISIBLE>>
		<FCLEAR ,RED-CARD ,INVISIBLE>
		<TELL
"You move" T ,BATH-MAT " and see" A ,RED-CARD " lying on the
floor of the bathroom." CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,RED-CARD ,INVISIBLE>>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)
		      (T
		       <FCLEAR ,RED-CARD ,INVISIBLE>
		       <TELL
"As you take" T ,BATH-MAT " you notice" A ,RED-CARD " lying on the floor
of the bathroom." CR>)>)>>

<OBJECT NEWSLETTER
	(IN MAILBOX)
	(DESC "copy of The Status Line")
	(SYNONYM NEWSLETTER LINE TIMES PAPER)
	(ADJECTIVE NEW ZORK STATUS COPY)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 1)
	(TEXT
"It's a copy of Infocom's newsletter \"The Status Line\" (formerly \"The
New Zork Times\"). It's addressed to Aunt Hildegarde and features a story
about a game called \"Hollywood Hijinx.\" In the article, author
\"Hollywood\" Dave Anderson thanks his fellow imps for their enormous help and
patience.")>

<OBJECT UPSTAIRS-CD
	(IN LOCAL-GLOBALS)
	(DESC "closet door")
        (SYNONYM DOOR)
	(ADJECTIVE CLOSET)
        (FLAGS DOORBIT NDESCBIT)
	(GENERIC WHICH-DOOR?)
	(ACTION UPSTAIRS-CD-F)>

<ROUTINE UPSTAIRS-CD-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,UPSTAIRS-CD ,OPENBIT>>
		     <NOT <EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>>
		     <EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>>
		<OPEN-DOOR-TO-SHAFT>
		<FSET ,UPSTAIRS-CD ,OPENBIT>)>>

<ROUTINE OPEN-DOOR-TO-SHAFT () 
	 <TELL "You open the door and see the ">
	 <COND (<OR <AND <EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
;"closet-top-3"		 <EQUAL? ,CLOSET-FLOOR ,FOYER>>
;"closet-top-2"	    <AND <EQUAL? ,HERE ,FOYER>
			 <EQUAL? ,CLOSET-FLOOR ,CELLAR>>>
		<TELL
"top of the closet at floor level and the shaft continuing upwards." CR>)
	       (<OR <AND <EQUAL? ,HERE ,CELLAR>
			 <EQUAL? ,CLOSET-FLOOR ,FOYER>>
		    <AND <EQUAL? ,HERE ,FOYER>
			 <EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>>
		    <AND <EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
			 <EQUAL? ,CLOSET-FLOOR ,ATTIC>>>
		<TELL "bottom of the closet at ceiling level">
		<COND (<EQUAL? ,HERE ,FOYER ,UPSTAIRS-HALL-MIDDLE>
		       <TELL " and a shaft below">)>
		<TELL "." CR>)
	       (<OR <AND <EQUAL? ,HERE ,CELLAR>
			 <EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>>
		    <AND <EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
			 <EQUAL? ,CLOSET-FLOOR ,CELLAR>>>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <TELL "bottom of the closet far above">)
		      (T
		       <TELL "top of the closet far below">)>
		<TELL "." CR>)
	       (<EQUAL? ,HERE ,ATTIC>
		<TELL "top of the closet ">
		<COND (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>
		       <TELL "at floor level">)
		      (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		       <TELL "far below">)
		      (T
		       <TELL "below">)>
		<TELL "." CR>)>>

<ROUTINE TO-FOYER-F ()
	 <COND (<NOT <FSET? ,NEWEL ,NEWEL-TURNED-BIT>>
		<TELL "As you step onto the first step, the staircase flattens
and you slide down the flattened stairs">
		<COND (<PROB 50>
		       <TELL
", experiencing for a split second the euphoria only an Olympic bobsledder
can know">)>
		<TELL
". After you slide into the foyer, the stairs return to normal." CR CR>
	        <RETURN ,FOYER>)
	       (T
		<COND (<FSET? ,SKIS ,WORNBIT>
		       <TELL ,SNOWPLOW CR CR>)
		      (T
		       <TELL "You walk down the stairs to the..." CR CR>)>
                <RETURN ,FOYER>)>>

<GLOBAL SNOWPLOW "You ski down the stairs then snowplow to a stop in the...">

<ROUTINE UPSTAIRS-CLOSET-ENTER-F ()
	 <COND (<NOT <FSET? ,UPSTAIRS-CD ,OPENBIT>>
		<ITS-CLOSED ,UPSTAIRS-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE>
		<RETURN ,CLOSET>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,CLOSET-TOP>)
               (T
                ;"CLOSET-FLOOR IS CELLAR"
		<TELL
"You enter the shaft and plunge down a floor. A bit shaken, you
find yourself at..." CR CR>
		<RETURN ,CLOSET-TOP>)>>

;<JIGS-UP
"You step into a shaft and plunge down. You slow ever so slightly as your body
crashes through the top of the closet and abruptly comes to stop on the floor
of the closet.">

;"------------------ Suspect Telephone ----------------------"

;"make suspect and witness numbers work"
<OBJECT PHONE
	(IN LOCAL-GLOBALS)
	(DESC "telephone")
	(SYNONYM PHONE TELEPHONE RECEIVER)
	(FLAGS NDESCBIT)
	(ACTION PHONE-F)>

<ROUTINE PHONE-F ()
	 <COND (<VERB? REPLY>
		<TELL "It wasn't ringing." CR>)
	       (<VERB? TAKE>
		<COND (<FSET? ,PHONE ,PHONE-DEAD-BIT>
		       <TELL
"You don't hear a dial tone. The line is dead." CR>)
		       (T
			<TELL "You hear a dial tone." CR>)>)
	       (<AND <VERB? PHONE>
		     <EQUAL? ,PRSO ,PHONE>>
		<TELL "You should dial a number, such as 911." CR>)
	       (<VERB? HANG-UP>
		;<DISABLE <INT I-HANG-UP>>
		<TELL "You replace the receiver." CR>)>>


;"\"Costumes Unlimited|
312 Wisconsin Ave.|
Rockville, MD|
555-9009|
|
(1) Cowboy costume with lariat and gunbelt: $65\"

"

;<OBJECT COSTUME-SHOP
	(IN GLOBAL-OBJECTS)
	(DESC "Costumes Unlimited")
	(SYNONYM SHOP)
	(ADJECTIVE COSTUME UNLIMITED)
	(FLAGS NDESCBIT)
	(ACTION SHOP-F)>

;<ROUTINE SHOP-F ()
	 <COND (<VERB? PHONE>
		<COND (<G? ,PRESENT-TIME 600>
		       <TELL
"The telephone rings continuously for as long as you wait." CR>)
		      (ELSE
		       <MOVE ,JACK ,HERE>
		       <ENABLE <QUEUE I-HANG-UP 5>>
		       <TELL
"A tired-sounding voice answers. \"Costumes Unlimited, Jack
speaking. We're closing at ten. We don't have many costumes left.
Better make it quick.\"" CR>)>)>>

;<ROUTINE I-HANG-UP ()
	 <COND (<IN? ,JACK ,HERE>
		<REMOVE ,JACK>
		<TELL
"You hear a click as the telephone is hung up at the other end." CR>)>>

;<OBJECT JACK
	(DESC "Jack")
	(SYNONYM JACK)
	(ACTION JACK-F)
	(FLAGS NDESCBIT TRANSBIT)>

;<ROUTINE JACK-F ()
	 <COND (<NOT <IN? ,JACK ,HERE>>
		<TELL "He hung up." CR>)
	       (<OR <EQUAL? ,JACK ,WINNER>
		    <VERB? $CALL>>
		<COND (<VERB? SGIVE TELL-ME> <RFALSE>)
		      (ELSE
		       <TELL "\"Get to the point, I'm busy.\"" CR>)>)
	       (<VERB? TAKE EXAMINE>
		<TELL "Jack's on the telephone, not">
		<TELL-HERE>)
	       (<AND <VERB? ASK-ABOUT> <EQUAL? ,PRSO ,JACK>>
		<COND (<==? ,PRSI ,GLOBAL-VERONICA ,VERONICA ,CORPSE>
		       <COND (<NOT ,JACK-ASKED?>
			      <SETG JACK-ASKED? T>
			      <TELL
"\"" 'VERONICA " Ashcroft, eh? Upper crust type, right? Yeah, she rented " A
,FAIRY-COSTUME ". Real expensive. Great costume, though.\"" CR>)
			     (ELSE <TELL ,REPEATING-YOURSELF CR>)>)
		      (<==? ,PRSI ,FAIRY-COSTUME>
		       <COND (<NOT ,JACK-ASKED?>
			      <SETG JACK-ASKED? T>
			      <TELL
"\"Yeah, we rented one of them. Some society dame rented it. Just a minute,
I can tell you who...\"  There is a short pause. \"Yeah, here she is.
" 'VERONICA " Ashcroft, one Titania costume, a hundred and twenty dollars.
We don't get much call for that one. Heck of a costume, though.\"" CR>)
			     (ELSE <TELL ,REPEATING-YOURSELF CR>)>)
		      (T
		       <TELL "\"Get to the point, I'm busy.\"" CR>)>)>>

;<GLOBAL REPEATING-YOURSELF "\"You're repeating yourself.\"">


;<ROUTINE TELL-NO-GRAB ()
	 <TELL ,IGNORES-YOU " or doesn't hear you." CR>>

;<GLOBAL LISTENING " is listening.">
;<GLOBAL YOU-DONT "You don't ">
<ROUTINE THERE-DOESNT-SEEM ()
         <TELL "There doesn't seem to be">>

;<ROUTINE PRE-PHONE ()
	 <COND (,PLAYER-HIDING
		<PLAYER-EMERGES>
		<RFALSE>)>>

<ROUTINE V-PHONE () ;("AUX" PER)
	 <COND (<NOT <GLOBAL-IN? ,PHONE ,HERE>>
		<THERE-DOESNT-SEEM>
		<TELL A ,PHONE " here." CR>)
	       (<AND ,PRSI 
                     <NOT <EQUAL? ,PRSI ,PHONE>>>
		<TELL "Too bad" T ,PRSI " isn't a telephone." CR>)
	       (<FSET? ,PHONE ,PHONE-DEAD-BIT>
	        <TELL "You don't hear a dial tone. The line is dead." CR>)
	       (<EQUAL? ,PRSO ,INTNUM>
	       ;<DISABLE <INT I-HANG-UP>>
		<COND (<OR <G? ,P-EXCHANGE 999>
			   <G? ,P-NUMBER 9999>>
		       <TELL
"You dialed too many numbers. Remember what Aunt Hildegarde thought about
guests making long distance calls!" CR>)
		      (<OR <AND <EQUAL? ,P-EXCHANGE 0>
			        <EQUAL? ,P-NUMBER 0>>
		           <AND <EQUAL? ,P-EXCHANGE 555>
			        <EQUAL? ,P-NUMBER 1212>>
			   <AND <EQUAL? ,P-EXCHANGE 0>
			        <EQUAL? ,P-NUMBER 411>>>
		       <TELL
"You hear a lazy voice come on the line. \"You have reached the Malibu
phone company. Our operator is busy now. Mellow out and try your call
again later.\"" CR>)
	              (<AND <EQUAL? ,P-EXCHANGE 0>
			    <EQUAL? ,P-NUMBER 911>>
		       <TELL
"A police officer answers the phone in mid-snore saying he'll send a car right
over, then hangs up and goes back to sleep." CR> 
		       <RTRUE>)
		      (<AND <EQUAL? ,P-EXCHANGE 492>
			    <EQUAL? ,P-NUMBER 6000>>
		       <TELL

"You hear voice talking at a fast pace trying to announce all the
information necessary in 30 seconds. The voice says, \"Thank you for
calling Infocom. We are closed now. Please call back during regular
business hours, Monday through Friday, 9 a.m. to 6 p.m., Eastern
Standard Time.\" Then the voice speeds up even more, giving information
for technical problems and the special numbers to call. Finally you hear
the voice take a deep breath and say, \"Have a nice (BEEP),\" and the
message ends." CR>)
		      (<AND <EQUAL? ,P-EXCHANGE 576>
			    <EQUAL? ,P-NUMBER 1851>>
		            <TELL
"A nerdish voice answers" T ,PHONE " saying, \"Hello, this is Roy G.
Biv, Computer Service and Repair. Our office is closed now. Please call
back during our regular business hours.\"" CR>)
		      (<AND <EQUAL? ,P-EXCHANGE 576>
			    <EQUAL? ,P-NUMBER 3190>>
		       <COND (<FSET? ,TOUPEE ,CARDS-RIGHT-BIT>
			      <FSET ,PHONE ,PHONE-DEAD-BIT>
		       	      <MOVE ,TOUPEE ,HOPPER>
		       	      <TELL
"An answering machine comes on the line. It sounds like Aunt Hildegarde's
voice saying, \"I can't come to the phone right now. I'm dead. Don't forget
to look in the hopper.\" Then the line goes dead." CR>)
			     (T
		       	      <TELL "You get a busy signal." CR>)>)
                      (<PROB 60>
		       <TELL
"The " D ,PHONE " rings and rings, but no one answers." CR>)
		      (T
		       <TELL
"The " D ,PHONE " is answered, \"Hello? Hello? Hey, what is this, a
crank call? You made my wife cry the last time you called, you
pervert.\" You hear the receiver slammed down." CR>)>)
	      ;(<IN? ,PRSO ,ROOMS>
		<TELL ,YOU-CANT "call another room">)
	      ;(<NOT <FSET? ,PRSO ,PERSON>>
		<TELL "Too bad" T ,PRSO " has no " D ,PHONE "." CR>)
	       (T
		<TELL "There's no sense in phoning" AR ,PRSO>)>>

;<ROUTINE TELL-ALREADY-ARE ()
	 <TELL "You already are." CR>>

;<ROUTINE VARIOUS-TABLES-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,SIDE-TABLE ,END-TABLE>>
		<TELL ,RIDICULOUS CR>)
	       (<VERB? EXAMINE>
		<TELL
"On " T ,PRSO " sits " A ,PHONE>
	       ;<PRINT-CONTENTS ,PRSO ", accompanied by ">
		<TELL "." CR>)>>

;<OBJECT END-TABLE
	(IN LIVING-ROOM)
	(DESC "end table")
	(SYNONYM TABLE)
	(ADJECTIVE END)
	(CAPACITY 20)
	(FLAGS NDESCBIT ;FURNITBIT VEHBIT TRYTAKEBIT TAKEBIT
	       SURFACEBIT OPENBIT CONTBIT)
	(ACTION END-TABLE-F)>

;<ROUTINE END-TABLE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There is" A ,PHONE " on" T ,END-TABLE>
		<COND (<FIRST? ,END-TABLE>
		       <RFALSE>)
		      (T
		       <TELL "." CR>
		       <RTRUE>)>)>>


;"----------------- FURNITURE ---------------------"

;<OBJECT SINK
	(IN LOCAL-GLOBALS)
	(DESC "sink")
	(SYNONYM SINK BASIN TAP)
	(ACTION SINK-F)
	(FLAGS NDESCBIT)>

;<ROUTINE SINK-F ()
	 <COND (<AND <VERB? BRUSH>
		     <EQUAL? ,PRSO ,HANDS>>
		<TELL "Your hands are now clean." CR>)>>

;<OBJECT SHOWER
	(IN LOCAL-GLOBALS)
	(DESC "shower")
	(SYNONYM BATH STALL)
	(ADJECTIVE SHOWER)
	(ACTION SHOWER-F)
	(FLAGS NDESCBIT)>

;<ROUTINE SHOWER-F ()
	 <COND (<VERB? TAKE LAMP-ON>
		<TELL "You'd get your costume all wet." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,THERE-IS "no blood in the shower." CR>)>>

<OBJECT TOILET
	(IN LOCAL-GLOBALS)
	(DESC "toilet")
	(SYNONYM TOILET JOHN SEAT POT)
	(ACTION TOILET-F)
	(CAPACITY 30)
	(FLAGS NDESCBIT ;FURNITBIT OPENBIT SEARCHBIT)>

<ROUTINE TOILET-F ()
	 <COND (<EQUAL? ,PRSO ,TOILET>
		<COND (<VERB? WALK USE SIT>
		       <TELL 
"You'll have to hold it in. The water's been shut off, remember?" CR>)
		      (<VERB? LOOK-INSIDE SMELL>
		       <TELL
"The toilet is immaculate. Nosey, aren't you?" CR>)
		      (<VERB? FLUSH>
		       <TELL
"You pull the handle, but nothing happens. The water has been shut off."
CR>)>)>>

<OBJECT SEAT
	(IN LOCAL-GLOBALS)
	(DESC "seat")
	(SYNONYM SEAT SEATS CHAIR CHAIRS)
	(ADJECTIVE ARM PLUSH)
	(FLAGS TRYTAKEBIT TAKEBIT)
	(ACTION SEAT-F)>

<ROUTINE SEAT-F ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,SEAT>>
		<TELL ,RIDICULOUS CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,SEAT ,SOFA>>
	        <FCLEAR ,PRSO ,WEARBIT>
		<MOVE ,PRSO ,HERE>
		<TELL
"It seems a shame to mar" T ,PRSI " with" A ,PRSO ", so you put it on
the floor instead." CR>)
	       (<VERB? CLIMB-ON BOARD SIT ENTER>
		<TELL
"You sit down and relax for a moment. Soon your mind begins to ponder
your Aunt's wealth and you jump to your feet, ready to continue." CR>)>>

<GLOBAL RIDICULOUS
"Believe it or not, Aunt Hildegarde paid a lot of money for a
professional to decorate this house. Let's leave the furniture
arrangement to professionals.">

<OBJECT BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BED BUNK BUNKS)
	(ADJECTIVE ROUND TOP BOTTOM BUNK BIG FLUFFY)
        (FLAGS ;FURNITBIT ;VEHBIT CONTBIT SEARCHBIT OPENBIT SURFACEBIT
               TRYTAKEBIT)
	(SIZE 100)
	(ACTION BED-F)>

<ROUTINE BED-F () ;("OPTIONAL" (RARG <>))
	 <COND ;(.RARG
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,BED>>
		<TELL ,RIDICULOUS CR>)
	       (<VERB? LIE-DOWN CLIMB-ON BOARD SIT ENTER>
		<TELL
"You get into bed and relax for a moment. Soon your mind begins to ponder
your Aunt's wealth and you jump to your feet, ready to continue." CR>) 
	       (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSI ,BED>>
		<MOVE ,PRSO ,HERE>
		<TELL
"Rather than marring the bed's fine linen with" A ,PRSO ", you put it on the floor." CR>)
	       (<VERB? PUSH PUSH-TO>
		<TELL ,RIDICULOUS CR>)>>

<OBJECT SOFA
	(IN LOCAL-GLOBALS)
	(DESC "sofa")
	(SYNONYM COUCH SOFA)
	(ADJECTIVE LARGE)
	(FLAGS ;FURNITBIT TRYTAKEBIT TAKEBIT)
	(ACTION SEAT-F)>

<ROUTINE I-SANDS-OF-TIME ("OPTIONAL" (X 0) "AUX" MINUTES (CNT 0) (TCNT 0) TNUM
			  (FOLLOW-THE-LAWYER <>))
	 <SET MINUTES <+ ,MOVES 1260>>	 
	 <COND (<EQUAL? .MINUTES 1859>
		<SET X 60>
		<MICKEY-MOUSE 2 "hours">)
	       (<EQUAL? .MINUTES 1919> ;"660"
		<SET X 30>
		<MICKEY-MOUSE 1 "hour">)
	       (<EQUAL? .MINUTES 1949> ;"690"
		<SET X 30>
		<MICKEY-MOUSE 30 "minutes">)	       
	       (<EQUAL? .MINUTES 1979> ;"720"
		<COND (<EQUAL? ,HERE ,FOYER ,FRONT-PORCH ,SOUTH-JUNCTION>
		       <FSET ,LIVING-ROOM ,ONBIT>
		       <SET FOLLOW-THE-LAWYER T>
		       <TELL CR
,OUT-OF-NOWHERE "\"Ah, there you are. Let's go into the living room and
talk,\" says the lawyer. You follow him to the living room." CR CR>
		       <GOTO ,LIVING-ROOM>
		       <CRLF>)>
		<COND (<IN? ,PLAYER ,LIVING-ROOM>
		       <COND (<NOT .FOLLOW-THE-LAWYER>
		              <TELL CR ,OUT-OF-NOWHERE>)>
		       <TELL
"\"Well, let's wrap this up quickly, I've got to be in court for the
LaFlank divorce this afternoon,\" the lawyer snaps. He pauses for a
moment, glancing around the room">
		       <SET TNUM <GET ,TREASURE-TABLE 0>>
		       <REPEAT ()
			       <COND (<IGRTR? CNT .TNUM>
				      <RETURN>)>
			       <SET X <GET ,TREASURE-TABLE .CNT>>
			       <COND (<VISIBLE? .X>
				      <SET TCNT <+ .TCNT 1>>)>>
		       <COND (<EQUAL? .TCNT 0>
			      <TELL
". \"Uhh, I don't see any 'treasures.'">)
			     (<EQUAL? .TCNT 10>
			      <TELL
" then at a small note pad in his hand. He congratulates you for finding
all the \"treasures.\" \"But you didn't follow your aunt's instructions
in the note.">)
			     (T
			      <TELL
" then at a small note pad in his hand. \"Uhh, I only count "
<GET ,NUMWORDS .TCNT> " 'treasure">
			      <COND (<NOT <EQUAL? .TCNT 1>>
				     <TELL "s">)>
			      <TELL "' here.">)>
		       <TELL
" I'm sorry, but you won't be inheriting Mrs. Burbank's estate after
all,\" says the lawyer. He turns and leaves as his words echo in your
head. Then you feel a sharp pain in your backside, as you kick yourself
for not having ">
		       <COND (<EQUAL? .TCNT 10>
			      <TELL "followed the instructions in the note">)
			     (<EQUAL? ,TREASURES-FOUND 10>
			      <TELL
"brought all the \"treasures\" you found to the living room">)
			     (<EQUAL? ,TREASURES-FOUND 0>
			      <TELL "found any of the \"treasures\"">)
			     (T
			      <TELL "found all the \"treasures\" in time">)>
		       <TELL "." CR>)
		      (T      ;"not in living room or didn't get dragged there"
		       <TELL "Your time is up! ">
                       <COND (<EQUAL? ,TREASURES-FOUND 10>
			      <TELL
"You did a good job by finding all the \"treasures,\" but you didn't meet
the lawyer at 9 a.m.">)
			     (<G? ,TREASURES-FOUND 0>
			      <TELL

"You only found " <GET ,NUMWORDS ,TREASURES-FOUND> " of the
ten \"treasures.\"">)
			     (T
			      <TELL
"What a bozo! You didn't find any \"treasures.\" You're not fit to be
fertilizer for the family tree! Are you sure you're a Burbank? I'd go on
but there is only so much room on a disk.">)>
		       <TELL
" You can't help but think about how disappointed Aunt Hildegarde and
Uncle Buddy would have been with you right now. Never mind your own
disappointment of missing out on inheriting a fortune.">)>
		<SETG MOVES 720>	;"because CLOCKER hasn't done it yet"
		<USL>		      
		<FINISH>)>
	;<COND (<EQUAL? .X 0>          ;"debug-if I started it in the middle"
	        <SET X 2>)>	       ;"set X to a value so it won't be <>"
         <QUEUE I-SANDS-OF-TIME .X>>

<GLOBAL OUT-OF-NOWHERE "The lawyer seems to appear out of nowhere. ">

<GLOBAL NUMWORDS
	<LTABLE "one" "two" "three" "four" "five"
		 "six" "seven" "eight" "nine">>

<GLOBAL TREASURE-TABLE
	<LTABLE PARKING-METER
		CORPSE-LINE
		RUBBER-STAMP
		GRATER
		MASK
                TOUPEE
		RING
		FINCH
	        FIRE-HYDRANT
		PENGUIN>>

<ROUTINE MICKEY-MOUSE (NUM STRING)
	 <TELL
CR "[Hurry up, you only have " N .NUM " " .STRING " left!]" CR>>

;<ROOM CIRCLE
      (IN ROOMS)
      (SYNONYM DRIVEWAY CIRCLE)
      (ADJECTIVE CIRCULAR)
      (DESC "Circular Driveway")
      (LDESC
"This is the circular driveway in front of the house. Many cars are parked
here, and the drive is somewhat blocked. To the south is a stand of oaks,
to the north is the front porch of the house. Piled along the border of
the driveway are hundreds of pumpkins. Many of them are carved and lighted,
others unadorned.")
      (NORTH TO PORCH)
      (UP TO PORCH)
      (EAST TO OUTSIDE)
      (WEST TO WEST-OF-HOUSE)
      (STATION CIRCLE)
      (LINE 4 ;OUTSIDE-LINE-C)
      (THINGS <PSEUDO (<> OAKS OAKS-PSEUDO)
		      (RUSTLING LEAVES LEAVES-PSEUDO)>)>

;<ROUTINE OAKS-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The oaks are ancient, stately, and wet." CR>)>>

;<OBJECT CHANDELIER
	(IN DINING-ROOM)
	(SYNONYM CHANDELIER)
	(ADJECTIVE CRYSTAL)
	(DESC "chandelier")
	(ACTION CHANDELIER-F)
	(FLAGS NDESCBIT)>

;<ROUTINE CHANDELIER-F ()
	 <COND (<VERB? TAKE>
		<TELL "It's too high to reach." CR>)>> 
 