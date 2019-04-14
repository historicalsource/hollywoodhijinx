"FIRST-FLOOR for ANTHILL (C)1986 Infocom Inc. All rights reserved."	

;"poster text: Melts in your mouth-- Scientists discover that people who
crave chocolate can actually get more pleasure from human flesh, but the
acne is much worse. Soon the word leaks out and one brave chocaholic
takes a bite out of her brother. The next ninety minutes are a frenzy of
munching while scientist and candy makers race to find a cure.
Morticians, sensing they are sitting on a gold mine, begin to market
bizzare products like                . Soon the forces of good rally,
with the aid of chainmail armor, rounding up the mis-guided flesh eaters
along with anyone with a bad complexion."

;"poster idea Grapefruit diet from planet 9"
;"some yuppie take off"
;"plan 9 from marketing"

<OBJECT LETTER
	(IN PLAYER)
	(DESC "Aunt Hildegarde's letter")
	(SYNONYM LETTER)
	(ADJECTIVE AUNT HILDEG)
	(FLAGS TAKEBIT BURNBIT READBIT NARTICLEBIT)
	(SIZE 1)
	(ACTION LETTER-F)>

<ROUTINE LETTER-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<FSET? ,LETTER ,WETBIT>
		       <WET-PAPER>
		       <RTRUE>)
		      (T
		       <TELL
"The letter looks exactly like the letter in your exquisitely designed
game package." CR>)>)>>

<OBJECT PHOTO
	(IN PLAYER)
	(DESC "photo of Uncle Buddy")
        (SYNONYM PHOTO BUDDY UNCLE)
	(ADJECTIVE UNCLE)
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 1)
	(ACTION PHOTO-F)>

<ROUTINE PHOTO-F ()
	 <COND (<VERB? READ EXAMINE>
		<COND (<FSET? ,PHOTO ,WETBIT>
		       <WET-PAPER>
		       <RTRUE>)>
		<COND (<NOT <FSET? ,PHOTO ,READBIT>>
		       <FSET ,PHOTO ,READBIT>
		       ;<SETG BUCK-KEY <PICK-ONE ,BUCK-COMBS>>)>
	       <TELL
"The photo looks exactly like the one that came in your game package." CR>
	       ;<TELL
"You fumble through your numerous package elements and find a note reading:~
~
Be brave as Sheriff Roy in \"Fastest Blender in the West\".~
 The day the rustlin' outlaws put their chainsaws to the test.~
Old Sheriff Roy used whip then chop then liquify/puree,~
 but his blender proved no match for the chainsaw's mean foray.~
As pieces of Roy scattered, we knew that we had trouble.~
 We hadn't switched the sheriff with his plastic life-size double!~
~
			   ___~
~
Be couragous as Capt. Bob in \"Cannibal Buffet East\".~
 Who attended the headhunter's dinner not knowing he was the feast.~
The appetizers gave him indigestion, sauteed fingers were the source.~
 Things did not get better when he was informed he was the main course.~
Don't feel bad for Capt. Bob, whose agent was a real smarty.~
 He signed Bob for the sequel \"Cannibal Meatloaf Party\".~
~
			   ___~
~
Be clever like the tailor in \"Vampire Penguins of the North\".~
 A cummerbund for each penguin was the plan he set forth.~
The first penguins he met were of Transylvanian extraction,~
 and their fondness for his neck was a natural reaction.~
Down in a casket, daisies the tailor is now pushin'~
 while the penguins are in search of a new pin cushion."CR>
	       <RTRUE>)
	       ;(<AND <VERB? CUT> ;"vocab word TEAR removed 8/1"
		     <PRSO? ,PHOTO>>
		<REMOVE ,PHOTO>
		<TELL
"Well done! You meticulously reduce the paper to near microscopic proportions.
The note is history." CR>)>>

;<ROUTINE PHOTO-F ()
	 <COND (<VERB? READ EXAMINE LOOK-INSIDE>
		<COND (<NOT <FSET? ,PHOTO ,READBIT>>
		       <FSET ,PHOTO ,READBIT>
		       <SETG BUCK-KEY <PICK-ONE ,BUCK-COMBS>>)>
	        <TELL
"Dearie,
The magic number is \"" N <GET ,BUCK-KEY 0> ".\"
Love, Aunt Hildegard" CR>
	       <RTRUE>)>>


;"  Buck  "

<OBJECT BUCK
	(IN SOUTH-JUNCTION)
        (DESC "statue of Buck Palace, the fighting letter carrier")
	(SYNONYM BUCK PALACE CARRIER STATUE)
	(ADJECTIVE BUCK LETTER FIGHTING)
	(DESCFCN BUCK-F)
	(ACTION BUCK-F)>

<GLOBAL STEPS-THROUGH-BUCK 0>
<GLOBAL BUCK-DIR <>>
<GLOBAL BUCK-TURNED? <>>
<GLOBAL SOUTH-JUNCTION-VISITS 1> ;"since game opens in South Junction"

<ROUTINE BUCK-F ("OPTIONAL" (OARG <>))
         <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<AND <NOT ,BUCK-TURNED?>
			    <EQUAL? ,SOUTH-JUNCTION-VISITS 2>>
		       <SETG BUCK-DIR ,P?SOUTH>)>
		<TELL CR
"A life-size statue of Buck Palace, one of the stars of Uncle Buddy's talent
stables, stands here. He's holding a bazooka pointing ">
		<SAY-BUCK-DIR>
		<TELL ".">
		<COND (<AND <NOT ,BUCK-TURNED?>
			    <EQUAL? ,SOUTH-JUNCTION-VISITS 2>>
		      ;<SETG BUCK-DIR ,P?SOUTH>
		       <TELL
" Hmmm. It looks as if" T ,BUCK ", has changed position.">)>
		<RTRUE>) 
	       (<VERB? TURN>
		<COND (<NOT ,PRSI>
		       <TELL "Next time, say which direction to turn it." CR>)
		      (<NOT <PRSI? ,INTDIR>>
		       <RFALSE>)
		      (<EQUAL? ,P-DIRECTION ,BUCK-DIR>
		       <ITS-ALREADY "turned that way">)
		      (T
		       <SETG BUCK-DIR ,P-DIRECTION>
		       <SETG BUCK-TURNED? T>
		       <COND (<AND <EQUAL? ,STEPS-THROUGH-BUCK 0>
				   <EQUAL? ,P-DIRECTION ,P?WEST>>
			      <SETG STEPS-THROUGH-BUCK 1>)
			     (<AND <EQUAL? ,STEPS-THROUGH-BUCK 1>
				   <EQUAL? ,P-DIRECTION ,P?EAST>>
			      <SETG STEPS-THROUGH-BUCK 2>)
			     (<AND <EQUAL? ,STEPS-THROUGH-BUCK 2>
				   <EQUAL? ,P-DIRECTION ,P?NORTH>>
			      <SETG STEPS-THROUGH-BUCK 3>)
			     (T
			      <SETG STEPS-THROUGH-BUCK 0>)>
		       <TELL "You turn" T ,BUCK ", to the ">
		       <SAY-BUCK-DIR>
		       <COND (<EQUAL? ,STEPS-THROUGH-BUCK 3>
			      <TELL ", and hear a click from off to the north">
			      <FCLEAR ,OAK-DOOR ,LOCKEDBIT>)>
		       <TELL "." CR>)>)
	        (<VERB? EXAMINE>
		 <TELL
"It's pretty much what you would expect of a sculpture of Buck Palace.
One hand is holding a pair of Uzi machine guns and his other hand is
gripping a bazooka on his shoulder which he is pointing ">
                 <SAY-BUCK-DIR>
                 <TELL
". Several belts of ammunition crisscross his half-naked chest. He's
wearing a double belt of grenades around his waist, and has a high-powered
rifle stuck in one of his combat boots and a bayonet between his teeth.
Of course Buck Palace, the fighting letter carrier, would not be complete
without his government-issue mailbag over his shoulder. The statue is on
a round, rotating pedestal, encircled by a compass rose." CR>)
		(<VERB? PUSH MOVE>
		 <TELL
"The " D ,BUCK " turns slightly, then twists back with the bazooka pointing ">
		 <SAY-BUCK-DIR>
		 <TELL "." CR>)>> 

<ROUTINE SAY-BUCK-DIR ()
	 <COND (<EQUAL? ,BUCK-DIR ,P?NORTH <>>
		<SETG BUCK-DIR ,P?NORTH>
		<TELL "north">)
	       (<EQUAL? ,BUCK-DIR ,P?EAST>
		<TELL "east">)
	       (<EQUAL? ,BUCK-DIR ,P?SOUTH>
		<TELL "south">)
	       (<EQUAL? ,BUCK-DIR ,P?WEST>
		<TELL "west">)
	       (<EQUAL? ,BUCK-DIR ,P?NE>
		<TELL "northeast">)
	       (<EQUAL? ,BUCK-DIR ,P?NW>
		<TELL "northwest">)
	       (<EQUAL? ,BUCK-DIR ,P?SE>
		<TELL "southeast">)
	       (<EQUAL? ,BUCK-DIR ,P?SW>
		<TELL "southwest">)>>

<OBJECT FLASHLIGHT
	(IN PLAYER)
	(SYNONYM FLASHLIGHT LIGHT TORCH LAMP)
	(ADJECTIVE FLASH)
	(DESC "flashlight")
	(FLAGS TAKEBIT LIGHTBIT) 
	(SIZE 5)
	(ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,FLASHLIGHT ,WETBIT>
		       <TELL 
"The soggy flashlight is switched on, but isn't working." CR>)
		      (T
         	       <TELL
"The rugged-looking " D ,FLASHLIGHT " is turned ">
         	       <COND (<FSET? ,FLASHLIGHT ,ONBIT>
			      <TELL "on">)
	       		     (T
			      <TELL "off">)>
		       <TELL "." CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,FLASHLIGHT ,WETBIT>
		       <TELL
"You turn it on, but nothing happens!" CR>
		       <RTRUE>)>)
	       (<VERB? OPEN>
		<TELL
"I'll bet you were the kind of kid who always took their toys apart." CR>)>>

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
		<DO-WALK ,P?DOWN>)
	       (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>


"--- Inside House ---"
"--- Foyer ---"

<ROOM FOYER
      (IN ROOMS)
      (DESC "Foyer")
      (SOUTH TO FRONT-PORCH IF OAK-DOOR IS OPEN)
      (IN PER FOYER-CLOSET-ENTER-F)
      (EAST TO OUTSIDE-PARLOR)
      (UP PER TO-UPSTAIRS-HALL-MIDDLE)
      (NORTH TO GAME-ROOM)
      (WEST TO LIVING-ROOM)
      (FLAGS RLANDBIT LOCKEDBIT)
      (GLOBAL OAK-DOOR FOYER-CD CLOSET-REF FOYER-STAIRS WINDOW)
      (CAPACITY 20) ;"Tell--sun coming up"
      (ACTION FOYER-F)>   

<ROUTINE FOYER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is the elegant foyer, covered in rich mahogany paneling. Your
footsteps echo sharply in this large, hollow space. A broad, graceful
staircase sweeps upstairs. Pillared archways beckon you east, west and
north. The front door to the south is ">
		<COND (<FSET? ,OAK-DOOR ,OPENBIT>
		       <TELL "open" >)
		      (T
		       <TELL "closed">)>
		<TELL
". There is a coat closet by the front door. The door to the closet is ">
		<COND (<FSET? ,FOYER-CD ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ".">)>>

<OBJECT FOYER-CD
	(IN LOCAL-GLOBALS)
	(DESC "closet door")
        (SYNONYM DOOR)
	(ADJECTIVE CLOSET)
        (FLAGS DOORBIT NDESCBIT)
	(GENERIC WHICH-DOOR?)
	(ACTION FOYER-CD-F)>

<ROUTINE FOYER-CD-F () 
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,FOYER-CD ,OPENBIT>>
		     <NOT <EQUAL? ,CLOSET-FLOOR ,FOYER>>
		     <EQUAL? ,HERE ,FOYER>>
		<OPEN-DOOR-TO-SHAFT>
		<FSET ,FOYER-CD ,OPENBIT>)>>  ;"SEM"?

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
		<TELL "The stairs are made of rich mahogany and lead ">
		<COND (<EQUAL? ,HERE ,FOYER>
		       <TELL "up">)
		      (T
		       <TELL "down">)>
		<TELL "." CR>)
	       (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN SKI>
		<DO-WALK ,P?DOWN>)>>

