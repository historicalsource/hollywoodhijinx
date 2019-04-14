

	.FUNCT	PARK-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's Tokyo Central Park, filled with little plastic trees and shrubs, and little plastic people sitting on little plastic benches. Tokyo's Main Street stops on the west side of the park then continues on the east side of the park. "
	EQUAL?	DOG-LOC,6 \?ELS8
	PRINTI	"In the western half of the park you can't help but notice the out-of-place "
	CALL	DPRINT,DOG
	ZERO?	ROCKET-LIFE /?ELS11
	PRINTI	" with a small rocket buzzing around it."
	JUMP	?CND9
?ELS11:	PRINTC	46
?CND9:	EQUAL?	TRUCK-LOC,33 /?CND6
	EQUAL?	TRUCK-LOC,30 /?CND6
	PRINTI	" A tiny truck is near some plastic trees in the eastern half of the park."
	JUMP	?CND6
?ELS8:	PRINTI	"In the eastern half of the park there"
	FSET?	MONUMENT,TRASHED-BIT \?ELS23
	PRINTI	" are bits and pieces of a smashed monument. "
	FSET?	DOG,CLUTCHING-BIT /?CND21
	ZERO?	RING-UNDER-DOME /?CND21
	PRINTI	"Lying near the remains of the monument is"
	CALL	APRINT,RING
	PRINTI	". "
	JUMP	?CND21
?ELS23:	PRINTI	" is a monument. "
?CND21:	FSET?	RING,ON-MONUMENT-BIT \?CND31
	PRINTI	"There is"
	CALL	APRINT,RING
	PRINTI	" perched on top of the monument. "
?CND31:	EQUAL?	DOG-LOC,7 \?ELS36
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" is standing in front of the monument and a "
	EQUAL?	TRUCK-LOC,30 \?CND37
	PRINTI	"smashed "
?CND37:	PRINTI	"truck is at his feet."
	ZERO?	ROCKET-LIFE /?CND6
	PRINTI	" There is a rocket flying around the dog."
	JUMP	?CND6
?ELS36:	EQUAL?	DOG-LOC,30 \?CND6
	PRINTI	"Scattered on the west and east sides of the park are pieces of fur and scales, mixed with bits of wire and a couple of servomotors."
	FSET?	DOG,CLUTCHING-BIT \?CND6
	PRINTI	" A "
	CALL	DPRINT,RING
	PRINTI	" is lying near the debris."
?CND6:	CRLF	
	RTRUE	
?ELS5:	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /FALSE
	PRINTR	"You can't touch the park. It's under the plastic dome."


	.FUNCT	DOME-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The thick plastic dome covers the model of downtown Tokyo"
	LESS?	BURN-DOME,3 \?CND6
	PRINTI	". There is a "
	EQUAL?	BURN-DOME,2 \?ELS11
	PRINTI	"slightly melted spot"
	JUMP	?CND9
?ELS11:	EQUAL?	BURN-DOME,1 \?ELS13
	PRINTI	"melted spot, almost a hole"
	JUMP	?CND9
?ELS13:	ZERO?	BURN-DOME \?CND9
	PRINTI	"small hole"
?CND9:	PRINTI	" on the dome's eastern side"
?CND6:	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS17
	CALL	PERFORM,V?EXAMINE,TOKYO
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?PUT \FALSE
	ZERO?	BURN-DOME \FALSE
	PRINTR	"You don't want to ruin the delicate model."


	.FUNCT	DOME-HOLE-PSEUDO
	EQUAL?	BURN-DOME,3 \?ELS5
	CALL	CANT-SEE-ANY
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS7
	LESS?	BURN-DOME,3 \?ELS7
	PRINTI	"There is a "
	EQUAL?	BURN-DOME,2 \?ELS12
	PRINTI	"slightly melted spot"
	JUMP	?CND10
?ELS12:	EQUAL?	BURN-DOME,1 \?ELS14
	PRINTI	"melted spot, almost a hole,"
	JUMP	?CND10
?ELS14:	ZERO?	BURN-DOME \?CND10
	PRINTI	"hole about the size of an orange"
?CND10:	PRINTR	" on the dome's eastern side."
?ELS7:	EQUAL?	PRSA,V?REACH-IN \?ELS18
	FSET?	DOG,CLUTCHING-BIT \?ELS18
	ZERO?	BURN-DOME \?ELS18
	PRINTI	"The "
	CALL	DPRINT,RING
	PRINTI	": "
	CALL	PERFORM,V?TAKE,RING
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS22
	PRINTR	"You see downtown Tokyo."
?ELS22:	EQUAL?	PRSA,V?PUT \FALSE
	ZERO?	BURN-DOME \FALSE
	PRINTR	"You don't want to ruin the delicate model."


	.FUNCT	TRUCK-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	EQUAL?	TRUCK-LOC,33 \?ELS10
	PRINTR	"You can't see any tiny truck here."
?ELS10:	EQUAL?	TRUCK-LOC,30 \?ELS12
	PRINTR	"The tiny truck is smashed into tiny bits and pieces."
?ELS12:	PRINTI	"It's a tiny truck with a small radar dish which is pointing at"
	CALL	TRPRINT,DOG
	RSTACK	
?ELS5:	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /FALSE
	PRINTR	"You can't reach the tiny truck. It's under the plastic dome."


	.FUNCT	ROCKET-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	EQUAL?	ROCKET-LOC,33 \?ELS10
	PRINTR	"You can't see any rocket here."
?ELS10:	EQUAL?	ROCKET-LOC,30 \?ELS12
	PRINTR	"You can't see any rocket here. It has been destroyed."
?ELS12:	PRINTI	"The rocket is circling around"
	CALL	TRPRINT,DOG
	RSTACK	
