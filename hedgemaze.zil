"HEDGEMAZE for ANTHILL (C)1986 by Infocom Inc. All Rights Reserved." 

<ROOM GAME-ROOM
      (IN ROOMS)
      (DESC "Game Room")
      (LDESC
"This was your favorite room as a child. Each summer Uncle Buddy would
have props and models from his various movies brought here for the
amusement of his numerous guests. There is a scale model of downtown
Tokyo here. Doorways lead south, east and west. There is a door to the
north.")
      (FLAGS RLANDBIT LOCKEDBIT)
      (NORTH TO PATIO IF PATIO-DOOR IS OPEN)
      (EAST TO SHORT-HALL)
      (WEST TO DINING-ROOM)
      (SOUTH TO FOYER)
      (GLOBAL PATIO-DOOR WINDOW)
      (CAPACITY 20) ;"Tell--sun coming up"
      (THINGS <PSEUDO (CENTRAL PARK PARK-PSEUDO)
		      (PLASTIC DOME DOME-PSEUDO)
		      (TINY TRUCK TRUCK-PSEUDO)
		      (<> ROCKET ROCKET-PSEUDO)
		      (<> HOLE DOME-HOLE-PSEUDO)
		      (MELTED SPOT DOME-HOLE-PSEUDO)>)>

<ROUTINE PARK-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's Tokyo Central Park, filled with little plastic trees and shrubs, and
little plastic people sitting on little plastic benches. Tokyo's Main Street
stops on the west side of the park then continues on the east side of the
park. ">
		<COND (<EQUAL? ,DOG-LOC 6>
		       <TELL
"In the western half of the park you can't help but notice
the out-of-place " D ,DOG>
		       <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>;"missile"
			      <TELL
" with a small rocket buzzing around it.">)
			     (T
			      <TELL ".">)>
		       <COND (<AND <NOT <EQUAL? ,TRUCK-LOC 33>>
				   <NOT <EQUAL? ,TRUCK-LOC 30>>>
			      <TELL
" A tiny truck is near some plastic trees in the eastern half of
the park.">)>
		      ;<CRLF>)
		      (T
		       <TELL "In the eastern half of the park there">
                       <COND (<FSET? ,MONUMENT ,TRASHED-BIT>
			      <TELL
" are bits and pieces of a smashed monument. ">
			      <COND (<AND <NOT <FSET? ,DOG ,CLUTCHING-BIT>>
					  ,RING-UNDER-DOME>
			             <TELL
"Lying near the remains of the monument is" A ,RING ". ">)>)
			     (T
			      <TELL " is a monument. ">)>
		       <COND (<FSET? ,RING ,ON-MONUMENT-BIT>
			      <TELL
"There is" A ,RING " perched on top of the monument. ">)>
		       <COND (<EQUAL? ,DOG-LOC 7>
			      <TELL
"The " D ,DOG " is standing in front of the monument and a ">
			      <COND (<EQUAL? ,TRUCK-LOC 30>
				     <TELL "smashed ">)>
			      <TELL "truck is at his feet.">
			      <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>
				     <TELL
 " There is a rocket flying around the dog.">)>)
			     (<EQUAL? ,DOG-LOC 30>
			      <TELL
"Scattered on the west and east sides of the park are pieces of fur and scales,
mixed with bits of wire and a couple of servomotors.">
			      <COND (<FSET? ,DOG ,CLUTCHING-BIT>
				     <TELL
" A " D ,RING " is lying near the debris.">)>)>)>
		<CRLF>
                <RTRUE>)
	       (<TOUCHING? ,PSEUDO-OBJECT>
		<TELL
"You can't touch the park. It's under the plastic dome." CR>)>>

<ROUTINE DOME-PSEUDO ()
         <COND (<VERB? EXAMINE>
		<TELL
"The thick plastic dome covers the model of downtown Tokyo">
		<COND (<L? ,BURN-DOME 3>
		       <TELL ". There is a ">
		       <COND (<EQUAL? ,BURN-DOME 2>
		              <TELL "slightly melted spot">)
		             (<EQUAL? ,BURN-DOME 1>
		              <TELL "melted spot, almost a hole">)
		             (<EQUAL? ,BURN-DOME 0>
		              <TELL "small hole">)>
		       <TELL " on the dome's eastern side">)>
		<TELL "." CR>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?EXAMINE ,TOKYO>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,BURN-DOME 0>> ;"hole burned in dome"
		<TELL "You don't want to ruin the delicate model." CR>)>>

<ROUTINE DOME-HOLE-PSEUDO ()              ;"SEM--ELSE HERE?"
	 <COND (<EQUAL? ,BURN-DOME 3>
		<CANT-SEE-ANY>)
	       (<AND <VERB? EXAMINE>
		     <L? ,BURN-DOME 3>> ;"was ,dome-hole"
		<TELL "There is a ">
	        <COND (<EQUAL? ,BURN-DOME 2>
		       <TELL "slightly melted spot">)
		      (<EQUAL? ,BURN-DOME 1>
		       <TELL "melted spot, almost a hole,">)
		      (<EQUAL? ,BURN-DOME 0>
		       <TELL "hole about the size of an orange">)>
		<TELL " on the dome's eastern side." CR>)
	       (<AND <VERB? REACH-IN>
		     <FSET? ,DOG ,CLUTCHING-BIT>
		     <EQUAL? ,BURN-DOME 0>>
		<TELL "The " D ,RING ": ">
		<PERFORM ,V?TAKE ,RING>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
	        <TELL "You see downtown Tokyo." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,BURN-DOME 0>> ;"hole burned in dome"
		<TELL "You don't want to ruin the delicate model." CR>)>>

<ROUTINE TRUCK-PSEUDO ()
         <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,TRUCK-LOC 33>  ;"OFF STAGE"
		       <TELL "You can't see any tiny truck here." CR>)
		      (<EQUAL? ,TRUCK-LOC 30>
		       <TELL
"The tiny truck is smashed into tiny bits and pieces." CR>)
	              (T
		       <TELL
"It's a tiny truck with a small radar dish which is pointing at" TR ,DOG>)>)
	       (<TOUCHING? ,PSEUDO-OBJECT>
		<TELL
"You can't reach the tiny truck. It's under the plastic dome." CR>)>>

<ROUTINE ROCKET-PSEUDO ()
         <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,ROCKET-LOC 33>
		       <TELL "You can't see any rocket here." CR>)
		      (<EQUAL? ,ROCKET-LOC 30>
		       <TELL
"You can't see any rocket here. It has been destroyed." CR>)
	              (T
		       <TELL
"The rocket is circling around" TR ,DOG>)>)
	       (<TOUCHING? ,PSEUDO-OBJECT>
		<TELL
"You can't reach the rocket. It's under the plastic dome." CR>)>>

<OBJECT TOKYO
        (IN GAME-ROOM)
	(DESC "scale model of downtown Tokyo")
	(SYNONYM TOKYO CITY DOWNTO MODEL)
	(ADJECTIVE SCALE DOWNTO)
        (FLAGS NDESCBIT)
	(ACTION TOKYO-F)>

<ROUTINE TOKYO-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the scale model of downtown Tokyo used in the movie \"Atomic
Chihuahuas From Hell.\" In the center of the model is Tokyo Central Park. ">
		<TELL "In the eastern half of the park there ">
                <COND (<FSET? ,MONUMENT ,TRASHED-BIT>
		       <TELL
"are bits and pieces of a smashed monument.">
		       <COND (<AND <NOT <FSET? ,DOG ,CLUTCHING-BIT>>
				   ,RING-UNDER-DOME>
			      <TELL
" Lying near the remains of the monument is" A ,RING ".">)>)
		      (T
		       <TELL "is a monument.">)>
		<COND (<FSET? ,RING ,ON-MONUMENT-BIT>
		       <TELL
" There is" A ,RING " perched on top of the monument.">)>
		<TELL
" Stretching east and west from the park is Tokyo's main street. ">

;"mention dog"  <COND (<EQUAL? ,DOG-LOC 30>
		       <TELL
"Scattered throughout the park are pieces of fur and scales mixed with
bits of wire and a couple of servomotors.">
		        <COND (<FSET? ,DOG ,CLUTCHING-BIT>
				     <TELL
" A " D ,RING " is lying near the debris.">)>)
		      (<EQUAL? ,DOG-LOC 20>
		       <TELL
"West of the park," T ,DOG " is lying in the street.">)
		      (<EQUAL? ,DOG-LOC 40>
		       <TELL
"Scattered in the street east of the park are pieces of fur and scales
mixed with bits of wire and a couple of servomotors.">
		        <COND (<FSET? ,DOG ,CLUTCHING-BIT>
				     <TELL
" A " D ,RING " is lying near the debris.">)>)
		      (<AND <L? ,DOG-LOC 6>
	                    <G? ,DOG-LOC 0>>
		       <TELL
"In the street west of the park there is an " D ,DOG>
		       <COND (<OR <EQUAL? ,DOG-LOC ,TANK-LOC <- ,TANK-LOC 1>>
				 <EQUAL? ,DOG-LOC ,PLANE-LOC <- ,PLANE-LOC 1>>>
			      <TELL " under attack">)>
		       <TELL ".">)
		      (<EQUAL? ,DOG-LOC 6 7>
		       <TELL "There is an " D ,DOG " in the park">
		       <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>
			      <TELL " with a rocket buzzing around it">)>
		       <TELL ".">)
		      (<G? ,DOG-LOC 7>
		       <TELL
"There is an " D ,DOG " in the street east of the park">
		       <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>
			      <TELL " with a rocket buzzing around it">)>
		       <TELL ".">)>
		<TELL
" The entire model is covered by a thick plastic dome">
		<COND (<L? ,BURN-DOME 3>
		       <TELL " which has a ">
		       <COND (<EQUAL? ,BURN-DOME 2>
			      <TELL "slightly melted spot">)
			     (<EQUAL? ,BURN-DOME 1>
			      <TELL "melted spot">)
			     (<EQUAL? ,BURN-DOME 0>
			      <TELL "small hole">)>
		       <TELL " in it near the east end">)>
		<TELL
". Outside the dome on the model there are five buttons: a blue button, a
black button, a green button, a white button and a red button." CR>)>>

<OBJECT MONUMENT
	(IN GAME-ROOM)
	(DESC "monument")
	(SYNONYM MONUMENT)
	(FLAGS NDESCBIT)
	(ACTION MONUMENT-F)>

<ROUTINE MONUMENT-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's ">
                <COND (<FSET? ,MONUMENT ,TRASHED-BIT>
		       <TELL "what's left of ">)>
		<TELL