<ROUTINE TO-UPSTAIRS-HALL-MIDDLE ()
         <COND (<NOT <FSET? ,NEWEL ,NEWEL-TURNED-BIT>>
		<TELL
"You start to go up, but suddenly the staircase flattens out. After you
awkwardly slide back down, the flattened stairs return to normal." CR>
	        <RFALSE>)
               (T 
                <TELL "You climb up the stairs to the..." CR CR>
                <RETURN ,UPSTAIRS-HALL-MIDDLE>)>>

<OBJECT NEWEL
	(IN UPSTAIRS-HALL-MIDDLE)
	(DESC "newel in the shape of Roger Corman's head")
	(SYNONYM NEWEL HEAD ROGER CORMAN)
	(FLAGS NDESCBIT)
	(ACTION NEWEL-F)>

<ROUTINE NEWEL-F ()
	 <COND (<VERB? TURN>
		<COND (<FSET? ,NEWEL ,NEWEL-TURNED-BIT>
		       <FCLEAR ,NEWEL ,NEWEL-TURNED-BIT>)
		      (T
		       <FSET ,NEWEL ,NEWEL-TURNED-BIT>)>;"stairs don't flatten"
		<TELL
"You turn" T ,NEWEL " and hear a click from the staircase." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It's a life-size, wooden replica of the head of one of Uncle Buddy's rivals,
Roger Corman." CR>)>>

<GLOBAL CLOSET-FLOOR FOYER>                                ;"starts at foyer-2"

<ROUTINE FOYER-CLOSET-ENTER-F ()
	 <COND (<NOT <FSET? ,FOYER-CD ,OPENBIT>>
		<ITS-CLOSED ,FOYER-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,FOYER>
		<RETURN ,CLOSET>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CLOSET-TOP>)
	       (T
		<TELL
"You enter the shaft and plunge down a floor. A bit shaken, you
find yourself at..." CR CR>
		<RETURN ,SHAFT-BOTTOM>)>>

;<JIGS-UP
"You step into the shaft and plunge down a floor, landing on your back
at the bottom of the shaft. As you lie in the shaft bottom regaining
your wits, you hear a humming noise coming from above. Suddenly you
realize it's the closet you were expecting descending, assuring you a
closed-casket service.">;<RFALSE>;"check for light or candle and blow it out"

;<OBJECT ARMOR
	(IN FOYER)
	(DESC "suit of armor")
	(SYNONYM SUIT ARMOR)
	(ADJECTIVE METAL STEEL)
	(FLAGS TRYTAKEBIT)
	(DESCFCN ARMOR-F)
	(ACTION ARMOR-F)>

;<ROUTINE ARMOR-F ("OPTIONAL" (OARG <>))
	  <COND (.OARG
		 <COND (<EQUAL? .OARG ,M-OBJDESC?>
			<RTRUE>)>
		 <TELL CR
"Standing demurely in the corner is a suit of armor, somewhat reminiscent
of the suits of armor that once graced the castle of Winston Churchill.
It is currently in the position that Masters and Johnson described as "
<GET ,ARMOR-DESCS ,ARMOR-DESC-NUM> ".">)
		(<VERB? EXAMINE>
		 <ARMOR-F ,M-OBJDESC>
		 <CRLF>)>>

;<GLOBAL ARMOR-DESC-NUM 0>

;<ROUTINE I-ARMOR-MOVE ()
	 <COND (<EQUAL? ,HERE ,FOYER>
	        <QUEUE I-ARMOR-MOVE 2>)
	       (T
		<SETG ARMOR-DESC-NUM <+ ,ARMOR-DESC-NUM 1>>
                <COND (<EQUAL? ,ARMOR-DESC-NUM 7>
		       <SETG ARMOR-DESC-NUM 0>)>)>
	 <RFALSE>>

;<GLOBAL ARMOR-DESCS
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
      (IN PER CELLAR-CLOSET-ENTER-F)
      (SOUTH PER CELLAR-CLOSET-ENTER-F)
      (UP TO KITCHEN)
      (GLOBAL STAIRS CELLAR-CD CLOSET-REF)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (THINGS <PSEUDO (<> CELLAR CELLAR-PSEUDO)>)
      (FLAGS RLANDBIT)
      (ACTION CELLAR-F)>

<ROUTINE CELLAR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a musty cellar. One of Uncle Buddy's old movie props, a
huge, over-teched " D ,COMPUTER " is here. There is a">
		<COND (<FSET? ,CELLAR-CD ,OPENBIT>
		       <TELL "n open">)
		      (T
		       <TELL " closed">)>
		<TELL " closet door to the south. A staircase leads up.">)>>

<ROUTINE CELLAR-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<V-LOOK>)>>

<OBJECT CELLAR-CD
	(IN LOCAL-GLOBALS)
	(DESC "closet door")
        (SYNONYM DOOR)
	(ADJECTIVE CLOSET)
	(FLAGS DOORBIT NDESCBIT)
	(GENERIC WHICH-DOOR?)
	(ACTION CELLAR-CD-F)>

<ROUTINE CELLAR-CD-F () 
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,CELLAR-CD ,OPENBIT>>
		     <NOT <EQUAL? ,CLOSET-FLOOR ,CELLAR>>
		     <EQUAL? ,HERE ,CELLAR>>
		<OPEN-DOOR-TO-SHAFT>
		<FSET ,CELLAR-CD ,OPENBIT>)>>

<ROUTINE CELLAR-CLOSET-ENTER-F ()
     	 <COND (<NOT <FSET? ,CELLAR-CD ,OPENBIT>>
		<ITS-CLOSED ,CELLAR-CD>
	        <RFALSE>)
	       (<EQUAL? ,CLOSET-FLOOR ,CELLAR>
		<RETURN ,CLOSET>)
	       (T
		<TELL "You step down a foot into the..." CR CR>
		<RETURN ,SHAFT-BOTTOM>)>>

"--- Computer ---"

;<OBJECT CONSOLE
	(IN CELLAR)
	(DESC "command console")
	(SYNONYM KEYBOARD CONSOLE)
	(ADJECTIVE COMMAND)
	(FLAGS NDESCBIT)>

<OBJECT DISPLAY-LIGHTS
	(IN CELLAR)
	(DESC "display lights")
	(SYNONYM LIGHTS DISPLAY)	
	(ADJECTIVE COMPUTER)
	(FLAGS NDESCBIT)
	(ACTION DISPLAY-LIGHTS-F)>

<ROUTINE DISPLAY-LIGHTS-F ()
	 <COND (<VERB? EXAMINE READ>
		<COND (<FSET? ,COMPUTER ,ONBIT>
		       <TELL
"You study the display of lights and see:" CR CR>
		       <FIXED-FONT-ON>
		       <TELL
<GET ,DISPLAY-TABLE 0> CR
<GET ,DISPLAY-TABLE 1> CR
<GET ,DISPLAY-TABLE 2> CR
<GET ,DISPLAY-TABLE 3> CR
<GET ,DISPLAY-TABLE 4> CR
<GET ,DISPLAY-TABLE 5> CR
<GET ,DISPLAY-TABLE 6> CR>
		       <FIXED-FONT-OFF>)
		      (T
		       <TELL "The " D ,DISPLAY-LIGHTS " are off." CR>)>)>>

<OBJECT COMPUTER
	(IN CELLAR)
	(DESC "computer")
	(SYNONYM COMPUTER SLOT)
	(FLAGS NDESCBIT LIGHTBIT)
        (ACTION COMPUTER-F)>

<GLOBAL WHERE-TO-PRINT 0>
<GLOBAL CARD-COUNT 0>