?ELS5:	CALL	TOUCHING?,PSEUDO-OBJECT
	ZERO?	STACK /FALSE
	PRINTR	"You can't reach the rocket. It's under the plastic dome."


	.FUNCT	TOKYO-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"It's the scale model of downtown Tokyo used in the movie ""Atomic Chihuahuas From Hell."" In the center of the model is Tokyo Central Park. "
	PRINTI	"In the eastern half of the park there "
	FSET?	MONUMENT,TRASHED-BIT \?ELS8
	PRINTI	"are bits and pieces of a smashed monument."
	FSET?	DOG,CLUTCHING-BIT /?CND6
	ZERO?	RING-UNDER-DOME /?CND6
	PRINTI	" Lying near the remains of the monument is"
	CALL	APRINT,RING
	PRINTC	46
	JUMP	?CND6
?ELS8:	PRINTI	"is a monument."
?CND6:	FSET?	RING,ON-MONUMENT-BIT \?CND16
	PRINTI	" There is"
	CALL	APRINT,RING
	PRINTI	" perched on top of the monument."
?CND16:	PRINTI	" Stretching east and west from the park is Tokyo's main street. "
	EQUAL?	DOG-LOC,30 \?ELS21
	PRINTI	"Scattered throughout the park are pieces of fur and scales mixed with bits of wire and a couple of servomotors."
	FSET?	DOG,CLUTCHING-BIT \?CND19
	PRINTI	" A "
	CALL	DPRINT,RING
	PRINTI	" is lying near the debris."
	JUMP	?CND19
?ELS21:	EQUAL?	DOG-LOC,20 \?ELS26
	PRINTI	"West of the park,"
	CALL	TPRINT,DOG
	PRINTI	" is lying in the street."
	JUMP	?CND19
?ELS26:	EQUAL?	DOG-LOC,40 \?ELS28
	PRINTI	"Scattered in the street east of the park are pieces of fur and scales mixed with bits of wire and a couple of servomotors."
	FSET?	DOG,CLUTCHING-BIT \?CND19
	PRINTI	" A "
	CALL	DPRINT,RING
	PRINTI	" is lying near the debris."
	JUMP	?CND19
?ELS28:	LESS?	DOG-LOC,6 \?ELS33
	GRTR?	DOG-LOC,0 \?ELS33
	PRINTI	"In the street west of the park there is an "
	CALL	DPRINT,DOG
	SUB	TANK-LOC,1
	EQUAL?	DOG-LOC,TANK-LOC,STACK /?THN39
	SUB	PLANE-LOC,1
	EQUAL?	DOG-LOC,PLANE-LOC,STACK \?CND36
?THN39:	PRINTI	" under attack"
?CND36:	PRINTC	46
	JUMP	?CND19
?ELS33:	EQUAL?	DOG-LOC,6,7 \?ELS42
	PRINTI	"There is an "
	CALL	DPRINT,DOG
	PRINTI	" in the park"
	ZERO?	ROCKET-LIFE /?CND43
	PRINTI	" with a rocket buzzing around it"
?CND43:	PRINTC	46
	JUMP	?CND19
?ELS42:	GRTR?	DOG-LOC,7 \?CND19
	PRINTI	"There is an "
	CALL	DPRINT,DOG
	PRINTI	" in the street east of the park"
	ZERO?	ROCKET-LIFE /?CND48
	PRINTI	" with a rocket buzzing around it"
?CND48:	PRINTC	46
?CND19:	PRINTI	" The entire model is covered by a thick plastic dome"
	LESS?	BURN-DOME,3 \?CND51
	PRINTI	" which has a "
	EQUAL?	BURN-DOME,2 \?ELS56
	PRINTI	"slightly melted spot"
	JUMP	?CND54
?ELS56:	EQUAL?	BURN-DOME,1 \?ELS58
	PRINTI	"melted spot"
	JUMP	?CND54
?ELS58:	ZERO?	BURN-DOME \?CND54
	PRINTI	"small hole"
?CND54:	PRINTI	" in it near the east end"
?CND51:	PRINTR	". Outside the dome on the model there are five buttons: a blue button, a black button, a green button, a white button and a red button."


	.FUNCT	MONUMENT-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's "
	FSET?	MONUMENT,TRASHED-BIT \?CND6
	PRINTI	"what's left of "
?CND6:	PRINTI	"a memorial dedicated to the brave Japanese men and women who have died defending Tokyo against various monsters"
	FSET?	RING,ON-MONUMENT-BIT \?ELS11
	PRINTI	". A "
	CALL	DPRINT,RING
	PRINTI	" is sitting atop the monument"
	JUMP	?CND9
?ELS11:	FSET?	MONUMENT,TRASHED-BIT \?CND9
	FSET?	DOG,CLUTCHING-BIT /?CND9
	PRINTI	". There is"
	CALL	APRINT,RING
	PRINTI	" lying next to the monument rubble"
?CND9:	PRINTR	"."
?ELS5:	CALL	TOUCHING?,MONUMENT
	ZERO?	STACK /FALSE
	PRINTI	"You can't reach"
	CALL	TPRINT,MONUMENT
	PRINTR	". It's under the plastic dome."


	.FUNCT	RING-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"It's"
	CALL	TPRINT,RING
	PRINTR	" from Uncle Buddy's movie ""The Big Diamond Ring."""
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS7
	FSET?	RING,TRYTAKEBIT \?ELS7
	ZERO?	BURN-DOME \?ELS14
	FSET?	DOG,CLUTCHING-BIT \?ELS19
	FCLEAR	RING,TRYTAKEBIT
	FCLEAR	DOG,CLUTCHING-BIT
	FCLEAR	RING,NDESCBIT
	SET	'RING-UNDER-DOME,FALSE-VALUE
	RFALSE	
?ELS19:	PRINTR	"It's in the park in the middle of downtown Tokyo, the model that is. Despite the hole, you can't reach it from here."
?ELS14:	PRINTR	"It's under the plastic dome. You can't reach it."
?ELS7:	EQUAL?	PRSA,V?CUT \FALSE
	EQUAL?	PRSI,RING \FALSE
	PRINTR	"You don't think that's a real diamond, do you? Not in one of Uncle Buddy's movies."


	.FUNCT	TANK-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	EQUAL?	TANK-LOC,33 \FALSE
	PRINTI	"You can't see any "
	CALL	DPRINT,TANK
	PRINTR	" here."