"a memorial dedicated to the brave Japanese men and women who have died
defending Tokyo against various monsters">
		<COND (<FSET? ,RING ,ON-MONUMENT-BIT>
		       <TELL ". A " D ,RING " is sitting atop the monument">)
		      (<AND <FSET? ,MONUMENT ,TRASHED-BIT>
			    <NOT <FSET? ,DOG ,CLUTCHING-BIT>>>
		       <TELL
". There is" A ,RING " lying next to the monument rubble">)>
		<TELL "." CR>)
	       (<TOUCHING? ,MONUMENT>
		<TELL
"You can't reach" T ,MONUMENT ". It's under the plastic dome." CR>)>> 

<OBJECT RING
	(IN GAME-ROOM)
	(DESC "Big Diamond Ring")
	(SYNONYM RING)
        (ADJECTIVE DIAMOND BIG)
	(FLAGS WEARBIT NDESCBIT TRYTAKEBIT TAKEBIT ON-MONUMENT-BIT)
	(SIZE 2)
	(VALUE 10)
	(ACTION RING-F)>

<GLOBAL RING-UNDER-DOME T>

<ROUTINE RING-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's" T ,RING " from Uncle Buddy's movie \"The Big Diamond Ring.\"" CR>)
	       (<AND <VERB? TAKE>
		     <FSET? ,RING ,TRYTAKEBIT>>
		<COND (<EQUAL? ,BURN-DOME 0> ;"hole burned in dome"
		       <COND (<FSET? ,DOG ,CLUTCHING-BIT>
			      <FCLEAR ,RING ,TRYTAKEBIT>
			      <FCLEAR ,DOG ,CLUTCHING-BIT>
			      <FCLEAR ,RING ,NDESCBIT>
			      <SETG RING-UNDER-DOME <>>
			      <RFALSE>)
			     (T
		       	      <TELL
"It's in the park in the middle of downtown Tokyo, the model that is.
Despite the hole, you can't reach it from here." CR>)>)
		      (T
		       <TELL
"It's under the plastic dome. You can't reach it." CR>)>)
	       (<AND <VERB? CUT>
		     <PRSI? ,RING>>
		<TELL
"You don't think that's a real diamond, do you? Not in one of Uncle
Buddy's movies." CR>)>>

<OBJECT TANK
	(IN GAME-ROOM)
	(SDESC "tiny tanks")
        (SYNONYM TANK TANKS)
	(ADJECTIVE TINY)
	(FLAGS NDESCBIT)
	(ACTION TANK-F)>

<ROUTINE TANK-F ()
         <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,TANK-LOC 33>  ;"OFF STAGE"
		       <TELL "You can't see any " D ,TANK " here." CR>)
	              (T
		       <RFALSE>)>)
	       (<TOUCHING? ,TANK>
		<TELL
"You can't reach" T ,TANK " under the plastic dome." CR>)>>

<OBJECT PLANE
        (IN GAME-ROOM)
	(SDESC "puny plane")
	(SYNONYM PLANE AIRPLANE PLANES)
	(ADJECTIVE PUNY)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION PLANE-F)>

<ROUTINE PLANE-F ()
         <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,PLANE-LOC 33>  ;"OFF STAGE"
		       <TELL "You can't see any " D ,PLANE " here." CR>)
	              (T
		       <RFALSE>)>)
	       (<TOUCHING? ,PLANE>
		<TELL
"You can't reach" T ,PLANE " under the plastic dome." CR>)>>

<OBJECT DOG
        (IN GAME-ROOM)
	(DESC "Atomic Chihuahua")
	(SYNONYM CHIHUAHUA DOG MONSTER)
	(ADJECTIVE ATOMIC)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION DOG-F)>

<ROUTINE DOG-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,DOG-LOC 30 40>
		       <TELL
"There's nothing left but bits of fur and scales mixed with pieces of wire
and a couple of servomotors." CR>
		       <RTRUE>)
		      (T
		       <TELL
"Being atomic, it bears little resemblance to the prancing rats you're
used to seeing, except for the bulging eyes, of course. It has a furry
underbelly, but in most places scales have replaced hair, giving it a
more reptilian look. Its front paws are now heavy, clawed appendages
and it has fierce-looking fangs. ">
		       <COND (<EQUAL? ,DOG-LOC 20>
		              <TELL
"It's lying on its side in the street, west of the park.">)
		             (T
		              <TELL
"It's standing on its hind legs balanced by its huge mutated spiny tail.">)>
		      <COND (<AND <G? ,HIT-POINTS 29>
			          <L? ,HIT-POINTS 33>>  ;"SEM"
			          <TELL " It seems near death.">)
		             (<AND <G? ,HIT-POINTS 25>
			           <L? ,HIT-POINTS 29>>
		                   <TELL
" The repeated attacks are taking their toll.">)>
		       <COND (<FSET? ,DOG ,CLUTCHING-BIT>
			      <TELL
" It's clutching" A ,RING " with its claws.">)>
		       <CRLF>)>)
	       (<TOUCHING? ,DOG>
		<COND (<AND <VERB? TAKE>
			    <PRSI? ,DOG>
			    <PRSO? ,RING>
			    <EQUAL? ,BURN-DOME 0>
			    <FSET? ,DOG ,CLUTCHING-BIT>>
		       <RFALSE>)>
		<TELL
"You can't reach" T ,DOG ". It's under the plastic dome." CR>)>>

<OBJECT RED-BUTTON      ;"bark/breath fire"
	(IN GAME-ROOM)
	(DESC "red button")
	(SYNONYM BUTTON)
	(ADJECTIVE RED)
	(FLAGS NDESCBIT)
	(ACTION RED-BUTTON-F)>

<GLOBAL BURN-DOME 3>
<GLOBAL DOG-BREATH 3>

