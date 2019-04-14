"BSHELTER for ANTHILL (C)1986 Infocom Inc. All rights reserved."

"--- Matchbox ---"

<OBJECT MATCHBOX
        (IN KITCHEN)
        (DESC "matchbox")
	(FDESC "Next to the sink is a matchbox.")
	(SYNONYM BOX MATCHBOX)
	(ADJECTIVE FESTIVE CHRISTMAS)
	(FLAGS TAKEBIT CONTBIT SEARCHBIT BURNBIT) 
	(CAPACITY 3)
	(SIZE 4)
	(ACTION MATCHBOX-F)>

<ROUTINE MATCHBOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You see a picture of Santa Claus in his sleigh. The sleigh is filled with
computer games from Infocom, and the reindeer pulling it look strained." CR>
	       ;<TELL
"You see a picture of Santa Claus with his pants down, shooting a moon. Printed
below the picture: \"Festive matches courtesy of the CambridgePark Cafe. Close
box and pull up pants before striking.\"" CR>)
	       (<VERB? TAKE>
		<FCLEAR ,MATCHBOX ,NDESCBIT>
		<RFALSE>)>>

<OBJECT WAX-COAT-1
	(DESC "wax coating")
	(SYNONYM WAX COATING)
	(ADJECTIVE WAX) ;"SEM"
	(FLAGS NDESCBIT)
	(SIZE 1)
	(GENERIC GENERIC-WAX-F)
	(ACTION WAX-COAT-F)>

<OBJECT WAX-COAT-2
	(DESC "wax coating")
	(SYNONYM WAX COATING)
	(ADJECTIVE WAX) ;"SEM"
	(FLAGS NDESCBIT)
	(SIZE 1)
	(GENERIC GENERIC-WAX-F)
	(ACTION WAX-COAT-F)>

<ROUTINE WAX-COAT-F ()	
	 <COND (<AND <VERB? SCRAPE-OFF>
		     <PRSI? ,RED-MATCH ,GREEN-MATCH>
		     <FSET? ,PRSI ,WAXED-BIT>>
		<FCLEAR ,PRSI ,WAXED-BIT>
		<COND (T
		       ;<AND <NOT <FSET? ,RED-MATCH ,WAXED-BIT>>
			    <NOT <FSET? ,GREEN-MATCH ,WAXED-BIT>>>
		       <COND (<IN? ,PRSO ,PRSI>
			      <REMOVE ,PRSO>)
			     (ELSE
			      <REMOVE ,WAX-COAT-2>)>)>
		<TELL "You scrape the wax coating off" TR ,PRSI>)>>  

<OBJECT RED-MATCH
	(IN MATCHBOX)
	(DESC "red match")
        (SYNONYM MATCH MATCHES)
	(ADJECTIVE RED WOODEN STICK)
	(SIZE 1)
        (FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 1)
	(MATCH-LIFE 2)
        (ACTION MATCH-F)>

<OBJECT GREEN-MATCH
	(IN BEACH)
	(DESC "green match")
	(FDESC "Lying near the fire is a green match.")
        (SYNONYM MATCH MATCHES)
	(ADJECTIVE GREEN WOODEN STICK)
	(SIZE 1)
        (FLAGS TAKEBIT BURNBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 1)
	(MATCH-LIFE 2)
        (ACTION MATCH-F)>