?ELS5:	CALL	TOUCHING?,TANK
	ZERO?	STACK /FALSE
	PRINTI	"You can't reach"
	CALL	TPRINT,TANK
	PRINTR	" under the plastic dome."


	.FUNCT	PLANE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	EQUAL?	PLANE-LOC,33 \FALSE
	PRINTI	"You can't see any "
	CALL	DPRINT,PLANE
	PRINTR	" here."
?ELS5:	CALL	TOUCHING?,PLANE
	ZERO?	STACK /FALSE
	PRINTI	"You can't reach"
	CALL	TPRINT,PLANE
	PRINTR	" under the plastic dome."


	.FUNCT	DOG-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	EQUAL?	DOG-LOC,30,40 \?ELS10
	PRINTR	"There's nothing left but bits of fur and scales mixed with pieces of wire and a couple of servomotors."
?ELS10:	PRINTI	"Being atomic, it bears little resemblance to the prancing rats you're used to seeing, except for the bulging eyes, of course. It has a furry underbelly, but in most places scales have replaced hair, giving it a more reptilian look. Its front paws are now heavy, clawed appendages and it has fierce-looking fangs. "
	EQUAL?	DOG-LOC,20 \?ELS15
	PRINTI	"It's lying on its side in the street, west of the park."
	JUMP	?CND13
?ELS15:	PRINTI	"It's standing on its hind legs balanced by its huge mutated spiny tail."
?CND13:	GRTR?	HIT-POINTS,29 \?ELS20
	LESS?	HIT-POINTS,33 \?ELS20
	PRINTI	" It seems near death."
	JUMP	?CND18
?ELS20:	GRTR?	HIT-POINTS,25 \?CND18
	LESS?	HIT-POINTS,29 \?CND18
	PRINTI	" The repeated attacks are taking their toll."
?CND18:	FSET?	DOG,CLUTCHING-BIT \?CND27
	PRINTI	" It's clutching"
	CALL	APRINT,RING
	PRINTI	" with its claws."
?CND27:	CRLF	
	RTRUE	
?ELS5:	CALL	TOUCHING?,DOG
	ZERO?	STACK /FALSE
	EQUAL?	PRSA,V?TAKE \?CND32
	EQUAL?	PRSI,DOG \?CND32
	EQUAL?	PRSO,RING \?CND32
	ZERO?	BURN-DOME \?CND32
	FSET?	DOG,CLUTCHING-BIT /FALSE
?CND32:	PRINTI	"You can't reach"
	CALL	TPRINT,DOG
	PRINTR	". It's under the plastic dome."


	.FUNCT	RED-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	DOG-DEAD?
	ZERO?	STACK \TRUE
	ZERO?	DOG-BREATH \?ELS12
	PRINTI	"You hear a faint gagging noise coming from"
	CALL	TPRINT,DOG
	PRINTR	", then see a little smoke rise from his nostrils."
?ELS12:	DEC	'DOG-BREATH
	EQUAL?	DOG-LOC,PLANE-LOC \?ELS19
	EQUAL?	PLANES-LEFT,2 \?ELS24
	SET	'PLANES-LEFT,1
	PUTP	PLANE,P?SDESC,STR?226
	PRINTR	"A gout of flame from the maw of the plutonium puppy burns up one of the puny planes."
?ELS24:	MOVE	PLANE,P-NMERGE
	SET	'PLANES-LEFT,0
	SET	'PLANE-LOC,30
	PRINTR	"An eight-inch flame shoots from the dog's mouth, burning up the remaining puny plane."
?ELS19:	EQUAL?	DOG-LOC,6,7 \?ELS28
	ZERO?	ROCKET-LIFE /?ELS28
	CALL	DEQUEUE,I-ROCKET-ATTACK
	SET	'ROCKET-LIFE,0
	SET	'ROCKET-LOC,30
	PRINTR	"The dog barks a flame, which burns the rocket to a crisp. (Japanese taxpayers are bound to complain about this useless and expensive waste of military hardware.)"
?ELS28:	EQUAL?	DOG-LOC,10 \?ELS32
	ZERO?	ROCKET-LIFE \?ELS32
	ZERO?	BURN-DOME /?ELS32
	DEC	'BURN-DOME
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" breathes fire which "
	EQUAL?	BURN-DOME,2 \?ELS37
	PRINTI	"slightly melts a spot"
	JUMP	?CND35
?ELS37:	EQUAL?	BURN-DOME,1 \?ELS39
	PRINTI	"melts the spot even more. There is almost a hole"
	JUMP	?CND35
?ELS39:	ZERO?	BURN-DOME \?CND35
	PRINTI	"burns a small hole"
?CND35:	PRINTR	" in the plastic dome."
?ELS32:	PRINTR	"A flame shoots from the dog's mouth into the air."


	.FUNCT	WHITE-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	DOG-DEAD?
	ZERO?	STACK \TRUE
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" swipes at "
	EQUAL?	DOG-LOC,PLANE-LOC \?ELS11
	PRINTI	"the "
	CALL	DPRINT,PLANE
	PRINTI	", striking "
	EQUAL?	PLANES-LEFT,2 \?ELS14
	PRINTI	"one"
	JUMP	?CND12
?ELS14:	PRINTI	"it"
?CND12:	PRINTI	". A puff of black smoke begins to trail from the puny plane. "
	EQUAL?	PLANES-LEFT,2 \?ELS19
	PRINTI	"It rolls to one side, then heads down, crashing in a Tokyo suburb"
	JUMP	?CND17
?ELS19:	PRINTI	"It tumbles out of control, crashing in the parking lot of the Tokyo Disneyland"
?CND17:	DEC	'PLANES-LEFT
	PUTP	PLANE,P?SDESC,STR?226
	ZERO?	PLANES-LEFT \?CND9
	MOVE	PLANE,P-NMERGE
	SET	'PLANES-LEFT,0
	SET	'PLANE-LOC,30
	JUMP	?CND9
?ELS11:	EQUAL?	DOG-LOC,ROCKET-LOC \?ELS26
	EQUAL?	ROCKET-LOC,30 /?ELS26
	PRINTI	"the rocket, barely missing it"
	JUMP	?CND9
