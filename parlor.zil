"PARLOR for ANTHILL (C)1986 Infocom Inc. All rights reserved."

<OBJECT FILM
        (IN PROJECTION-BOOTH)
        (DESC "strip of film")
        (SYNONYM FILM STRIP)
	(ADJECTIVE FILM)
	(SIZE 1)
	(FLAGS TAKEBIT)
        (ACTION FILM-F)>

;<TELL
"You expertly splice the two ends of the film together (This kind of
work is in your blood)." CR>

<ROUTINE FILM-F ()
         <COND (<VERB? EXAMINE>
		<COND (<AND <IN? ,FILM ,FILM-PROJECTOR>
			    <FSET? ,FILM-PROJECTOR ,ONBIT>>
		       <PERFORM ,V?EXAMINE ,PROJECTION-SCREEN>
		       <RTRUE>)
		      (T
		       <FILM-SLIDE-DESC ,FILM "six-foot long ">)>)
	      ;(<VERB? SPLICE>
		<COND (<NOT <FSET? ,FILM ,FILM-LOOPED-BIT>>
		       <COND (<IN? ,FILM ,SPLICER>
		              <TELL
"You expertly splice the two ends of the film together (This kind of
work is in your blood)." CR>
		              <PUTP ,FILM ,P?SDESC "loop of film">
		              <FSET ,FILM ,FILM-LOOPED-BIT>)
		             (T
		              <TELL
"You'll have to put" T ,FILM " in the splicer first." CR>)>)
		      (T
		       <TELL "You already did that." CR>)>)
	       (<VERB? TAKE>
		<COND (<AND <IN? ,FILM ,FILM-PROJECTOR>
			    <FSET? ,FILM-PROJECTOR ,ONBIT>>
		       <TELL
"Even a nonunion projectionist like yourself should know how dangerous
it is to try to take film from" A ,FILM-PROJECTOR " while it's running."
CR>)>)
	       (<AND <VERB? PUT>
		     <FSET? ,FILM-PROJECTOR ,ONBIT>
		     <PRSI? ,FILM-PROJECTOR>>
		<TELL
"You start to put" T ,FILM " in" T ,FILM-PROJECTOR ", but glance up at a sign
on the wall. The sign states: Remember, Perry Projectionist sez, \"Never
try to put film in" A ,FILM-PROJECTOR " that's turned on.\"" CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,SLIDE-PROJECTOR>>
		<TELL "The " D ,FILM " won't fit in" TR ,PRSI>)>>

<OBJECT SLIDE
        (IN PROJECTION-BOOTH)
        (DESC "slide")
        (SYNONYM SLIDE TRANSPARENCY)
	(SIZE 1)
        (FLAGS TAKEBIT TRANSBIT ;NDESCBIT)
        (ACTION SLIDE-F)>

<ROUTINE SLIDE-F ()
	 <COND (<VERB? EXAMINE>
                <FILM-SLIDE-DESC ,SLIDE>)
	      ;(<VERB? PUT>
                <COND (<EQUAL? ,PRSO ,SLIDE>
		       <TELL "You drop" T ,SLIDE " in" TR ,SLIDE-PROJECTOR>
		       <MOVE ,SLIDE ,SLIDE-PROJECTOR>)
		      (T
		       <TELL "That won't fit in" TR ,SLIDE-PROJECTOR>)>)>>  

<ROUTINE FILM-SLIDE-DESC (OBJ "OPTIONAL" (STRING <>))
	 <COND (<OR <IN? .OBJ ,FILM-PROJECTOR>
                    <IN? .OBJ ,SLIDE-PROJECTOR>>
		<TELL "It's in" T <LOC .OBJ> "." CR>)
	       (T
		<TELL "You examine the ">
		<COND (.STRING
		       <TELL .STRING>)>
		<TELL
D .OBJ " closely. Whatever is on it is too small for you to make out." CR>)>>

;<OBJECT SPLICER 
        (IN PROJECTION-BOOTH)
        (DESC "film splicer")
        (SYNONYM SPLICE)
	(ADJECTIVE FILM)
	(FLAGS CONTBIT OPENBIT SEARCHBIT TRYTAKEBIT)
        (CAPACITY 1)
        (ACTION SPLICER-F)>

;<ROUTINE SPLICER-F ()
         <COND (<VERB? TAKE>
		<TELL "You can't. It's fastened to the workbench." CR>)
	       (<VERB? READ>
		<PERFORM ,V?READ ,DIRECTIONS>
		<RTRUE>)
               (<VERB? EXAMINE>
		<TELL
"It's your average film splicer with operating instructions
printed right on it. ">
		 <RFALSE>)>>

;<OBJECT DIRECTIONS
        (IN PROJECTION-BOOTH)
	(DESC "directions for film splicer")
	(SYNONYM DIRECTION INSTRUCTIONS)
        (ADJECTIVE OPERATING)
	(FLAGS READBIT NDESCBIT)
	(ACTION DIRECTIONS-F)>

;<ROUTINE DIRECTIONS-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"         OPERATING INSTRUCTIONS~
~
1. Place film to be spliced into splicer.~
2. Type SPLICE FILM." CR>)>>

<OBJECT FILM-PROJECTOR
        (IN PROJECTION-BOOTH)
        (DESC "film projector")
        (SYNONYM PROJEC)
	(ADJECTIVE FILM SIMPLEX)
	(FLAGS CONTBIT OPENBIT SEARCHBIT LIGHTBIT)
	(CAPACITY 13)
        (ACTION FILM-PROJECTOR-F)>