<ROUTINE COMPUTER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the huge, massive, steel contraption of" A ,COMPUTER " that saved
the earth from the maurading marketeers in \"Plan Nine from Marketing.\"
The front of" T ,COMPUTER " is covered with rows of lights. Beneath the
lights are a slot and a button. There is a hopper on one end of it.
The " D ,COMPUTER " is ">
		<COND (<FSET? ,COMPUTER ,ONBIT>
		       <TELL "on">)
		      (T
		       <TELL "off">)>
		<TELL "." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,COMPUTER>>
		<COND (<GETPT ,PRSO ,P?CARD-NUM>
		       <COND (<NOT <FSET? ,COMPUTER ,ONBIT>>
			      <TELL ,NO-DATA>)
			     (<FSET? ,PRSO ,WETBIT>
			      <MOVE ,PRSO ,HERE>
			      <TELL
"The " D ,COMPUTER " starts to suck in the wet punch card,
then spits it back out at you." CR>)
			     (T
			      <TELL
"The " D ,COMPUTER " sucks in the card, making a slurping noise">
			      <COND (<IN? ,TOUPEE ,RESET-BUTTON>
				     <TELL
", then begins to rumble like something inside is trying to get out">)>
			      <TELL
". It pauses as if it were thinking about what to do next,
then" T ,DISPLAY-LIGHTS " change." CR>
			      <PUT ,DISPLAY-TABLE ,WHERE-TO-PRINT
				   <GET ,CARD-TABLE <GETP ,PRSO ,P?CARD-NUM>>>
			      <SETG WHERE-TO-PRINT <+ ,WHERE-TO-PRINT 1>>
			      <SETG CARD-COUNT <+ ,CARD-COUNT 1>>
			      <MOVE ,PRSO ,COMPUTER>
			      <COND (<EQUAL? ,CARD-COUNT 7>
				    ;<AND <EQUAL? ,CARD-COUNT 7>
					  <EQUAL? <GET ,DISPLAY-TABLE 0>
						  <GET ,CARD-TABLE 0>>
					  <EQUAL? <GET ,DISPLAY-TABLE 1>
						  <GET ,CARD-TABLE 1>>
					  <EQUAL? <GET ,DISPLAY-TABLE 2>
						  <GET ,CARD-TABLE 2>>
					  <EQUAL? <GET ,DISPLAY-TABLE 3>
						  <GET ,CARD-TABLE 3>>
					  <EQUAL? <GET ,DISPLAY-TABLE 4>
						  <GET ,CARD-TABLE 4>>
					  <EQUAL? <GET ,DISPLAY-TABLE 5>
						  <GET ,CARD-TABLE 5>>
					  <EQUAL? <GET ,DISPLAY-TABLE 6>
						  <GET ,CARD-TABLE 6>>>
				     <FSET ,TOUPEE ,CARDS-RIGHT-BIT>)>
			      <RTRUE>)>)
		      (<EQUAL? <GETP ,PRSO ,P?SIZE> 1>
		       <COND (<FSET? ,COMPUTER ,ONBIT>
			      <TELL
"The " D ,COMPUTER " sucks in" T ,PRSO ", pauses momentarily, then spits out"
T ,PRSO " with a whining noise." CR>
			      <MOVE ,PRSO ,HERE>)
			     (T
			      <TELL ,NO-DATA>)>)
		      (T
		       <TELL
"How are you going to fit" T ,PRSO " in" T ,COMPUTER "'s card slot?" CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,COMPUTER ,ONBIT>
		       <ITS-ALREADY "on">)
		      (T                    ;<NOT <FSET? ,COMPUTER ,ONBIT>>
		       <TELL

"The " D ,COMPUTER"'s machinery begins to roar as you turn it on. The
seven rows of display lights on the front of" T ,COMPUTER " flash on and
off in unison several times as it comes to life." CR>
		<FSET ,COMPUTER ,ONBIT>
		<FSET ,CELLAR ,ONBIT>)>)
	       (<AND <VERB? LAMP-OFF>
		     <FSET? ,COMPUTER ,ONBIT>>
		<TELL
"The " D ,COMPUTER " winds down slowly coming to a stop and the lights of
the display dim and go out. ">
		<RESET-COMPUTER>
		<FCLEAR ,CELLAR ,ONBIT> ;"SEM?"
		<FCLEAR ,COMPUTER ,ONBIT>)
	       (<VERB? RESET>
		<PERFORM ,V?PUSH ,RESET-BUTTON>
		<RTRUE>)
	      ;(<VERB? LOOK-INSIDE OPEN>
		<TELL "That's a job for the DEC twits." CR>)>>

<GLOBAL NO-DATA "You can't feed data to a computer that isn't turned on!~">

<ROUTINE RESET-COMPUTER ()
	 <COND (<FIRST? ,COMPUTER>
		<COND (<EQUAL? ,CARD-COUNT 1>
		       <TELL "A punch card drops">)
		      (T
		       <COND (<L? ,CARD-COUNT 3>
			      <TELL "A couple of">)
			     (<L? ,CARD-COUNT 4>
			      <TELL "A few">)
			     (<L? ,CARD-COUNT 8>
			      <TELL "Some">)>
		       <TELL " punch cards drop">)>
		<TELL " into" T ,HOPPER "." CR>)
	       (T
		<CRLF>)>
	 <SETG WHERE-TO-PRINT 0>
	 <ROB ,COMPUTER ,HOPPER>
	 <SETG CARD-COUNT 0>
	 <PUT ,DISPLAY-TABLE 0 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 1 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 2 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 3 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 4 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 5 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 6 ,COMPUTER-LIGHTS>>

<OBJECT RESET-BUTTON
	(IN CELLAR)
        (DESC "reset button")
	(SYNONYM BUTTON)
	(ADJECTIVE RESET)
	(FLAGS NDESCBIT)
	(ACTION RESET-BUTTON-F)>

<ROUTINE RESET-BUTTON-F ()
	 <COND (<VERB? PUSH>
		<COND (<FSET? ,COMPUTER ,ONBIT>
		       <TELL
"All" T ,DISPLAY-LIGHTS " flash off and on several times. ">
		       <RESET-COMPUTER>)
                      (T                       ;"meaning the computer isn't on"
		       <TELL "You hear a click, but that's all." CR>)>)
		(<VERB? EXAMINE>
		 <TELL "It's a small button labeled \"Reset.\"" CR>)>>

<OBJECT CARD
	(IN MAILBOX)
	(DESC "business card")
	(SYNONYM CARD)
	(ADJECTIVE BUSINESS)
	(SIZE 1)
	(FLAGS READBIT TAKEBIT)
	(TEXT
"~
  For fast service, call~
~
        ROY G. BIV~
 COMPUTER SERVICE & REPAIR~
         576-1851")>

<OBJECT HOPPER
        (IN CELLAR)
	(DESC "hopper")
	(SYNONYM HOPPER)
	(ADJECTIVE CARD PUNCH)
	(CAPACITY 8) 
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)>

<GLOBAL COMPUTER-LIGHTS "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO">

;<ROUTINE RESET-DISPLAY ()
	 <SETG WHERE-TO-PRINT 0>
	 <ROB ,COMPUTER ,HOPPER>
	 <SETG CARD-COUNT 0>
	 <PUT ,DISPLAY-TABLE 0 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 1 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 2 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 3 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 4 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 5 ,COMPUTER-LIGHTS>
	 <PUT ,DISPLAY-TABLE 6 ,COMPUTER-LIGHTS>> 

<GLOBAL CARD-TABLE
        <TABLE
;"0 Red   " "OOOO OOOO O        OOOO    O OOOO OOOO"
;"1 Orange" "O       O O           O    O O  O O  O"
;"2 Yellow" "O       O O           O    O O  O O  O"
;"3 Green " "OOOO    O OOOO OOO OOOO    O OOOO O  O"  
;"4 Blue  " "   O    O O  O        O    O    O O  O"
;"5 Indigo" "   O    O O  O        O    O    O O  O"
;"6 Violet" "OOOO    O OOOO     OOOO    O    O OOOO">>
           ;"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
<GLOBAL DISPLAY-TABLE
        <TABLE
;"0" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"  
;"1" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
;"2" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
;"3" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
;"4" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
;"5" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
;"6" "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO">>

<OBJECT TOUPEE
	(IN RESET-BUTTON)  ;"so you can check it's LOC to see if it's untaken"
        (DESC "Uncle Buddy's toupee")
	(SYNONYM TOUPEE RUG HAIR PIECE)
	(ADJECTIVE BUDDY BURBAN HAIR)
	(FLAGS TAKEBIT WEARBIT NARTICLEBIT)
	(SIZE 5)
	(VALUE 10)
	(ACTION TOUPEE-F)>

<ROUTINE TOUPEE-F ()
         <COND (<VERB? EXAMINE>
                <TELL
"Ah, ahem, well, it looks like Uncle Buddy's toupee. One of the worst
kept secrets in Hollywood." CR>)
	      ;(<VERB? WEAR>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)
		      (T
		       <TELL
"You put on " D ,TOUPEE " in an attempt to cover that Burbank bald
spot." CR>
		<RFALSE>)>)
	       (<VERB? ROLL-UP>
		<TELL "Now come on, it's not that kind of a rug!" CR>)>>