?ELS26:	PRINTI	"thin air"
?CND9:	PRINTR	"."


	.FUNCT	DOG-DEAD?
	EQUAL?	DOG-LOC,30,40 \?ELS5
	PRINTI	"A servomotor "
	EQUAL?	DOG-LOC,40 \?ELS8
	PRINTI	"east of "
	JUMP	?CND6
?ELS8:	PRINTI	"in "
?CND6:	PRINTR	"the park spins for a moment."
?ELS5:	EQUAL?	DOG-LOC,20 \FALSE
	EQUAL?	PRSI,RED-BUTTON \?ELS17
	PRINTI	"A slight puff of smoke emerges slowly from"
	CALL	TPRINT,DOG
	PRINTR	"'s left nostril."
?ELS17:	PRINTI	"You press"
	CALL	TPRINT,PRSO
	PRINTR	" but nothing happens."


	.FUNCT	GREEN-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	DOG-DEAD?
	ZERO?	STACK \TRUE
	EQUAL?	DOG-LOC,TANK-LOC,PLANE-LOC \?ELS10
	PRINTI	"The gunfire prevents"
	CALL	TPRINT,DOG
	PRINTI	" from moving further forward."
	CRLF	
	JUMP	?CND6
?ELS10:	EQUAL?	DOG-LOC,10 \?ELS12
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" bumps its atomic snout into the plastic dome covering the model."
	CRLF	
	JUMP	?CND6
?ELS12:	INC	'DOG-LOC
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	", in "
	GRTR?	HIT-POINTS,8 \?ELS17
	PRINTI	"a wounded waddle,"
	JUMP	?CND15
?ELS17:	PRINTI	"its best prehistoric prance,"
?CND15:	PRINTI	" moves "
	EQUAL?	DOG-LOC,6 \?ELS22
	PRINTI	"into the west end of the park, violating all leash laws."
	CRLF	
	JUMP	?CND6
?ELS22:	EQUAL?	DOG-LOC,7 \?ELS24
	PRINTI	"to the east end of the park right in front of a monument, near the tiny truck."
	ZERO?	ROCKET-LIFE /?CND25
	SET	'ROCKET-LOC,7
	PRINTI	" The rocket follows close behind."
?CND25:	CRLF	
	JUMP	?CND6
?ELS24:	EQUAL?	DOG-LOC,8 \?ELS29
	PRINTI	"forward, crushing the monument. Dozens of local pigeons commence mourning. "
	FSET	MONUMENT,TRASHED-BIT
	FSET?	DOG,CLUTCHING-BIT /?CND30
	FCLEAR	RING,ON-MONUMENT-BIT
	PRINTI	"The "
	CALL	DPRINT,RING
	PRINTI	" tumbles off the monument onto the ground. "
?CND30:	PRINTI	"The dog leaves the park and moves into the street"
	EQUAL?	DOG-LOC,ROCKET-LOC /?CND33
	EQUAL?	ROCKET-LOC,30 /?CND33
	SET	'ROCKET-LOC,DOG-LOC
	PRINTI	". The rocket follows close behind"
?CND33:	PRINTC	46
	CRLF	
	JUMP	?CND6
?ELS29:	EQUAL?	DOG-LOC,9 \?ELS39
	PRINTI	"further east, then comes to a stop."
	EQUAL?	DOG-LOC,ROCKET-LOC /?CND40
	EQUAL?	ROCKET-LOC,30 /?CND40
	SET	'ROCKET-LOC,DOG-LOC
	PRINTI	" The rocket follows close behind."
?CND40:	CRLF	
	JUMP	?CND6
?ELS39:	EQUAL?	DOG-LOC,2 \?ELS46
	PRINTI	"east, then comes to a stop."
	CRLF	
	JUMP	?CND6
?ELS46:	PRINTI	"further east, then comes to a stop."
	CRLF	
?CND6:	EQUAL?	DOG-LOC,2 \?ELS51
	EQUAL?	DOG-LOC,TANK-LOC,PLANE-LOC /?ELS51
	SET	'TANK-LOC,5
	SET	'PLANE-LOC,7
	CALL	QUEUE,I-TANK-ATTACK,2
	CRLF	
	PRINTI	"Suddenly, several blocks east of"
	CALL	TPRINT,DOG
	PRINTI	", a pair of "
	CALL	DPRINT,TANK
	PRINTI	" turn a corner onto the main street. They're heading straight for"
	CALL	TPRINT,DOG
	PRINTR	". Out of the corner of your eye you notice a puny plane flying over the park. The puny plane banks, turning towards the main street."
?ELS51:	EQUAL?	DOG-LOC,6 \TRUE
	CALL	QUEUE,I-ROCKET-ATTACK,2
	SET	'ROCKET-LOC,6
	SET	'TRUCK-LOC,7
	CRLF	
	PRINTI	"Suddenly out from under a clump of trees at the east end of the park, a tiny truck with a rocket mounted on it rolls into view. (Apparently, violating Tokyo's leash laws is not taken lightly.) A small radar dish on the tiny truck spins furiously until it locks in on"
	CALL	TPRINT,DOG
	PRINTR	" and stops. A puff of smoke comes from the back of the rocket as it blasts off toward the dog."


	.FUNCT	I-TANK-ATTACK,HITS,TANK-IN-RANGE=0,PLANE-IN-RANGE=0
	ZERO?	TANKS-LEFT \?CND1
	ZERO?	PLANES-LEFT \?CND1
	CALL	DEQUEUE,I-TANK-ATTACK
	RFALSE	
?CND1:	CALL	QUEUE,I-TANK-ATTACK,-1
	SET	'HITS,HIT-POINTS
	EQUAL?	HERE,GAME-ROOM \?CND6
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND6
	CRLF	
?CND6:	EQUAL?	DOG-LOC,TANK-LOC \?ELS13
	EQUAL?	DOG-LOC,PLANE-LOC \?ELS13
	EQUAL?	HERE,GAME-ROOM \?CND16
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND16
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" continues to take fire from"
	CALL	TPRINT,TANK
	PRINTI	" and"
	CALL	TPRINT,PLANE
	PRINTC	46