<ROUTINE FILM-PROJECTOR-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a large, black, Simplex 70, 35mm " D ,FILM-PROJECTOR ". In the front it
has a short lens. ">
		<COND (<IN? ,LENS-CAP ,FILM-PROJECTOR>
		       <TELL "There's a lens cap on the lens. ">)>
		<TELL "The " D ,FILM-PROJECTOR>
		<COND (<IN? ,FILM ,FILM-PROJECTOR>
		       <TELL " has" A ,FILM " in it, and">)
		      (<IN? ,CORPSE-LINE ,FILM-PROJECTOR>
		       <TELL " has" A ,CORPSE-LINE " in it, and">)>
		<TELL " is turned o">
		<COND (<FSET? ,FILM-PROJECTOR ,ONBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL "." CR>) 
	       (<AND <VERB? LAMP-ON>
		     <NOT <FSET? ,FILM-PROJECTOR ,ONBIT>>>
		<TELL "Immediately the projector begins to roll">
		<FSET ,FILM-PROJECTOR ,ONBIT>
		<COND (<OR <IN? ,FILM ,FILM-PROJECTOR>
			   <IN? ,CORPSE-LINE ,FILM-PROJECTOR>> 
		       <COND (<IN? ,FILM ,FILM-PROJECTOR>
			      <QUEUE I-FILM-DROP 2>)>
		       <TELL ". The film starts to run through the projector">
			      <COND (<FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>
			             <FSET ,SCREENING-ROOM ,ONBIT>
				     <TELL
" and a stream of colored light shoots out of the lens onto the screen in the
screening room">
				     <COND (<IN? ,CORPSE-LINE ,FILM-PROJECTOR>
					    <TELL "." CR>
					    <CORPSE-LINE-DEATH>)>)>)
		      (T  				;"no film in projector"
		       <COND (<FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>
			      <FSET ,SCREENING-ROOM ,ONBIT>
		              <TELL
". A stream of white light shoots out of the lens of" T ,FILM-PROJECTOR " onto
the screen in the screening room">)
;"semied to fix period bug"  ;(T			         ;"lens cap on"
			       <CRLF>)>)>
		        <TELL "." CR>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)	       
	       (<AND <VERB? LAMP-OFF>
		     <FSET? ,FILM-PROJECTOR ,ONBIT>>
		<FCLEAR ,FILM-PROJECTOR ,ONBIT>
		<COND (<NOT <FSET? ,SLIDE-PROJECTOR ,ONBIT>>
		       <FCLEAR ,SCREENING-ROOM ,ONBIT>)>
		<TELL
"You hear" T ,FILM-PROJECTOR "'s whining trail off as it rolls to a stop." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,FILM-PROJECTOR>>
		<COND (<NOT <EQUAL? ,PRSO ,FILM ,CORPSE-LINE>>
		       <WASTE-OF-TIME>)
		      (<OR <IN? ,FILM ,FILM-PROJECTOR>
			   <IN? ,CORPSE-LINE ,FILM-PROJECTOR>>
		       <TELL 
"You'll have to take" T <FIRST? ,FILM-PROJECTOR> " out first." CR>)>)>>

<ROUTINE CORPSE-LINE-DEATH ()
	 <TELL CR "Your eyes are immediately drawn to the screen. ">
	 <COND (<FSET? ,SLIDE-PROJECTOR
		       ,ONBIT>
		<TELL
"Although it's a little distorted by the slide projector, you">)
	       (T
		<TELL "You">)>
	 <JIGS-UP
" quickly realize why \"A Corpse Line\" could never be released: From
the back of a large theatre the camera slowly pans in. The camera
moves forward and you are able to make out a dozen or more figures lying
side-by-side on the stage in glittering top hats. Then the music starts
and the figures rise to their feet. The camera is now close enough to
see more detail. The figures are corpses, some badly decayed, clad in
top hats. They begin to dance in unison as the music swells. For a
moment you forget they are corpses and begin to enjoy their mastery of
the art.~
~
Then the horror begins, just as it must have for Uncle Buddy. The line
does a kick, and several legs fly into the audience. You feel your heart
pounding as never before. The corpses, gripping each other's shoulders,
turn at the same time and a half-dozen arms are pulled from their
sockets. You can't seem to catch your breath. It's as if a pile of
bricks were stacked on your chest. As the number ends, the corpses
(what's left of them) remove their hats to take a bow. The camera moves
in close as they bend over and you see the tops of their heads have been
removed. You begin to shake uncontrollably, then you feel what seems
like an explosion in your chest. The last thing you see is the corpses'
brains plop onto the stage as they take their bow. You collapse.">>

<ROUTINE I-FILM-DROP ()
	 <MOVE ,FILM ,PROJECTION-BOOTH>
	 <COND (<EQUAL? ,HERE ,PROJECTION-BOOTH>
		<TELL CR
"The " D ,FILM " runs out of" T ,FILM-PROJECTOR " and onto the floor." CR>)>>

<ROUTINE PROJECTORS-DESC (OBJ "OPTIONAL" (STRING <>))
	 <TELL "It's" A .OBJ>
	 <COND (.STRING
		<TELL .STRING>)>
	 <TELL ". The " D .OBJ " ">
	 <COND (<FIRST? .OBJ>
		<TELL "has" A <FIRST? .OBJ> " in it">)
	       (T
		<TELL "is empty">)>
	 <TELL " and is turned o">
	 <COND (<FSET? .OBJ ,ONBIT>
		<TELL "n">)
	       (T
		<TELL "ff">)>
	 <TELL "." CR>>

<OBJECT SLIDE-PROJECTOR
        (IN PROJECTION-BOOTH)
        (DESC "slide projector")
        (SYNONYM PROJEC)
	(ADJECTIVE SLIDE)
	(CAPACITY 1)
	(FLAGS CONTBIT OPENBIT SEARCHBIT LIGHTBIT)
        (ACTION SLIDE-PROJECTOR-F)>

<ROUTINE SLIDE-PROJECTOR-F ()
	 <COND (<VERB? EXAMINE>
		<PROJECTORS-DESC ,SLIDE-PROJECTOR " with a lens">)	       
               (<AND <VERB? LAMP-ON>
		     <NOT <FSET? ,SLIDE-PROJECTOR ,ONBIT>>>
		<FSET ,SLIDE-PROJECTOR ,ONBIT>
		<FSET ,SCREENING-ROOM ,ONBIT>
		<TELL "A stream of ">
	        <COND (<IN? ,SLIDE ,SLIDE-PROJECTOR>
		       <TELL "colored">)
		      (T
		       <TELL "white">)>
		<TELL
" light shoots out of the lens of" T ,SLIDE-PROJECTOR " onto the screen in the
screening room." CR>)
	       (<VERB? FOCUS>
		<PERFORM ,V?FOCUS ,SLIDE-PROJECTOR-LENS>
		<RTRUE>);"add unfocus here"
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)
     	       (<AND <VERB? LAMP-OFF>
		     <FSET? ,SLIDE-PROJECTOR ,ONBIT>>
		     <FCLEAR ,SLIDE-PROJECTOR ,ONBIT>
		     <COND (<OR <NOT <FSET? ,FILM-PROJECTOR ,ONBIT>>
				<NOT <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>>
			    <FCLEAR ,SCREENING-ROOM ,ONBIT>)>
		     <TELL
"You turn off" T ,SLIDE-PROJECTOR " and the light from the lens
fades away." CR>)>>

<OBJECT PROJECTED-IMAGE
	(IN LOCAL-GLOBALS)
	(DESC "image")
	(SYNONYM IMAGE WORDS BITS PIECES)
	(ADJECTIVE BLURRED WASHED)
	(FLAGS NDESCBIT)
	(ACTION PROJECTED-IMAGE-F)>

<ROUTINE PROJECTED-IMAGE-F ()
	 <COND (<EQUAL? ,PRSI ,PROJECTED-IMAGE>
		<PERFORM ,PRSA ,PRSO ,PROJECTION-SCREEN>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,PROJECTED-IMAGE>
		<PERFORM ,PRSA ,PROJECTION-SCREEN ,PRSI>
		<RTRUE>)>>

<OBJECT PROJECTION-SCREEN
	(IN LOCAL-GLOBALS)
	(DESC "viewing screen")
	(SYNONYM SCREEN)
	(ADJECTIVE VIEWING MOVIE)
	(FLAGS NDESCBIT)
	(ACTION PROJECTION-SCREEN-F)>                       

<GLOBAL WHITE-LIGHT "filled with white light">

<GLOBAL BITS-&-PIECES "filled with bits and pieces of colored words">

<GLOBAL WASHED-OUT-BITS "filled with washed-out bits of colored words">

<GLOBAL PROJECTOR-POINTS <>> ;"true if you solved projector puzzle"

<ROUTINE PROJECTION-SCREEN-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL "The " D ,PROJECTION-SCREEN " is ">
		<COND (<AND <FSET? ,FILM-PROJECTOR ,ONBIT>
			    <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>
		       <COND (<IN? ,FILM ,FILM-PROJECTOR>
			      <COND (<FSET? ,SLIDE-PROJECTOR ,ONBIT>
				      <COND (<IN? ,SLIDE ,SLIDE-PROJECTOR>
					     <COND (<FSET?
                                                    ,SLIDE-PROJECTOR-LENS
						    ,FOCUS-BIT>
						    <TELL
"showing a message saying:~
~
PLAY \"" <GET ,SONGS ,SONG-NUMBER> ".\"~
         Love,~
           Aunt Hildegarde">
						    <COND (<NOT
                 					   ,PROJECTOR-POINTS>
						           <SETG SCORE
							   <+ ,SCORE 10>>
 							   <SETG
							 PROJECTOR-POINTS T>)>)
;"slide projector lens not focused"     	   (T 
						    <TELL
"filled with bits of colored words and a blur of colored light">)>)
;"no slide in slide projector"   	   (T
					    <TELL ,WASHED-OUT-BITS>)>)
;"slide projector isn't turn on"    (T
				     <TELL ,BITS-&-PIECES>)>)
;"projector on but no film"  (T
			      <COND (<FSET? ,SLIDE-PROJECTOR ,ONBIT>
				     <COND (<IN? ,SLIDE ,SLIDE-PROJECTOR>
					    <COND (<FSET? ,SLIDE-PROJECTOR-LENS
							  ,FOCUS-BIT>
						   <TELL ,WASHED-OUT-BITS>)
						  (T
						   <TELL
;"a washed-out blur of colored light" ,WASHED-OUT-BITS>)>)
;"both projectors on and empty"            (T
					    <TELL ,WHITE-LIGHT>)>)
;"film proj on but not slide proj"  (T
				     <TELL ,WHITE-LIGHT>)>)>)
		      (T ;"film projector is doing nothing to screen"
		       <COND (<FSET? ,SLIDE-PROJECTOR ,ONBIT>
			      <COND (<IN? ,SLIDE ,SLIDE-PROJECTOR>
				     <COND (<FSET? ,SLIDE-PROJECTOR-LENS
						   ,FOCUS-BIT>
					    <TELL ,BITS-&-PIECES>)
					   (T
					    <TELL "a blur of colored light">)>)
				    (T
				     <TELL ,WHITE-LIGHT>)>)
			     (T ;"neither projector doing anything to screen"
			      <TELL "blank">)>)>
		<TELL "." CR>)>>

<OBJECT LENS-CAP
	(IN FILM-PROJECTOR)
	(DESC "lens cap")
	(SYNONYM CAP COVER)
	(ADJECTIVE LENS FILM PROJEC)
	(FLAGS TRYTAKEBIT TAKEBIT NDESCBIT) ;"that's why"
        (SIZE 3)
	(ACTION LENS-CAP-F)>

<ROUTINE LENS-CAP-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,FILM-PROJECTOR ,FILM-PROJECTOR-LENS>>
		<FCLEAR ,LENS-CAP ,LENS-CAP-OFF-BIT>
		<FSET ,LENS-CAP ,NDESCBIT>
		<FSET ,LENS-CAP ,TRYTAKEBIT>
		<MOVE ,LENS-CAP ,FILM-PROJECTOR>
		<COND (<AND <NOT <FSET? ,SLIDE-PROJECTOR ,ONBIT>>
			    <FSET? ,FILM-PROJECTOR ,ONBIT>>
		       <FCLEAR ,SCREENING-ROOM ,ONBIT>)>
		<TELL "You place" T ,LENS-CAP " over" TR ,FILM-PROJECTOR-LENS>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,SLIDE-PROJECTOR ,SLIDE-PROJECTOR-LENS>>
		<TELL "The " D ,LENS-CAP " won't fit on" TR ,PRSI>)
	       (<AND <VERB? TAKE-OFF UNTIE> ;"UNATTACH"
		     <NOT <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>>
		<PERFORM ,V?TAKE ,LENS-CAP>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,LENS-CAP>
		     <NOT <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)>
		<FSET ,LENS-CAP ,LENS-CAP-OFF-BIT>
		<FCLEAR ,LENS-CAP ,NDESCBIT>
		<FCLEAR ,LENS-CAP ,TRYTAKEBIT>
		<COND (<FSET? ,FILM-PROJECTOR ,ONBIT>
		       <FSET ,SCREENING-ROOM ,ONBIT>
		       <TELL "As you remove" T ,LENS-CAP " a stream of ">
		       <COND (<OR <IN? ,FILM ,FILM-PROJECTOR>
				  <IN? ,CORPSE-LINE ,FILM-PROJECTOR>>
			      <TELL "colored">)
			     (T
			      <TELL "white">)>
		       <TELL
" light shoots from" T ,FILM-PROJECTOR "'s lens." CR>
		       <COND (<IN? ,CORPSE-LINE ,FILM-PROJECTOR>
			      <CORPSE-LINE-DEATH>)>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)>>

<OBJECT FILM-PROJECTOR-LENS
        (IN PROJECTION-BOOTH)
        (DESC "film projector lens")
        (SYNONYM LENS)
	(ADJECTIVE FILM PROJEC)
	(FLAGS NDESCBIT)
        (ACTION FILM-PROJECTOR-LENS-F)>

<ROUTINE FILM-PROJECTOR-LENS-F ()
	 <COND (<VERB? EXAMINE>
                <TELL
"It's a hand-ground, all-aluminum, Bierman 500 " D ,FILM-PROJECTOR-LENS>
		<COND (<NOT <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>
		       <TELL " with" A ,LENS-CAP " on it">)
		      (T
                       <COND (<FSET? ,FILM-PROJECTOR ,ONBIT>
		              <TELL ", with a spray of ">
		              <COND (<IN? ,FILM ,FILM-PROJECTOR>
			             <TELL "colored">)
			            (T
			             <TELL "white">)>
		              <TELL " light coming out of it">)>)>   
		<TELL "." CR>)
               (<VERB? FOCUS ;UNFOCUS TURN>
		<TELL
,YOU-CANT "adjust" T ,FILM-PROJECTOR-LENS ". It's preset for Uncle Buddy's
screening room." CR>)
	       (<VERB? TAKE UNTIE>  ;"UNATTACH"
	        <TELL ,LENS-ATTACHED CR>)>>

<GLOBAL LENS-ATTACHED "The lens is firmly attached to the projector.">

<OBJECT SLIDE-PROJECTOR-LENS
        (IN PROJECTION-BOOTH)
        (DESC "slide projector lens")
        (SYNONYM LENS)
	(ADJECTIVE SLIDE PROJEC)
	(FLAGS NDESCBIT)
        (ACTION SLIDE-PROJECTOR-LENS-F)>

<ROUTINE SLIDE-PROJECTOR-LENS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a fairly expensive, focusable " D ,SLIDE-PROJECTOR-LENS>
		<COND (<FSET? ,SLIDE-PROJECTOR ,ONBIT>
		       <TELL ". A stream of ">
		       <COND (<IN? ,SLIDE ,SLIDE-PROJECTOR>
			      <TELL "colored">)
			     (T
			      <TELL "white">)>
		       <TELL " light sprays from the lens">)>
		<TELL "." CR>)
	       (<VERB? FOCUS TURN>
		<COND (<NOT <FSET? ,SLIDE-PROJECTOR ,ONBIT>>
		       <TELL
"How can you focus" T ,SLIDE-PROJECTOR " when it's not turned on?" CR>)
                      (<FSET? ,SLIDE-PROJECTOR-LENS ,FOCUS-BIT>
                       <YOU-ALREADY>)       ;"pass a string- focused the prso?"
		      (<NOT <IN? ,SLIDE ,SLIDE-PROJECTOR>>
		       <TELL
"How can you focus" T ,SLIDE-PROJECTOR " when there's nothing in it?" CR>)
		      (T
                       <TELL "You twist" TR ,SLIDE-PROJECTOR-LENS>
                       ;"say more here?"
		       <FSET ,SLIDE-PROJECTOR-LENS ,FOCUS-BIT>)>)
	      ;(<VERB? UNFOCUS>			;"say more here?"
		       <TELL "You twist" TR ,SLIDE-PROJECTOR-LENS>
		       <FCLEAR ,SLIDE-PROJECTOR-LENS ,FOCUS-BIT>) 
	       (<VERB? TAKE>
	        <TELL ,LENS-ATTACHED CR>)>>
                       		       
<ROOM PROJECTION-BOOTH
      (IN ROOMS)
      (DESC "Projection Booth")
      (LDESC
"This cramped area is just big enough for one person and all the equipment.
A thick glass window overlooks the screening room to the north.")
      (NORTH TO SCREENING-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL PROJECTION-SCREEN PROJECTED-IMAGE WINDOW)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (THINGS <PSEUDO (SCREEN ROOM SCREENING-ROOM-PSEUDO-F)>)
      (ACTION PROJECTION-BOOTH-F)>

<ROUTINE PROJECTION-BOOTH-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,PROJECTION-BOOTH ,EVERYBIT>>>
		<FSET ,PROJECTION-BOOTH ,EVERYBIT>
		<SETG SONG-NUMBER <- <RANDOM 10> 1>>)>>

<ROUTINE SCREENING-ROOM-PSEUDO-F ()
	 <COND (<VERB? EXAMINE>
		<PERFORM ,V?LOOK-INSIDE ,WINDOW>
		<RTRUE>)>>

;<ROUTINE TO-SCREENING-ROOM ()
	 <COND (<AND <IN? ,CORPSE-LINE ,FILM-PROJECTOR>
		     <FSET? ,FILM-PROJECTOR ,ONBIT>
		     <FSET? ,LENS-CAP ,LENS-CAP-OFF-BIT>>
		<CORPSE-LINE-DEATH>)
	       (T
		,SCREENING-ROOM)>>

<GLOBAL SONG-NUMBER 10>

<GLOBAL SONGS
	<TABLE
	 ;"0"	"Yesterday"
	 ;"1"	"Greensleeves"
	 ;"2"	"Camelot"
	 ;"3"	"Stardust"
	 ;"4"	"Misty"
	 ;"5"	"People"
	 ;"6"	"Feelings"
	 ;"7"	"Tomorrow"
	 ;"8"	"Tonight"
	 ;"9"	"Oklahoma">>

<ROOM SCREENING-ROOM 
      (IN ROOMS)
      (DESC "Screening Room")
      (LDESC
"This is the screening room where Uncle Buddy died. He had a massive
heart attack while viewing the final cut of his first horror musical, \"A
Corpse Line.\" The film was never released and no one knows what
happened to the only full-length version, worth a fortune today. Rumor
has it that as he was dying he proclaimed \"A Corpse Line\" to be his
masterwork of horror. Other rumors say the film was so bad that, if it
had been released and he hadn't died, someone would have killed him.
Several rows of plush theatre-like seats face a movie screen. Doorways
lead south and west.")
      (SOUTH TO PROJECTION-BOOTH)
      (WEST TO SHORT-HALL)
      (FLAGS RLANDBIT)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (GLOBAL ;BOOTH-DOOR SEAT PROJECTION-SCREEN PROJECTED-IMAGE WINDOW)>

<ROOM OUTSIDE-PARLOR
      (IN ROOMS)
      (DESC "Hallway")
      (EAST TO PARLOR)
      (WEST TO FOYER)
      (GLOBAL WINDOW)
      (FLAGS RLANDBIT LOCKEDBIT) ;"FOR SAFE"
      (CAPACITY 20) ;"Tell--sun coming up"
      (ACTION OUTSIDE-PARLOR-F)>

<ROUTINE OUTSIDE-PARLOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a long hall stretching east and west.">
	        <COND (<FSET? ,WALL-SAFE ,INVISIBLE>
		       <TELL
" There is a painting hanging here.">)
		      (T
		       <TELL
" There is a painting swung away from the wall. Next
to the painting is a">
		       <COND (<FSET? ,WALL-SAFE ,OPENBIT>
			      <TELL "n open">)
			     (T
			      <TELL " closed">)>
		       <TELL" wall safe.">)>)>>

<ROOM PARLOR
      (IN ROOMS)
      (DESC "Parlor")
      (WEST TO OUTSIDE-PARLOR)
      (DOWN PER TO-CRAWL-SPACE-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL CRAWL-SPACE-DOOR SEAT)
      (CAPACITY 10) ;"DON'T LIGHT THIS ROOM WHEN SUN COMES UP"
      (THINGS <PSEUDO (PIANO CASTERS CASTERS-PSEUDO)>)
      (ACTION PARLOR-F)>

<ROUTINE PARLOR-F (RARG)
      <COND (<EQUAL? .RARG ,M-LOOK>
	     <COND (,TIPPED
		    <TELL
"This room is askew with the floor tilting down in the ">
		    <COND (<EQUAL? ,TIPPED ,CRAWL-SPACE-NORTH>
		           <TELL "north and up in the south">)
			  (T
			   <TELL "south and up in the north">)>
		    <TELL ". The piano is ">)
		   (T
		    <TELL
"This is the parlor where Uncle Buddy would bring potential investors.
He would break out his finest scotch and Cuban cigars. Once the
\"guests\" were tight he would present his latest movie idea. (You've
seen his movies, so you know anyone who would agree to invest in one of
them had to have been drinking.) Strange, you notice all the furniture
in this room is bolted to the floor, except for the piano ">)>
	     <COND (<EQUAL? ,PIANO-LOC 1>
		    <TELL "against the northern wall">)
		   (<EQUAL? ,PIANO-LOC 2>
		    <TELL "in the middle of the room">)
		   (T
		    <TELL "against the southern wall">)>
	     <COND (<FSET? ,CRAWL-SPACE-DOOR ,OPENBIT>
		    <TELL
". There is an open door in the floor">)>
	     <TELL ". A doorway leads west.">)>>

<ROUTINE TO-CRAWL-SPACE-NORTH ()
	 <COND (<FSET? ,CRAWL-SPACE-DOOR ,OPENBIT>
		<COND (<FSET? ,SKIS ,WORNBIT>
		       <TELL
"You can't fit through the opening wearing the skis." CR>
		       <RFALSE>) ;"ADDED 10-31" 
                      (<EQUAL? ,TIPPED ,CRAWL-SPACE-NORTH>
		       <TELL
"Now that the parlor is tilted, you can't fit into the crawl space." CR>
		       <RFALSE>)
		      (T
		       ,CRAWL-SPACE-NORTH)>)
		(T
		 <TELL "You can't go that way." CR>
		 <RFALSE>)>>
  

"--- Crawl Space ---"

<OBJECT CRAWL-SPACE-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "crawl space door")
	(SYNONYM DOOR)
	(ADJECTIVE CRAWL SPACE) ;"will open crawl space door work"
	(FLAGS DOORBIT NDESCBIT)
        (ACTION CRAWL-SPACE-DOOR-F)>