<ROUTINE RED-BUTTON-F ()   ;"bark/breath fire"
	 <COND (<VERB? PUSH>
		<COND (<DOG-DEAD?>
		       <RTRUE>)
		      (<EQUAL? ,DOG-BREATH 0>
		       <TELL
"You hear a faint gagging noise coming from" T ,DOG ", then see a little smoke
rise from his nostrils." CR>
		       <RTRUE>)
		      (T
		       <SETG DOG-BREATH <- ,DOG-BREATH 1>>
		       <COND (<EQUAL? ,DOG-LOC ,PLANE-LOC>
			      <COND (<EQUAL? ,PLANES-LEFT 2>
				     <SETG PLANES-LEFT 1>
				     <PUTP ,PLANE ,P?SDESC "puny plane">
				     <TELL
"A gout of flame from the maw of the plutonium puppy burns up one
of the puny planes." CR>)
				    (T
				     ;<REMOVE ,PLANE>
			      ;"SEM" <MOVE ,PLANE ,P-NMERGE> ;"temp fix"
				     <SETG PLANES-LEFT 0>
				     <SETG PLANE-LOC 30> 
				     <TELL
"An eight-inch flame shoots from the dog's mouth, burning up the remaining
puny plane." CR>)>)
			     (<AND <EQUAL? ,DOG-LOC 6 7>
				   <NOT <EQUAL? ,ROCKET-LIFE 0>>>
			      <DEQUEUE ,I-ROCKET-ATTACK>
			      <SETG ROCKET-LIFE 0>
			      <SETG ROCKET-LOC 30>
			      <TELL
"The dog barks a flame, which burns the rocket to a crisp. (Japanese
taxpayers are bound to complain about this useless and expensive waste
of military hardware.)" CR>)
			     (<AND <EQUAL? ,DOG-LOC 10>
				   <EQUAL? ,ROCKET-LIFE 0>
				   <NOT <EQUAL? ,BURN-DOME 0>>>
			      <SETG BURN-DOME <- ,BURN-DOME 1>>
			      <TELL "The " D ,DOG " breathes fire which ">
			      <COND (<EQUAL? ,BURN-DOME 2>
				     <TELL "slightly melts a spot">)
				    (<EQUAL? ,BURN-DOME 1>
				     <TELL
"melts the spot even more. There is almost a hole">)
				    (<EQUAL? ,BURN-DOME 0>
				     <TELL "burns a small hole">)>
			      <TELL " in the plastic dome." CR>)
			     (T
			      <TELL
"A flame shoots from the dog's mouth into the air." CR>)>)>)>>

<OBJECT WHITE-BUTTON      ;"swipe"
	(IN GAME-ROOM)
	(DESC "white button")
	(SYNONYM BUTTON)
	(ADJECTIVE WHITE)
	(FLAGS NDESCBIT)
	(ACTION WHITE-BUTTON-F)>

<ROUTINE WHITE-BUTTON-F ()   ;"swipe"
	 <COND (<VERB? PUSH>
		<COND (<DOG-DEAD?>
		       <RTRUE>)>		
                <TELL "The " D ,DOG " swipes at ">
		<COND (<EQUAL? ,DOG-LOC ,PLANE-LOC>;"SEM COULD I CUT THIS COND"
		       <TELL "the " D ,PLANE ", striking ">
		       <COND (<EQUAL? ,PLANES-LEFT 2>
			      <TELL "one">)
			     (T
			      <TELL "it">)>
		       <TELL
". A puff of black smoke begins to trail from the puny plane. ">
		       <COND (<EQUAL? ,PLANES-LEFT 2>
			      <TELL 
"It rolls to one side, then heads down, crashing in a Tokyo suburb">)
			     (T
			      <TELL
"It tumbles out of control, crashing in the parking lot of the Tokyo
Disneyland">)>
		       <SETG PLANES-LEFT <- ,PLANES-LEFT 1>>
		       <PUTP ,PLANE ,P?SDESC "puny plane">
		       <COND (<EQUAL? ,PLANES-LEFT 0>
			     ;<REMOVE ,PLANE>
			      <MOVE ,PLANE ,P-NMERGE> ;"temp fix"
			      <SETG PLANES-LEFT 0>
			      <SETG PLANE-LOC 30>)>)
		      (<AND <EQUAL? ,DOG-LOC ,ROCKET-LOC>
                            <NOT <EQUAL? ,ROCKET-LOC 30>>>
		       <TELL "the rocket, barely missing it">)
		      (T
		       <TELL "thin air">)>
		<TELL "." CR>)>>

<ROUTINE DOG-DEAD? ()
         <COND (<EQUAL? ,DOG-LOC 30 40>
		<TELL "A servomotor ">
	        <COND (<EQUAL? ,DOG-LOC 40>
		       <TELL "east of ">)
		      (T
		       <TELL "in ">)>
		<TELL "the park spins for a moment." CR>)
	       (<EQUAL? ,DOG-LOC 20>
	        <COND (<PRSI? ,RED-BUTTON>
		       <TELL
"A slight puff of smoke emerges slowly from" T ,DOG "'s left nostril." CR>)
		      (T
		       <TELL
"You press" T ,PRSO " but nothing happens." CR>)>)>>

<GLOBAL PLANES-LEFT 2>
<GLOBAL TANKS-LEFT 2>

<OBJECT GREEN-BUTTON    ;"Forward"
	(IN GAME-ROOM)
	(DESC "green button")
	(SYNONYM BUTTON)
	(ADJECTIVE GREEN)
	(FLAGS NDESCBIT)
	(ACTION GREEN-BUTTON-F)>

<GLOBAL ROCKET-LOC 33>

<ROUTINE GREEN-BUTTON-F ()    ;"forward"
	 <COND (<VERB? PUSH>
		<COND (<DOG-DEAD?>
		       <RTRUE>)
		      (<EQUAL? ,DOG-LOC ,TANK-LOC ,PLANE-LOC>
		       <TELL
"The gunfire prevents" T ,DOG " from moving further forward." CR>)
		      (<EQUAL? ,DOG-LOC 10>   ;"last room"
		       <TELL
"The " D ,DOG " bumps its atomic snout into the plastic
dome covering the model." CR>)
		      (T     ;"walk the dog"
                       <SETG DOG-LOC <+ ,DOG-LOC 1>>		       
		       <TELL "The " D ,DOG ", in ">
		       <COND (<G? ,HIT-POINTS 8>
			      <TELL "a wounded waddle,">)
			     (T
			      <TELL "its best prehistoric prance,">)>
		       <TELL " moves ">
		       <COND (<EQUAL? ,DOG-LOC 6> ;"Westside of Park"
			      <TELL
"into the west end of the park, violating all leash laws." CR>)
			     (<EQUAL? ,DOG-LOC 7> ;"Eastside of Park"
			      <TELL
"to the east end of the park right in front of a monument, near the tiny
truck.">
			      <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>
				     <SETG ROCKET-LOC 7>
				     <TELL
" The rocket follows close behind.">)>
			      <CRLF>)
			     (<EQUAL? ,DOG-LOC 8>
			      <TELL
"forward, crushing the monument. Dozens of local pigeons commence mourning. ">
			      <FSET ,MONUMENT ,TRASHED-BIT>
			      <COND (<NOT <FSET? ,DOG ,CLUTCHING-BIT>>
				     <FCLEAR ,RING ,ON-MONUMENT-BIT>
				     <TELL
"The " D ,RING " tumbles off the monument onto the ground. ">)>
			      <TELL
"The dog leaves the park and moves into the street">
			      <COND (<AND <NOT <EQUAL? ,DOG-LOC ,ROCKET-LOC>>
				          <NOT <EQUAL? ,ROCKET-LOC 30>>>
			             <SETG ROCKET-LOC ,DOG-LOC>
			             <TELL
                                     ". The rocket follows close behind">)>
			      <TELL "." CR>)
			     (<EQUAL? ,DOG-LOC 9>
			      <TELL "further east, then comes to a stop.">
			      <COND (<AND <NOT <EQUAL? ,DOG-LOC ,ROCKET-LOC>>
				          <NOT <EQUAL? ,ROCKET-LOC 30>>>
			           <SETG ROCKET-LOC ,DOG-LOC>
			           <TELL " The rocket follows close behind.">)>
			      <CRLF>)
			     (<EQUAL? ,DOG-LOC 2>
			      <TELL "east, then comes to a stop." CR>)
			     (T
			      <TELL
"further east, then comes to a stop." CR>)>)>
		<COND (<AND <EQUAL? ,DOG-LOC 2>
		            <NOT <EQUAL? ,DOG-LOC ,TANK-LOC ,PLANE-LOC>>>
		       <SETG TANK-LOC 5>
		       <SETG PLANE-LOC 7>
		       <QUEUE I-TANK-ATTACK 2>
		       <TELL CR
"Suddenly, several blocks east of" T ,DOG ", a pair of " D ,TANK " turn a
corner onto the main street. They're heading straight for" T ,DOG ". Out
of the corner of your eye you notice a puny plane flying over the park. The
puny plane banks, turning towards the main street." CR>)
		      (<EQUAL? ,DOG-LOC 6> ;"Park"
		       <QUEUE I-ROCKET-ATTACK 2>
		       <SETG ROCKET-LOC 6>
		       <SETG TRUCK-LOC 7>
		       <TELL CR
"Suddenly out from under a clump of trees at the east end of the park, a
tiny truck with a rocket mounted on it rolls into view. (Apparently,
violating Tokyo's leash laws is not taken lightly.) A small radar dish
on the tiny truck spins furiously until it locks in on" T ,DOG " and
stops. A puff of smoke comes from the back of the rocket as it blasts
off toward the dog." CR>)>
		<RTRUE>)
	      ;(<VERB? EXAMINE>
		<TELL
"The " D ,GREEN-BUTTON " is labeled \"Forward.\"">)>>

<GLOBAL HIT-POINTS 0>

<GLOBAL DOG-LOC 1>   ;"1-first room of downtown Tokyo"
<GLOBAL TANK-LOC 33>  ;"33-offstage"
<GLOBAL PLANE-LOC 33> ;"33-offstage"  "7-east park"

<ROUTINE I-TANK-ATTACK ("AUX" HITS (TANK-IN-RANGE <>) (PLANE-IN-RANGE <>))
	 <COND (<AND <EQUAL? ,TANKS-LEFT 0>
		     <EQUAL? ,PLANES-LEFT 0>>
		<DEQUEUE I-TANK-ATTACK>
		<RFALSE>)>
         <QUEUE I-TANK-ATTACK -1>
	 <SET HITS ,HIT-POINTS>
	 <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     <LIT? ,GAME-ROOM>>
                <CRLF>)>
	 <COND (<AND <EQUAL? ,DOG-LOC ,TANK-LOC>
		     <EQUAL? ,DOG-LOC ,PLANE-LOC>>
		<COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		            <LIT? ,GAME-ROOM>>
			    <TELL
"The " D ,DOG " continues to take fire from" T ,TANK " and" T ,PLANE ".">)>
		<SETG HIT-POINTS <+ ,HIT-POINTS <+ ,PLANES-LEFT ,TANKS-LEFT>>>)
	       (T
;"Tanks"	<COND (<EQUAL? ,TANK-LOC ,DOG-LOC>
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		              <LIT? ,GAME-ROOM>>
			      <TELL
"The " D ,DOG " continues to take hits from" T ,TANK ".">)>
		       <SETG HIT-POINTS <+ ,HIT-POINTS ,TANKS-LEFT>>)
		      (<NOT <EQUAL? ,TANKS-LEFT 0>>
		       <SETG TANK-LOC <- ,TANK-LOC 1>>
		       <COND (<EQUAL? ,TANK-LOC ,DOG-LOC>
			      <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     			  <LIT? ,GAME-ROOM>>
			             <TELL "The tanks ">
			             <COND (<G? ,HIT-POINTS 0>
				            <TELL "continue">)
				           (T
				            <TELL "begin">)>
			                    <TELL
" to fire as they roll to a stop at the foot of the mutant
Mexican hairless.">)>
			      <SETG HIT-POINTS <+ ,HIT-POINTS ,TANKS-LEFT>>)
			     (<EQUAL? <+ ,DOG-LOC 1> ,TANK-LOC>
			      <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		                          <LIT? ,GAME-ROOM>>
				     <TELL
"The tanks, only a block away, begin firing as they move within range.">)>
			      <SETG HIT-POINTS <+ ,HIT-POINTS ,TANKS-LEFT>>)
			     (<NOT <EQUAL? ,TANK-LOC ,DOG-LOC>>
			      <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		    	  <LIT? ,GAME-ROOM>>
				     <TELL
"The tanks, a few blocks away, continue to advance toward the radiated
sewer rat.">)>)>)>
	       <COND (<NOT <EQUAL? ,TANKS-LEFT 0>>
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		   <LIT? ,GAME-ROOM>>
			      <TELL " ">)>)>
;"Planes"	<COND (<EQUAL? ,PLANE-LOC ,DOG-LOC>
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		   <LIT? ,GAME-ROOM>>
			      <TELL
"The " D ,DOG " continues to take fire from" T ,PLANE ".">)>
		       <SETG HIT-POINTS <+ ,HIT-POINTS ,PLANES-LEFT>>)
		      (<NOT <EQUAL? ,PLANES-LEFT 0>>
		       <SETG PLANE-LOC <- ,PLANE-LOC 1>>
		       <COND (<EQUAL? ,PLANE-LOC ,DOG-LOC>
			      <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     			  <LIT? ,GAME-ROOM>>
				     <TELL
"The planes, spewing bullet-shaped death, reach the radioactive reptile
and begin circling around it.">)>
			      <SETG HIT-POINTS <+ ,HIT-POINTS ,PLANES-LEFT>>)
			     (<EQUAL? <+ ,DOG-LOC 1> ,PLANE-LOC>
			      <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     			  <LIT? ,GAME-ROOM>>
				     <TELL
"The planes, only a block away, begin firing as they move within range.">)>
			      <SETG HIT-POINTS <+ ,HIT-POINTS ,PLANES-LEFT>>)
			     (<NOT <EQUAL? ,PLANE-LOC ,DOG-LOC>>
			      <COND (<EQUAL? ,PLANE-LOC 6>
				     <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     				 <LIT? ,GAME-ROOM>>
					    <TELL
"Over the park, a second puny plane joins the first one.">)>
				     <PUTP ,PLANE ,P?SDESC "puny planes">)
				    (<EQUAL? ,PLANE-LOC 5>
				     <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     				 <LIT? ,GAME-ROOM>>
					    <TELL
"The puny planes swoop out of the park and down the street">)>
				     <COND (<EQUAL? ,DOG-LOC 4>
					    <COND (<AND
						   <EQUAL? ,HERE ,GAME-ROOM>
						   <LIT? ,GAME-ROOM>>
						   <TELL " firing at" T ,DOG>)>
					    <SETG HIT-POINTS
						<+ ,HIT-POINTS ,PLANES-LEFT>>)>
				     <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     				 <LIT? ,GAME-ROOM>>
					    <TELL ".">)>)
				    (T
				     <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     				 <LIT? ,GAME-ROOM>>
					    <TELL
"The planes, a few blocks away, continue to fly toward the radiated sewer
rat.">)>)>)>)>)>
	 <COND (<G? ,HIT-POINTS .HITS>
		<COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		            <LIT? ,GAME-ROOM>>
		       <COND (<EQUAL? ,PLANE-LOC 30>
			      <TELL ;" " <PICK-ONE ,DOG-IN-PAIN>>)
			     (T
			      <TELL " " <PICK-ONE ,DOG-IN-PAIN>>)>)>
                <COND (<G? ,HIT-POINTS 19>
		      ;<G? ,HIT-POINTS 33>		       
		       <DEQUEUE I-TANK-ATTACK>
		       <SETG DOG-LOC 20>   ;"dead in street west of park"
		       <SETG TANK-LOC 33>  ;"off stage"
		       <SETG PLANE-LOC 33> ;"off stage"
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		   <LIT? ,GAME-ROOM>>
			      <TELL
" The " D ,DOG " starts to shake as if he has to go outside, then stumbles and
falls to the ground.~
~
*** The " D ,DOG " has died ***~
~
           Tokyo is saved!" CR CR>
			      <TELL "The ">
			      <COND (<NOT <EQUAL? ,TANKS-LEFT 0>>
				     <TELL "tiny tank">
				     <COND (<EQUAL? ,TANKS-LEFT 2>
					    <TELL "s turn">)
					   (T
					    <TELL " turns">)>
				     <TELL" onto a side street and disappear">
				     <COND (<EQUAL? ,TANKS-LEFT 1>
					    <TELL "s">)>
				     <COND (<EQUAL? ,PLANES-LEFT 0>
					    <TELL ".">)
					   (T
					    <TELL " as the puny plane">
					    <COND (<EQUAL? ,PLANES-LEFT 2>
						   <TELL "s tip their">)
						  (T
					           <TELL " tips its">)>
					    <TELL" wings and head">
					    <COND (<EQUAL? ,PLANES-LEFT 1>
						   <TELL"s">)>
					    <TELL " for home.">)>)
				    (T
				     <TELL "puny plane">
				     <COND (<EQUAL? ,PLANES-LEFT 2>
					    <TELL "s tip their">)
					   (T
					    <TELL " tips its">)>
				     <TELL" wings and head">
				     <COND (<EQUAL? ,PLANES-LEFT 1>
					    <TELL"s">)>
				     <TELL " for home.">)>)>)
		      (<AND <G? ,HIT-POINTS 15>
			    <NOT <G? .HITS 15>>>
		       ;<AND <G? ,HIT-POINTS 29>
			    <NOT <G? .HITS 29>>>
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		   <LIT? ,GAME-ROOM>>
			      <TELL
" The repeated attacks weaken" T ,DOG " and it seems near death.">)>)
		      (<AND <G? ,HIT-POINTS 11>
			    <NOT <G? .HITS 11>>>
		       <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     		   <LIT? ,GAME-ROOM>>
			      <TELL
" The repeated attacks begin to take their toll on" T ,DOG ".">)>)>)>
	 <COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		     <LIT? ,GAME-ROOM>>
	        <CRLF>)>
	 <RTRUE>>