?CND16:	ADD	PLANES-LEFT,TANKS-LEFT
	ADD	HIT-POINTS,STACK >HIT-POINTS
	JUMP	?CND11
?ELS13:	EQUAL?	TANK-LOC,DOG-LOC \?ELS25
	EQUAL?	HERE,GAME-ROOM \?CND26
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND26
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" continues to take hits from"
	CALL	TPRINT,TANK
	PRINTC	46
?CND26:	ADD	HIT-POINTS,TANKS-LEFT >HIT-POINTS
	JUMP	?CND23
?ELS25:	ZERO?	TANKS-LEFT /?CND23
	DEC	'TANK-LOC
	EQUAL?	TANK-LOC,DOG-LOC \?ELS35
	EQUAL?	HERE,GAME-ROOM \?CND36
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND36
	PRINTI	"The tanks "
	GRTR?	HIT-POINTS,0 \?ELS43
	PRINTI	"continue"
	JUMP	?CND41
?ELS43:	PRINTI	"begin"
?CND41:	PRINTI	" to fire as they roll to a stop at the foot of the mutant Mexican hairless."
?CND36:	ADD	HIT-POINTS,TANKS-LEFT >HIT-POINTS
	JUMP	?CND23
?ELS35:	ADD	DOG-LOC,1
	EQUAL?	STACK,TANK-LOC \?ELS47
	EQUAL?	HERE,GAME-ROOM \?CND48
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND48
	PRINTI	"The tanks, only a block away, begin firing as they move within range."
?CND48:	ADD	HIT-POINTS,TANKS-LEFT >HIT-POINTS
	JUMP	?CND23
?ELS47:	EQUAL?	TANK-LOC,DOG-LOC /?CND23
	EQUAL?	HERE,GAME-ROOM \?CND23
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND23
	PRINTI	"The tanks, a few blocks away, continue to advance toward the radiated sewer rat."
?CND23:	ZERO?	TANKS-LEFT /?CND60
	EQUAL?	HERE,GAME-ROOM \?CND60
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND60
	PRINTC	32
?CND60:	EQUAL?	PLANE-LOC,DOG-LOC \?ELS70
	EQUAL?	HERE,GAME-ROOM \?CND71
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND71
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" continues to take fire from"
	CALL	TPRINT,PLANE
	PRINTC	46
?CND71:	ADD	HIT-POINTS,PLANES-LEFT >HIT-POINTS
	JUMP	?CND11
?ELS70:	ZERO?	PLANES-LEFT /?CND11
	DEC	'PLANE-LOC
	EQUAL?	PLANE-LOC,DOG-LOC \?ELS80
	EQUAL?	HERE,GAME-ROOM \?CND81
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND81
	PRINTI	"The planes, spewing bullet-shaped death, reach the radioactive reptile and begin circling around it."
?CND81:	ADD	HIT-POINTS,PLANES-LEFT >HIT-POINTS
	JUMP	?CND11
?ELS80:	ADD	DOG-LOC,1
	EQUAL?	STACK,PLANE-LOC \?ELS87
	EQUAL?	HERE,GAME-ROOM \?CND88
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND88
	PRINTI	"The planes, only a block away, begin firing as they move within range."
?CND88:	ADD	HIT-POINTS,PLANES-LEFT >HIT-POINTS
	JUMP	?CND11
?ELS87:	EQUAL?	PLANE-LOC,DOG-LOC /?CND11
	EQUAL?	PLANE-LOC,6 \?ELS97
	EQUAL?	HERE,GAME-ROOM \?CND98
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND98
	PRINTI	"Over the park, a second puny plane joins the first one."
?CND98:	PUTP	PLANE,P?SDESC,STR?227
	JUMP	?CND11
?ELS97:	EQUAL?	PLANE-LOC,5 \?ELS104
	EQUAL?	HERE,GAME-ROOM \?CND105
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND105
	PRINTI	"The puny planes swoop out of the park and down the street"
?CND105:	EQUAL?	DOG-LOC,4 \?CND110
	EQUAL?	HERE,GAME-ROOM \?CND113
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND113
	PRINTI	" firing at"
	CALL	TPRINT,DOG
?CND113:	ADD	HIT-POINTS,PLANES-LEFT >HIT-POINTS
?CND110:	EQUAL?	HERE,GAME-ROOM \?CND11
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND11
	PRINTC	46
	JUMP	?CND11
?ELS104:	EQUAL?	HERE,GAME-ROOM \?CND11
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND11
	PRINTI	"The planes, a few blocks away, continue to fly toward the radiated sewer rat."
?CND11:	GRTR?	HIT-POINTS,HITS \?CND130
	EQUAL?	HERE,GAME-ROOM \?CND133
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND133
	EQUAL?	PLANE-LOC,30 \?ELS140
	CALL	PICK-ONE,DOG-IN-PAIN
	PRINT	STACK
	JUMP	?CND133
?ELS140:	PRINTC	32
	CALL	PICK-ONE,DOG-IN-PAIN
	PRINT	STACK
?CND133:	GRTR?	HIT-POINTS,19 \?ELS145
	CALL	DEQUEUE,I-TANK-ATTACK
	SET	'DOG-LOC,20
	SET	'TANK-LOC,33
	SET	'PLANE-LOC,33
	EQUAL?	HERE,GAME-ROOM \?CND130
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND130
	PRINTI	" The "
	CALL	DPRINT,DOG
	PRINTI	" starts to shake as if he has to go outside, then stumbles and falls to the ground.

*** The "
	CALL	DPRINT,DOG
	PRINTI	" has died ***

           Tokyo is saved!"
	CRLF	
	CRLF	
	PRINTI	"The "
	ZERO?	TANKS-LEFT /?ELS153
	PRINTI	"tiny tank"
	EQUAL?	TANKS-LEFT,2 \?ELS156
	PRINTI	"s turn"
	JUMP	?CND154