<GLOBAL SONG-PLAYED <>>

<ROUTINE CRAWL-SPACE-DOOR-F ()
	 <COND (<VERB? OPEN>
		<COND (<EQUAL? ,HERE ,PARLOR>
		       <COND (<AND ,SONG-PLAYED
			          <NOT <FSET? ,CRAWL-SPACE-DOOR ,OPENBIT>>>
		             <FSET ,CRAWL-SPACE-DOOR ,OPENBIT>
		             <TELL "Opened." CR>)
		            (T
		       <TELL "You can't seem to open it." CR>)>)>)>>	       

<ROOM CRAWL-SPACE-NORTH
      (IN ROOMS)
      (DESC "Crawl Space, North")
      (FLAGS RLANDBIT)
      (UP TO PARLOR IF CRAWL-SPACE-DOOR IS OPEN)
      (SOUTH PER TO-CRAWL-SPACE-SOUTH)
      (NORTH PER TO-FIRST-SECRET-ROOM)
      (GLOBAL CRAWL-SPACE-DOOR)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION CRAWL-SPACE-NORTH-F)
      (THINGS <PSEUDO (WOODEN BEAM BEAM-PSEUDO)
		      (THICK BEAM BEAM-PSEUDO)>)>

<ROUTINE CRAWL-SPACE-NORTH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the northern half of an uncomfortably warm crawl space beneath the
parlor. It appears as though this room is under construction.">
		<DESCRIBE-CRAWL-SPACE-BEAM "south">
		<TELL