<OBJECT INDIGO-CARD
        (IN FIREPLACE)
	(DESC "indigo punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH INDIGO)
	(FLAGS TAKEBIT VOWELBIT INVISIBLE)
	(SIZE 1)
	(CARD-NUM 5)
	(ACTION PUNCH-CARD-F)>

<OBJECT YELLOW-CARD
	(IN SCREENING-ROOM)
	(DESC "yellow punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH YELLOW CARDS)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(CARD-NUM 2)
	(ACTION PUNCH-CARD-F)>

<OBJECT GREEN-CARD
	(IN OUTSIDE-PARLOR)
	(DESC "green punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH GREEN)
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 1)
	(CARD-NUM 3)
	(ACTION PUNCH-CARD-F)>

<OBJECT RED-CARD
	(IN UPSTAIRS-BATHROOM)
	(DESC "red punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH RED)
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 1)
	(CARD-NUM 0)
	(ACTION PUNCH-CARD-F)>

<OBJECT BLUE-CARD
	;(IN BEDROOM-3)
	(IN SHAFT-BOTTOM)
	(DESC "blue punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH BLUE)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(CARD-NUM 4)
	(ACTION PUNCH-CARD-F)>

<OBJECT ORANGE-CARD
	(IN PATIO)
	(DESC "orange punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH ORANGE CARDS)
	(FLAGS TAKEBIT VOWELBIT)
	(SIZE 1)
	(CARD-NUM 1)
	(ACTION PUNCH-CARD-F)>

<OBJECT VIOLET-CARD
        (IN PIANO)
        (DESC "violet punch card")
	(SYNONYM CARD CARDS)
	(ADJECTIVE PUNCH VIOLET)
        (FLAGS TAKEBIT)
	(SIZE 1)
	(CARD-NUM 6)
	(ACTION PUNCH-CARD-F)>

<ROUTINE PUNCH-CARD-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The surface of" T ,PRSO " is covered with holes">
	        <COND (<FSET? ,PRSO ,WETBIT>
		       <TELL " and it's rather soggy">)>
		<TELL "." CR>)
	       (<VERB? READ>
		<TELL "Only a computer can read a punch card!" CR>)>>


"--- Living room ---"

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (LDESC

"This is the living room where Uncle Buddy and Aunt Hildegarde used to
spend their evenings. Most of the west wall is covered by a grand stone
fireplace with a mantle over it. A long sofa, several cushy chairs and a
telephone fill the room. Most of the hardwood floor is covered by a
monstrous Persian rug. A doorway leads north and an archway exits to the
east.")
      (FLAGS RLANDBIT ;LOCKEDBIT)
      (NORTH TO DINING-ROOM) 
      (EAST TO FOYER)
      (IN TO FIREPLACE)
      (WEST "If you want to go in the fireplace, say so.")
      (GLOBAL PHONE FIREPLACE-GLOBAL SEAT WINDOW SOFA)
      (CAPACITY 20)> ;"Tell--sun coming up"

<OBJECT PERSIAN-RUG
	(IN LIVING-ROOM)
	(DESC "Persian rug")
	(SYNONYM RUG CARPET)
        (ADJECTIVE PERSIAN)
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION PERSIAN-RUG-F)>

<ROUTINE PERSIAN-RUG-F ()
	 <COND (<VERB? TAKE>
		<TELL ,SPINACH CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,PERSIAN-RUG>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? ROLL-UP MOVE LOOK-UNDER>
	        <TELL
"You move the rug but don't find any trap door. Amidst your sorrow you return
the carpet to its original splendor." CR>)>>

<OBJECT MANTLE
	(IN LIVING-ROOM)
	(DESC "mantle")
	(SYNONYM MANTLE)
	(FLAGS CONTBIT SEARCHBIT OPENBIT SURFACEBIT NDESCBIT)
	(CAPACITY 60)>

"--- Statuettes ---"

<OBJECT BLUE-CANDLE
	(IN MANTLE)
	(DESC "blue wax statuette")
	(SYNONYM CANDLE STATUE WICK)
	(ADJECTIVE WAX BLUE)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT BURNBIT)
	(CAPACITY 1)
	(SIZE 10)
	(GENERIC GENERIC-CANDLE-F)
        (ACTION BLUE-CANDLE-F)>

<ROUTINE BLUE-CANDLE-F ()
	 <CANDLE-F ,BLUE-CANDLE>>

<OBJECT WHITE-CANDLE
	(IN MANTLE)
	(DESC "white wax statuette")
	(SYNONYM CANDLE STATUE WICK)
	(ADJECTIVE WAX WHITE)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT BURNBIT)
	(CAPACITY 1)
	(SIZE 10)
	(GENERIC GENERIC-CANDLE-F)
	(ACTION WHITE-CANDLE-F)>

<ROUTINE WHITE-CANDLE-F ()
	 <CANDLE-F ,WHITE-CANDLE>>

<OBJECT RED-CANDLE
	(IN MANTLE)
	(DESC "red wax statuette")
	(SYNONYM CANDLE STATUE WICK)
	(ADJECTIVE WAX RED)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT BURNBIT)
	(CAPACITY 1)
	(SIZE 10)
	(GENERIC GENERIC-CANDLE-F)
        (ACTION RED-CANDLE-F)>

<ROUTINE RED-CANDLE-F ()
	 <CANDLE-F ,RED-CANDLE>>

<ROUTINE GENERIC-CANDLE-F ("AUX" NUM LIT-CANDLE)
	 <COND (<VERB? LAMP-OFF>
		<SET NUM 0>
		<COND (<AND <FSET? ,RED-CANDLE ,FLAMEBIT>
			    <VISIBLE? ,RED-CANDLE>>
		       <SET NUM <+ .NUM 1>>
		       <SET LIT-CANDLE ,RED-CANDLE>)
		      (<AND <FSET? ,WHITE-CANDLE ,FLAMEBIT>
			    <VISIBLE? ,WHITE-CANDLE>>
		       <SET NUM <+ .NUM 1>>
		       <SET LIT-CANDLE ,WHITE-CANDLE>)
		      (<AND <FSET? ,BLUE-CANDLE ,FLAMEBIT>
			    <VISIBLE? ,BLUE-CANDLE>>
		       <SET NUM <+ .NUM 1>>
		       <SET LIT-CANDLE ,BLUE-CANDLE>)>
		<COND (<EQUAL? .NUM 1>
		       <RETURN .LIT-CANDLE>)
		      (T
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<ROUTINE CANDLE-F (CANDLE "AUX" SIZE FEET I-CANDLE CANDLE-WAX)
	 <SET SIZE <GETP ,PRSO ,P?SIZE>>
	 <COND (<EQUAL? .CANDLE ,RED-CANDLE>
		<SET FEET ,RED-FEET>
		<SET I-CANDLE ,I-RED-CANDLE-BURN>
		<SET CANDLE-WAX ,RED-WAX>)
	       (<EQUAL? .CANDLE ,WHITE-CANDLE>
		<SET FEET ,WHITE-FEET>
		<SET I-CANDLE ,I-WHITE-CANDLE-BURN>
		<SET CANDLE-WAX ,WHITE-WAX>)
	       (<EQUAL? .CANDLE ,BLUE-CANDLE>
		<SET FEET ,BLUE-FEET>
		<SET I-CANDLE ,I-BLUE-CANDLE-BURN>
		<SET CANDLE-WAX ,BLUE-WAX>)>
         <COND (<VERB? EXAMINE>
	        <COND (<EQUAL? .SIZE 1>
		       <WAX-FEET .FEET>
		       <RTRUE>)>
		<TELL "It's ">
		<COND (<L? .SIZE 10>
		       <TELL "what's left of ">)>
		<TELL
	      "a thin, wax statuette of a Hindu god, dressed in a long gown. ">
		<COND (<G? .SIZE 7>
		       <TELL "The foot-high god is holding up its ">
		       <COND (<PRSO? ,WHITE-CANDLE>
			      <TELL "lef">)
			     (T
			      <TELL "righ">)>
		       <TELL "t hand, showing ">
		       <COND (<PRSO? ,RED-CANDLE>
			      <TELL "three">)
			     (<PRSO? WHITE-CANDLE>
			      <TELL "seven">)
			     (T
			      <TELL "five">)>
		       <TELL " fingers. ">)>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL
"The wax statuette is lit, and a bit of wax is dripping down it">)
		      (T
		       <COND (<G? .SIZE 1>
			      <TELL "A wick is sticking up from ">
			      <COND (<G? .SIZE 4>
				     <TELL "the top of the statuette">)
				    (T
				     <TELL
                              "the little that remains of the statuette">)>)>)>
		<COND (<AND <L? .SIZE 10>
		            <G? .SIZE 1>>
		       <TELL
                        ". The wax statuette has burned down to the god's "
		       <GET ,CANDLE-DESC .SIZE>>)>
		<TELL "." CR>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? .CANDLE>>
		<TELL "You can't possibly do that." CR>) 
	       (<AND <VERB? LAMP-ON BURN>
		     <PRSO? ,RED-CANDLE ,WHITE-CANDLE ,BLUE-CANDLE>>
		<COND (<SET-FLAME-SOURCE>
		       <RTRUE>)>
		<COND (<FSET? ,PRSI ,FLAMEBIT>
		       <COND (<FSET? ,PRSO ,FLAMEBIT>
			      <TELL "It's already lit." CR>)
			     (<EQUAL? .SIZE 1>
			      <TELL "It's all used up. ">
			      <WAX-FEET .FEET>)
			     (T
			      <FSET ,PRSO ,ONBIT>
			      <FSET ,PRSO ,FLAMEBIT>
			      <FCLEAR ,PRSO ,NDESCBIT> ;"SEM?"
			      <QUEUE .I-CANDLE -1>
			      <MOVE .CANDLE-WAX .CANDLE>
		              <TELL 
"You light" T ,PRSO " and a bit of wax begins to dribble down the god." CR>)>)
		      (<PRSI? ,RED-MATCH ,GREEN-MATCH ,RED-CANDLE
			      ,BLUE-CANDLE ,WHITE-CANDLE>
		       <TELL "But" T ,PRSI "'s not lit!" CR>)>)
	       (<VERB? LAMP-OFF>
		       <COND (<FSET? ,PRSO ,ONBIT>
		              <BLOW-OUT-CANDLE .CANDLE>)
	                     (T
		              <TELL "The wax god isn't lit." CR>
	                      <RTRUE>)>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)
	       (<VERB? TAKE>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RFALSE>)>>

;<TELL "The candle has burned down to the god's ">

<GLOBAL CANDLE-DESC <TABLE
0
 ;"1" "ankle"
 ;"2" "shins"
 ;"3" "knees"
 ;"4" "thighs"
 ;"5" "waist"
 ;"6" "stomach"
 ;"7" "chest"
 ;"8" "shoulders"
 ;"9" "forehead">>

<ROUTINE CANDLE-BURN (CANDLE FEET I-CANDLE "AUX" SIZE)
       	 <PUTP .CANDLE ,P?SIZE <- <GETP .CANDLE ,P?SIZE> 1>>
	 <SET SIZE <GETP .CANDLE ,P?SIZE>>
	 <COND (<EQUAL? .SIZE 1>
		<COND (<VISIBLE? .CANDLE>
		       <CRLF>)>
		<MOVE .FEET <LOC .CANDLE>>
		<BLOW-OUT-CANDLE .CANDLE>
	       ;<WAX-FEET .FEET>
		<REMOVE .CANDLE>
		<DEQUEUE .I-CANDLE>)>
	 <COND (<EQUAL? .SIZE 2>
		<COND (<EQUAL? .CANDLE ,RED-CANDLE>
		       <QUEUE I-RED-ALMOST-OUT 5>)
		      (<EQUAL? .CANDLE ,WHITE-CANDLE>
		       <QUEUE I-WHITE-ALMOST-OUT 5>)
		      (<EQUAL? .CANDLE ,BLUE-CANDLE>
		       <QUEUE I-BLUE-ALMOST-OUT 5>)>)>
	 <COND (<NOT <ACCESSIBLE? .CANDLE>>
		<RFALSE>)
	       (<EQUAL? .SIZE 8 6 4 2>
		<TELL CR
		      "The " D .CANDLE " has burned down to the god's "
		      <GET ,CANDLE-DESC .SIZE> "." CR>)>>

<ROUTINE I-RED-ALMOST-OUT ()
	 <QUEUE I-RED-NEARLY-OUT 2>
	 <COND (<ACCESSIBLE? ,RED-CANDLE>
		<TELL CR "The " D ,RED-CANDLE " is almost out!" CR>)>>

<ROUTINE I-WHITE-ALMOST-OUT ()
	 <QUEUE I-WHITE-NEARLY-OUT 2>
	 <COND (<ACCESSIBLE? ,WHITE-CANDLE>
		<TELL CR "The " D ,WHITE-CANDLE " is almost out!" CR>)>>

<ROUTINE I-BLUE-ALMOST-OUT ()
	 <QUEUE I-BLUE-NEARLY-OUT 2>
	 <COND (<ACCESSIBLE? ,BLUE-CANDLE>
		<TELL CR "The " D ,BLUE-CANDLE " is almost out!" CR>)>>

<ROUTINE I-RED-NEARLY-OUT ()
	 <COND (<ACCESSIBLE? ,RED-CANDLE>
		<TELL CR "The " D ,RED-CANDLE " is nearly out!" CR>)>>

<ROUTINE I-WHITE-NEARLY-OUT ()
	 <COND (<ACCESSIBLE? ,WHITE-CANDLE>
                <TELL CR "The " D ,WHITE-CANDLE " is nearly out!" CR>)>>

<ROUTINE I-BLUE-NEARLY-OUT ()
	 <COND (<ACCESSIBLE? ,BLUE-CANDLE>
                <TELL CR "The " D ,BLUE-CANDLE " is nearly out!" CR>)>>

<ROUTINE I-RED-CANDLE-BURN ()
	 <QUEUE I-RED-CANDLE-BURN
		<COND (,RED-MID-BURN
		       ,RED-MID-BURN)
		      (ELSE 10)>>
	 <SETG RED-MID-BURN <>>
	 <CANDLE-BURN ,RED-CANDLE ,RED-FEET ,I-RED-CANDLE-BURN>>
	
<ROUTINE I-WHITE-CANDLE-BURN ()
	 <QUEUE I-WHITE-CANDLE-BURN
		<COND (,WHITE-MID-BURN
		       ,WHITE-MID-BURN)
		      (ELSE 10)>>
	 <SETG WHITE-MID-BURN <>>
	 <CANDLE-BURN ,WHITE-CANDLE ,WHITE-FEET ,I-WHITE-CANDLE-BURN>>

<ROUTINE I-BLUE-CANDLE-BURN ()
	 <QUEUE I-BLUE-CANDLE-BURN
		<COND (,BLUE-MID-BURN
		       ,BLUE-MID-BURN)
		      (ELSE 10)>>
	 <SETG BLUE-MID-BURN <>>
	 <CANDLE-BURN ,BLUE-CANDLE ,BLUE-FEET ,I-BLUE-CANDLE-BURN>>

<OBJECT RED-FEET
	(DESC "pair of red wax feet")
	(SYNONYM FEET CANDLE)
	(ADJECTIVE RED WAX PAIR)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION FEET-F)>

<OBJECT WHITE-FEET
	(DESC "pair of white wax feet")
	(SYNONYM FEET CANDLE)
	(ADJECTIVE WHITE WAX PAIR)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION FEET-F)>