?ELS156:	PRINTI	" turns"
?CND154:	PRINTI	" onto a side street and disappear"
	EQUAL?	TANKS-LEFT,1 \?CND159
	PRINTC	115
?CND159:	ZERO?	PLANES-LEFT \?ELS164
	PRINTC	46
	JUMP	?CND130
?ELS164:	PRINTI	" as the puny plane"
	EQUAL?	PLANES-LEFT,2 \?ELS169
	PRINTI	"s tip their"
	JUMP	?CND167
?ELS169:	PRINTI	" tips its"
?CND167:	PRINTI	" wings and head"
	EQUAL?	PLANES-LEFT,1 \?CND172
	PRINTC	115
?CND172:	PRINTI	" for home."
	JUMP	?CND130
?ELS153:	PRINTI	"puny plane"
	EQUAL?	PLANES-LEFT,2 \?ELS179
	PRINTI	"s tip their"
	JUMP	?CND177
?ELS179:	PRINTI	" tips its"
?CND177:	PRINTI	" wings and head"
	EQUAL?	PLANES-LEFT,1 \?CND182
	PRINTC	115
?CND182:	PRINTI	" for home."
	JUMP	?CND130
?ELS145:	GRTR?	HIT-POINTS,15 \?ELS186
	GRTR?	HITS,15 /?ELS186
	EQUAL?	HERE,GAME-ROOM \?CND130
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND130
	PRINTI	" The repeated attacks weaken"
	CALL	TPRINT,DOG
	PRINTI	" and it seems near death."
	JUMP	?CND130
?ELS186:	GRTR?	HIT-POINTS,11 \?CND130
	GRTR?	HITS,11 /?CND130
	EQUAL?	HERE,GAME-ROOM \?CND130
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND130
	PRINTI	" The repeated attacks begin to take their toll on"
	CALL	TPRINT,DOG
	PRINTC	46
?CND130:	EQUAL?	HERE,GAME-ROOM \TRUE
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /TRUE
	CRLF	
	RTRUE	


	.FUNCT	I-ROCKET-ATTACK
	EQUAL?	ROCKET-LOC,30 /FALSE
	CALL	QUEUE,I-ROCKET-ATTACK,-1
	DEC	'ROCKET-LIFE
	ZERO?	ROCKET-LIFE \?ELS8
	EQUAL?	HERE,GAME-ROOM \?CND9
	CALL	LIT?,GAME-ROOM
	ZERO?	STACK /?CND9
	CRLF	
	PRINTI	"The rocket swoops down, striking"
	CALL	TPRINT,DOG
	PRINTI	" in the chest. The "
	CALL	DPRINT,DOG
	PRINTI	" explodes and pieces of fur and scales, mixed with bits of wire and a couple of servomotors, scatter throughout the area.

*** The "
	CALL	DPRINT,DOG
	PRINTI	" has died ***

           Tokyo is saved!"
	CRLF	
?CND9:	SET	'ROCKET-LOC,30
	CALL	DEQUEUE,I-ROCKET-ATTACK
	EQUAL?	DOG-LOC,6,7 \?ELS18
	SET	'DOG-LOC,30
	RETURN	DOG-LOC
?ELS18:	SET	'DOG-LOC,40
	RETURN	DOG-LOC
?ELS8:	EQUAL?	ROCKET-LIFE,3 \?ELS27
	EQUAL?	HERE,GAME-ROOM \?ELS27
	CALL	LIT?,HERE
	ZERO?	STACK /?ELS27
	CRLF	
	PRINTI	"The rocket speeds toward"
	CALL	TPRINT,DOG
	PRINTR	" and begins circling as it nears."
?ELS27:	EQUAL?	ROCKET-LIFE,2 \?ELS31
	EQUAL?	HERE,GAME-ROOM \?ELS31
	CALL	LIT?,HERE
	ZERO?	STACK /?ELS31
	CRLF	
	PRINTI	"The rocket begins bobbing up and down, sniffing for just the right spot as it circles"
	CALL	TRPRINT,DOG
	RSTACK	
?ELS31:	EQUAL?	ROCKET-LIFE,1 \FALSE
	EQUAL?	HERE,GAME-ROOM \FALSE
	CALL	LIT?,HERE
	ZERO?	STACK /FALSE
	CRLF	
	PRINTI	"Suddenly the rocket makes a wide turn out in front of"
	CALL	TPRINT,DOG
	PRINTR	". It seems to have found the spot it was looking for. The rocket's speed increases as it heads right for the dog's heart!"


	.FUNCT	BLUE-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	DOG-DEAD?
	ZERO?	STACK \TRUE
	PRINTI	"The "
	CALL	DPRINT,DOG
	FSET?	DOG,CLUTCHING-BIT \?ELS13
	PRINTI	" clutches"
	CALL	TPRINT,RING
	PRINTR	" more tightly."
?ELS13:	EQUAL?	DOG-LOC,7 \?ELS15
	PRINTI	" clutches"
	CALL	TPRINT,RING
	PRINTI	" in its front claws."
	CRLF	
	FCLEAR	RING,ON-MONUMENT-BIT
	FSET	DOG,CLUTCHING-BIT
	RTRUE	
?ELS15:	PRINTR	" grasps at thin air with its front claws."


	.FUNCT	BLACK-BUTTON-F
	EQUAL?	PRSA,V?PUSH \FALSE
	CALL	DOG-DEAD?
	ZERO?	STACK \TRUE
	EQUAL?	DOG-LOC,TANK-LOC \?ELS11
	EQUAL?	TANKS-LEFT,2 \?ELS14
	RANDOM	100
	LESS?	50,STACK /?ELS14
	PUTP	TANK,P?SDESC,STR?232
	PRINTI	"Just as"
	CALL	TPRINT,DOG
	PRINTI	" is about to raise its hind leg, one of the tiny tanks drives up onto its toenail. As"
	CALL	TPRINT,DOG
	PRINTI	" raises its hind leg, the tiny tank is lifted off the ground and hurled through the air into the middle of a nearby apartment building, demolishing a large portion of it. Hundreds of house plants fall to their deaths. The "
	CALL	DPRINT,DOG
	PRINTI	" stomps the street's pavement with its clawed foot."
	SET	'TANKS-LEFT,1
	JUMP	?CND9