" To the north, about a foot above the floor, you see an entrance to
a passage.">
		<COND (<NOT ,TIPPED>
		       <TELL
" The entrance is partially blocked by the floor of the room above.">)>
		<DESCRIBE-NICHE ,NORTH-NICHE>
		<TELL " There is a">
		<COND (<FSET? ,CRAWL-SPACE-DOOR ,OPENBIT>
		       <TELL "n open">)
		      (T
		       <TELL" closed">)>
		<TELL " door above you.">)>>

<ROUTINE TO-CRAWL-SPACE-SOUTH ()
	 <COND (<EQUAL? ,TIPPED ,CRAWL-SPACE-SOUTH>
		<TELL
"You won't fit in the southern half of the crawl space. The ceiling shifted
and now fills the space." CR>
		<RFALSE>)
	       (T
		,CRAWL-SPACE-SOUTH)>>

<ROUTINE TO-FIRST-SECRET-ROOM ()
         <COND (<EQUAL? ,TIPPED ,CRAWL-SPACE-SOUTH>
		,FIRST-SECRET-ROOM)
	       (T
		<TELL
"You can't fit through the passage. It's partially blocked by the floor
of the room above." CR>
		<RFALSE>)>>

<ROOM FIRST-SECRET-ROOM
      (IN ROOMS)
      (DESC "Small Passage")
      (LDESC
"This is a small passage which ends here. It looks as if the
construction of this room was never completed.")
      (FLAGS RLANDBIT)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (SOUTH TO CRAWL-SPACE-NORTH)>

<OBJECT PARKING-METER
	(IN FIRST-SECRET-ROOM)
	(DESC "parking meter")
	(SYNONYM METER)
	(ADJECTIVE PARKING)
	(FLAGS TAKEBIT)
	(SIZE 10)
	(VALUE 10)
	(ACTION PARKING-METER-F)>

<ROUTINE PARKING-METER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"This is the parking meter that was the final frustration for budding
actor Alan Chaplin in Uncle Buddy's \"You Can't Fight City Hall, But You
Can Blow It Up!\"" CR>)>>