<ROUTINE I-ROCKET-ATTACK ()
         <COND (<EQUAL? ,ROCKET-LOC 30>
                <RFALSE>)>
	 <QUEUE I-ROCKET-ATTACK -1>
	 <SETG ROCKET-LIFE <- ,ROCKET-LIFE 1>>
	 <COND (<EQUAL? ,ROCKET-LIFE 0>
		<COND (<AND <EQUAL? ,HERE ,GAME-ROOM>
		            <LIT? ,GAME-ROOM>>
		       <TELL CR
"The rocket swoops down, striking" T ,DOG " in the chest. The " D ,DOG "
explodes and pieces of fur and scales, mixed with bits of wire and a
couple of servomotors, scatter throughout the area.~
~
*** The " D ,DOG " has died ***~
~
           Tokyo is saved!" CR>)>
		<SETG ROCKET-LOC 30>
		<DEQUEUE I-ROCKET-ATTACK>
		<COND (<EQUAL? ,DOG-LOC 6 7>
		       <SETG DOG-LOC 30>)
		      (T
		       <SETG DOG-LOC 40>)>);"dead east of park"
	       (T
	        <COND (<AND <EQUAL? ,ROCKET-LIFE 3>
			    <EQUAL? ,HERE ,GAME-ROOM>
			    <LIT? ,HERE>>
                       <TELL CR
"The rocket speeds toward" T ,DOG " and begins circling as it nears." CR>)
		      (<AND <EQUAL? ,ROCKET-LIFE 2>
			    <EQUAL? ,HERE ,GAME-ROOM>
			    <LIT? ,HERE>>
		       <TELL CR
"The rocket begins bobbing up and down, sniffing for just the right spot as
it circles" TR ,DOG>)
		      (<AND <EQUAL? ,ROCKET-LIFE 1>
			    <EQUAL? ,HERE ,GAME-ROOM>
			    <LIT? ,HERE>>
		       <TELL CR
"Suddenly the rocket makes a wide turn out in front of" T ,DOG ". It seems
to have found the spot it was looking for. The rocket's speed increases as it
heads right for the dog's heart!" CR>)>)>> 

<GLOBAL DOG-IN-PAIN
	<LTABLE 0
"The Atomic Chihuahua's bulging eyes wince with pain as several rounds fire
into its chest."
"As the gunfire strikes the Atomic Chihuahua, its heavy reptilian tail
pounds the street's pavement angrily."
"As bullets pierce the dazed dog's scales he pauses momentarily, remembering
his younger days with Xavier Cugat."
"The Atomic Chihuahua takes two rounds in the throat and gasps. (Two rounds to
you and me, but that's 14 rounds to little scale-face!)">>

<OBJECT BLUE-BUTTON        ;"clutch"
	(IN GAME-ROOM)
	(DESC "blue button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLUE)
	(FLAGS NDESCBIT)
	(ACTION BLUE-BUTTON-F)>

<ROUTINE BLUE-BUTTON-F ()           ;"clutch"
	 <COND (<VERB? PUSH>
                <COND (<DOG-DEAD?>
		       <RTRUE>)>
		<TELL "The " D ,DOG>
		<COND (<FSET? ,DOG ,CLUTCHING-BIT>
		       <TELL
" clutches" T ,RING " more tightly." CR>)
                      (<EQUAL? ,DOG-LOC 7>
		       <TELL
" clutches" T ,RING " in its front claws." CR>
		       <FCLEAR ,RING ,ON-MONUMENT-BIT>
		       <FSET ,DOG ,CLUTCHING-BIT>)
		      (T
		       <TELL
" grasps at thin air with its front claws." CR>)>)>>

<OBJECT BLACK-BUTTON        ;"stomp"
	(IN GAME-ROOM)
	(DESC "black button")
	(SYNONYM BUTTON)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(ACTION BLACK-BUTTON-F)>

<GLOBAL TRUCK-LOC 33>
<GLOBAL ROCKET-LIFE 4>

<ROUTINE BLACK-BUTTON-F ()                ;"stomp"
	 <COND (<VERB? PUSH>
	        <COND (<DOG-DEAD?>
		       <RTRUE>)>
		<COND (<EQUAL? ,DOG-LOC ,TANK-LOC>
		       <COND (<AND <EQUAL? ,TANKS-LEFT 2>
                                   <PROB 50>>
			      <PUTP ,TANK ,P?SDESC "tiny tank">
			      <TELL
"Just as" T ,DOG " is about to raise its hind leg, one of the tiny tanks
drives up onto its toenail. As" T ,DOG " raises its hind leg, the tiny
tank is lifted off the ground and hurled through the air into the middle
of a nearby apartment building, demolishing a large portion of it. Hundreds
of house plants fall to their deaths. The " D ,DOG " stomps the street's
pavement with its clawed foot.">
			      <SETG TANKS-LEFT 1>)
			     (T
			      <TELL
"The " D ,DOG " lifts its hind leg and, just as you thought this game was
going to become even more base, stomps its clawed foot down on ">
			      <COND (<EQUAL? ,TANKS-LEFT 2>
			             <TELL "one of the tiny tanks">
				     <PUTP ,TANK ,P?SDESC "tiny tank">
				     <SETG TANKS-LEFT 1>)
				    (T
				     <TELL "the other tiny tank">
				     <MOVE ,TANK ,P-NMERGE> ;"temp fix"
				     <SETG TANKS-LEFT 0>
				     <SETG TANK-LOC 30>)>
			      <TELL ", crushing it.">)>)
		      (<AND <EQUAL? ,TRUCK-LOC 7> ;"East Park"  
                            <EQUAL? ,DOG-LOC 7>>
		       <TELL
"The Chihuahua raises his hind leg and soundly stomps the tiny truck,
smashing it to bits.">
		       <COND (<NOT <EQUAL? ,ROCKET-LIFE 0>>
			      <TELL
" The rocket heads straight for the Atomic Chihuahua, then begins to
swerve and dive erratically. It sails past the Atomic Chihuahua,
colliding with Tokyo's tallest building, the Ginsu Building, corporate
headquarters of the Ginsu Knife Company. Just as your mind pauses to
consider the possibility of a Ginsu knife standing up to this kind of
punishment, the rocket explodes and the entire building collapses. Tokyo
isn't saved but millions of late-night TV viewers are.">)>
		      ;<CRLF>
		       <SETG TRUCK-LOC 30>
		       <SETG ROCKET-LOC 30>
		       <SETG ROCKET-LIFE 0>
		       <DEQUEUE ,I-ROCKET-ATTACK>)
                      (<EQUAL? ,DOG-LOC 6 7>
		       <TELL
"The " D ,DOG " lifts its hind leg (no, not that!) and stomps its scaly
claw down on the grass, creating a children's wading pool.">)
		      (T
		       <TELL 
"The " D ,DOG " lifts its hind leg and stomps its clawed foot down on the
street's pavement.">)>
		<CRLF>)>>

<ROOM SHORT-HALL
      (IN ROOMS)
      (DESC "Short Hall")
      (LDESC
"This is a short hall stretching east and west. Doorways lead north to the
ladies' room and south to the men's room.")
      (SOUTH TO MENS-ROOM)
      (NORTH TO LADIES-ROOM)
      (EAST TO SCREENING-ROOM)
      (WEST TO GAME-ROOM)
      (GLOBAL WINDOW)
      (CAPACITY 20) ;"Tell--sun coming up"
      (FLAGS RLANDBIT)>

<ROOM MENS-ROOM
      (IN ROOMS)
      (DESC "Men's Room")
      (NORTH TO SHORT-HALL)
      (FLAGS RLANDBIT)
      (GLOBAL TOILET WATER)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION MENS-ROOM-F)>

<ROUTINE MENS-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
                <DESCRIBE-BATHROOM "men's">)>>

<ROUTINE DESCRIBE-BATHROOM (GENDER)
	 <TELL
"This is an ordinary restroom which looks like a "
.GENDER " room in a theatre.">>

<ROOM LADIES-ROOM
      (IN ROOMS)
      (DESC "Ladies' Room")
      (SOUTH TO SHORT-HALL)
      (FLAGS RLANDBIT)
      (GLOBAL TOILET WATER)
      (CAPACITY 10) ;"don't light room when sun comes up"
      (ACTION LADIES-ROOM-F)>

<ROUTINE LADIES-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
                <DESCRIBE-BATHROOM "ladies'">)>>

<SETG X-N 1> ;"these are temporary until compiler fix."
<SETG X-E 2>
<SETG X-W 4>
<SETG X-S 8>
<SETG X-H 16>

<CONSTANT X-N 1>
<CONSTANT X-E 2>
<CONSTANT X-W 4>
<CONSTANT X-S 8>
<CONSTANT X-H 16>

<ROOM ENTRANCE-TO-MAZE
      (IN ROOMS)
      (DESC "Entrance to Hedge Maze")
      (LDESC
"This is the entrance to the hedge maze. Aunt Hildegarde told you never
to go into the maze without the map, and of course you would go in
anyway and she would have to come in and find you.~
~
Guests were forever getting lost in the maze at parties. Sometimes you
wished Cousin Herman would go in and never come out. But you always had
the feeling he was thinking the same about you, only more seriously.
Tall hedges, thick and green, stretch along paths leading to the east and
west and a grass path north enters the maze. A stone walkway leads south.")
      (NORTH PER ENTER-HM)
      (EAST TO NORTHEAST-JUNCTION)
      (WEST TO NORTHWEST-JUNCTION)
      (SOUTH TO NORTH-GARDEN)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL HEDGE-MAZE-OBJ)>

<ROUTINE ENTER-HM ()
	 <FCLEAR ,HEDGE-MAZE ,TOUCHBIT>
	 <SETG HM-ROOM 439>
	 <COND (<AND <NOT <ULTIMATELY-IN? ,VERTICAL-MAP>>
		     <NOT <ULTIMATELY-IN? ,HORIZONTAL-MAP>>>
		<TELL
"You feel uneasy going into the hedge maze knowing Aunt Hildegarde isn't here
to help you find your way out." CR CR>)> 
	 <QUEUE I-HEDGE-FOOTSTEPS <+ 30 <RANDOM 20>>> 
         ,HEDGE-MAZE>

<ROUTINE I-HEDGE-FOOTSTEPS ()
	 <COND (<EQUAL? ,HERE ,HEDGE-MAZE>
		<QUEUE I-HEDGE-FOOTSTEPS <+ 30 <RANDOM 20>>>
		<TELL CR
"You hear footsteps on the other side of the hedge." CR>)
	       (T
		<RFALSE>)>>

<OBJECT HEDGE-MAZE-OBJ
	(IN LOCAL-GLOBALS)
	(DESC "hedge maze")
	(SYNONYM MAZE LABYRINTYH)
	(ADJECTIVE HEDGE)
	(FLAGS NDESCBIT)
	(ACTION HEDGE-MAZE-OBJ-F)>

<ROUTINE HEDGE-MAZE-OBJ-F ()
	 <COND (<VERB? ENTER EXIT LEAVE WALK-TO DISEMBARK>
		<V-WALK-AROUND>)>>

<ROOM HEDGE-MAZE
      (IN ROOMS)
      (DESC "Hedge Maze")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (CAPACITY 1)
      (GLOBAL HEDGE-MAZE-OBJ)
      (ACTION HEDGE-MAZE-F)>

<GLOBAL HM-ROOM 439>
<GLOBAL HM-BITS 15>

<ROUTINE HEDGE-MAZE-F (RARG "AUX" (PATHS 0) OLD STEPS DIR)
	 <COND (<EQUAL? .RARG ,M-LOOK>		
	        <TELL "You are in a hedge maze of astonishing complexity. ">

;"find out how many paths lead out of current room"
		<COND (<BTST ,HM-BITS ,X-N>
		       <SET PATHS <+ .PATHS 1>>)>
		<COND (<BTST ,HM-BITS ,X-E>      
                       <SET PATHS <+ .PATHS 1>>)>
		<COND (<BTST ,HM-BITS ,X-W>      
		       <SET PATHS <+ .PATHS 1>>)>
		<COND (<BTST ,HM-BITS ,X-S>
		       <SET PATHS <+ .PATHS 1>>)>
                <COND (<G? .PATHS 1> 
                       <TELL "Paths lead ">)
                       (T
                        <TELL "A path leads ">)>
;"tell direction path(s) lead in"
                <COND (<BTST ,HM-BITS ,X-N>
		       <TELL "north">
		       <SET PATHS <PUNCTUATION .PATHS>>)>
		<COND (<BTST ,HM-BITS ,X-S>
		       <TELL "south">
                       <SET PATHS <PUNCTUATION .PATHS>>)>
		<COND (<BTST ,HM-BITS ,X-E>
		       <TELL "east">
		       <SET PATHS <PUNCTUATION .PATHS>>)>
	        <COND (<BTST ,HM-BITS ,X-W>
		       <TELL "west">
		       <SET PATHS <PUNCTUATION .PATHS>>)>
		<COND (<BTST ,HM-BITS ,X-H>          ;"x-h checks for hole"
                       <TELL
CR CR "There is a hole in the ground here from your previous excavations.">
		       <MOVE ,MAZE-HOLE ,HERE>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG HM-BITS <GETB ,HM-TABLE ,HM-ROOM>>
		<OBJECTS-TO-ROOM ,HM-ROOM>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <SET OLD ,HM-ROOM>
		       <OBJECTS-TO-TABLE .OLD>
		       <COND (<AND <EQUAL? ,P-WALK-DIR ,P?NORTH>
				   <BTST ,HM-BITS ,X-N>>
			      <SET DIR "north">
			      <SET STEPS <HEDGE-WALK ,X-N>>)
			     (<AND <EQUAL? ,P-WALK-DIR ,P?SOUTH>
				   <BTST ,HM-BITS ,X-S>>
			      <COND (<EQUAL? ,HM-ROOM 439>
				     <GOTO ,ENTRANCE-TO-MAZE>
				     <RTRUE>)
				    (<EQUAL? ,HM-ROOM 388>
				     <TELL
"You make your way 10 feet south along the path." CR CR>
				     <GOTO ,HEART-OF-MAZE>
				     <RTRUE>)>
			      <SET DIR "south">
			      <SET STEPS <HEDGE-WALK ,X-S>>)
			     (<AND <EQUAL? ,P-WALK-DIR ,P?EAST>
				   <BTST ,HM-BITS ,X-E>>
			      <SET DIR "east">
			      <SET STEPS <HEDGE-WALK ,X-E>>)
			     (<AND <EQUAL? ,P-WALK-DIR ,P?WEST>
				   <BTST ,HM-BITS ,X-W>>
			      <SET DIR "west">
			      <SET STEPS <HEDGE-WALK ,X-W>>)
			     (<EQUAL? ,P-WALK-DIR ,P?UP>
			      <TELL "Please don't climb the hedges." CR>
			      <RFATAL>)
                             (<EQUAL? ,P-WALK-DIR ,P?DOWN>
			      <TELL "You burrow furiously to no avail." CR>
			      <RFATAL>)
			     (ELSE
			      <OBJECTS-TO-ROOM .OLD>
			      <TELL <PICK-ONE ,HEDGE-CRASH> "." CR>
			      <RFATAL>)>
		       <FCLEAR ,HEDGE-MAZE ,TOUCHBIT>
		       <TELL
"You make your way " N <* 10 .STEPS> " feet " .DIR " along the path." CR CR>
		       <GOTO ,HEDGE-MAZE>)>)>>

<ROOM HEART-OF-MAZE
      (IN ROOMS)
      (DESC "Hedge Maze")
      (LDESC
"You are in a hedge maze of astonishing complexity. A path leads north.")
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (CAPACITY 1)
      (GLOBAL HEDGE-MAZE-OBJ)
      (NORTH PER OUT-OF-HEART-OF-MAZE)
      (SOUTH "You walk face first into the hedge.")
      (WEST "You walk face first into the hedge.")
      (EAST "You walk face first into the hedge.")
      (NE "You walk face first into the hedge.")
      (NW "You walk face first into the hedge.")
      (SE "You walk face first into the hedge.")
      (SW "You walk face first into the hedge.")       
      (DOWN "You burrow furiously to no avail.")>

<ROUTINE OUT-OF-HEART-OF-MAZE ()
	 <FCLEAR ,HEDGE-MAZE ,TOUCHBIT>
	 <TELL
"You make your way 10 feet north along the path." CR CR>
	 ,HEDGE-MAZE>

<OBJECT HEART-OF-MAZE-HOLE
	(DESC "hole")
	(SYNONYM HOLE)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 11)
	(ACTION HEART-OF-MAZE-HOLE-F)>

<ROUTINE HEART-OF-MAZE-HOLE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>	

<OBJECT RUBBER-STAMP
	(IN HEART-OF-MAZE-HOLE)
        (DESC "Buck Palace's large rubber stamp")
	(SYNONYM STAMP)
	(ADJECTIVE RUBBER POSTAL)
        (SIZE 10)
	(VALUE 10)
	(FLAGS TAKEBIT NARTICLEBIT)
	(ACTION RUBBER-STAMP-F)>

<OBJECT SHOVEL
	(IN WEST-GARDEN)
	(DESC "shovel")
	(FDESC "A small shovel is lying amongst the flower beds.")
	(SYNONYM SHOVEL SPADE)
	(FLAGS TAKEBIT)
	(SIZE 20)>

<ROUTINE PUNCTUATION (PATHS)
         <COND (<EQUAL? .PATHS 4>
		<TELL ", ">)
               (<EQUAL? .PATHS 3>
		<TELL ", ">)
	       (<EQUAL? .PATHS 2>
	        <TELL " and ">)
	       (T
		<TELL ".">)>
	 <SET PATHS <- .PATHS 1>>
	 <RETURN .PATHS>>

<ROUTINE HEDGE-WALK (BIT "AUX" (STEPS 0) MBITS)
	 <SET MBITS ,HM-BITS>
	 <REPEAT ()
		 <COND (<AND <EQUAL? .BIT ,X-N> <BTST .MBITS ,X-N>>
			<SETG HM-ROOM <- ,HM-ROOM 1>>)
		       (<AND <EQUAL? .BIT ,X-S> <BTST .MBITS ,X-S>>
			<SETG HM-ROOM <+ ,HM-ROOM 1>>)
		       (<AND <EQUAL? .BIT ,X-E> <BTST .MBITS ,X-E>>
			<SETG HM-ROOM <+ ,HM-ROOM 20>>)
		       (<AND <EQUAL? .BIT ,X-W> <BTST .MBITS ,X-W>>
			<SETG HM-ROOM <- ,HM-ROOM 20>>)
		       (ELSE
			<RETURN .STEPS>)>
		 <SET STEPS <+ .STEPS 1>>
		 <COND (<NOT <ZERO? <GETB ,HM-TABLE ,HM-ROOM>>>
			<RETURN .STEPS>)
		       (ELSE
			<SET MBITS %<+ ,X-N ,X-E ,X-W ,X-S>>)>>>

<ROUTINE OBJECTS-TO-TABLE (SLOC "AUX" TBL (CNT 0) (F <FIRST? ,HEDGE-MAZE>) N)
	 <REMOVE ,MAZE-HOLE>
         <SET TBL ,HEDGE-OBJECTS-TABLE>
	 <REPEAT ()
		 <COND (.F <SET N <NEXT? .F>>)
		       (ELSE <RETURN>)>
		 <COND (<EQUAL? .F ,WINNER>)
		       (<FSET? .F ,TAKEBIT>
			<REPEAT ()
				<COND (<==? <GET .TBL .CNT> 0>
				       <PUT .TBL .CNT .SLOC>
				       <PUT .TBL <+ .CNT 1> .F>
				       <SET CNT <+ .CNT 2>>
				       <REMOVE .F>
				       <RETURN>)
				      (ELSE
				       <SET CNT <+ .CNT 2>>)>>)>
		 <SET F .N>>>

<ROUTINE OBJECTS-TO-ROOM (SLOC "AUX" TBL (CNT 0))
	 <SET TBL ,HEDGE-OBJECTS-TABLE>
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,HEDGE-OBJECT-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET .TBL .CNT> .SLOC>
			<PUT .TBL .CNT 0>
			<MOVE <GET .TBL <+ .CNT 1>> ,HEDGE-MAZE>)>
		 <SET CNT <+ .CNT 2>>>>

<CONSTANT HEDGE-OBJECT-TABLE-LENGTH 70>        ;"currently ? takeable objects"

<GLOBAL HEDGE-OBJECTS-TABLE    ;"length should be 2*number of takeable objects"
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<GLOBAL HM-TABLE
        <TABLE
  ;"0" <BYTE 0>
  ;"1" <BYTE 0>	
  ;"2" <BYTE 0>   
  ;"3" <BYTE 0>
  ;"4" <BYTE 0>
  ;"5" <BYTE 0>
  ;"6" <BYTE 0>
  ;"7" <BYTE 0>
  ;"8" <BYTE 0>
  ;"9" <BYTE 0>
 ;"10" <BYTE 0>
 ;"11" <BYTE 0>
 ;"12" <BYTE 0>
 ;"13" <BYTE 0>
 ;"14" <BYTE 0>
 ;"15" <BYTE 0>
 ;"16" <BYTE 0>
 ;"17" <BYTE 0>
 ;"18" <BYTE 0>
 ;"19" <BYTE 0>

 ;"20" <BYTE 0>
 ;"21" <BYTE ,X-S ,X-E>
 ;"22" <BYTE 0>
 ;"23" <BYTE 0>
 ;"24" <BYTE ,X-N ,X-E> 
 ;"25" <BYTE ,X-S ,X-E> 
 ;"26" <BYTE ,X-N ,X-E>
 ;"27" <BYTE ,X-E ,X-S>
 ;"28" <BYTE 0> 
 ;"29" <BYTE 0> 
 ;"30" <BYTE 0> 
 ;"31" <BYTE ,X-N> 
 ;"32" <BYTE ,X-S ,X-E>
 ;"33" <BYTE 0>
 ;"34" <BYTE 0> 
 ;"35" <BYTE 0>
 ;"36" <BYTE 0>
 ;"37" <BYTE 0>
 ;"38" <BYTE 0>
 ;"39" <BYTE ,X-N ,X-E>

 ;"40" <BYTE 0>
 ;"41" <BYTE 0>
 ;"42" <BYTE 0>
 ;"43" <BYTE 0>
 ;"44" <BYTE 0> 
 ;"45" <BYTE 0> 
 ;"46" <BYTE ,X-W>
 ;"47" <BYTE 0>
 ;"48" <BYTE 0> 
 ;"49" <BYTE 0> 
 ;"50" <BYTE 0> 
 ;"51" <BYTE 0> 
 ;"52" <BYTE 0>
 ;"53" <BYTE 0>
 ;"54" <BYTE 0> 
 ;"55" <BYTE 0>
 ;"56" <BYTE 0>
 ;"57" <BYTE 0>
 ;"58" <BYTE 0>
 ;"59" <BYTE 0>

 ;"60" <BYTE 0>
 ;"61" <BYTE ,X-W>
 ;"62" <BYTE ,X-S ,X-E>
 ;"63" <BYTE ,X-N ,X-E ,X-S>
 ;"64" <BYTE ,X-W ,X-E ,X-N> 
 ;"65" <BYTE 0> 
 ;"66" <BYTE 0>
 ;"67" <BYTE 0>
 ;"68" <BYTE ,X-E ,X-S> 
 ;"69" <BYTE 0> 
 ;"70" <BYTE 0> 
 ;"71" <BYTE 0> 
 ;"72" <BYTE ,X-W ,X-E ,X-N>
 ;"73" <BYTE ,X-S ,X-E>
 ;"74" <BYTE 0> 
 ;"75" <BYTE 0>
 ;"76" <BYTE ,X-N ,X-E>
 ;"77" <BYTE ,X-S ,X-E>
 ;"78" <BYTE 0>
 ;"79" <BYTE ,X-W ,X-N>

 ;"80" <BYTE 0>
 ;"81" <BYTE 0>
 ;"82" <BYTE 0>
 ;"83" <BYTE 0>
 ;"84" <BYTE 0> 
 ;"85" <BYTE ,X-W ,X-S ,X-E> 
 ;"86" <BYTE 0>
 ;"87" <BYTE ,X-N ,X-W>
 ;"88" <BYTE 0> 
 ;"89" <BYTE 0> 
 ;"90" <BYTE 0> 
 ;"91" <BYTE 0> 
 ;"92" <BYTE 0>
 ;"93" <BYTE 0>
 ;"94" <BYTE 0> 
 ;"95" <BYTE 0>
 ;"96" <BYTE 0>
 ;"97" <BYTE 0>
 ;"98" <BYTE 0>
 ;"99" <BYTE 0>

 ;"100" <BYTE 0>
 ;"101" <BYTE ,X-S>
 ;"102" <BYTE ,X-W ,X-N>
 ;"103" <BYTE 0>
 ;"104" <BYTE 0> 
 ;"105" <BYTE 0> 
 ;"106" <BYTE 0>
 ;"107" <BYTE 0>
 ;"108" <BYTE 0> 
 ;"109" <BYTE ,X-S ,X-E> 
 ;"110" <BYTE 0> 
 ;"111" <BYTE 0> 
 ;"112" <BYTE ,X-N ,X-W>
 ;"113" <BYTE ,X-W ,X-S>
 ;"114" <BYTE 0> 
 ;"115" <BYTE ,X-N ,X-E>
 ;"116" <BYTE 0>
 ;"117" <BYTE ,X-W ,X-S>
 ;"118" <BYTE 0>
 ;"119" <BYTE ,X-N ,X-E>

 ;"120" <BYTE 0>
 ;"121" <BYTE 0>
 ;"122" <BYTE 0>
 ;"123" <BYTE 0>
 ;"124" <BYTE 0> 
 ;"125" <BYTE ,X-W ,X-E ,X-S> 
 ;"126" <BYTE 0>
 ;"127" <BYTE 0>
 ;"128" <BYTE ,X-N ,X-W> 
 ;"129" <BYTE 0> 
 ;"130" <BYTE 0> 
 ;"131" <BYTE 0> 
 ;"132" <BYTE 0>
 ;"133" <BYTE 0>
 ;"134" <BYTE 0> 
 ;"135" <BYTE 0>
 ;"136" <BYTE 0>
 ;"137" <BYTE 0>
 ;"138" <BYTE 0>
 ;"139" <BYTE 0>

 ;"140" <BYTE 0>
 ;"141" <BYTE ,X-S>
 ;"142" <BYTE ,X-E ,X-N>
 ;"143" <BYTE ,X-W ,X-S>
 ;"144" <BYTE ,X-W ,X-S ,X-N> 
 ;"145" <BYTE ,X-W ,X-E ,X-N> 
 ;"146" <BYTE 0>
 ;"147" <BYTE 0>
 ;"148" <BYTE 0> 
 ;"149" <BYTE 0> 
 ;"150" <BYTE ,X-S ,X-E> 
 ;"151" <BYTE 0> 
 ;"152" <BYTE 0>
 ;"153" <BYTE 0>
 ;"154" <BYTE ,X-N ,X-E> 
 ;"155" <BYTE 0>
 ;"156" <BYTE ,X-W ,X-S>
 ;"157" <BYTE 0>
 ;"158" <BYTE ,X-N ,X-E>
 ;"159" <BYTE 0>

 ;"160" <BYTE 0>
 ;"161" <BYTE 0>
 ;"162" <BYTE 0>
 ;"163" <BYTE 0>
 ;"164" <BYTE 0> 
 ;"165" <BYTE 0> 
 ;"166" <BYTE ,X-S>
 ;"167" <BYTE 0>
 ;"168" <BYTE 0> 
 ;"169" <BYTE ,X-N ,X-W> 
 ;"170" <BYTE 0> 
 ;"171" <BYTE 0> 
 ;"172" <BYTE 0>
 ;"173" <BYTE 0>
 ;"174" <BYTE 0> 
 ;"175" <BYTE 0>
 ;"176" <BYTE 0>
 ;"177" <BYTE 0>
 ;"178" <BYTE 0>
 ;"179" <BYTE 0>

 ;"180" <BYTE 0>
 ;"181" <BYTE ,X-E>
 ;"182" <BYTE ,X-W ,X-E ,X-S>
 ;"183" <BYTE 0>
 ;"184" <BYTE 0> 
 ;"185" <BYTE ,X-W ,X-N> 
 ;"186" <BYTE 0>
 ;"187" <BYTE 0>
 ;"188" <BYTE 0> 
 ;"189" <BYTE 0> 
 ;"190" <BYTE ,X-W ,X-E ,X-S> 
 ;"191" <BYTE 0> 
 ;"192" <BYTE 0>
 ;"193" <BYTE ,X-N>
 ;"194" <BYTE ,X-W ,X-S ,X-E> 
 ;"195" <BYTE ,X-W ,X-N ,X-E>
 ;"196" <BYTE ,X-S ,X-E>
 ;"197" <BYTE 0>
 ;"198" <BYTE ,X-W ,X-N>
 ;"199" <BYTE 0>

 ;"200" <BYTE 0>
 ;"201" <BYTE 0>
 ;"202" <BYTE 0>
 ;"203" <BYTE 0>
 ;"204" <BYTE 0> 
 ;"205" <BYTE 0> 
 ;"206" <BYTE ,X-S>
 ;"207" <BYTE 0>
 ;"208" <BYTE 0> 
 ;"209" <BYTE ,X-N ,X-E> 
 ;"210" <BYTE 0> 
 ;"211" <BYTE 0> 
 ;"212" <BYTE 0>
 ;"213" <BYTE 0>
 ;"214" <BYTE 0> 
 ;"215" <BYTE 0>
 ;"216" <BYTE 0>
 ;"217" <BYTE 0>
 ;"218" <BYTE 0>
 ;"219" <BYTE 0>

 ;"220" <BYTE 0>
 ;"221" <BYTE 0>
 ;"222" <BYTE ,X-W ,X-S ,X-E>
 ;"223" <BYTE 0>
 ;"224" <BYTE 0> 
 ;"225" <BYTE ,X-N ,X-E> 
 ;"226" <BYTE 0>
 ;"227" <BYTE 0>
 ;"228" <BYTE 0> 
 ;"229" <BYTE 0> 
 ;"230" <BYTE ,X-W ,X-S> 
 ;"231" <BYTE 0> 
 ;"232" <BYTE 0>
 ;"233" <BYTE 0>
 ;"234" <BYTE ,X-W ,X-N> 
 ;"235" <BYTE 0>
 ;"236" <BYTE 0>
 ;"237" <BYTE ,X-S ,X-E>
 ;"238" <BYTE 0>
 ;"239" <BYTE ,X-W ,X-N>

 ;"240" <BYTE 0>
 ;"241" <BYTE 0>
 ;"242" <BYTE 0>
 ;"243" <BYTE 0>
 ;"244" <BYTE 0> 
 ;"245" <BYTE ,X-W ,X-S ,X-E> 
 ;"246" <BYTE 0>
 ;"247" <BYTE 0>
 ;"248" <BYTE ,X-N ,X-E> 
 ;"249" <BYTE 0> 
 ;"250" <BYTE 0> 
 ;"251" <BYTE 0> 
 ;"252" <BYTE 0>
 ;"253" <BYTE 0>
 ;"254" <BYTE 0> 
 ;"255" <BYTE 0>
 ;"256" <BYTE 0>
 ;"257" <BYTE 0>
 ;"258" <BYTE 0>
 ;"259" <BYTE 0>

 ;"260" <BYTE 0>
 ;"261" <BYTE ,X-W ,X-S>
 ;"262" <BYTE ,X-N ,X-S ,X-W>
 ;"263" <BYTE 0>
 ;"264" <BYTE ,X-N ,X-E> 
 ;"265" <BYTE 0> 
 ;"266" <BYTE 0>
 ;"267" <BYTE 0>
 ;"268" <BYTE 0> 
 ;"269" <BYTE ,X-W ,X-S> 
 ;"270" <BYTE 0> 
 ;"271" <BYTE 0> 
 ;"272" <BYTE ,X-N ,X-E>
 ;"273" <BYTE ,X-E ,X-S>
 ;"274" <BYTE 0> 
 ;"275" <BYTE ,X-N ,X-W>
 ;"276" <BYTE 0>
 ;"277" <BYTE ,X-W ,X-S>
 ;"278" <BYTE 0>
 ;"279" <BYTE ,X-N ,X-E>

 ;"280" <BYTE 0>
 ;"281" <BYTE 0>
 ;"282" <BYTE 0>
 ;"283" <BYTE 0>
 ;"284" <BYTE 0> 
 ;"285" <BYTE 0> 
 ;"286" <BYTE ,X-E ,X-S>
 ;"287" <BYTE ,X-N ,X-E>
 ;"288" <BYTE 0> 
 ;"289" <BYTE 0> 
 ;"290" <BYTE 0> 
 ;"291" <BYTE 0> 
 ;"292" <BYTE 0>
 ;"293" <BYTE 0>
 ;"294" <BYTE 0> 
 ;"295" <BYTE 0>
 ;"296" <BYTE 0>
 ;"297" <BYTE 0>
 ;"298" <BYTE 0>
 ;"299" <BYTE 0>

 ;"300" <BYTE 0>
 ;"301" <BYTE ,X-E ,X-S>
 ;"302" <BYTE 0>
 ;"303" <BYTE 0>
 ;"304" <BYTE ,X-W ,X-N ,X-E> 
 ;"305" <BYTE 0> 
 ;"306" <BYTE 0>
 ;"307" <BYTE ,X-W>
 ;"308" <BYTE ,X-W ,X-S> 
 ;"309" <BYTE 0> 
 ;"310" <BYTE 0> 
 ;"311" <BYTE ,X-N> 
 ;"312" <BYTE 0>
 ;"313" <BYTE ,X-W ,X-S>
 ;"314" <BYTE 0> 
 ;"315" <BYTE ,X-N ,X-E>
 ;"316" <BYTE ,X-W ,X-S>
 ;"317" <BYTE 0>
 ;"318" <BYTE 0>
 ;"319" <BYTE ,X-W ,X-N>

 ;"320" <BYTE 0>
 ;"321" <BYTE 0>
 ;"322" <BYTE 0>
 ;"323" <BYTE 0>
 ;"324" <BYTE 0> 
 ;"325" <BYTE 0> 
 ;"326" <BYTE 0>
 ;"327" <BYTE 0>
 ;"328" <BYTE 0> 
 ;"329" <BYTE 0> 
 ;"330" <BYTE 0> 
 ;"331" <BYTE 0> 
 ;"332" <BYTE 0>
 ;"333" <BYTE 0>
 ;"334" <BYTE 0> 
 ;"335" <BYTE 0>
 ;"336" <BYTE 0>
 ;"337" <BYTE 0>
 ;"338" <BYTE 0>
 ;"339" <BYTE 0>

 ;"340" <BYTE 0>
 ;"341" <BYTE ,X-W ,X-S>
 ;"342" <BYTE 0>
 ;"343" <BYTE 0>
 ;"344" <BYTE ,X-W ,X-N> 
 ;"345" <BYTE ,X-W ,X-S> 
 ;"346" <BYTE ,X-W ,X-E ,X-N>
 ;"347" <BYTE ,X-S ,X-E>
 ;"348" <BYTE 0> 
 ;"349" <BYTE 0> 
 ;"350" <BYTE 0> 
 ;"351" <BYTE ,X-N ,X-E> 
 ;"352" <BYTE ,X-W ,X-S>
 ;"353" <BYTE 0>
 ;"354" <BYTE ,X-N ,X-E> 
 ;"355" <BYTE ,X-W ,X-E ,X-S>
 ;"356" <BYTE 0>
 ;"357" <BYTE 0>
 ;"358" <BYTE 0>
 ;"359" <BYTE ,X-N ,X-E>

 ;"360" <BYTE 0>
 ;"361" <BYTE 0>
 ;"362" <BYTE 0>
 ;"363" <BYTE 0>
 ;"364" <BYTE 0> 
 ;"365" <BYTE 0> 
 ;"366" <BYTE 0>
 ;"367" <BYTE 0>
 ;"368" <BYTE 0> 
 ;"369" <BYTE 0> 
 ;"370" <BYTE 0> 
 ;"371" <BYTE 0> 
 ;"372" <BYTE 0>
 ;"373" <BYTE 0>
 ;"374" <BYTE 0> 
 ;"375" <BYTE 0>
 ;"376" <BYTE 0>
 ;"377" <BYTE 0>
 ;"378" <BYTE 0>
 ;"379" <BYTE 0>

 ;"380" <BYTE 0>
 ;"381" <BYTE ,X-S ,X-E>
 ;"382" <BYTE ,X-N ,X-E>
 ;"383" <BYTE ,X-S ,X-E>
 ;"384" <BYTE 0> 
 ;"385" <BYTE 0> 
 ;"386" <BYTE ,X-W ,X-N>
 ;"387" <BYTE 0>
 ;"388" <BYTE ,X-S ,X-E> 
 ;"389" <BYTE 0> 
 ;"390" <BYTE 0> 
 ;"391" <BYTE 0> 
 ;"392" <BYTE ,X-S ,X-E>
 ;"393" <BYTE ,X-N>
 ;"394" <BYTE 0> 
 ;"395" <BYTE ,X-W ,X-S ,X-E>
 ;"396" <BYTE 0>
 ;"397" <BYTE 0>
 ;"398" <BYTE ,X-N ,X-E>
 ;"399" <BYTE 0>

 ;"400" <BYTE 0>
 ;"401" <BYTE 0>
 ;"402" <BYTE 0>
 ;"403" <BYTE 0>
 ;"404" <BYTE 0> 
 ;"405" <BYTE 0> 
 ;"406" <BYTE 0>
 ;"407" <BYTE 0>
 ;"408" <BYTE 0> 
 ;"409" <BYTE 0> 
 ;"410" <BYTE 0> 
 ;"411" <BYTE 0> 
 ;"412" <BYTE 0>
 ;"413" <BYTE 0>
 ;"414" <BYTE 0> 
 ;"415" <BYTE 0>
 ;"416" <BYTE 0>
 ;"417" <BYTE 0>
 ;"418" <BYTE 0>
 ;"419" <BYTE 0>

 ;"420" <BYTE 0>
 ;"421" <BYTE 0>
 ;"422" <BYTE ,X-W ,X-S ,X-E>
 ;"423" <BYTE ,X-W ,X-N>
 ;"424" <BYTE ,X-S ,X-E> 
 ;"425" <BYTE 0> 
 ;"426" <BYTE 0>
 ;"427" <BYTE ,X-W ,X-N ,X-E>
 ;"428" <BYTE ,X-W ,X-S> 
 ;"429" <BYTE 0> 
 ;"430" <BYTE 0> 
 ;"431" <BYTE ,X-W ,X-N> 
 ;"432" <BYTE ,X-W ,X-S>
 ;"433" <BYTE 0>
 ;"434" <BYTE ,X-W ,X-S ,X-N> 
 ;"435" <BYTE ,X-W ,X-N ,X-E>
 ;"436" <BYTE ,X-E ,X-S>
 ;"437" <BYTE ,X-N>
 ;"438" <BYTE ,X-W ,X-S ,X-E>
 ;"439" <BYTE ,X-W ,X-S ,X-E ,X-N>

 ;"440" <BYTE 0>
 ;"441" <BYTE ,X-W>
 ;"442" <BYTE 0>
 ;"443" <BYTE 0>
 ;"444" <BYTE 0> 
 ;"445" <BYTE 0> 
 ;"446" <BYTE 0>
 ;"447" <BYTE 0>
 ;"448" <BYTE 0> 
 ;"449" <BYTE 0> 
 ;"450" <BYTE 0> 
 ;"451" <BYTE 0> 
 ;"452" <BYTE 0>
 ;"453" <BYTE 0>
 ;"454" <BYTE 0> 
 ;"455" <BYTE 0>
 ;"456" <BYTE 0>
 ;"457" <BYTE 0>
 ;"458" <BYTE 0>
 ;"459" <BYTE 0>

 ;"460" <BYTE 0>
 ;"461" <BYTE 0>
 ;"462" <BYTE ,X-W ,X-E ,X-S>
 ;"463" <BYTE 0>
 ;"464" <BYTE ,X-W ,X-N ,X-S> 
 ;"465" <BYTE ,X-N ,X-S ,X-E> 
 ;"466" <BYTE 0>
 ;"467" <BYTE ,X-W ,X-N>
 ;"468" <BYTE ,X-S> 
 ;"469" <BYTE ,X-E ,X-N> 
 ;"470" <BYTE ,X-E ,X-S> 
 ;"471" <BYTE 0> 
 ;"472" <BYTE 0>
 ;"473" <BYTE 0>
 ;"474" <BYTE ,X-N ,X-E> 
 ;"475" <BYTE ,X-W ,X-S ,X-E>
 ;"476" <BYTE ,X-W ,X-S ,X-N>
 ;"477" <BYTE 0>
 ;"478" <BYTE ,X-N ,X-W>
 ;"479" <BYTE 0>

 ;"480" <BYTE 0>
 ;"481" <BYTE ,X-E>
 ;"482" <BYTE 0>
 ;"483" <BYTE 0>
 ;"484" <BYTE 0> 
 ;"485" <BYTE 0> 
 ;"486" <BYTE 0>
 ;"487" <BYTE 0>
 ;"488" <BYTE 0> 
 ;"489" <BYTE 0> 
 ;"490" <BYTE ,X-W> 
 ;"491" <BYTE 0> 
 ;"492" <BYTE 0>
 ;"493" <BYTE 0>
 ;"494" <BYTE 0> 
 ;"495" <BYTE 0>
 ;"496" <BYTE 0>
 ;"497" <BYTE 0>
 ;"498" <BYTE 0>
 ;"499" <BYTE 0>

 ;"500" <BYTE 0>
 ;"501" <BYTE 0>
 ;"502" <BYTE 0>
 ;"503" <BYTE ,X-E ,X-S>
 ;"504" <BYTE ,X-N ,X-E> 
 ;"505" <BYTE 0> 
 ;"506" <BYTE ,X-E>
 ;"507" <BYTE ,X-S ,X-E>
 ;"508" <BYTE ,X-E ,X-N> 
 ;"509" <BYTE 0> 
 ;"510" <BYTE 0> 
 ;"511" <BYTE ,X-S ,X-E> 
 ;"512" <BYTE 0>
 ;"513" <BYTE 0>
 ;"514" <BYTE ,X-N ,X-W ,X-S> 
 ;"515" <BYTE ,X-W ,X-N ,X-S>
 ;"516" <BYTE 0>
 ;"517" <BYTE ,X-N ,X-E ,X-S>
 ;"518" <BYTE 0>
 ;"519" <BYTE ,X-W ,X-N>

 ;"520" <BYTE 0>
 ;"521" <BYTE ,X-W ,X-S>
 ;"522" <BYTE ,X-N ,X-W>
 ;"523" <BYTE ,X-W>
 ;"524" <BYTE ,X-W ,X-S> 
 ;"525" <BYTE ,X-N ,X-W ,X-S> 
 ;"526" <BYTE ,X-W ,X-N>
 ;"527" <BYTE ,X-W>
 ;"528" <BYTE 0> 
 ;"529" <BYTE ,X-W ,X-S> 
 ;"530" <BYTE 0> 
 ;"531" <BYTE ,X-N ,X-W ,X-E> 
 ;"532" <BYTE 0>
 ;"533" <BYTE 0>
 ;"534" <BYTE 0> 
 ;"535" <BYTE 0>
 ;"536" <BYTE 0>
 ;"537" <BYTE 0>
 ;"538" <BYTE 0>
 ;"539" <BYTE 0>

 ;"540" <BYTE 0>
 ;"541" <BYTE 0>
 ;"542" <BYTE 0>
 ;"543" <BYTE 0>
 ;"544" <BYTE 0> 
 ;"545" <BYTE 0> 
 ;"546" <BYTE 0>
 ;"547" <BYTE 0>
 ;"548" <BYTE 0> 
 ;"549" <BYTE 0> 
 ;"550" <BYTE 0> 
 ;"551" <BYTE 0> 
 ;"552" <BYTE ,X-E ,X-S>
 ;"553" <BYTE 0>
 ;"554" <BYTE 0> 
 ;"555" <BYTE ,X-N ,X-S ,X-E>
 ;"556" <BYTE ,X-N ,X-E>
 ;"557" <BYTE ,X-E ,X-W ,X-S>
 ;"558" <BYTE 0>
 ;"559" <BYTE ,X-N ,X-E>

 ;"560" <BYTE 0>
 ;"561" <BYTE ,X-E ,X-S>
 ;"562" <BYTE 0>
 ;"563" <BYTE 0>
 ;"564" <BYTE ,X-N> 
 ;"565" <BYTE ,X-E ,X-S> 
 ;"566" <BYTE 0>
 ;"567" <BYTE 0>
 ;"568" <BYTE ,X-W ,X-N> 
 ;"569" <BYTE ,X-E ,X-S> 
 ;"570" <BYTE ,X-N ,X-E> 
 ;"571" <BYTE 0> 
 ;"572" <BYTE 0>
 ;"573" <BYTE 0>
 ;"574" <BYTE 0> 
 ;"575" <BYTE 0>
 ;"576" <BYTE 0>
 ;"577" <BYTE 0>
 ;"578" <BYTE 0>
 ;"579" <BYTE 0>

 ;"580" <BYTE 0>
 ;"581" <BYTE 0>
 ;"582" <BYTE 0>
 ;"583" <BYTE 0>
 ;"584" <BYTE 0> 
 ;"585" <BYTE 0> 
 ;"586" <BYTE 0>
 ;"587" <BYTE 0>
 ;"588" <BYTE 0> 
 ;"589" <BYTE 0> 
 ;"590" <BYTE 0> 
 ;"591" <BYTE 0> 
 ;"592" <BYTE 0>
 ;"593" <BYTE ,X-S ,X-E>
 ;"594" <BYTE ,X-N ,X-E> 
 ;"595" <BYTE 0>
 ;"596" <BYTE 0>
 ;"597" <BYTE 0>
 ;"598" <BYTE ,X-E>
 ;"599" <BYTE 0>

 ;"600" <BYTE 0>
 ;"601" <BYTE 0>
 ;"602" <BYTE ,X-S ,X-E>
 ;"603" <BYTE 0>
 ;"604" <BYTE 0> 
 ;"605" <BYTE ,X-W ,X-N ,X-S> 
 ;"606" <BYTE 0>
 ;"607" <BYTE 0>
 ;"608" <BYTE 0> 
 ;"609" <BYTE ,X-N ,X-W ,X-E> 
 ;"610" <BYTE 0> 
 ;"611" <BYTE ,X-W ,X-S> 
 ;"612" <BYTE ,X-W ,X-S ,X-N>
 ;"613" <BYTE ,X-N ,X-W>
 ;"614" <BYTE ,X-W> 
 ;"615" <BYTE 0>
 ;"616" <BYTE ,X-W ,X-S>
 ;"617" <BYTE ,X-W ,X-N>
 ;"618" <BYTE ,X-W ,X-S>
 ;"619" <BYTE ,X-N ,X-W>

 ;"620" <BYTE 0>
 ;"621" <BYTE 0>
 ;"622" <BYTE 0>
 ;"623" <BYTE 0>
 ;"624" <BYTE 0> 
 ;"625" <BYTE 0> 
 ;"626" <BYTE 0>
 ;"627" <BYTE 0>
 ;"628" <BYTE 0> 
 ;"629" <BYTE 0> 
 ;"630" <BYTE 0> 
 ;"631" <BYTE 0> 
 ;"632" <BYTE 0>
 ;"633" <BYTE 0>
 ;"634" <BYTE 0> 
 ;"635" <BYTE 0>
 ;"636" <BYTE 0>
 ;"637" <BYTE 0>
 ;"638" <BYTE 0>
 ;"639" <BYTE 0>

 ;"640" <BYTE 0>
 ;"641" <BYTE 0>
 ;"642" <BYTE ,X-S ,X-W>
 ;"643" <BYTE 0>
 ;"644" <BYTE 0> 
 ;"645" <BYTE 0> 
 ;"646" <BYTE 0>
 ;"647" <BYTE 0>
 ;"648" <BYTE 0> 
 ;"649" <BYTE ,X-N ,X-W> 
 ;"650" <BYTE 0> 
 ;"651" <BYTE ,X-E ,X-S> 
 ;"652" <BYTE 0>
 ;"653" <BYTE 0>
 ;"654" <BYTE 0> 
 ;"655" <BYTE ,X-W ,X-N ,X-S>
 ;"656" <BYTE ,X-N ,X-S ,X-E>
 ;"657" <BYTE 0>
 ;"658" <BYTE 0>
 ;"659" <BYTE ,X-N ,X-E>

 ;"660" <BYTE 0>
 ;"661" <BYTE 0>
 ;"662" <BYTE 0>
 ;"663" <BYTE 0>
 ;"664" <BYTE 0> 
 ;"665" <BYTE 0> 
 ;"666" <BYTE 0>
 ;"667" <BYTE 0>
 ;"668" <BYTE 0> 
 ;"669" <BYTE 0> 
 ;"670" <BYTE 0> 
 ;"671" <BYTE 0> 
 ;"672" <BYTE 0>
 ;"673" <BYTE 0>
 ;"674" <BYTE 0> 
 ;"675" <BYTE 0>
 ;"676" <BYTE 0>
 ;"677" <BYTE 0>
 ;"678" <BYTE 0>
 ;"679" <BYTE 0>

 ;"680" <BYTE 0>
 ;"681" <BYTE ,X-W ,X-S>
 ;"682" <BYTE 0>
 ;"683" <BYTE 0>
 ;"684" <BYTE 0> 
 ;"685" <BYTE 0> 
 ;"686" <BYTE 0>
 ;"687" <BYTE 0>
 ;"688" <BYTE 0> 
 ;"689" <BYTE 0> 
 ;"690" <BYTE ,X-W ,X-N ,X-S> 
 ;"691" <BYTE ,X-N ,X-W> 
 ;"692" <BYTE ,X-S>
 ;"693" <BYTE 0>
 ;"694" <BYTE 0> 
 ;"695" <BYTE 0>
 ;"696" <BYTE ,X-W ,X-N>
 ;"697" <BYTE ,X-S>
 ;"698" <BYTE 0>
 ;"699" <BYTE ,X-N ,X-W>>>

<GLOBAL HEDGE-CRASH
	<LTABLE 0
	 "You walk right into a thick hedge"
	 "You march face first into a hedge">>