?ELS14:	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" lifts its hind leg and, just as you thought this game was going to become even more base, stomps its clawed foot down on "
	EQUAL?	TANKS-LEFT,2 \?ELS21
	PRINTI	"one of the tiny tanks"
	PUTP	TANK,P?SDESC,STR?232
	SET	'TANKS-LEFT,1
	JUMP	?CND19
?ELS21:	PRINTI	"the other tiny tank"
	MOVE	TANK,P-NMERGE
	SET	'TANKS-LEFT,0
	SET	'TANK-LOC,30
?CND19:	PRINTI	", crushing it."
	JUMP	?CND9
?ELS11:	EQUAL?	TRUCK-LOC,7 \?ELS25
	EQUAL?	DOG-LOC,7 \?ELS25
	PRINTI	"The Chihuahua raises his hind leg and soundly stomps the tiny truck, smashing it to bits."
	ZERO?	ROCKET-LIFE /?CND28
	PRINTI	" The rocket heads straight for the Atomic Chihuahua, then begins to swerve and dive erratically. It sails past the Atomic Chihuahua, colliding with Tokyo's tallest building, the Ginsu Building, corporate headquarters of the Ginsu Knife Company. Just as your mind pauses to consider the possibility of a Ginsu knife standing up to this kind of punishment, the rocket explodes and the entire building collapses. Tokyo isn't saved but millions of late-night TV viewers are."
?CND28:	SET	'TRUCK-LOC,30
	SET	'ROCKET-LOC,30
	SET	'ROCKET-LIFE,0
	CALL	DEQUEUE,I-ROCKET-ATTACK
	JUMP	?CND9
?ELS25:	EQUAL?	DOG-LOC,6,7 \?ELS32
	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" lifts its hind leg (no, not that!) and stomps its scaly claw down on the grass, creating a children's wading pool."
	JUMP	?CND9
?ELS32:	PRINTI	"The "
	CALL	DPRINT,DOG
	PRINTI	" lifts its hind leg and stomps its clawed foot down on the street's pavement."
?CND9:	CRLF	
	RTRUE	


	.FUNCT	MENS-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	DESCRIBE-BATHROOM,STR?234
	RSTACK	


	.FUNCT	DESCRIBE-BATHROOM,GENDER
	PRINTI	"This is an ordinary restroom which looks like a "
	PRINT	GENDER
	PRINTI	" room in a theatre."
	RTRUE	


	.FUNCT	LADIES-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	DESCRIBE-BATHROOM,STR?235
	RSTACK	


	.FUNCT	ENTER-HM
	FCLEAR	HEDGE-MAZE,TOUCHBIT
	SET	'HM-ROOM,439
	CALL	ULTIMATELY-IN?,VERTICAL-MAP
	ZERO?	STACK \?CND1
	CALL	ULTIMATELY-IN?,HORIZONTAL-MAP
	ZERO?	STACK \?CND1
	PRINTI	"You feel uneasy going into the hedge maze knowing Aunt Hildegarde isn't here to help you find your way out."
	CRLF	
	CRLF	
?CND1:	RANDOM	20
	ADD	30,STACK
	CALL	QUEUE,I-HEDGE-FOOTSTEPS,STACK
	RETURN	HEDGE-MAZE


	.FUNCT	I-HEDGE-FOOTSTEPS
	EQUAL?	HERE,HEDGE-MAZE \FALSE
	RANDOM	20
	ADD	30,STACK
	CALL	QUEUE,I-HEDGE-FOOTSTEPS,STACK
	CRLF	
	PRINTR	"You hear footsteps on the other side of the hedge."


	.FUNCT	HEDGE-MAZE-OBJ-F
	EQUAL?	PRSA,V?LEAVE,V?EXIT,V?ENTER /?THN6
	EQUAL?	PRSA,V?DISEMBARK,V?WALK-TO \FALSE
?THN6:	CALL	V-WALK-AROUND
	RSTACK	


	.FUNCT	HEDGE-MAZE-F,RARG,PATHS=0,OLD,STEPS,DIR
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are in a hedge maze of astonishing complexity. "
	BTST	HM-BITS,X-N \?CND6
	INC	'PATHS
?CND6:	BTST	HM-BITS,X-E \?CND9
	INC	'PATHS
?CND9:	BTST	HM-BITS,X-W \?CND12
	INC	'PATHS
?CND12:	BTST	HM-BITS,X-S \?CND15
	INC	'PATHS
?CND15:	GRTR?	PATHS,1 \?ELS20
	PRINTI	"Paths lead "
	JUMP	?CND18
?ELS20:	PRINTI	"A path leads "
?CND18:	BTST	HM-BITS,X-N \?CND23
	PRINTI	"north"
	CALL	PUNCTUATION,PATHS >PATHS
?CND23:	BTST	HM-BITS,X-S \?CND26
	PRINTI	"south"
	CALL	PUNCTUATION,PATHS >PATHS
?CND26:	BTST	HM-BITS,X-E \?CND29
	PRINTI	"east"
	CALL	PUNCTUATION,PATHS >PATHS
?CND29:	BTST	HM-BITS,X-W \?CND32
	PRINTI	"west"
	CALL	PUNCTUATION,PATHS >PATHS
?CND32:	BTST	HM-BITS,X-H \TRUE
	CRLF	
	CRLF	
	PRINTI	"There is a hole in the ground here from your previous excavations."
	MOVE	MAZE-HOLE,HERE
	RTRUE	
?ELS5:	EQUAL?	RARG,M-ENTER \?ELS39
	GETB	HM-TABLE,HM-ROOM >HM-BITS
	CALL	OBJECTS-TO-ROOM,HM-ROOM
	RSTACK	