<ROUTINE MATCH-F ("AUX" WAXED)
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the wooden, self-lighting variety of match. The " D ,PRSO>
		<COND (<FSET? ,PRSO ,WAXED-BIT>
                       <TELL " head is coated with a thin layer of wax">)
		      (<FSET? ,PRSO ,WETBIT>
		       <TELL " is wet">)
		      (T
		       <TELL " is ">
		       <COND (<NOT <FSET? ,PRSO ,ONBIT>>
			      <TELL "not ">)>
		       <TELL "lit">)>
		<TELL "." CR>)
	       (<VERB? LAMP-ON KILL>
		<COND (<NOT <IN? ,PRSO ,PLAYER>>
		       <TELL "You're not holding" TR ,PRSO>)
		      (<FSET? ,PRSO ,FLAMEBIT>
		       <TELL "It's already lit." CR>)
                      (<ZERO? <GETP ,PRSO ,P?MATCH-LIFE>>
		       <TELL "You can't. It's all used up." CR>)
		      (<FSET? ,PRSO ,WETBIT>
                       <TELL "It's wet. It won't light now." CR>)
		      (<EQUAL? ,HERE ,IN-POOL-1 ,IN-POOL-2 ,UNDERPASS-1
    				     ,UNDERPASS-2>
		       <TELL
"Not even Uncle Buddy's best special effects men could light a match
under water!" CR>)
		      (<EQUAL? ,HERE ,ON-POOL-1 ,ON-POOL-2 ,INLET>
		       <TELL
"You'd better find some dry land first." CR>)
                      (T
		       <QUEUE I-MATCH-BURN -1>
		       ;<MOVE ,PRSO ,PLAYER>
		       <FSET ,PRSO ,ONBIT>
		       <COND (<IN? ,WAX-COAT-1 ,PRSO>
			      <REMOVE ,WAX-COAT-1>)
			     (<IN? ,WAX-COAT-2 ,PRSO>
			      <REMOVE ,WAX-COAT-2>)>
		       <FSET ,PRSO ,FLAMEBIT>
		       <COND (<FSET? ,PRSO ,WAXED-BIT>
			      <FCLEAR ,PRSO ,WAXED-BIT>
			      <TELL
"The wax coating melts away as you light" TR ,PRSO>)
			     (T
			      <TELL "Okay," T ,PRSO " is now lit." CR>)>
		       <NOW-LIT?>
		       <RTRUE>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <BLOW-OUT-MATCH ,PRSO>)
		      (T
		       <TELL "It's not lit." CR>)>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<ROUTINE I-MATCH-BURN ()
	 <COND (<FSET? ,RED-MATCH ,ONBIT>
		<MATCH-BURN ,RED-MATCH>)>
	 <COND (<FSET? ,GREEN-MATCH ,ONBIT>
		<MATCH-BURN ,GREEN-MATCH>)>>

<ROUTINE MATCH-BURN (OBJ)
	 <COND (<ZERO? <GETP .OBJ ,P?MATCH-LIFE>>
		<BLOW-OUT-MATCH .OBJ T>)
               (T
                <PUTP .OBJ ,P?MATCH-LIFE <- <GETP .OBJ ,P?MATCH-LIFE> 1>>)>>

<ROUTINE BLOW-OUT-MATCH (OBJ "OPTIONAL" (ADD-CR <>))
	 <FCLEAR .OBJ ,ONBIT>
	 <FCLEAR .OBJ ,FLAMEBIT>
	 <COND (<AND <NOT <FSET? ,RED-MATCH ,ONBIT>>
		     <NOT <FSET? ,GREEN-MATCH ,ONBIT>>>
		<DEQUEUE I-MATCH-BURN>)>
	 <COND (<VISIBLE? .OBJ>
		<COND (.ADD-CR
		       <CRLF>)>
		<TELL
"The " D .OBJ " goes out, turns to ashes, falls to the
ground and disappears." CR>
		<SAY-IF-NOT-LIT>
                <REMOVE .OBJ>)>>

<ROOM BOAT-DOCK
      (IN ROOMS)
      (DESC "Grotto")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (WEST "If you want to swim, say so.")
      (EAST "You bump into the wall of the cave.")
      (NORTH PER WALKWAY-TO-BOAT-DOCK)
      (SOUTH "You bump into the wall of the cave.")
      (DOWN "If you want to swim, say so.")
      (GLOBAL WATER)
      (ACTION BOAT-DOCK-F)>

<ROUTINE BOAT-DOCK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a large grotto standing on a boat dock. Moonlight trickling
through the grotto's opening to the north reflects off the water, dimly
illuminating this area. A wooden walkway leads north out of the grotto.
A pool of sea water covers the bottom of the grotto.">)>>  ;"grotto or cavern?"

<OBJECT PORTABLE-WATER
	(DESC "water")
	(SYNONYM WATER)
	(FLAGS NARTICLEBIT)
	(ACTION PORTABLE-WATER-F)>

<ROUTINE PORTABLE-WATER-F ()
	 <COND (<VERB? SWIM ENTER>
		<COND (<GLOBAL-IN? ,WATER ,HERE>
		       <PERFORM ,PRSA ,WATER>
		       <RTRUE>)
		      (ELSE
		<TELL "You'd never fit into" T <LOC ,PORTABLE-WATER> "!" CR>)>)
	       (<VERB? DRINK DRINK-FROM TASTE>
		<COND (<NOT-HOLDING-WATER?>
		       <RTRUE>)
		      (T
		       <TELL "You take a sip." CR>)>)	       
	       (<AND <VERB? THROW DROP EMPTY ;TAKE PUT-ON PUT POUR>
		     <PRSO? ,PORTABLE-WATER>>
		<COND (<NOT-HOLDING-WATER?>;"is port-water in bucket?"
		       <RTRUE>)
		      (T
		       <REMOVE ,PORTABLE-WATER>
		       <FCLEAR ,PORTABLE-WATER ,NDESCBIT>
		       <SETG AMOUNT-OF-WATER 0>
		       <DEQUEUE I-DRIP>
		       <COND (<VERB? EMPTY>
			      <TELL "You pour the water out of the bucket." CR>
			      <RTRUE>)>
		       <COND (,PRSI
			      <FSET ,PRSI ,WETBIT>
			      <COND (<FSET? ,PRSI ,FLAMEBIT>
				     <FCLEAR ,PRSI ,FLAMEBIT>
				     <FCLEAR ,PRSI ,ONBIT>
				     <COND (<EQUAL? ,PRSI ,RED-CANDLE>
					    <STOP-RED-BURNING>)
					   (<EQUAL? ,PRSI ,WHITE-CANDLE>
					    <STOP-WHITE-BURNING>)
					   (<EQUAL? ,PRSI ,BLUE-CANDLE>
					    <STOP-BLUE-BURNING>)
					   (<EQUAL? ,PRSI
						    ,GREEN-MATCH ,RED-MATCH>
					    <DEQUEUE I-MATCH-BURN>)>
				     <TELL
"You douse the flame with water." CR>
				     <RTRUE>)>
			      <TELL
"You pour water over it, making a mess." CR>)
			     (ELSE
			      <REMOVE ,PORTABLE-WATER>
			      <TELL
"The water pours out, making a mess." CR>)>)>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,PORTABLE-WATER>
		     <IN? ,PORTABLE-WATER ,BUCKET>>
		<PERFORM ,V?PUT ,PRSO ,BUCKET>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSO ,PORTABLE-WATER>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?POUR ,PORTABLE-WATER>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE SEARCH EXAMINE>
		<PERFORM ,PRSA <LOC ,PORTABLE-WATER>>
		<RTRUE>)>>

<OBJECT WATER
        (IN LOCAL-GLOBALS)
        (DESC "water")
        (SYNONYM WATER OCEAN SEA POOL)
	(ADJECTIVE SALT SEA)
	(FLAGS NARTICLEBIT)
	(ACTION WATER-F)>

<ROUTINE WATER-F ()
	 <COND (<EQUAL? ,HERE ,UPSTAIRS-BATHROOM ,KITCHEN
			      ,LADIES-ROOM ,MENS-ROOM>
		<TELL "Hmmm. It seems the water has been turned off." CR>)
	       (<VERB? DISEMBARK>
		<DO-WALK ,P?OUT>
		<RTRUE>)
	       (<VERB? SWIM ENTER>
		<COND (<EQUAL? ,HERE ,NORTH-GARDEN> ;"put in pond-f?"
		       <TELL "The pond's too shallow for swimming." CR>
		       <RTRUE>)
		      (<FSET? ,SKIS ,WORNBIT>
		       <TELL ,DOG-PADDLE CR>
		       <RTRUE>)
		      (<ULTIMATELY-IN? ,LADDER>
		       <TELL
"You won't be able to swim carrying" TR ,LADDER>
		       <RTRUE>)
                     ;(<G? <WEIGHT ,PLAYER> 20>
		       <TELL "You're holding too much to swim." CR>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,INLET ,ON-POOL-1 ,IN-POOL-1
			             ,UNDERPASS-1 ,UNDERPASS-2
				     ,IN-POOL-2 ,ON-POOL-2>
		       <TELL "You swim a few yards." CR>
		       <RTRUE>)>
		<ALL-WET ,PLAYER>
		<TELL
"As you enter the chilly water, goose bumps cover your body and your teeth
chatter a bit." CR CR>
		<COND (<IN? ,BUCKET ,PLAYER>
		       <MOVE ,PORTABLE-WATER ,BUCKET>
		       <QUEUE I-DRIP 1>)>
		<COND (<EQUAL? ,HERE ,BOAT-DOCK>
		       <GOTO ,ON-POOL-1>)
		      (<EQUAL? ,HERE ,LEDGE>
		       <GOTO ,ON-POOL-2>)
		      (T
		       <GOTO ,INLET>)>
		<COND (<AND <ULTIMATELY-IN? ,FLASHLIGHT>
			    <FSET? ,FLASHLIGHT ,ONBIT>>      
		       <FCLEAR ,FLASHLIGHT ,ONBIT>
		       <TELL CR
"Oops! Your flashlight went out. The water ruined it." CR>)>
      		<COND (<AND <ULTIMATELY-IN? ,RED-CANDLE>
			    <FSET? ,RED-CANDLE ,ONBIT>>      
		       <BLOW-OUT-CANDLE ,RED-CANDLE>)>
		<COND (<AND <ULTIMATELY-IN? ,WHITE-CANDLE>
			    <FSET? ,WHITE-CANDLE ,ONBIT>>      
		       <BLOW-OUT-CANDLE ,WHITE-CANDLE>)>
		<COND (<AND <ULTIMATELY-IN? ,BLUE-CANDLE>
			    <FSET? ,BLUE-CANDLE ,ONBIT>>
		       <BLOW-OUT-CANDLE ,BLUE-CANDLE>)>
		<COND (<AND <ULTIMATELY-IN? ,GREEN-MATCH>
			    <FSET? ,GREEN-MATCH ,FLAMEBIT>
			    <ULTIMATELY-IN? ,RED-MATCH>
			    <FSET? ,RED-MATCH ,FLAMEBIT>>
		       <FCLEAR ,RED-MATCH ,ONBIT>
		       <FCLEAR ,RED-MATCH ,FLAMEBIT>
		       <REMOVE ,RED-MATCH>
		       <FCLEAR ,GREEN-MATCH ,ONBIT>
		       <FCLEAR ,GREEN-MATCH ,FLAMEBIT>
		       <REMOVE ,GREEN-MATCH>
		       <TELL
"You drop the lit " D ,GREEN-MATCH " and the lit " D ,RED-MATCH "." CR>)>
		       <COND (<AND <ULTIMATELY-IN? ,RED-MATCH>
				   <FSET? ,RED-MATCH ,FLAMEBIT>>
			      <FCLEAR ,RED-MATCH ,ONBIT>
			      <FCLEAR ,RED-MATCH ,FLAMEBIT>
			      <REMOVE ,RED-MATCH>
			      <TELL "You drop the lit " D ,RED-MATCH "." CR>)>
		       <COND (<AND <ULTIMATELY-IN? ,GREEN-MATCH>
				   <FSET? ,GREEN-MATCH ,FLAMEBIT>>
			      <FCLEAR ,GREEN-MATCH ,ONBIT>
			      <FCLEAR ,GREEN-MATCH ,FLAMEBIT>
			      <REMOVE ,GREEN-MATCH>
			     <TELL
"You drop the lit " D ,GREEN-MATCH "." CR>)>
		       <RTRUE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,WATER>
		     <IN? ,BUCKET ,PLAYER>>
		<PERFORM ,V?FILL ,BUCKET ,WATER>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WATER>>
		<COND (<EQUAL? ,HERE ,NORTH-GARDEN>
		       <PERFORM ,V?PUT ,PRSO ,POND>
		       <RTRUE>)
		      (T
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " disappears into the ocean water." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,NORTH-GARDEN>
		       <PERFORM ,V?LOOK-INSIDE ,POND>
		       <RTRUE>)
		      (T
		       <TELL "You see nothing unusual about sea water." CR>)>)
	       (<AND <VERB? DRINK>
		     <PRSO? ,WATER>>
		<TELL "You take a sip." CR>)>>

<ROUTINE ALL-WET (THING "AUX" OBJ)
         <FSET .THING ,WETBIT>
	 <SET OBJ <FIRST? .THING>>
         <REPEAT ()
                 <COND (<ZERO? .OBJ>
                        <RETURN>)>
		 <FSET .OBJ ,WETBIT>
                 <COND (<FIRST? .OBJ> 
                        <ALL-WET .OBJ>)>
                 <SET OBJ <NEXT? .OBJ>>>
	 <COND (<FSET? ,RED-MATCH ,WAXED-BIT>
		<FCLEAR ,RED-MATCH ,WETBIT>)>
	 <COND (<FSET? ,GREEN-MATCH ,WAXED-BIT>
		<FCLEAR ,GREEN-MATCH ,WETBIT>)>>

;<ROUTINE ALL-WET (THING "AUX" OBJ)
         <SET OBJ <FIRST? .THING>>
         <REPEAT ()
                 <COND (<ZERO? .OBJ>
                        <RETURN>)>
                 <FSET .OBJ ,WETBIT>
                 <COND (<FIRST? .OBJ> 
                        <ALL-WET .OBJ>)>
                 <SET OBJ <NEXT? .OBJ>>>>

<ROOM ON-POOL-1
      (IN ROOMS)
      (DESC "Surface of Grotto Pool")
      (LDESC
"You are swimming on the surface of the pool. The water sparkles,
reflecting the light coming in from an opening to the north. To the
east is a boat dock.")      
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (WEST "You lose your footing and plunge back into the water.")
      (EAST PER TO-BOAT-DOCK)
      (OUT PER TO-BOAT-DOCK)
      (UP PER TO-BOAT-DOCK)
      (NORTH TO INLET)
      (SOUTH "The walls are too steep to climb.")
      (DOWN PER UNDER-WATER-F)
      (GLOBAL WATER)>

<ROUTINE TO-BOAT-DOCK ()
         <COND (<EQUAL? ,HERE ,ON-POOL-1>
	        <TELL
"You climb out of the pool and onto the boat dock. The night air makes you
shiver." CR CR>
                ,BOAT-DOCK)>>

<ROUTINE UNDER-WATER-F ()
	 <TELL "You take a deep breath then plunge down." CR CR>
	 <COND (<EQUAL? ,HERE ,ON-POOL-1>
                <GOTO ,IN-POOL-1>)
               (T
		<GOTO ,IN-POOL-2>)>
                ;"eventually will need a which-room routine here."
         ;<V-LOOK>
	 <SETG BREATH 6>
         <QUEUE I-BREATH -1>
	 <RFALSE>>
         
<GLOBAL BREATH 6>

<ROUTINE I-BREATH ()
	 <SETG BREATH <- ,BREATH 1>>
	 <COND (<EQUAL? ,BREATH 3>
		<TELL CR 
"You feel pressure building in your chest. You won't be able to hold
your breath much longer." CR>)
	       (<EQUAL? ,BREATH 2>
	       <TELL CR
"The pressure is increasing. Your feel as if your lungs are going to
rupture!" CR>)
	       (<EQUAL? ,BREATH 1>
		<TELL CR
"You can't hold the air in your lungs any longer. You open your mouth and the
air bursts out." CR>)
	       (<ZERO? ,BREATH>
		<TELL CR
"As you gasp for your next breath, you suck in a mouthful of cold sea water.
You swim frantically a short distance then pass out. Later you awake to find
yourself on the beach." CR CR>
		<GOTO ,BEACH>)>>

<ROOM IN-POOL-1
      (IN ROOMS)
      (DESC "Grotto, Underwater")
      (LDESC
"As you swim underwater you can see faint light above you and
darkness below.") 
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (UP PER OUT-OF-WATER-F)
      (DOWN TO UNDERPASS-1)
      (GLOBAL WATER)
      ;(ACTION IN-POOL-1-F)>

 ;"in pool desc mention less light, also mention more than just skeletons, too much of a give-away. also can you see the green of the water with just the full moon?"

;<ROUTINE IN-POOL-1-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are underwater. Through the green of the water you see">
		<COND (<EQUAL? ,HERE <LOC ,SKELETONS>>
		       <TELL A ,SKELETONS " below you">)
		      (T
		       <TELL
D ,BONES " scattered all around an opening leading down">)>
		<TELL "." CR>)>>

<ROUTINE OUT-OF-WATER-F ()
	 <DEQUEUE I-BREATH>
	 <TELL "You come to the surface and catch your breath." CR CR>
	 <COND (<EQUAL? ,HERE ,IN-POOL-1>
		<RETURN ,ON-POOL-1>)
               (<EQUAL? ,HERE ,IN-POOL-2>
		<RETURN ,ON-POOL-2>)>>

<ROOM UNDERPASS-1
      (IN ROOMS)
      (DESC "Underwater Passage")
      (LDESC
"You feel a mild current flowing east. You have to grit your teeth
to keep them from chattering in the cold water.")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (WEST PER TO-UNDERPASS-WEST)
      (UP TO IN-POOL-1)
      (GLOBAL WATER)>

<ROUTINE TO-UNDERPASS-EAST ()
	 <TELL "You swim east through a narrow, jagged passage." CR CR>
         <RETURN ,UNDERPASS-1>>

<ROUTINE TO-UNDERPASS-WEST ()
	 <TELL "You swim west through a narrow, jagged passage." CR CR>
         <RETURN ,UNDERPASS-2>>

<ROOM UNDERPASS-2
      (IN ROOMS)
      (DESC "Underwater Passage")
      (LDESC       ;"say dark and cold here"
"You feel a current coming from above and flowing east through the passage.")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (UP TO IN-POOL-2)
      (EAST PER TO-UNDERPASS-EAST)
      (GLOBAL WATER)>

;<ROOM UNDERPASS-3
      (IN ROOMS)
      (DESC "Underwater Passage")
      (LDESC
"The passage heads east into darkness. Above you there is an exit leading to
the pool in the grotto.") ;"could you see any off this?"
      (FLAGS RLANDBIT CAVEBIT)
      (EAST PER TO-UNDERPASS-EAST)
      (UP TO IN-POOL-2)
      (GLOBAL WATER)>

<ROOM IN-POOL-2
      (IN ROOMS)
      (DESC "Underwater")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (UP PER OUT-OF-WATER-F)
      (DOWN TO UNDERPASS-2)
      (GLOBAL WATER)
      (ACTION IN-POOL-2-F)>

<ROUTINE IN-POOL-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are swimming underwater. In the darkness, you can't make out your
surroundings here.">
		<COND (<LIT? ,ON-POOL-2>
		       <TELL
" However you do notice a faint light above you.">)>
		<RTRUE>
	       ;<CRLF>)>>

<ROOM ON-POOL-2
      (IN ROOMS)
      (DESC "Surface of Pool")
      (FLAGS RLANDBIT CAVEBIT)
      (NORTH TO LEDGE)
      (OUT "That's for you to figure out.")
      (SOUTH
"Feeling the wall with your hands you find there's no way out in this
direction.")
      (EAST
"With your hands you feel the eastern wall of the cave. You can't get out to
the east.") ;"change all these defaults"
      (WEST "The cave wall prevents any further westward movement.")
      (DOWN PER UNDER-WATER-F)
      (GLOBAL WATER)
      (ACTION ON-POOL-2-F)>

<ROUTINE ON-POOL-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are swimming on the surface of a pool ">
		<COND (<LIT? ,HERE>
		       <TELL
"inside a small grotto. To the north is a small ledge.">)
		      (T
		       <TELL
"in the dark. From the sound of your breathing you can tell this is a
fairly small area.">)>)>>

<ROOM LEDGE
      (IN ROOMS)
      (DESC "Ledge")
      (LDESC
"You're on a wet, narrow ledge in a dripping underground cave. There is a
pool of blackness to the south and a tunnel leads north.")
      (FLAGS RLANDBIT CAVEBIT)
      (NORTH TO TUNNEL)
      (DOWN "If you want to swim, say so.")
      (SOUTH "If you want to swim, say so.")
      (GLOBAL WATER)>

<ROOM TUNNEL
      (IN ROOMS)
      (DESC "Tunnel")
      (LDESC
"Your soggy footsteps echo through the long, slimy corridor which runs up,
towards a dry area, and south, toward dripping noises.")
      (SOUTH TO LEDGE) 
      (UP TO BOMB-SHELTER)
      (GLOBAL ROPE)
      (FLAGS RLANDBIT CAVEBIT)>


"--- Bomb Shelter ---"

<ROOM BOMB-SHELTER
      (IN ROOMS)
      (DESC "Bomb Shelter")
      (DOWN TO TUNNEL)
      (SOUTH TO TUNNEL)
      (UP PER TO-&-FROM-BOMB-SHELTER)
      (GLOBAL HATCH PLANK HATCH-HOLE) 
      (FLAGS RLANDBIT CAVEBIT LOCKEDBIT)
      (THINGS <PSEUDO (<> PULLEY PULLEY-PSEUDO)>)
      (ACTION BOMB-SHELTER-F)>

<ROUTINE BOMB-SHELTER-F (RARG)
	  <COND (<EQUAL? .RARG ,M-LOOK>
		 <TELL
"With its concrete walls and floor this room looks as if it might be
a bomb shelter. A heavy-duty sawhorse has" A ,PLANK " across it. ">
		 <COND (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
			<TELL
"A " D ,BS-SAFE " is on" T ,LEFT-END>)
		       (T
			<TELL
"Suspended above the left end of the plank by" A ,ROPE>
			<COND (<EQUAL? ,ROPE-LIFE 1 2>
			       <TELL ", which is burning,">)>
			<TELL
" is" A ,BS-SAFE ". The rope stretches from the safe, through a pulley in the
ceiling, to the floor where it is tied to a pipe running along the wall">)>
		 <TELL ". In the ceiling above" T ,RIGHT-END " there is a">
		 <COND (<FSET? ,HATCH ,OPENBIT>
			<TELL "n open">)
		       (T
			<TELL " closed">)>
		 <TELL
" hatch. A long chain hangs down from" T ,HATCH ". Just beneath" T ,HATCH "
there is a ">
		 <COND (<FSET? ,LADDER ,HUNG-BIT>
			<TELL D ,LADDER " hanging from a ">)>
		 <TELL
"pair of heavy-duty metal hooks protruding from the wall. There is a
doorway leading south.">)
		(<AND <EQUAL? .RARG ,M-BEG>
		      <VERB? HANG-UP>
		      <NOT ,PRSI>>
		 <PERFORM ,V?HANG-UP ,PRSO ,HOOKS>
		 <RTRUE>)>>

<OBJECT SAWHORSE
        (IN BOMB-SHELTER)
	(DESC "sawhorse")
	(SYNONYM SAWHORSE)
	(ADJECTIVE HEAVY) ;"SEM heavy-duty?"
	(FLAGS NDESCBIT)>

<OBJECT HATCH
	(IN LOCAL-GLOBALS)
	(DESC "hatch")
	(SYNONYM HATCH)
	(ADJECTIVE STEEL)
        (FLAGS DOORBIT NDESCBIT)
        (ACTION HATCH-F)>

<ROUTINE HATCH-F ()
         <COND (<AND <VERB? PUT>
		     <PRSI? ,HATCH>>
		<COND (<FSET? ,HATCH ,OPENBIT>
		       <PERFORM ,V?PUT ,PRSO ,HATCH-HOLE>
		       <RTRUE>)
		      (T
		       <TELL "The hatch is closed!" CR>)>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,HATCH ,OPENBIT>>>
		<COND (<EQUAL? ,HERE ,BOMB-SHELTER>
		       <TELL "That's for you to figure out." CR>)
		      (T
		       <TELL
"There doesn't seem to be any way to open it from this side." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,HATCH ,OPENBIT>>
		<TELL
"The " D ,HATCH " is open, revealing a hole about the size of a manhole." CR>
		<RTRUE>)
               (<AND <VERB? CLOSE>
		     <FSET? ,HATCH ,OPENBIT>>
		<COND (<EQUAL? ,HERE ,BOMB-SHELTER>
		       <TELL "That's for you to figure out." CR>)
		      (T
		       <FCLEAR ,HATCH ,OPENBIT>
		       <FSET ,HATCH-HOLE ,INVISIBLE>
		      ;<COND (<FSET? ,LADDER ,HUNG-BIT>
			      <MOVE ,LADDER ,BOMB-SHELTER>)>
		       <TELL
"With a show of strength which would make Aunt Hildegarde proud, you manage to
close the heavy hatch." CR>)>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,CLIFF>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <DO-WALK ,P?UP>)>)>>

<OBJECT CHAIN
	(IN BOMB-SHELTER)
	(DESC "long, greasy chain")
	(SYNONYM CHAIN)
	(ADJECTIVE LONG GREASY)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION CHAIN-F)>

<ROUTINE CHAIN-F ()
	 <COND (<VERB? PULL CLIMB-UP> 
		<TELL "You pull on the " D ,CHAIN>
		<COND (<VERB? CLIMB-UP>
		       <TELL " as you attempt to climb">)>
		<TELL " and" T ,HATCH>		
                <COND (<FSET? ,HATCH ,OPENBIT>		       
		       <TELL " drops, covering the">
		       <FCLEAR ,HATCH ,OPENBIT>
		       <FSET ,HATCH-HOLE ,INVISIBLE>)
		      (T
		       <TELL " pops up, revealing a">
		       <FSET ,HATCH ,OPENBIT>
		       <FCLEAR ,HATCH-HOLE ,INVISIBLE>)>
		      <TELL " hole in the ceiling.">
		      <COND (<VERB? CLIMB-UP>
			     <TELL
" The chain is too slippery to climb.">)>
		      <CRLF>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,CHAIN " hangs down to about eye-level from the hatch above." CR>)
	       (<VERB? TAKE>
		<TELL
"You can't take the chain; it's attached to the hatch." CR>)>>

"--- Plank ends ---"

<OBJECT LEFT-END
	(IN BOMB-SHELTER)
	(DESC "left end of the plank")
        (SYNONYM END PLANK BOARD)
        (ADJECTIVE LEFT ;ED)
        (FLAGS NDESCBIT VEHBIT CONTBIT OPENBIT SEARCHBIT)
	(GENERIC GENERIC-PLANK-F)
	(ACTION ENDS-F)>  ;"why contbit and no capacity?"

<OBJECT RIGHT-END
        (IN BOMB-SHELTER)
        (DESC "right end of the plank")
	(SYNONYM END PLANK BOARD)
	(ADJECTIVE RIGHT)
        (FLAGS NDESCBIT VEHBIT CONTBIT OPENBIT SEARCHBIT)
        (GENERIC GENERIC-PLANK-F)
        (ACTION ENDS-F)>

<GLOBAL WHICH-END-IS-UP RIGHT-END>

<ROUTINE ENDS-F ("OPTIONAL" (RARG <>))	
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <TOUCHING? ,PRSO>
		     <NOT <ULTIMATELY-IN? ,PRSO <LOC ,PLAYER>>>>
		<TELL ,YOU-CANT 
"reach it from here. You'll have to step off" T <LOC ,PLAYER> " first." CR>
		<RTRUE>)
	       (.RARG
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL "The " D ,PRSO " is ">
		<COND (<OR <AND <PRSO? ,RIGHT-END>
				<EQUAL? ,WHICH-END-IS-UP ,RIGHT-END>>
			   <AND <PRSO? ,LEFT-END>
				<EQUAL? ,WHICH-END-IS-UP ,LEFT-END>>>
                       <TELL "in the air">)
		      (T
		       <TELL "on the ground">)>
		<TELL "." CR>)
	       (<AND <VERB? PUSH-DOWN LOWER>
		     <NOT ,PRSI>>
		<COND (<NOT <EQUAL? ,PRSO ,WHICH-END-IS-UP>>
		       <ITS-ALREADY "down">)
		      (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
		       <TELL
"It won't budge. The safe is on the other end. You should have eaten
more carrots as Aunt Hildegarde told you to, instead of feeding them to
the dog. It might have improved your eyesight." CR>)
		      (<EQUAL? ,PRSO <LOC ,PLAYER>>
		       <TELL
"How can you do that to" T ,PRSO " when you're standing on it?" CR>)
		      (<AND <EQUAL? ,PRSO ,WHICH-END-IS-UP>
			    <OR <IN? ,PLAYER ,LEFT-END>
				<IN? ,PLAYER ,RIGHT-END>>>
		       <TELL
"You can't lower" T ,PRSO " when you're standing on" TR <LOC ,PLAYER>>)
		      (T
		       <TELL "You push down the ">
		       <COND (<EQUAL? ,WHICH-END-IS-UP ,RIGHT-END>
			      <SETG WHICH-END-IS-UP ,LEFT-END>
			      <TELL "right">)
			     (T
			      <SETG WHICH-END-IS-UP ,RIGHT-END>
			      <TELL "left">)>
		       <TELL
			" end of the plank and the other end goes up." CR>)>)
	       (<AND <VERB? RAISE>
		     <NOT ,PRSI>>
		<COND (<EQUAL? ,PRSO ,WHICH-END-IS-UP>
		       <ITS-ALREADY "in the air">)
		      (<EQUAL? ,PRSO <LOC ,PLAYER>>
		       <TELL
"How can you raise" T ,PRSO " when you're standing on it?" CR>)
		      (<AND <EQUAL? ,PRSO ,LEFT-END>
			    <FSET? ,BS-SAFE ,ON-GROUND-BIT>>
		       <TELL
"You can't raise the left end when the safe is on it." CR>)
		      (T
		       <TELL "You raise the ">
		       <COND (<EQUAL? ,WHICH-END-IS-UP ,RIGHT-END>
			      <SETG WHICH-END-IS-UP ,LEFT-END>
			      <TELL "left">)
			     (T
			      <SETG WHICH-END-IS-UP ,RIGHT-END>
			      <TELL "right">)>
		       <TELL
" end of the plank and the other end goes down." CR>)>)
	       (<VERB? STAND-ON CLIMB-ON>
		<COND (<EQUAL? ,WHICH-END-IS-UP ,PRSO>
		       <IN-AIR>)
		      (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
		       <TELL
,YOU-CANT "do that. The " D ,BS-SAFE " is already there." CR>)
		      (<FSET? ,SKIS ,WORNBIT>
		       <TELL
"You step onto" T ,PLANK " but ski right off." CR>) 
		      (T
		       <PERFORM ,V?BOARD ,PRSO>
		       <RTRUE>)>)
	       (<VERB? PUT PUT-ON>
		<SLIDES-OFF>)>>

<ROUTINE IN-AIR ()
         <TELL "It's in the air. How can you stand on it?" CR>>


"--- Plank ---"

<OBJECT PLANK
        (IN LOCAL-GLOBALS)
        (DESC "heavy wooden plank")
	(SYNONYM ;END PLANK BOARD)
        (ADJECTIVE WOODEN HEAVY)
	(FLAGS NDESCBIT TRYTAKEBIT)
        (GENERIC GENERIC-PLANK-F)
        (ACTION PLANK-F)>

<ROUTINE GENERIC-PLANK-F ()
	 <COND (<VERB? STAND-ON CLIMB-ON>
		<RFALSE>)                           ;"asks which end you mean?"
	       (T
		,PLANK)>>

<ROUTINE PLANK-F ()
	 <COND (<AND <VERB? STAND-ON CLIMB-ON>
		     <NOT ,LIT>>
		<TOO-DARK>)
	       (<VERB? EXAMINE> 
		<TELL
"The " D ,PLANK " is about 12 feet long and several inches thick. The
right end of the plank is ">
		<COND (<EQUAL? ,WHICH-END-IS-UP ,RIGHT-END>
		       <TELL "in the air ">)
		      (T
		       <TELL "on the ground ">)>
		<TELL "and the left end is ">
		<COND (<EQUAL? ,WHICH-END-IS-UP ,RIGHT-END>
		       <TELL "on the ground">
		       <COND (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
			      <TELL " with" A ,BS-SAFE " sitting on it">)>)
		      (T
		       <TELL "in the air">)>
		<TELL "." CR>
		<RTRUE>)
	       (<AND <VERB? DISEMBARK>
		     <OR <IN? ,PLAYER ,RIGHT-END>
			 <IN? ,PLAYER ,LEFT-END>>>
		<PERFORM ,V?DISEMBARK <LOC ,PLAYER>>
		<RTRUE>)
	       (<AND <VERB? PUSH-DOWN>            	  ;"what does this do?"
		     <NOT ,PRSI>>
		<ENDS-F>)
	       (<VERB? TAKE>
		<TELL ,SPINACH CR>)
	       (<VERB? PUT PUT-ON>
		<SLIDES-OFF>)>>

<ROUTINE SLIDES-OFF ()
	 <TELL "The " D ,PRSO " slides off onto the ground." CR>
	 <MOVE ,PRSO ,HERE>>

<ROUTINE PULLEY-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "The pulley is firmly attached to the ceiling." CR>)>>

<OBJECT PIPE
        (IN BOMB-SHELTER)
        (DESC "pipe")
        (SYNONYM PIPE)
	(FLAGS NDESCBIT)
        (ACTION PIPE-F)>

<ROUTINE PIPE-F ()
	 <COND (<VERB? UNTIE>
		<TELL
"You can't even loosen the knot because of the weight of the safe." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The " D ,PIPE " runs along a wall of the bomb shelter">
		<COND (<NOT <EQUAL? ,ROPE-LIFE 0>>
		       <TELL ". There is a rope tied to it">)>
		<TELL "." CR>)>>

<OBJECT BS-SAFE
        (IN BOMB-SHELTER)
        (DESC "safe")
	(SYNONYM DIAL SAFE)
	(ADJECTIVE BIG)
	(FLAGS TRYTAKEBIT NDESCBIT CONTBIT LOCKEDBIT SEARCHBIT)
	(CAPACITY 33)
        (ACTION BS-SAFE-F)>

<GLOBAL STEPS-THROUGH-BS-SAFE 0>

<GLOBAL BS-SAFE-DIAL-NUMBER 3> 

;"Safe combo- Left 4, Right 5, Left 7"

<ROUTINE BS-SAFE-F ()
	 <COND (<AND <VERB? TURN-LEFT TURN-RIGHT>
		     <PRSI? ,INTNUM>>
		<COND (<NOT <FSET? ,BS-SAFE ,ON-GROUND-BIT>>
		       <TELL "You can't reach the safe from here." CR>)
		      (T
		       <COND ;(<EQUAL? ,P-NUMBER ,BS-SAFE-DIAL-NUMBER>
			      <TELL
"It's already set to " N ,BS-SAFE-DIAL-NUMBER "." CR>)
			     (<G? ,P-NUMBER 10>
			      <TELL "The dial only goes to 10." CR>)
			     (T
			      <SETG BS-SAFE-DIAL-NUMBER ,P-NUMBER>
			      <TELL
"You turn the dial to " N ,BS-SAFE-DIAL-NUMBER ".">  			      
			      <COND (<AND <NOT <FSET? ,BS-SAFE ,OPENBIT>>
					  <EQUAL? ,STEPS-THROUGH-BS-SAFE 0>
					  <VERB? TURN-LEFT>
					  <EQUAL? ,BS-SAFE-DIAL-NUMBER 4>>
				     <SETG STEPS-THROUGH-BS-SAFE 1>)
				    (<AND <NOT <FSET? ,BS-SAFE ,OPENBIT>>
					  <EQUAL? ,STEPS-THROUGH-BS-SAFE 1>
					  <VERB? TURN-RIGHT>
					  <EQUAL? ,BS-SAFE-DIAL-NUMBER 5>>
				     <SETG STEPS-THROUGH-BS-SAFE 2>)
				    (<AND <NOT <FSET? ,BS-SAFE ,OPENBIT>>
					  <EQUAL? ,STEPS-THROUGH-BS-SAFE 2>
					  <VERB? TURN-LEFT>
					  <EQUAL? ,BS-SAFE-DIAL-NUMBER 7>>
				     <SETG STEPS-THROUGH-BS-SAFE 3>
				     <FCLEAR ,BS-SAFE ,LOCKEDBIT>
				    ;<FSET ,BS-SAFE ,OPENBIT>
				     <TELL
" You hear a faint click.">)
				    (T
				     <SETG STEPS-THROUGH-BS-SAFE 0>)>
			      <CRLF>)>)>)
	       (<VERB? TURN TURN-RIGHT TURN-LEFT>
		<COND (<NOT <FSET? ,BS-SAFE ,ON-GROUND-BIT>>
		       <TELL "You can't reach the safe from here." CR>)
		      (T		      
		       <COND (<EQUAL? ,PRSI <> ,ROOMS>
			      <TELL
"You didn't say what number you wanted to turn the dial to, or the direction."
			       CR>)
			     (<EQUAL? ,PRSI ,INTNUM>
			      <TELL
"You didn't say whether you wanted to turn the dial RIGHT to "
N ,P-NUMBER " or LEFT to " N ,P-NUMBER "." CR>)
			     (T
			      <TELL "Huh?" CR>)>)>)
	       (<VERB? EXAMINE>
		<TELL "The " D ,BS-SAFE " is ">
		<COND (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
		       <TELL
"sitting on" T ,LEFT-END ". There is a dial on the safe which can be set to
any number between 0 and 10. The dial is set to " N ,BS-SAFE-DIAL-NUMBER>)
		      (T
		       <TELL "suspended overhead by" A ,ROPE>)>
		<TELL
". There is a small plaque on the front of" T ,BS-SAFE ". ">
		<RFALSE>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,BS-SAFE ,OPENBIT>>
		<FSET ,BS-SAFE ,LOCKEDBIT>
		<RFALSE>)>>

<OBJECT PLAQUE
        (IN BOMB-SHELTER)
	(DESC "plaque")
	(SYNONYM PLAQUE)
	(FLAGS READBIT NDESCBIT)
       ;(TEXT
" LEVY, REGAN, LEBLING~
     SAFE COMPANY~
 UPPER SANDUSKY, OHIO~
         1936")
	(ACTION PLAQUE-F)>

<ROUTINE PLAQUE-F ()
	 <COND (<NOT <FSET? ,BS-SAFE ,ON-GROUND-BIT>>
		<TELL
"It's up too high. " ,YOU-CANT "read it from here." CR>)
	       (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
" LEVY, REGAN, LEBLING~
     SAFE COMPANY~
 UPPER SANDUSKY, OHIO~
         1936">
		<FIXED-FONT-OFF>)>>

;<OBJECT BS-SAFE-DIAL
	(IN BOMB-SHELTER)
	(DESC "dial")
	(SYNONYM DIAL)
        (FLAGS NDESCBIT)
	(ACTION BS-SAFE-DIAL-F)>   ;"SEM could I just use an ldesc here?"

;<ROUTINE BS-SAFE-DIAL-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,BS-SAFE ,ON-GROUND-BIT>
		       <TELL
"The " D ,DIAL " can be set to any number between 0 and 100." CR>)
		      (T
                       <TELL
"It's too high up to make out any detail." CR>)>)>>

<OBJECT CORPSE-LINE
        (IN BS-SAFE)
	(DESC "copy of the film \"A Corpse Line\"")
	(SYNONYM CORPSE LINE FILM MOVIE)
	(ADJECTIVE REEL COPY CORPSE)
        (SIZE 10)
	(VALUE 10)
	(FLAGS TAKEBIT)
	(ACTION CORPSE-LINE-F)>

<ROUTINE CORPSE-LINE-F ()
         <COND (<VERB? EXAMINE>
		<COND (<AND <IN? ,CORPSE-LINE ,FILM-PROJECTOR>
			    <FSET? ,FILM-PROJECTOR ,ONBIT>>
		       <PERFORM ,V?EXAMINE ,PROJECTION-SCREEN>
		       <RTRUE>)
		      (T
		       <TELL
"It's a copy of the film \"A Corpse Line,\" on a large film reel." CR>)>)
	       (<VERB? TAKE>
		<COND (<AND <IN? ,CORPSE-LINE ,FILM-PROJECTOR>
			    <FSET? ,FILM-PROJECTOR ,ONBIT>>
		       <TELL
"Even a nonunion projectionist like yourself should know how dangerous
it is to try to take film from" A ,FILM-PROJECTOR " while it's running."
CR>)>)
	       (<AND <VERB? PUT>
		     <FSET? ,FILM-PROJECTOR ,ONBIT>
		     <PRSI? ,FILM-PROJECTOR>>
		<TELL
"You start to put" T ,CORPSE-LINE " in" T ,FILM-PROJECTOR ", but glance
up at a sign on the wall. The sign states: Remember, Perry Projectionist
sez, \"Never try to put film in" A ,FILM-PROJECTOR " that's turned
on.\"" CR>)
	       (<VERB? SHOW>
		<TELL "It is a little more complicated than that." CR>)>>

<ROUTINE RUBBER-STAMP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the large rubber stamp Buck Palace used to mail the POW's to the
Pentagon in Uncle Buddy's \"Address Unknown.\"" CR>)>>


"--- Rope ---"

<OBJECT ROPE
	(IN BOMB-SHELTER)
	(DESC "rope")
	(SYNONYM ROPE)
        (FLAGS ;TAKEBIT TRYTAKEBIT NDESCBIT BURNBIT)
       ;(SIZE 10)
	(ACTION ROPE-F)>

<GLOBAL ROPE-LIFE 3>

<ROUTINE ROPE-F ()
	 <COND (<VERB? TAKE TIE UNTIE>
                <COND (<EQUAL? ,ROPE-LIFE 1 2>
                       <TELL "You'd burn your hand. It's on fire!" CR>)
	              (T
		       <TELL
"You can't even loosen the knot because of the weight of" TR ,BS-SAFE>)>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,ROPE-LIFE 2>
		       <TELL
"One end of" T ,ROPE " is tied around" T ,BS-SAFE" and the other end is tied to
a pipe running along the wall." CR>) 
		      (<EQUAL? ,ROPE-LIFE 1>
		       <TELL
"The rope is burning and is tied to" TR ,BS-SAFE>)>)
	       (<AND <VERB? PUT-UNDER>
		     <PRSO? ,RED-CANDLE ,BLUE-CANDLE ,WHITE-CANDLE>
		     <FSET? ,PRSO ,FLAMEBIT>>
		<PERFORM ,V?BURN ,ROPE ,PRSO>
		<RTRUE>)
	       (<VERB? BURN>
		<COND (<SET-FLAME-SOURCE>
		       <RTRUE>)
		      (<NOT <FSET? ,PRSI ,FLAMEBIT>>
		       <TELL "Huh?" CR>)
		      (<L? ,ROPE-LIFE 3>
		       <ITS-ALREADY "burning">)
		      (<EQUAL? ,ROPE-LIFE 3>	                   
		       <TELL					
"You touch the flame to the rope then pull it back. The rope catches fire and
begins to burn." CR>
		       <SETG ROPE-LIFE 2>
		       <FSET ,ROPE ,ONBIT>
                       <QUEUE I-ROPE-BURN 2>)>)
	       (<AND <VERB? PULL>
		     <NOT <FSET? ,BS-SAFE ,ON-GROUND-BIT>>>
		<TELL
		 "You pull on" T ,ROPE " but nothing happens." CR>)
	       (<VERB? TIE>
		<TELL
,YOU-CANT" do that. The " D ,ROPE " is already tied to" TR ,BS-SAFE>)
	       (<VERB? CLIMB-UP>
		<TELL
"You climb the rope, almost reaching the safe, then lose your grip and
drop to the ground." CR>)
	       (T
		<RFALSE>)>>                      ;"why rfalse here?"

<ROUTINE I-ROPE-BURN ()
	 <SETG ROPE-LIFE <- ,ROPE-LIFE 1>>
         <COND (<ZERO? ,ROPE-LIFE>
		<CRLF>
		<DEQUEUE I-ROPE-BURN>
		<BURN-THROUGH-ROPE>)
               (T
		<TELL CR "The " D ,ROPE " continues to burn." CR>
		<QUEUE I-ROPE-BURN -1>
                <RTRUE>)>>

<ROUTINE BURN-THROUGH-ROPE ()
	 <COND (<OR <EQUAL? ,HERE ,TUNNEL>
		    <EQUAL? ,HERE ,LEDGE>>
		<TELL "You hear a crash echo from the bomb shelter." CR>)
	       (<EQUAL? ,HERE ,BOMB-SHELTER>
		<TELL
"As the flame burns through" T ,ROPE " it snaps and" T ,BS-SAFE " crashes down
on" T ,LEFT-END>		
		<COND (<EQUAL? <LOC ,PLAYER> ,RIGHT-END>
		       <TELL ". The " D ,RIGHT-END " catapults you up">
		       <COND (<FSET? ,HATCH ,OPENBIT>
			      <TELL
" through the opening in the ceiling. The thrilling sensation of flying ends
as you land on your feet on a cliff." CR CR>
			      <GOTO ,CLIFF>)
			     (T
			      <JIGS-UP

". Unfortunately the hatch was closed. Your body crumples like an empty
beer can at a frat party as you smash into the closed hatch. You black
out as your body hits the ground with a plop!">)>)
		      (<EQUAL? <LOC ,PLAYER> ,LEFT-END>		          
		       <JIGS-UP
". Unfortunately you were standing on the left end of the plank.">)
		      (T
		       ;"Not on either end of the plank"
		       <TELL ". The rope burns up and turns to ashes." CR>)>)>
	 <FSET ,BS-SAFE ,ON-GROUND-BIT>
	 <SETG ROPE-LIFE 0>
	 <FCLEAR ,ROPE ,ONBIT>
         <REMOVE ,ROPE>		       
	 <SETG WHICH-END-IS-UP ,RIGHT-END>>

<ROUTINE I-SUNRISE ()
	 <COND (<OR <FSET? ,HERE ,OUTDOORSBIT>
		    <EQUAL? <GETP ,HERE ,P?CAPACITY> 20>>
		<COND (<EQUAL? ,MOVES 547> ;"6:07 A.M."
		       <QUEUE I-SUNRISE 10>
		       <DEQUEUE I-NOISE>
		       <TELL CR
"The sun begins to rise over the colony." CR>)
		      (<EQUAL? ,MOVES 557>
		       <FSET ,GAME-ROOM ,ONBIT>
		       <FSET ,SHORT-HALL ,ONBIT>
		       <FSET ,OUTSIDE-PARLOR ,ONBIT>
		       <FSET ,FOYER ,ONBIT>
		       <FSET ,LIVING-ROOM ,ONBIT>
		       <FSET ,KITCHEN ,ONBIT>
		       <FSET ,DINING-ROOM ,ONBIT>
		       <FSET ,BEDROOM-1 ,ONBIT>
		       <FSET ,BEDROOM-2 ,ONBIT>
		       <FSET ,BEDROOM-3 ,ONBIT>
		       <FSET ,UPSTAIRS-HALL-EAST ,ONBIT>
		       <FSET ,UPSTAIRS-HALL-MIDDLE ,ONBIT>
		       <FSET ,UPSTAIRS-HALL-WEST ,ONBIT>       
		       <TELL CR
"The sun rises in the sky, signalling a new day in Malibu." CR>)>)>>