<OBJECT BLUE-FEET
	(DESC "pair of blue wax feet")
	(SYNONYM FEET CANDLE)
	(ADJECTIVE BLUE WAX PAIR)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION FEET-F)>

<ROUTINE FEET-F ()
	 <COND (<VERB? LAMP-ON BURN>
		<TELL "They're just wax. You can't light them." CR>)>> 

<GLOBAL RED-MID-BURN <>>
<GLOBAL WHITE-MID-BURN <>>
<GLOBAL BLUE-MID-BURN <>>

<ROUTINE BLOW-OUT-CANDLE (CANDLE "OPTIONAL" (DONT-TELL <>) "AUX" C FEET)
	 <FCLEAR .CANDLE ,ONBIT>
         <FCLEAR .CANDLE ,FLAMEBIT>
	 <COND (<EQUAL? .CANDLE ,RED-CANDLE>
		<SET FEET ,RED-FEET>
		<COND (<SET C <QUEUED? I-RED-CANDLE-BURN>>
		       <SETG RED-MID-BURN <GET .C ,C-TICK>>)
		      (ELSE <SETG RED-MID-BURN <>>)>
		<STOP-RED-BURNING>)          ;"dequeues 3 interupts for candle"
	       (<EQUAL? .CANDLE ,WHITE-CANDLE>
		<SET FEET ,WHITE-FEET>
		<COND (<SET C <QUEUED? I-WHITE-CANDLE-BURN>>
		       <SETG WHITE-MID-BURN <GET .C ,C-TICK>>)
		      (ELSE <SETG WHITE-MID-BURN <>>)>
		<STOP-WHITE-BURNING>)        ;"dequeues 3 interupts for candle"
	       (<EQUAL? .CANDLE ,BLUE-CANDLE>
		<SET FEET ,BLUE-FEET>
		<COND (<SET C <QUEUED? I-BLUE-CANDLE-BURN>>
		       <SETG BLUE-MID-BURN <GET .C ,C-TICK>>)
		      (ELSE <SETG BLUE-MID-BURN <>>)>
		<STOP-BLUE-BURNING>)>       ;"dequeues 3 interupts for candle"
	 <COND (<AND <NOT .DONT-TELL>
		     <ACCESSIBLE? .CANDLE>>
                <TELL "The " D .CANDLE " goes out.">
		<COND (<EQUAL? <GETP .CANDLE ,P?SIZE> 1>
		       <TELL " ">
		       <WAX-FEET .FEET>)
		      (<EQUAL? ,PRSI ,POND>
		       <RTRUE>) ;"so there it no cr from this routine"
		      (T
		       <CRLF>)>)>
	 <SAY-IF-NOT-LIT>
	 <RTRUE>>

<ROUTINE WAX-FEET (FEET)
	 <COND (<ACCESSIBLE? .FEET>
		<TELL "There's nothing left but" A .FEET "." CR>)>>

<ROUTINE STOP-RED-BURNING ()
	 <DEQUEUE I-RED-CANDLE-BURN>
	 <DEQUEUE I-RED-ALMOST-OUT>
	 <DEQUEUE I-RED-NEARLY-OUT>>

<ROUTINE STOP-WHITE-BURNING ()
	 <DEQUEUE I-WHITE-CANDLE-BURN>
	 <DEQUEUE I-WHITE-ALMOST-OUT>
	 <DEQUEUE I-WHITE-NEARLY-OUT>>

<ROUTINE STOP-BLUE-BURNING ()
	 <DEQUEUE I-BLUE-CANDLE-BURN>
	 <DEQUEUE I-BLUE-ALMOST-OUT>
	 <DEQUEUE I-BLUE-NEARLY-OUT>>

<OBJECT RED-WAX
	(IN RED-CANDLE)
	(DESC "red candle wax")
	(SYNONYM WAX)
	(ADJECTIVE RED CANDLE MELTED)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WAX-F)
        (SIZE 1)
	(ACTION WAX-F)>

<OBJECT WHITE-WAX
	(IN WHITE-CANDLE)
	(DESC "white candle wax")
	(SYNONYM WAX)
	(ADJECTIVE WHITE CANDLE MELTED)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WAX-F)
        (SIZE 1)
	(ACTION WAX-F)>

<OBJECT BLUE-WAX
	(IN BLUE-CANDLE)
	(DESC "blue candle wax")
	(SYNONYM WAX)
	(ADJECTIVE BLUE CANDLE MELTED)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-WAX-F)
        (SIZE 1)
	(ACTION WAX-F)>

<ROUTINE GENERIC-WAX-F ("AUX" (RED-HERE <>) (BLUE-HERE <>) (WHITE-HERE <>))
	 <COND (<AND <VERB? SCRAPE-OFF>
		     ;,PRSI  ;"PRSI isn't set when GENERIC is called for PRSO!"
		     ;<FSET? ,PRSI ,WAXED-BIT>>
		<COND (<VISIBLE? ,WAX-COAT-1>
		       ;<IN? ,WAX-COAT-1 ,PRSI>
		       <RETURN ,WAX-COAT-1>)
		      (<VISIBLE? ,WAX-COAT-2>
		       ;<IN? ,WAX-COAT-2 ,PRSI>
		       <RETURN ,WAX-COAT-2>)
		      (T
		       <RFALSE>)>)>
	 <COND (<AND <FSET? ,RED-CANDLE ,ONBIT>
		     <VISIBLE? ,RED-CANDLE>>
		<SET RED-HERE T>)
	       (<AND <FSET? ,WHITE-CANDLE ,ONBIT>
		     <VISIBLE? ,WHITE-CANDLE>>
		<SET WHITE-HERE T>)
	       (<AND <FSET? ,BLUE-CANDLE ,ONBIT>
		     <VISIBLE? ,BLUE-CANDLE>>
		<SET BLUE-HERE T>)>
	 <COND (<AND .BLUE-HERE
		     <NOT .RED-HERE>
		     <NOT .WHITE-HERE>>
		<RETURN ,BLUE-WAX>)
	       (<AND .RED-HERE
		     <NOT .BLUE-HERE>
		     <NOT .WHITE-HERE>>
		<RETURN ,RED-WAX>)
	       (<AND .WHITE-HERE
		     <NOT .BLUE-HERE>
		     <NOT .RED-HERE>>
		<RETURN ,WHITE-WAX>)
	       (T
		<RFALSE>)>>

<ROUTINE WAX-F ()
	 <COND (<AND <PRSO? ,RED-WAX>
		     <NOT <FSET? ,RED-CANDLE ,FLAMEBIT>>>
		<COND (<VERB? POUR PUT-ON>
		       <TELL "The " D ,PRSO " is not lit." CR>)
		      (ELSE
		       <PERFORM ,PRSA ,RED-CANDLE ,PRSI>
		       <RTRUE>)>)
	       (<AND <PRSI? ,RED-WAX>
		     <NOT <FSET? ,RED-CANDLE ,FLAMEBIT>>>
		<PERFORM ,PRSA ,PRSO ,RED-CANDLE>
		<RTRUE>)	       
	       (<AND <PRSO? ,WHITE-WAX>
		     <NOT <FSET? ,WHITE-CANDLE ,FLAMEBIT>>>
		<COND (<VERB? POUR PUT-ON>
		       <TELL "The " D ,PRSO " is not lit." CR>)
		      (ELSE
		       <PERFORM ,PRSA ,WHITE-CANDLE ,PRSI>
		       <RTRUE>)>)
	       (<AND <PRSI? ,WHITE-WAX>
		     <NOT <FSET? ,WHITE-CANDLE ,FLAMEBIT>>>
		<PERFORM ,PRSA ,PRSO ,WHITE-CANDLE>
		<RTRUE>)
	       (<AND <PRSO? ,BLUE-WAX>
		     <NOT <FSET? ,BLUE-CANDLE ,FLAMEBIT>>>
		<COND (<VERB? POUR PUT-ON>
		       <TELL "The " D ,PRSO " is not lit." CR>)
		      (ELSE
		       <PERFORM ,PRSA ,BLUE-CANDLE ,PRSI>
		       <RTRUE>)>)
	       (<AND <PRSI? ,BLUE-WAX>
		     <NOT <FSET? ,BLUE-CANDLE ,FLAMEBIT>>>
		<PERFORM ,PRSA ,PRSO ,BLUE-CANDLE>
		<RTRUE>)
	       (<VERB? TAKE RUB>
		<TELL "You'd burn your fingers." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,RED-WAX ,WHITE-WAX ,BLUE-WAX>>
		<PERFORM ,V?PUT-ON ,PRSI ,PRSO>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <PRSO? ,RED-WAX ,WHITE-WAX ,BLUE-WAX>>
		<PERFORM ,V?PUT-ON ,PRSO ,PRSI>
		<RTRUE>)
	       (<VERB? DROP>
		<TELL "Huh?" CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,WHITE-WAX ,RED-WAX ,BLUE-WAX>>
		<COND (<FSET? ,PRSI ,WAXED-BIT>
		       <YOU-ALREADY>)
		      (<FSET? ,PRSI ,FLAMEBIT>
		       <TELL ,YOU-CANT "put wax on it while it's burning." CR>)
		      (<PRSI? ,RED-MATCH ,GREEN-MATCH>
		       <FSET ,PRSI ,WAXED-BIT>
		       <COND (<LOC ,WAX-COAT-1>
			      <MOVE ,WAX-COAT-2 ,PRSI>)
			     (T
			      <MOVE ,WAX-COAT-1 ,PRSI>)>
		       <TELL
"The match head is now covered with a thin coating of candle wax." CR>)
		      (T
		       <TELL
"You drip a bit of wax onto" T ,PRSI ". Rather pointless, really." CR>)>)>>