?ELS39:	EQUAL?	RARG,M-BEG \FALSE
	EQUAL?	PRSA,V?WALK \FALSE
	SET	'OLD,HM-ROOM
	CALL	OBJECTS-TO-TABLE,OLD
	EQUAL?	P-WALK-DIR,P?NORTH \?ELS49
	BTST	HM-BITS,X-N \?ELS49
	SET	'DIR,STR?99
	CALL	HEDGE-WALK,X-N >STEPS
	JUMP	?CND47
?ELS49:	EQUAL?	P-WALK-DIR,P?SOUTH \?ELS53
	BTST	HM-BITS,X-S \?ELS53
	EQUAL?	HM-ROOM,439 \?ELS58
	CALL	GOTO,ENTRANCE-TO-MAZE
	RTRUE	
?ELS58:	EQUAL?	HM-ROOM,388 \?CND56
	PRINTI	"You make your way 10 feet south along the path."
	CRLF	
	CRLF	
	CALL	GOTO,HEART-OF-MAZE
	RTRUE	
?CND56:	SET	'DIR,STR?97
	CALL	HEDGE-WALK,X-S >STEPS
	JUMP	?CND47
?ELS53:	EQUAL?	P-WALK-DIR,P?EAST \?ELS62
	BTST	HM-BITS,X-E \?ELS62
	SET	'DIR,STR?237
	CALL	HEDGE-WALK,X-E >STEPS
	JUMP	?CND47
?ELS62:	EQUAL?	P-WALK-DIR,P?WEST \?ELS66
	BTST	HM-BITS,X-W \?ELS66
	SET	'DIR,STR?238
	CALL	HEDGE-WALK,X-W >STEPS
	JUMP	?CND47
?ELS66:	EQUAL?	P-WALK-DIR,P?UP \?ELS70
	PRINTI	"Please don't climb the hedges."
	CRLF	
	RETURN	2
?ELS70:	EQUAL?	P-WALK-DIR,P?DOWN \?ELS74
	PRINTI	"You burrow furiously to no avail."
	CRLF	
	RETURN	2
?ELS74:	CALL	OBJECTS-TO-ROOM,OLD
	CALL	PICK-ONE,HEDGE-CRASH
	PRINT	STACK
	PRINTC	46
	CRLF	
	RETURN	2
?CND47:	FCLEAR	HEDGE-MAZE,TOUCHBIT
	PRINTI	"You make your way "
	MUL	10,STEPS
	PRINTN	STACK
	PRINTI	" feet "
	PRINT	DIR
	PRINTI	" along the path."
	CRLF	
	CRLF	
	CALL	GOTO,HEDGE-MAZE
	RSTACK	


	.FUNCT	OUT-OF-HEART-OF-MAZE
	FCLEAR	HEDGE-MAZE,TOUCHBIT
	PRINTI	"You make your way 10 feet north along the path."
	CRLF	
	CRLF	
	RETURN	HEDGE-MAZE


	.FUNCT	HEART-OF-MAZE-HOLE-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \FALSE
	CALL	CANT-OPEN-CLOSE
	RSTACK	


	.FUNCT	PUNCTUATION,PATHS
	EQUAL?	PATHS,4 \?ELS3
	PRINTI	", "
	JUMP	?CND1
?ELS3:	EQUAL?	PATHS,3 \?ELS5
	PRINTI	", "
	JUMP	?CND1
?ELS5:	EQUAL?	PATHS,2 \?ELS7
	PRINTI	" and "
	JUMP	?CND1
?ELS7:	PRINTC	46
?CND1:	DEC	'PATHS
	RETURN	PATHS


	.FUNCT	HEDGE-WALK,BIT,STEPS=0,MBITS
	SET	'MBITS,HM-BITS
?PRG1:	EQUAL?	BIT,X-N \?ELS5
	BTST	MBITS,X-N \?ELS5
	DEC	'HM-ROOM
	JUMP	?CND3
?ELS5:	EQUAL?	BIT,X-S \?ELS9
	BTST	MBITS,X-S \?ELS9
	INC	'HM-ROOM
	JUMP	?CND3
?ELS9:	EQUAL?	BIT,X-E \?ELS13
	BTST	MBITS,X-E \?ELS13
	ADD	HM-ROOM,20 >HM-ROOM
	JUMP	?CND3
?ELS13:	EQUAL?	BIT,X-W \?ELS17
	BTST	MBITS,X-W \?ELS17
	SUB	HM-ROOM,20 >HM-ROOM
	JUMP	?CND3
?ELS17:	RETURN	STEPS
?CND3:	INC	'STEPS
	GETB	HM-TABLE,HM-ROOM
	ZERO?	STACK /?ELS24
	RETURN	STEPS
?ELS24:	SET	'MBITS,15
	JUMP	?PRG1


	.FUNCT	OBJECTS-TO-TABLE,SLOC,TBL,CNT=0,F,N
	FIRST?	HEDGE-MAZE >F /?KLU21
?KLU21:	REMOVE	MAZE-HOLE
	SET	'TBL,HEDGE-OBJECTS-TABLE
?PRG1:	ZERO?	F /TRUE
	NEXT?	F >N /?CND3
?CND3:	EQUAL?	F,WINNER /?CND9
	FSET?	F,TAKEBIT \?CND9
?PRG14:	GET	TBL,CNT
	ZERO?	STACK \?ELS18
	PUT	TBL,CNT,SLOC
	ADD	CNT,1
	PUT	TBL,STACK,F
	ADD	CNT,2 >CNT
	REMOVE	F
	JUMP	?CND9
?ELS18:	ADD	CNT,2 >CNT
	JUMP	?PRG14
?CND9:	SET	'F,N
	JUMP	?PRG1


	.FUNCT	OBJECTS-TO-ROOM,SLOC,TBL,CNT=0
	SET	'TBL,HEDGE-OBJECTS-TABLE
?PRG1:	LESS?	CNT,HEDGE-OBJECT-TABLE-LENGTH \TRUE
	GET	TBL,CNT
	EQUAL?	STACK,SLOC \?CND3
	PUT	TBL,CNT,0
	ADD	CNT,1
	GET	TBL,STACK
	MOVE	STACK,HEDGE-MAZE
?CND3:	ADD	CNT,2 >CNT
	JUMP	?PRG1

	.ENDI