<ROUTINE DESCRIBE-NICHE (NICHE)
	 <TELL " There is a niche in the ceiling here.">
         <COND (<FIRST? .NICHE>
		<TELL
" In" T .NICHE " there is" A <FIRST? .NICHE> " supporting the ceiling.">)>
	 <RTRUE>
	;<CRLF>>

<ROUTINE BEAM-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The thick, wooden beam runs across the ceiling of the crawl space." CR>)>>

<ROUTINE DESCRIBE-CRAWL-SPACE-BEAM (STRING)
	 <TELL
" A wooden beam runs east-west across the ceiling, forming the boundary between
this side of the crawl space and the other half to the " .STRING ".">>

<ROOM CRAWL-SPACE-SOUTH
      (IN ROOMS)
      (DESC "Crawl Space, South")
      (FLAGS RLANDBIT)
      (NORTH TO CRAWL-SPACE-NORTH)
      ;(GLOBAL DANK-NICHE SOUTH-NICHE)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION CRAWL-SPACE-SOUTH-F)
      (THINGS <PSEUDO (WOODEN BEAM BEAM-PSEUDO)
		      (THICK BEAM BEAM-PSEUDO)>)>

<ROUTINE CRAWL-SPACE-SOUTH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the southern half of an uncomfortably warm crawl space beneath the
parlor.">
		<DESCRIBE-CRAWL-SPACE-BEAM "north">
		<DESCRIBE-NICHE ,SOUTH-NICHE>
		;<CRLF>)>>