<OBJECT PORTRAIT
	(IN OUTSIDE-PARLOR)
	(DESC "portrait of Aunt Hildegarde and Uncle Buddy")
	(SYNONYM PORTRAIT PAINTING PICTURE)
	(ADJECTIVE OIL)
	(FLAGS NDESCBIT)
	(ACTION PORTRAIT-F)>

<ROUTINE PORTRAIT-F ()
	 <COND (<VERB? MOVE LOOK-BEHIND PULL RAISE SWING> 
                <COND (<NOT <FSET? ,WALL-SAFE ,INVISIBLE>> 
                       <YOU-ALREADY>)
		      (T
		       <FCLEAR ,WALL-SAFE ,INVISIBLE>
                       <TELL
"You swing" T ,PORTRAIT " away from the wall and find" A ,WALL-SAFE ".">
		       <COND (<FSET? ,GREEN-CARD ,INVISIBLE>
			      <FCLEAR ,GREEN-CARD ,INVISIBLE>
			      <TELL
" A " D ,GREEN-CARD " flutters to the floor." CR>)
			     (T
			      <CRLF>
			      <RTRUE>)>)>)
	       (<VERB? TAKE>
		<TELL
"It seems to be attached to the wall on one side." CR>)
	       (<AND <VERB? COVER>
		     <PRSO? ,WALL-SAFE>>
		<FSET ,WALL-SAFE ,INVISIBLE>
		<TELL
"You cover" T ,WALL-SAFE " with" TR ,PORTRAIT>)
	       (<VERB? EXAMINE>
	        <TELL
"It's a very conservative portrait of Aunt Hildegarde sitting in a
Victorian-style chair with Uncle Buddy standing behind her, wearing a
black-and-white checkered polyester leisure suit." CR>)>>


"--- Wall Safe ---"

<OBJECT WALL-SAFE
        (IN OUTSIDE-PARLOR)
	(DESC "wall safe")
	(SYNONYM DIAL SAFE)
	(ADJECTIVE WALL)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT LOCKEDBIT INVISIBLE)
	(CAPACITY 21)
	(ACTION WALL-SAFE-F)>

;"Safe combination-- 3 to the right, 7 to the left, 5 to the right"

<GLOBAL STEPS-THROUGH-WALL-SAFE 0>

<GLOBAL DIAL-NUMBER 6>

<ROUTINE WALL-SAFE-F ()
         <COND (<AND <VERB? TURN-LEFT TURN-RIGHT>
		     <PRSI? ,INTNUM>>
		<COND ;(<EQUAL? ,P-NUMBER ,DIAL-NUMBER>
		       <TELL "It's already set to " N ,DIAL-NUMBER "." CR>)
		      (<G? ,P-NUMBER 10>
		       <TELL "The dial only goes to 10." CR>)
		      (T
		       <SETG DIAL-NUMBER ,P-NUMBER>
		       <TELL"You turn the dial to " N ,DIAL-NUMBER ".">
		       <COND (<AND <NOT <FSET? ,WALL-SAFE ,OPENBIT>> 
				   <EQUAL? ,STEPS-THROUGH-WALL-SAFE 0>
				   <VERB? TURN-RIGHT>
				   <EQUAL? ,DIAL-NUMBER 3>>
			      <SETG STEPS-THROUGH-WALL-SAFE 1>)
			     (<AND <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
				   <EQUAL? ,STEPS-THROUGH-WALL-SAFE 1>
				   <VERB? TURN-LEFT>
				   <EQUAL? ,DIAL-NUMBER 7>>
			      <SETG STEPS-THROUGH-WALL-SAFE 2>)
			     (<AND <NOT <FSET? ,WALL-SAFE ,OPENBIT>>
				   <EQUAL? ,STEPS-THROUGH-WALL-SAFE 2>
				   <VERB? TURN-RIGHT>
				   <EQUAL? ,DIAL-NUMBER 5>>
			      <SETG STEPS-THROUGH-WALL-SAFE 3>
			      <FCLEAR ,WALL-SAFE ,LOCKEDBIT>
			     ;<FSET ,WALL-SAFE ,OPENBIT>
			      <TELL " You hear a faint click.">
			     ;<TELL
" You hear a faint click and the safe opens slightly.">)
			     (T
			      <SETG STEPS-THROUGH-WALL-SAFE 0>)>
		       <CRLF>)>)
	       (<VERB? TURN TURN-LEFT TURN-RIGHT>
		<COND (<EQUAL? ,PRSI <> ,ROOMS>
		       <TELL
"You didn't say what number you wanted to turn the dial to, or the
direction." CR>)
		      (<EQUAL? ,PRSI ,INTNUM>
		       <TELL
"You didn't say whether you wanted to turn the dial RIGHT to " N ,P-NUMBER
" or LEFT to " N ,P-NUMBER "." CR>)
		      (T
		       <TELL "Huh?" CR>)>)
	       (<VERB? EXAMINE>
	        <TELL
"It's a rather large safe with a dial which can be set to any number between
0 and 10. The dial is set to " N ,DIAL-NUMBER ". ">
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,WALL-SAFE ,OPENBIT>>
		<FSET ,WALL-SAFE ,LOCKEDBIT>
		<SETG STEPS-THROUGH-WALL-SAFE 0>
		<RFALSE>)>>

<OBJECT GRATER
	(IN WALL-SAFE)
	(DESC "Mama Maggio's cheese grater")
	(SYNONYM GRATER SHREDDER)
	(ADJECTIVE MAGGIO CHEESE MAMA MAMA\'S)
        (SIZE 10)
	(VALUE 10)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION GRATER-F)>

<ROUTINE GRATER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the cheese grater Mama Maggio used to paddle her nine sons and
seven daughters with in the \"Maggio Boys and Girls\" serial. Uncle Buddy
wrote the scripts for these mystery yarns about 16 teenage brothers and
sisters who were junior detectives." CR>)>>


"--- Chimney ---"

<OBJECT FIREPLACE-GLOBAL
	(IN LOCAL-GLOBALS)
	(DESC "fireplace")
	(SYNONYM FIREPLACE MORTAR)
	(FLAGS NDESCBIT)
	(ACTION FIREPLACE-GLOBAL-F)>

<ROUTINE FIREPLACE-GLOBAL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,FIREPLACE>
		       <V-LOOK>)
		      (T
		       <TELL
"You see a large, finely crafted brick fireplace." CR>)>)
	       (<VERB? LOOK-INSIDE SEARCH>
		<COND (<EQUAL? ,HERE ,LIVING-ROOM>
		       <TELL
"You can't quite make out the inside of the fireplace from here." CR>)
		      (T
		       <TELL "Look around you!" CR>)>)
	       (<AND <VERB? ENTER BOARD>
		     <EQUAL? ,HERE ,LIVING-ROOM>>
		<GOTO ,FIREPLACE>)
	       (<VERB? REACH-IN>
		<COND (<EQUAL? ,HERE ,LIVING-ROOM>
		       <TELL
"You reach in the fireplace and imagine a warm glow." CR>)>)
	       (<AND <VERB? CLIMB-UP>
		     <PRSI? ,FIREPLACE>
		     <EQUAL? ,HERE ,FIREPLACE>>
		<DO-WALK ,P?UP>)		 
	       (<VERB? PUT>
     		<MOVE ,PRSO ,FIREPLACE>
		<TELL "Done." CR>)>> 

<ROOM FIREPLACE
      (IN ROOMS)
      (DESC "Fireplace")
      (EAST TO LIVING-ROOM)
      (OUT TO LIVING-ROOM)
      (UP PER UP-CHIMNEY)
      (FLAGS RLANDBIT)
      (GLOBAL FIREPLACE-GLOBAL CHIMNEY)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION FIREPLACE-F)>

;<ROOM NORTH-CELL
      (IN ROOMS)
      (DESC "Cell")
      (SOUTH TO DUNGEON IF NORTH-CELL-DOOR IS OPEN) 
      (EAST TO SECRET-PASSAGE IF NORTH-BLOCK-FLAG)
      (OUT TO DUNGEON IF NORTH-CELL-DOOR IS OPEN)
      (FLAGS RLANDBIT)
      (ACTION NORTH-CELL-F)
      (GLOBAL NORTH-CELL-DOOR STONE-WALL NORTH-BLOCK)
      (PSEUDO "CELL" CELL-F)>

;<ROUTINE NORTH-CELL-F (RARG)
	 <COND (<==? .RARG ,M-LOOK>
		<TELL
"This is a damp and unhealthy dungeon cell with writing on the walls.
The rusty door of the cell is ">
		<COND (<FSET? ,NORTH-CELL-DOOR ,OPENBIT>
		       <TELL "open.">)
		      (ELSE <TELL "closed.">)>
		<COND (,NORTH-BLOCK-FLAG
		       <TELL
" A square block sits beside a passage in the eastern wall.">)
		      (<AND <NOT ,NORTH-BLOCK-FLAG>
			    <NOT <FSET? ,NORTH-BLOCK ,NDESCBIT>>>
		       <TELL
" A square block in the east wall seems to be loose.">)>
		<CRLF>)>>

<ROUTINE FIREPLACE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The fireplace is finely crafted masonry, but has long been
neglected. The mortar is crumbling in a number of places.">
		<COND (<FSET? ,BRICK-HOLE ,INVISIBLE>
		       <TELL
" One brick, about waist high, seems particularly loose.">)>
		<TELL " The fireplace opens to the east.">)>>