<OBJECT SQUARE-POST
	(IN SOUTH-NICHE)
        (DESC "dirty pillar")
        (SYNONYM PILLAR)
	(ADJECTIVE DIRTY WOODEN)
	(SIZE 10)
        (FLAGS NDESCBIT TAKEBIT TRYTAKEBIT CANT-MOVE-POST-BIT)
        (ACTION POST-F)>

<OBJECT ROUND-POST
	(IN NORTH-NICHE)
        (DESC "dusty pillar")
        (SYNONYM PILLAR)
	(ADJECTIVE DUSTY WOODEN)
	(SIZE 10)
        (FLAGS TAKEBIT NDESCBIT TRYTAKEBIT CANT-MOVE-POST-BIT)
        (ACTION POST-F)>

<ROUTINE POST-F ("OPTIONAL" OARG "AUX" POST-LOC)
	 <SET POST-LOC <LOC ,PRSO>>
	 <COND ;(.OARG
		<COND (<EQUAL? .POST-LOC ,NORTH-NICHE ,SOUTH-NICHE>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)
			     (T
			      <TELL
"A " D ,PRSO " is standing vertically from floor to ceiling, its top
stuck in" A .POST-LOC ".">)>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? TAKE MOVE>
		     <FSET? ,PRSO ,CANT-MOVE-POST-BIT>>
		<TELL "The pillar won't budge from the niche." CR>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? .POST-LOC ,NORTH-NICHE ,SOUTH-NICHE>
		       <TELL "It's in" TR <LOC ,PRSO>>) ;"SEM"
		      (T
		       <TELL
"The " D ,PRSO " is made of wood and is about two feet tall." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,NORTH-NICHE ,SOUTH-NICHE>>
		<COND (,TIPPED
		       <TELL
"The post won't go in the niche now that the ceiling is tilted." CR>)
		      (<OR <AND <PRSI? ,NORTH-NICHE>
			        <EQUAL? ,PIANO-LOC 1>>
			   <AND <PRSI? ,SOUTH-NICHE>
				<EQUAL? ,PIANO-LOC 3>>
			   <AND <EQUAL? ,PIANO-LOC 2>
				<OR <PRSI? ,NORTH-NICHE>
				    <PRSI? ,SOUTH-NICHE>>>>
		       <TELL
"Because of the weight from above you can't put the pillar back in the
niche." CR>)>) 
	       (<VERB? BURN>
		<TELL ,PYRO>)>>

<GLOBAL PIANO-LOC 2>

<GLOBAL TIPPED <>>

<OBJECT PIANO
	(IN PARLOR)
	(DESC "piano")
	(SYNONYM PIANO LID)
	(FLAGS NDESCBIT SEARCHBIT CONTBIT)
	(CAPACITY 75)
	(ACTION PIANO-F)>

<ROUTINE PIANO-F ()
	 <COND (<AND <VERB? PUSH-TO>
		     <PRSI? ,INTDIR>>
		     <COND (<NOT <EQUAL? ,TIPPED ,CRAWL-SPACE-NORTH
					         ,CRAWL-SPACE-SOUTH>>
		            <COND (<AND <EQUAL? ,P-DIRECTION ,P?NORTH>
					<EQUAL? ,PIANO-LOC 1>>
				   <TELL
"It's already up against the wall." CR>)
                                  (<AND <EQUAL? ,P-DIRECTION ,P?NORTH>
					<EQUAL? ,PIANO-LOC 2>>
				   <COND (<IN? ,ROUND-POST ,NORTH-NICHE>
					  <FCLEAR ,SQUARE-POST
						  ,CANT-MOVE-POST-BIT>
					  <SETG PIANO-LOC 1>
					  <TELL
"The hearty breakfast you had this morning pays off as you push
the piano north against the wall." CR>)
					 (T
				          <SETG TIPPED ,CRAWL-SPACE-NORTH>
				          <SETG PIANO-LOC 1>
				          <TELL
"You push the piano north a couple of feet and the room begins to tip. As the
north side of the parlor tips down, the piano rolls across the floor and
against the north wall with an atonal banging of the keys. The south side
of the floor tilts up." CR>)>)
				  (<AND <EQUAL? ,P-DIRECTION ,P?NORTH>
					<EQUAL? ,PIANO-LOC 3>>
				   <COND (<IN? ,ROUND-POST ,NORTH-NICHE>
					  <FSET ,ROUND-POST
					        ,CANT-MOVE-POST-BIT>)>
				   <COND (<IN? ,SQUARE-POST ,SOUTH-NICHE>
					  <FSET ,SQUARE-POST
						,CANT-MOVE-POST-BIT>)>   
				   <SETG PIANO-LOC 2>
				   <TELL
"You push the piano north to the center of the room." CR>)
				  (<AND <EQUAL? ,P-DIRECTION ,P?SOUTH>
					<EQUAL? ,PIANO-LOC 1>>
				   <COND (<IN? ,ROUND-POST ,NORTH-NICHE>
					  <FSET ,ROUND-POST
					        ,CANT-MOVE-POST-BIT>)>
       				   <COND (<IN? ,SQUARE-POST ,SOUTH-NICHE>
					  <FSET ,SQUARE-POST
						,CANT-MOVE-POST-BIT>)>
				   <SETG PIANO-LOC 2>
				   <TELL
"You push the piano south to the center of the room." CR>)
				  (<AND <EQUAL? ,P-DIRECTION ,P?SOUTH>
					<EQUAL? ,PIANO-LOC 2>>
				   <COND (<IN? ,SQUARE-POST ,SOUTH-NICHE>
					  <FCLEAR ,ROUND-POST 
						  ,CANT-MOVE-POST-BIT>
					  <SETG PIANO-LOC 3>
					  <TELL
"The hearty breakfast you had this morning pays off as you push
the piano south against the wall." CR>)
					 (T
				          <MOVE ,ROUND-POST ,CRAWL-SPACE-NORTH>
					  <FCLEAR ,ROUND-POST ,NDESCBIT>
				          <FCLEAR ,ROUND-POST
						  ,CANT-MOVE-POST-BIT>
				          <SETG TIPPED ,CRAWL-SPACE-SOUTH>
					  <SETG PIANO-LOC 3>
				          <TELL
"You push the piano south a couple of feet and the room begins to tip. As the
south side of the parlor tips down the piano rolls across the floor and
slams against the south wall. The north side of the floor tilts up." CR>)>)
				  (<AND <EQUAL? ,P-DIRECTION ,P?SOUTH>
					<EQUAL? ,PIANO-LOC 3>>
				   <TELL
"It's already up against the wall." CR>)
				  (<EQUAL? ,P-DIRECTION ,P?EAST ,P?WEST
							,P?NE ,P?NW
							,P?SE ,P?SW>
				   <TELL "You try pushing the piano ">
				   <COND (<EQUAL? ,P-DIRECTION ,P?EAST>
					  <TELL "east">)
					 (<EQUAL? ,P-DIRECTION ,P?WEST>
					  <TELL "west">)
					 (<EQUAL? ,P-DIRECTION ,P?NE>
					  <TELL "northeast">)
					 (<EQUAL? ,P-DIRECTION ,P?NW>
					  <TELL "northwest">)
					 (<EQUAL? ,P-DIRECTION ,P?SE>
					  <TELL "southeast">)
					 (<EQUAL? ,P-DIRECTION ,P?SW>
					  <TELL "southwest">)>
				   <TELL
" but the casters it rides on are old and worn.
They're stuck, so" T ,PIANO " will only move north and south." CR>)>)
			   (T
			    <TELL
"Now that the room is tipped, the piano is too heavy to move." CR>)>)
	       (<VERB? PUSH MOVE>
		<TELL "Did you have a direction in mind?" CR>)
	       (<VERB? RAISE>
		<PERFORM ,V?OPEN ,PIANO>
		<RTRUE>)
	       (<VERB? LOWER>
		<PERFORM ,V?CLOSE ,PIANO>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"It's the baby grand that Aunt Hildegarde bought for you and Herman.
Though neither of you practiced as you should, you've managed to
maintain a shaky repertoire of standards. The casters on the piano's
legs have seen better days. The piano lid is ">
		<COND (<FSET? ,PIANO ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL "." CR>)>>

;<OBJECT CASTERS
	(IN PARLOR)
	(DESC "CASTERS")
	(SYNONYM CASTERS)
	(ADJECTIVE PIANO)
	(FLAGS NDESCBIT)
	(ACTION CASTERS-F)>

<ROUTINE CASTERS-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The casters look old and worn, as if they have seen better days." CR>)>>

<OBJECT NORTH-NICHE
	(IN CRAWL-SPACE-NORTH)
	(DESC "niche")
	(SYNONYM NICHE)
        (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 10)
        (ACTION NICHE-F)>

<OBJECT SOUTH-NICHE
	(IN CRAWL-SPACE-SOUTH)
	(DESC "niche")
	(SYNONYM NICHE)
        (FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 10)
        (ACTION NICHE-F)>

<ROUTINE NICHE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
                <TELL "You see">
		<COND (<NOT <FIRST? ,PRSO>>
		       <TELL " nothing">)
		      (T
		       <TELL A <FIRST? ,PRSO>>)>
		<TELL " in" TR ,PRSO>)	       
	       (<AND <VERB? PUT>
		     <PRSI? NORTH-NICHE SOUTH-NICHE>
		     <NOT <PRSO? ROUND-POST SQUARE-POST>>>
		<WASTE-OF-TIME>)
              ;(<VERB? PUT> ;"HUH? SEM"
		<COND (<PRSO? ,ROUND-POST ,SQUARE-POST>
		       <RFALSE>)>
	        <TELL "Putting" T ,PRSO " in the corner is useless." CR>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>


"--- Noise ---"

<ROUTINE I-NOISE ()
	 <COND (<FSET? ,HERE ,CAVEBIT>
		<QUEUE I-NOISE 5>
		<RFALSE>)>
	 <CRLF>
	 <COND (<FSET? ,HERE ,OUTDOORSBIT>
                <TELL <PICK-ONE ,OUTDOOR-NOISE>>)
               (T
		<TELL <PICK-ONE ,INDOOR-NOISE>>)>
	 <CRLF>
	 <QUEUE I-NOISE <+ 30 <RANDOM 20>>>
	 <RFALSE>>

<GLOBAL INDOOR-NOISE
	<LTABLE 0
	 "Somewhere in the house you hear the thud of something falling on the floor."
	;"Nearby you hear the scraping noise of something being dragged across the floor."
	;"Without warning, a door slams shut."
	 "You hear the eerie whistling of wind coming down the chimney."
	 "Somewhere in the house you hear the creaking of floorboards."
	;"Suddenly the antique music box begins to play an old melody."
	;"There is a faint tapping on the window."
	;"Suddenly, maniacal laughter fills the house.">>

<GLOBAL OUTDOOR-NOISE
	<LTABLE 0
	;"You hear the thunder of waves crashing on the rocks."
	 "You can hear dogs howling in the distance."
	;"All around the house you can hear the shrieking of seagulls."
	;"In the distance you hear the ominous rumbling of thunder."
	;"Suddenly overhead there is a loud bang of thunder."
	 "Somewhere nearby several of Morgan Fairchild's cats begin crying."
	;"You can hear somewhere a door banging against the house."
	 "From the ocean there is the distant ringing of warning buoys."
	;"The foghorn begins warning any boats still in the area."
       "Shadows pour over you as grey clouds sweep past the night's full moon."
>>


"--- Leftovers ---"

; <OBJECT INDENT
	(IN CRAWL-SPACE)
	(DESC "slight indentation")
	(SYNONYM INDENT NICHE)
	(ADJECTIVE SLIGHT)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)
        (CAPACITY 50)>

;<ROUTINE STUCK-POST-F ()
	 <COND (<VERB? MOVE REMOVE TAKE>
		<TELL
"You push, pull and tug but cannot remove the post. There is too much weight
on the post from the room above." CR>)>>

;<ROUTINE THICK-POST-F ()
	 <COND (<VERB? MOVE TAKE>
		<COND (<NOT <EQUAL? ,THICK-POST-LOC ,LOCAL-GLOBALS>>
		       <MOVE-THICK-POST>)>)>>

;<ROUTINE MOVE-THICK-POST ()
	 <TELL "When you remove the post, ">
	 <COND (<NOT <EQUAL? ,THIN-POST-LOC ,LOCAL-GLOBALS>>
		<TELL
"the corner of the ceiling that it was holding up begins to sag noticably.
Luckily, the other post still supports a corner of the ceiling"
CR>
		;<MOVE ,THICK-POST ,PLAYER>
		;<SETG THICK-POST-LOC ,LOCAL-GLOBALS>
		<RFATAL>)
	       (T
                <JIGS-UP
"the ceiling collapses onto you, crushing you.">)>>

;<ROUTINE THIN-POST-F ()
	 <COND (<VERB? MOVE TAKE>
		<COND (<NOT <EQUAL? ,THIN-POST-LOC ,LOCAL-GLOBALS>>
		       <MOVE-THIN-POST>)>)>>
		       
;<ROUTINE MOVE-THIN-POST ()
	 <TELL "When you remove the post, ">
	 <COND (<NOT <EQUAL? ,THICK-POST-LOC ,LOCAL-GLOBALS>>
		<TELL
"the corner of the ceiling that it was holding up begins to sag noticably.
Luckily, the other post still supports a corner of the ceiling"
CR>
		<MOVE ,THIN-POST ,PLAYER>
		<SETG THIN-POST-LOC ,LOCAL-GLOBALS>
		<RFATAL>)
	       (T
                <JIGS-UP
"the ceiling collapses onto you, crushing you.">)>> 	

<ROOM P-DEBUG
      (IN ROOMS)
      (DESC "Work Room")
      (LDESC
"~
                            Cellar                                   ~
                   Cannon     |     Crawl Space North                ~
                 Emplacement  |    /                                 ~
                          ____|___/                                  ~
                          |       |                                  ~
            Boat Dock ----| Work  |----Heart of Maze                 ~
                          | Room  |                                  ~
                          |_______|                                  ~
                         /    |    .                                 ~
                        /     |     .                                ~
                    Attic  Upstairs  Bomb Shelter                    ~
                          Hall Middle
~")
      (UP PER OUT-OF-P-DEBUG)
      (NORTH PER OUT-OF-P-DEBUG)
      (WEST PER OUT-OF-P-DEBUG)
      (EAST PER OUT-OF-P-DEBUG)
      (SOUTH PER OUT-OF-P-DEBUG)
      (SE PER OUT-OF-P-DEBUG)
      (SW PER OUT-OF-P-DEBUG)
      (NE PER OUT-OF-P-DEBUG)
      (NW PER OUT-OF-P-DEBUG)
      (FLAGS RLANDBIT ONBIT TOUCHBIT)>

<ROUTINE OUT-OF-P-DEBUG ()
         <FSET ,FLASHLIGHT ,ONBIT>
	 <MOVE ,GREEN-MATCH ,PLAYER>
	 <MOVE ,FLASHLIGHT ,PLAYER>
	 <TELL
"Your flashlight comes on and a green match appears in your hand as you exit
the work room." CR CR>
	 <COND (<EQUAL? ,P-WALK-DIR ,P?NORTH>
		,CELLAR)
	       (<EQUAL? ,P-WALK-DIR ,P?SW>
		,ATTIC)
	       (<EQUAL? ,P-WALK-DIR ,P?WEST>
		,BOAT-DOCK)
	       (<EQUAL? ,P-WALK-DIR ,P?EAST>
		,HEART-OF-MAZE)
	       (<EQUAL? ,P-WALK-DIR ,P?SOUTH>
		,UPSTAIRS-HALL-MIDDLE)
	       (<EQUAL? ,P-WALK-DIR ,P?SE>
		,BOMB-SHELTER)
	       (<EQUAL? ,P-WALK-DIR ,P?NE>
		,CRAWL-SPACE-NORTH)
	       (<EQUAL? ,P-WALK-DIR ,P?NW>
		,CANNON-EMPLACEMENT)>>