;<ROOM FIREPLACE
      (IN ROOMS)
      (DESC "Fireplace")
      (LDESC
"The fireplace is finely crafted masonry, but has long been neglected.
The mortar is crumbling in a number of places. The fireplace opens to
the east.")
      (EAST TO LIVING-ROOM)
      (OUT TO LIVING-ROOM)
      (UP PER UP-CHIMNEY)
      (FLAGS RLANDBIT)
      (GLOBAL FIREPLACE-GLOBAL CHIMNEY)
      (CAPACITY 10)> ;"don't light room when sun comes up"

<OBJECT BRICK-HOLE
        (IN FIREPLACE)
	(DESC "hole")
	(LDESC "There is a hole in the fireplace about waist high here.")
	(SYNONYM HOLE HOLD)
        (ADJECTIVE FOOT HAND)
	(FLAGS ;NDSECBIT INVISIBLE CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 6)
       ;(DESCFCN BRICK-HOLE-F)
        (ACTION BRICK-HOLE-F)>

<ROUTINE BRICK-HOLE-F () ;("OPTIONAL" (OARG <>))
	 <COND ;(.OARG
		<COND (<IN? ,BRICK ,BRICK-HOLE>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL
"One brick, about waist high, seems particularly loose.">)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT ;PULL>
		     <PRSI? ,BRICK-HOLE>>
		<COND (<PRSO? ,BRICK>
		       <FCLEAR ,FIREPLACE ,BRICK-REMOVED-BIT>
	               <FSET ,PRSO ,NDESCBIT>
		      ;<FCLEAR ,BRICK-HOLE ,NDESCBIT>
		       <FSET ,BRICK-HOLE ,INVISIBLE>
		       <RFALSE>)
		      (<AND <L? <GETP ,PRSO ,P?SIZE> 5>
			    <FSET? ,FIREPLACE ,BRICK-REMOVED-BIT>>
		       <REMOVE ,PRSO>
		       <TELL
"You push it into the hole and it falls down into the space beyond the
hole." CR>)
		      (T
		       <TELL "It doesn't fit into the hole." CR>)>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<OBJECT BRICK-HOLE-GLOBAL
	(IN LOCAL-GLOBALS)
	(DESC "hole")
	(SYNONYM HOLE HOLD)
        (ADJECTIVE FOOT HAND)
	(FLAGS NDESCBIT)
        (ACTION BRICK-HOLE-GLOBAL-F)>

<ROUTINE BRICK-HOLE-GLOBAL-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,BRICK-HOLE-GLOBAL>>
		<COND (<PRSO? ,BRICK>
		       <TELL
"You wouldn't be able to climb the chimney if you did that." CR>)
		      (<L? <GETP ,PRSO ,P?SIZE> 5>
		       <REMOVE ,PRSO>
		       <TELL
"It falls down into the space beyond the hole." CR>)
		      (T
		       <TELL "It doesn't fit into the hole." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You can't see a thing. It's pitch black." CR>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<OBJECT BRICK
	(IN FIREPLACE)
	(DESC "brick")
	(SYNONYM BRICK)
	(ADJECTIVE LOOSE)
	(FLAGS TAKEBIT NDESCBIT)
	(SIZE 5)
       ;(DESCFCN BRICK-F)
	(ACTION BRICK-F)>

<ROUTINE BRICK-F ()
	 <COND ;(.OARG
		<COND (<IN? ,BRICK ,BRICK-HOLE>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL
"One brick, about waist high, seems particularly loose.">)
		      (T
		       <RFALSE>)>)
	  (<VERB? TAKE PULL>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)
		      (T
		       <FSET ,FIREPLACE ,BRICK-REMOVED-BIT>
		       <FCLEAR ,BRICK-HOLE ,INVISIBLE>
      		       <COND (<FSET? ,INDIGO-CARD ,INVISIBLE>
		              <FCLEAR ,INDIGO-CARD ,INVISIBLE>
		       	      <TELL
"You pull the brick out of the hole, and along with it
comes" A ,INDIGO-CARD ", which drops in a spiral to the ground." CR>)
			     (T ;"Let v-take do the rest"
			      <RFALSE>)>)>)>>

<ROUTINE UP-CHIMNEY ()
	 <COND (<AND <NOT <FSET? ,FIREPLACE ,BRICK-REMOVED-BIT>>
		     <EQUAL? ,HERE ,FIREPLACE>>
		<TELL "You'll have to figure that out for yourself." CR>
		<RFALSE>)
	       (<G? <WEIGHT ,PLAYER> 38>
		<TELL "You're carrying too much to climb up" TR ,CHIMNEY>
		<RFALSE>)
	       (<FSET? ,SKIS ,WORNBIT>
		<TELL
"You can't climb up while you're wearing the skis." CR>)		    
	       (T
		<TELL "Using the ">
		<COND (<EQUAL? ,HERE ,FIREPLACE>
		       <TELL "hole where the brick was,">)
		      (T
		       <TELL "holes">)>
		<TELL " you climb up the chimney several feet">
		<COND (<EQUAL? ,HERE ,FIREPLACE>
		       <TELL "." CR CR>
		       <RETURN ,CHIMNEY-1>)
		      (<EQUAL? ,HERE ,CHIMNEY-1>
		       <TELL "." CR CR>
		       <RETURN ,CHIMNEY-2>)
		      (T
		       <TELL " onto the..." CR CR>
		       <COND (<EQUAL? ,HERE ,CHIMNEY-2>
			      <RETURN ,ROOF-1>)
			     (T
			      <RETURN ,ROOF-2>)>)>)>>

<ROUTINE DOWN-CHIMNEY ()
	 <TELL "Using the ">
	 <COND (<EQUAL? ,HERE ,FIREPLACE>
	        <TELL "hole where the brick was">)
	       (T
		<TELL "holes">)>
	 <TELL ", you climb down the chimney several feet">
	 <COND (<EQUAL? ,HERE ,CHIMNEY-1>
		<TELL " into the..." CR CR> 
		<RETURN ,FIREPLACE>)
	       (<EQUAL? ,HERE ,CHIMNEY-2>
		<TELL "." CR CR>
		<RETURN ,CHIMNEY-1>)>>

<ROOM CHIMNEY-1
      (IN ROOMS)
      (DESC "In the Chimney")
      (LDESC
"You're in the chimney, above the fireplace. You can see a couple of
holes here in the chimney where bricks used to be. The chimney continues
upward and the fireplace is below." CR)
      (FLAGS RLANDBIT EVERYBIT)  ;"WHY EVERYBIT?"
      (UP PER UP-CHIMNEY)
      (DOWN PER DOWN-CHIMNEY)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (GLOBAL CHIMNEY BRICK-HOLE-GLOBAL)>

<ROOM CHIMNEY-2
      (IN ROOMS)
      (DESC "In the Chimney")
      (LDESC
"You're inside the chimney. You can see a couple of holes here in the chimney
where bricks used to be. The chimney continues upward and downward." CR)
      (FLAGS RLANDBIT)
      (UP PER UP-CHIMNEY)
      (DOWN PER DOWN-CHIMNEY)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (GLOBAL CHIMNEY BRICK-HOLE-GLOBAL)>

<ROOM CHIMNEY-3
      (IN ROOMS)
      (DESC "In the Chimney")                                  ;"other chimney"
      (LDESC
"You're standing in the chimney. There are a couple of holes here in the
chimney where bricks used to be. This chimney doesn't lead any further
down, only up." CR)
      (FLAGS RLANDBIT)
      (UP PER UP-CHIMNEY)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (GLOBAL CHIMNEY BRICK-HOLE-GLOBAL)> 

<OBJECT PENGUIN
	(IN CHIMNEY-3)
	(DESC "stuffed penguin")
	(SYNONYM PENGUIN BIRD)
	(ADJECTIVE STUFFED)
	(SIZE 15)
	(VALUE 10)
	(FLAGS TAKEBIT)
	(ACTION PENGUIN-F)>

<ROUTINE PENGUIN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's a life-size stuffed penguin. It was probably used in the filming of
\"Vampire Penguins of the North.\"" CR>)>>

<OBJECT MASK
	(IN COMPARTMENT)
	(DESC "catcher's mask")
	(SYNONYM MASK)
	(ADJECTIVE CATCHER)
        (SIZE 5)
	(VALUE 10)
	(FLAGS TAKEBIT WEARBIT)
	(ACTION MASK-F)>

<ROUTINE MASK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It looks like" T ,MASK " from \"Friday the 15th.\"" CR>)
	      ;(<VERB? WEAR>
		<COND (<NOT <ITAKE>>
		       <RTRUE>)
		      (T
		       <FSET ,PRSO ,WORNBIT>
		       <TELL
"You feel an unexplainable urge to go to summer camp." CR>)>)>>

<ROOM ROOF-1
      (IN ROOMS)
      (DESC "West End of Roof")
      (LDESC
"You're doing your best to keep your balance here on the roof. During a
fierce storm you can see Linda Ronstadt's house wash into the ocean from
here. A chimney juts up from the roof here and there is another chimney
to the east, near the end of the roof.")
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (DOWN PER ROOF-TO-CHIMNEY)
      (IN PER ROOF-TO-CHIMNEY)
      (EAST TO ROOF-2)
      (WEST "You'd fall off the roof!")
      (SOUTH "You'd fall off the roof!")
      (NORTH "You'd fall off the roof!")
      (NE "You'd fall off the roof!")
      (SE "You'd fall off the roof!") 
      (SW "You'd fall off the roof!")
      (NW "You'd fall off the roof!")
      (GLOBAL CHIMNEY)> 

<ROOM ROOF-2
      (IN ROOMS)
      (DESC "East End of Roof")
      (LDESC
"This is the east end of the roof. A chimney juts up from the roof here
and there is another chimney off to the west, near the end of the roof.")
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (WEST TO ROOF-1)
      (DOWN PER ROOF-TO-CHIMNEY)
      (IN PER ROOF-TO-CHIMNEY)
      (EAST "You'd fall off the roof!")
      (SOUTH "You'd fall off the roof!")
      (NORTH "You'd fall off the roof!")
      (NE "You'd fall off the roof!")
      (SE "You'd fall off the roof!") 
      (SW "You'd fall off the roof!")
      (NW "You'd fall off the roof!")
      (GLOBAL CHIMNEY)>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(DESC "brick chimney")
	(SYNONYM CHIMNEY)
	(FLAGS NDESCBIT)
	(ACTION CHIMNEY-F)>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It is your average chimney, made of bricks." CR>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,ROOF-1>
                       <TELL
"You see a few holes in the wall of" TR ,CHIMNEY>)
		      (T
		       <TELL
"You can't quite make out what's inside from here." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CHIMNEY>>
		<COND (<EQUAL? ,HERE ,FIREPLACE>
		       <TELL "You're at the bottom of the chimney!" CR>)
		      (T
		       <TELL "You drop" T ,PRSO " down the chimney." CR> 
		       <COND (<EQUAL? ,HERE ,ROOF-1 ,CHIMNEY-1 ,CHIMNEY-2>
			      <COND (<AND <PRSO? RED-CANDLE WHITE-CANDLE
						 BLUE-CANDLE>
					  <FSET? ,PRSO ,FLAMEBIT>>
				     <BLOW-OUT-CANDLE ,PRSO>)
			            (<OR <PRSO? FINCH>
					 <ULTIMATELY-IN? ,FINCH ,PRSO>>
				     <BREAK-FINCH T>)>
			      <MOVE ,PRSO ,FIREPLACE>)
			     (T
			      <MOVE ,PRSO ,CHIMNEY-3>)>)>)
	       (<VERB? ENTER>
		<DO-WALK ,P?IN>)
	       (<VERB? CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<ROUTINE ROOF-TO-CHIMNEY ()
	 <TELL "You climb down into the chimney." CR CR>
	 <COND (<EQUAL? ,HERE ,ROOF-1>
		<RETURN ,CHIMNEY-2>)
	       (T
		<RETURN ,CHIMNEY-3>)>> ;"is this safe?"


"--- Maps ---"

<OBJECT VERTICAL-MAP
	(IN MAILBOX)
        (DESC "yellowed piece of paper")
	(SYNONYM MAP PAPER)
	(ADJECTIVE YELLOW PIECE)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 1)
	;(VALUE 10)
	(ACTION VERTICAL-MAP-F)>

<ROUTINE VERTICAL-MAP-F ()
	 <COND (<VERB? READ EXAMINE>
		<COND (<FSET? ,VERTICAL-MAP ,WETBIT>
		       <WET-PAPER>)
		      (T
		       <LOOK-AT-MAP>
		       <TELL          ;"THE NEW NEW COMPLETE MAP" 
"~
|   | | |     |   |    |   |       |~
| |   |       | | |        | |   | |~
| |     | | | | | |   | |  | | | | |~
|       | | |     | |   |  | | | | |~
|         |       | | |    |   | | |~
|  | | | | | |      | | |  | | | | |~
|    | | | | |  |       |  | | | | |~
| |    | | |    | |   | |    | | | |~
| | |    |    | | |X| |    |     | |~
| | | |     | | | | | |  | |       |~
| | | | | | | | |     | |      |   |~
|     | | | |     |   | | |    | | |~
| |   | | | |   | | | | | | |  | | |~
| | | |     | | |     |   | |  | | |~
| | |         |           |      | |~
| |     |       | | |   | |    |   |~
| |   | | |   | | | | | |      | | |~
| | | |   | | | | |     | | |  | | |~
|   |       |   |         |    |   |~">     

                       ;<TELL       ;"old map"
"|       |   |   |            |    |   |~
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
|   |    |            |   |   |       |~">
		<FIXED-FONT-OFF>
		;<CRLF>)>)
	       (<VERB? PUT-ON>
		<COND (<OR <PRSO? ,HORIZONTAL-MAP>
			   <PRSI? ,HORIZONTAL-MAP>>
		       <COND (<AND <FSET? ,VERTICAL-MAP ,WETBIT>
				   <FSET? ,HORIZONTAL-MAP ,WETBIT>>
			      <TELL
"All you can make out on the soggy pieces
of paper are some blurred lines." CR>)
			     (<FSET? ,PRSO ,WETBIT>
			      <TELL
"You see blurred vertical lines through the soggy paper." CR>)
			     (<FSET? ,PRSI ,WETBIT>
			      <PERFORM ,V?READ ,PRSO>
			      <RTRUE>)
		             (T
		              <WHOLE-MAP>)>)
		      (<FSET? ,PRSI ,SURFACEBIT>
		       <RFALSE>)
		      (T
		       <TELL "That doesn't seem to accomplish much." CR>)>)>>

<ROUTINE LOOK-AT-MAP ()
	 <TELL "You see the following:" CR>
	 <FIXED-FONT-ON>>

<ROUTINE WET-PAPER ()
         <TELL
"All you see is a piece of wet paper with ink stains on it." CR>>

<OBJECT HORIZONTAL-MAP
        (IN DINING-ROOM)
        (DESC "thin piece of paper")
	(SYNONYM MAP PAPER)
        (ADJECTIVE THIN PIECE)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 1)
	;(VALUE 10)
	(ACTION HORIZONTAL-MAP-F)>

<ROUTINE HORIZONTAL-MAP-F ()
	 <COND (<VERB? READ EXAMINE>
		<COND (<FSET? ,HORIZONTAL-MAP ,WETBIT>
		       <WET-PAPER>)
		      (T
                       <LOOK-AT-MAP>
		       <TELL  ;"THE NEW NEW HORIZONTAL MAP"
"____________________________________~
  __     ____       ___ __   _____~
    __ __          __ _ ___~
    ___             __    _~
 ______      _____       _  _~
  __   ___ _ ____       __~
 __            _____     __~
  ___         __  ______  _~
    ___     ___          ____~
      ___ ___      X   ___   ____~
                   _    _   ______~
 _             _ _____    ____   __~
  ____       ____           __~
         _         _          _~
       __ __     ____  __    __~
     _________ __   ___     ____~
   ____   _____            ___   __~
                     _      ___~
       ___         __ __     _~
 ___ _______ ___ ____ ____ ____ ___~">
                         ;<TELL        ;"old map"
"_______________________________________~
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
 ___ ____ _________ __ ___ ___ _______~">
		<FIXED-FONT-OFF>
		;<CRLF>)>)
	       (<VERB? PUT-ON>
		<COND (<OR <PRSO? ,VERTICAL-MAP>
			   <PRSI? ,VERTICAL-MAP>>
		       <COND (<AND <FSET? ,HORIZONTAL-MAP ,WETBIT>
				   <FSET? ,VERTICAL-MAP ,WETBIT>>
			      <TELL
"You see blurred vertical lines through the soggy paper." CR>)
			     (<FSET? ,PRSI ,WETBIT>
			      <PERFORM ,V?READ ,PRSO>
			      <RTRUE>)
		             (T
		              <WHOLE-MAP>)>)
		      (<FSET? ,PRSI ,SURFACEBIT>
		       <RFALSE>)
		      (ELSE
		       <TELL "That doesn't seem to accomplish much." CR>)>)>>

;"NEW OLD PUT-ON FOR MAPS"
;(<VERB? PUT-ON>
  <COND (<PRSO? ,HORIZONTAL-MAP>
	 <COND (<FSET? ,PRSO ,WETBIT>
		<TELL
		 "You see blurred vertical lines through the soggy paper." CR>)
	       (<FSET? ,PRSI ,WETBIT> ;"SEM say vert-map here?"
		<PERFORM ,V?READ ,HORIZONTAL-MAP>
		<RTRUE>)
	       (<AND <FSET? ,VERTICAL-MAP ,WETBIT>
		     <FSET? ,HORIZONTAL-MAP ,WETBIT>>
		<TELL
"All you can make out on the soggy pieces of paper are
some blurred lines." CR>)
	       (T
		<WHOLE-MAP>)>)
	(ELSE
	 <TELL "That doesn't seem to accomplish much." CR>)>)


;"OLD PUT-ON FOR MAPS"
;(<VERB? PUT-ON>
 <COND (<PRSO? ,VERTICAL-MAP>
	<WHOLE-MAP>)
       (ELSE
	<TELL "That doesn't seem to accomplish much." CR>)>)

<ROUTINE WHOLE-MAP ()
         <LOOK-AT-MAP>
	 <TELL   ;"THE NEW NEW COMPLETE MAP"
"____________________________________~
| __| | |____ |   | ___|__ | _____ |~
| | __|__     | | |__ _ ___| |   | |~
| | ___ | | | | | | __| | _| | | | |~
|______ | | |_____| |   |_ |_| | | |~
| __   ___|_ ____ | | | __ |   | | |~
|__| | | | | | _____| | |__| | | | |~
| ___| | | | |__| ______| _| | | | |~
| | ___| | |___ | |   | |____| | | |~
| | | ___|___ | | |X| |___ | ____| |~
| | | |     | | | |_| | _| |______ |~
|_| | | | | | |_|_____| | ____ | __|~
| ____| | | |____ |   | | | __ | | |~
| |   | |_| |   | |_| | | | | _| | |~
| | | |__ __| | |____ |__ | |__| | |~
| | |_________|__   ___   | ____ | |~
| |____ | _____ | | |   | |___ | __|~
| |   | | |   | | | |_| |   ___| | |~
| | | |___| | | | |__ __| | |_ | | |~
|___|_______|___|____ ____|____|___|~">
	 <FIXED-FONT-OFF>
	 ;<CRLF>
         ;%<COND (<GASSIGNED? ZILCH>
		'<TELL "You see the following: [ZIP]~
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
|___|____|_________ __|___|___|_______|~">)
		(T
                 '<TELL "You see the following: [ZIL]
_______________________________________
| _____ |   |   |   __   ___ | __ |   |
|____ | | | | | | | |__| |___|_ | | | |
| ____| | |___|___| | _______ | |___| |
|____ | | |   ___ __| | ___ | | |   | |
| ____|_ _| | ___ | | | | | | | | | | |
| | ________|__ ___ | | | | |   | | | |
| | |   | ___ | | __| | | | | | | | | |
| | | | |__ __| |_| __| |___| | | |___|
| | | |_| _______ |x| |_______|______ |
| |_____________|_|_| |______ ___   | |
|____   | _____ | __|__ ___ __| | | | |
|   | | | |   | | | | | | ___ | | | | |
| | | | | | | | | | __| |_____|___| | |
| | | |   | | | | |   ___ | __ _____| |
| | | | | | |_| | |_| ___ | |   | ____|
| |___| | |_____| | ________| | |____ |
| |   | |_____ ___| |   |   | | | ____|
| | | |_ | __| | _| | | | | | | |____ |
|___|____|_________ __|___|___|_______|">)>>


"--- Kitchen ---"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (LDESC
"This is Aunt Hildegarde's kitchen. It is a fairly large, sterile area
with several pieces of commercial-grade equipment to handle the vast
amount of food needed for Hollywood parties. It is not exactly the kind
of homey kitchen most people's aunts have. The whole family remembers
the Christmas everyone received fruit cakes with serial numbers on them.
A doorway leads to the east and stairs lead down from here.")
      (FLAGS RLANDBIT)
      (EAST TO DINING-ROOM)
      (DOWN PER TO-CELLAR)
      (CAPACITY 20) ;"Tell--sun coming up"
      (GLOBAL STAIRS WINDOW WATER)>

<ROUTINE TO-CELLAR ()
	 <COND (<FSET? ,SKIS ,WORNBIT>
		<TELL ,SNOWPLOW CR CR>)>
	 ,CELLAR>

<ROOM DINING-ROOM
      (IN ROOMS)
      (DESC "Dining Room")
      (LDESC 
"This is the dining room with a long, walnut table and seating for
twelve. You remember more than one evening falling asleep at the table
while Uncle Buddy rambled on about the way Hollywood used to be. A
large picture window looks out on the garden. Doorways lead east, west
and south.")
      (FLAGS RLANDBIT)
      (WEST TO KITCHEN)
      (EAST TO GAME-ROOM)
      (SOUTH TO LIVING-ROOM)
      (CAPACITY 20) ;"Tell--sun coming up"
      (GLOBAL WINDOW SEAT GARDEN)>

<OBJECT DINING-ROOM-TABLE
	(IN DINING-ROOM)
	(SYNONYM TABLE)
	(ADJECTIVE WALNUT)
	(DESC "table")
	(CAPACITY 100)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT SURFACEBIT)>

"--- Junk Yard ---"

;<ROUTINE I-LIGHTS-DIM ()
	 <COND (<FSET? ,HERE ,OUTDOORSBIT>
		<TELL
"The sun is rapidly sinking into west. It's getting dark out here." CR>)
	       (T
		<COND (<FSET? ,HERE ,ONBIT>
		       <TELL
"The sun is going down. It's getting dark in here." CR>)>)>
	 <QUEUE I-LIGHTS-OUT 10>>

;<ROUTINE I-LIGHTS-OUT ()
	 <FCLEAR ,SOUTH-JUNCTION ,ONBIT>
	 <TELL "The sun has set. ">
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (T
		<CRLF>)>>
