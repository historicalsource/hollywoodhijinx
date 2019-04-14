"OUTSIDE for ANTHILL (C)1986 by Infocom Inc. All Rights Reserved."

"--- Outside House ---"

<OBJECT HOUSE	
	(IN LOCAL-GLOBALS)
	(DESC "Aunt Hildegarde's house")
	(SYNONYM HOUSE HILDEBUD)
	(ADJECTIVE AUNT HILDEG)
	(FLAGS NARTICLEBIT)
	(ACTION HOUSE-F)>

<ROUTINE HOUSE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's dark, but you can make out a stately two-story home with chimneys
near the east and west ends of the house. Hardly anything has changed since
you were last here several years ago, though you always remember the house
as full of life, and now it is deserted and silent." CR>)
	       (<VERB? ENTER>
		<DO-WALK P?IN>)>>

;"mention by the light of the full moon, your anle to make out its features."
;"Add routine to mysteriously turn on sprinklers if you walk on grass."

<ROOM SOUTH-JUNCTION
      (IN ROOMS)
      (DESC "South Junction")
      (LDESC
"You're standing in front of the house where you spent many of your
summers as a youngster. The old place is not as big as it seemed to
you then, but it is still quite large. Stone pathways wind east and
west around the house, and a larger main walkway leads north.")
      (NORTH PER TO-FRONT-PORCH)
      (EAST PER TO-&-FROM-SOUTH-JUNCTION)
      (WEST PER TO-&-FROM-SOUTH-JUNCTION)
      (SOUTH "It's a long way back to town.")
      (CAPACITY 2)
      (GLOBAL STAIRS HOUSE CHIMNEY)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT BLACK-CAT-BIT)
      (THINGS <PSEUDO (COMPASS ROSE COMPASS-ROSE-PSEUDO)>)
      (ACTION SOUTH-JUNCTION-F)>

<ROUTINE SOUTH-JUNCTION-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG SOUTH-JUNCTION-VISITS <+ ,SOUTH-JUNCTION-VISITS 1>>)>>

<ROUTINE TO-FRONT-PORCH ()
	 <COND (<FSET? ,SOUTH-JUNCTION ,BLACK-CAT-BIT>
		<TELL
"As you walk toward the house, a large black cat scurries across the path,
heading toward Johnny Carson's house." CR CR>
		<FCLEAR ,SOUTH-JUNCTION ,BLACK-CAT-BIT>
		,FRONT-PORCH)
	       (T
		,FRONT-PORCH)>>

<ROUTINE COMPASS-ROSE-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The compass rose encircles the base of the statue." CR>)>>

<OBJECT BAZOOKA
	(IN SOUTH-JUNCTION)
	(DESC "bazooka")
	(SYNONYM BAZOOKA)
	(FLAGS NDESCBIT)
	(ACTION BAZOOKA-F)>

<ROUTINE BAZOOKA-F ()
	 <COND (<VERB? PUSH MOVE TURN>
		<PERFORM ,PRSA ,BUCK ,PRSI>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The bazooka is pointing to the ">
		<SAY-BUCK-DIR>
		<TELL "." CR>)
	       (<VERB? SHOOT>
		<TELL "It's a stone gun, you geek." CR>)>>

<ROUTINE TO-&-FROM-SOUTH-JUNCTION ("AUX" NEW-ROOM)
	 <TELL "You follow the stone walkway as it turns ">
	 <COND (<EQUAL? ,HERE ,SOUTHEAST-JUNCTION>
                <SET NEW-ROOM ,SOUTH-JUNCTION>
		<TELL "west">)
	       (<EQUAL? ,HERE ,SOUTHWEST-JUNCTION>
                <SET NEW-ROOM ,SOUTH-JUNCTION>
		<TELL "east">)
	       (T
		<TELL "north">
		<COND (<PRSO? ,P?WEST>
		       <SET NEW-ROOM ,SOUTHWEST-JUNCTION>)
	       	      (T
		       <SET NEW-ROOM ,SOUTHEAST-JUNCTION>)>)>
	 <TELL " around the corner of the house, arriving at..." CR CR>
         .NEW-ROOM>

<ROOM SOUTHEAST-JUNCTION
      (IN ROOMS)
      (DESC "Southeast Junction")
      (LDESC
"This is the southeastern corner of a large backyard whose main feature
is an elaborate garden. The stone walkway splits in three directions
here: north, along the perimeter of the garden; south, around the side of
the house; and west, where the walkway ends at a couple of steps leading
up." CR)
      (NORTH TO NORTHEAST-JUNCTION)
      (WEST TO PATIO)
      (SOUTH PER TO-&-FROM-SOUTH-JUNCTION)
      (CAPACITY 2)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN)>

<ROUTINE TO-&-FROM-TOP-LANDING ()
         <COND (<FSET? ,NORTHEAST-JUNCTION ,EVERYBIT>
		<FCLEAR ,NORTHEAST-JUNCTION ,EVERYBIT>
		<TELL
"As you walk along the path you hear footsteps running south along the
stone walkway." CR CR>)
	       (T
		<TELL
"You walk a short distance along the grass path, arriving at..." CR CR>)>
	 <COND (<EQUAL? ,HERE ,NORTHEAST-JUNCTION>
		        ,TOP-LANDING)
	       (<EQUAL? ,HERE ,TOP-LANDING>
		        ,NORTHEAST-JUNCTION)>> ;"SEM- 2 conds?"

<ROOM SOUTHWEST-JUNCTION
      (IN ROOMS)
      (DESC "Southwest Junction")
      (LDESC
"This is the southwestern corner of a large backyard whose main feature
is an elaborate garden. The stone walkway splits in three directions
here: north, along the perimeter of the garden; south, around the side
of the house; and east, where the walkway ends at the foot of a couple of
steps." CR)
      (NORTH TO NORTHWEST-JUNCTION)
      (SOUTH PER TO-&-FROM-SOUTH-JUNCTION)
      (EAST TO PATIO)
      (CAPACITY 2)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN)>

<ROOM PATIO
      (IN ROOMS)
      (DESC "Patio")
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT) 
      (SOUTH TO GAME-ROOM IF PATIO-DOOR IS OPEN)
      (EAST TO SOUTHEAST-JUNCTION)
      (WEST TO SOUTHWEST-JUNCTION)
      (NORTH TO SOUTH-GARDEN)      
      (GLOBAL PATIO-DOOR HOUSE CHIMNEY GARDEN)
      (ACTION PATIO-F)>

<ROUTINE PATIO-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large fieldstone patio spanning the entire width of the
back of the house. In the daytime you can look out onto Aunt Hildegarde's
beautiful garden, said to be the envy of the Malibu colony. This is
where Uncle Buddy and Aunt Hildegarde would often entertain.~
~
Standing here you remember the time at one of their parties when you
swiped one of Uncle Buddy's big Hollywood cigars and smoked it, then got
sick on a rose bush in the garden. You snicker a little bit thinking
about that poor rose bush now and the goofy things you did as a child.
To the north a stone pathway leads to the garden. Steps lead down off to
the east and west, and there is a">
		<COND (<FSET? ,PATIO-DOOR ,OPENBIT>
		       <TELL "n open">)
		      (T
		       <TELL " closed">)>
		<TELL " door to the south.">)>>

;"ADD HACK FOR SOMEONE LOOKING AT GARDEN AT NIGHT"

<OBJECT PATIO-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "patio door")
	(SYNONYM DOOR)
	(ADJECTIVE PATIO)
        (FLAGS DOORBIT NDESCBIT LOCKEDBIT)>

<OBJECT GARDEN
	(IN LOCAL-GLOBALS)
	(DESC "Aunt Hildegarde's garden")
	(SYNONYM GARDEN)
	(FLAGS NARTICLEBIT)
	(ACTION GARDEN-F)>

<ROUTINE GARDEN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "This garden was Aunt Hildegarde's pride and joy. ">
		<COND (<NOT <G? ,MOVES 535>>
		       <TELL "By the moonlight you can see the outline of">)
		      (T
		       <TELL "You can see">)>
		<TELL
" dozens of fancy varieties of flowers and shrubs. Several small
trees dot the garden, giving shade during the day to the more delicate
blossoms. Stone walkways lead through the garden. A stone wall surrounds
the garden with entrances north and south." CR>)
	       (<VERB? ENTER>
		<TELL
"You can only enter the garden from the north or south of the garden." CR>)>>

<OBJECT GARDEN-WALLS
	(IN LOCAL-GLOBALS)
	(DESC "stone wall")
	(SYNONYM WALL)
	(ADJECTIVE STONE GARDEN)
	(FLAGS NDESCBIT)
	(ACTION GARDEN-WALLS-F)>

<ROUTINE GARDEN-WALLS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The stone wall surrounds the entire garden, with entrances to the north and
south of the garden." CR>)
	       (<VERB? CLIMB CLIMB-ON CLIMB-UP CLIMB-OVER>
		<TELL
"Aunt Hildegarde would paddle your fanny if she saw you do that." CR>)>>

<ROOM SOUTH-GARDEN
      (IN ROOMS)
      (DESC "Garden, South")
      (LDESC
"You're standing on a stone walkway in Aunt Hildegarde's much envied
garden where she would spend hours tending to her flowers, bushes and
trees. The garden was off limits to you as a child because of an
incident one summer when you and Cousin Herman were playing in the
garden. You suggested pretending to be wild African animals and climbed
a tree and began to screech as if a baboon while Cousin Herman ran off
toward the roses shouting something about being a rhinoceros.~
~
After howling until your throat felt like you had puffed on one of Uncle
Buddy's Hollywood cigars, you went to find Cousin Herman. When you
arrived you couldn't believe your eyes -- Cousin Herman had pulled all
the thorns off of all of Aunt Hildegarde's rose bushes in a quest to
find the biggest thorn possible so he could be a rhino. Of course when
Aunt Hildegarde saw her naked rose bushes, Cousin Herman blamed it all on
you. The walkway leads south, northeast and northwest.")
      (SOUTH TO PATIO)
      (NORTH "You bounce off a dwarf fig tree.")
      (NE TO EAST-GARDEN)
      (NW TO WEST-GARDEN)
      (CAPACITY 2)
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN GARDEN-WALLS)
      (THINGS <PSEUDO (<> TREES FLORAL-PSEUDO)
		      (<> TREE FLORAL-PSEUDO)
		      (<> FLOWER FLORAL-PSEUDO)>)>

<ROOM EAST-GARDEN
      (IN ROOMS)
      (DESC "Garden, East")
      (LDESC
"You are in the overpoweringly fragrant rose bush section of the garden.
As you admire the roses you notice one somewhat sickly rose bush.
Something about the sight of this particular rose bush makes you feel a
bit queasy. The stone walkway leads northwest and southwest.")
      (NW TO NORTH-GARDEN)
      (SW TO SOUTH-GARDEN)
      (EAST "After a brief altercation with a large rose bush you turn back.")
      (WEST "After a brief altercation with a large rose bush you turn back.")
      (CAPACITY 2)
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN GARDEN-WALLS)
      (THINGS <PSEUDO (ROSE BUSH ROSE-BUSH-PSEUDO)
		      (<> ROSE ROSE-BUSH-PSEUDO)
		      (<> ROSES FLORAL-PSEUDO)
		      (<> TREES FLORAL-PSEUDO)
		      (<> TREE FLORAL-PSEUDO)
		      (<> FLOWER FLORAL-PSEUDO)>)>

<ROUTINE ROSE-BUSH-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"You remember this rose bush from many summers ago. It's the one you got
sick on after smoking one of Uncle Buddy's cigars." CR>)
               (<VERB? SMELL>
		<TELL
"No doubt the fragrance would be sweeter had you not thrown-up on it
many years ago." CR>)
	       (<VERB? WATER>
		<TELL
"Driven by guilt, you splash some water on the bush. It looks better
already." CR>)>>

<ROOM WEST-GARDEN
      (IN ROOMS)
      (DESC "Garden, West")
      (LDESC
"You're standing on a stone walkway in the tulip section of the garden.
The walkway leads northeast and southeast.") 
      (NE TO NORTH-GARDEN)
      (SE TO SOUTH-GARDEN)
      (EAST "You couldn't bear to step on the tulips.")
      (WEST "You couldn't bear to step on the tulips.")
      (NORTH "You couldn't bear to step on the tulips.")
      (SOUTH "You couldn't bear to step on the tulips.")
      (CAPACITY 2)
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN GARDEN-WALLS)
      (THINGS <PSEUDO (<> TULIP FLORAL-PSEUDO)
		      (<> TULIPS FLORAL-PSEUDO)
		      (<> TREES FLORAL-PSEUDO)
		      (<> TREE FLORAL-PSEUDO)
		      (<> FLOWER FLORAL-PSEUDO)>)>

<ROOM NORTH-GARDEN
      (IN ROOMS)
      (DESC "Garden, North")
      (LDESC
"You are in the orchid section of the garden. Tender orchid petals of
every color surround a small pond here. The stone walkway leads north,
southeast and southwest.")
      (NORTH TO ENTRANCE-TO-MAZE)
      (SOUTH "You bounce off a dwarf fig tree.")
      (SE TO EAST-GARDEN)
      (SW TO WEST-GARDEN)
      (CAPACITY 2)
      (FLAGS RLANDBIT ONBIT OUTDOORSBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN WATER GARDEN-WALLS)
      (THINGS <PSEUDO (<> TREES FLORAL-PSEUDO)
		      (<> TREE FLORAL-PSEUDO)
		      (<> FLOWER FLORAL-PSEUDO)>)>

<OBJECT ORCHIDS
	(IN NORTH-GARDEN)
	(DESC "orchids")
	(SYNONYM ORCHID)
	(FLAGS NDESCBIT)
	(ACTION FLORAL-PSEUDO)>

<ROUTINE FLORAL-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's the lovely flora you would expect in Aunt Hildegarde's
reknowned garden." CR>)
	       (<VERB? SMELL>
		<TELL "Hmmm. What a lovely scent." CR>)>>

<OBJECT POND
	(IN NORTH-GARDEN)
	(DESC "small pond")
	(SYNONYM POND)
	(ADJECTIVE SMALL)
	(CAPACITY 200)
	(FLAGS OPENBIT CONTBIT NDESCBIT SEARCHBIT)
	(ACTION POND-F)>	

<ROUTINE POND-F ()
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,POND>>
		<TELL "You drop" T ,PRSO " in" T ,POND>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 5>
		       <TELL " with a splash">)>
		<TELL ".">
		<MOVE ,PRSO ,POND>
		<ALL-WET ,PRSO>
		<BLOW-OUT-ALL-IN ,PRSO ", as it hits the water">
		<COND (<AND <PRSO? ,BUCKET>
			    <FIRST? ,PRSO>>
		       <ROB ,BUCKET ,POND>
		       <TELL
" The contents of the bucket sink to the bottom of the shallow pond.">)>
		<COND (<AND <PRSO? ,FLASHLIGHT>
			    <FSET? ,FLASHLIGHT ,ONBIT>>      
		       <FCLEAR ,FLASHLIGHT ,ONBIT>
		       <FSET ,FLASHLIGHT ,WETBIT>
		       <TELL " The flashlight goes out.">)>
		<CRLF>
	       ;<COND (<PRSO? ,BUCKET>
		       <MOVE ,PORTABLE-WATER ,BUCKET>
		       <QUEUE I-DRIP 1>)>
		<RTRUE>)
	       (<VERB? ENTER>
		<TELL
"How soon they forget. Don't you remember the summer Aunt Hildegarde caught
you wading in the pond and paddled your behind?" CR>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<ROUTINE BLOW-OUT-ALL-IN (OBJ "OPTIONAL" (STR <>))
	 <COND (<NOT .STR>
		<SET STR "">)>
	 <REPEAT ()
		 <COND (<NOT .OBJ> <RETURN>)
		       (T
			<COND (<FSET? .OBJ ,FLAMEBIT>
			       <FCLEAR .OBJ ,FLAMEBIT>
			       <FCLEAR .OBJ ,ONBIT>
			       <TELL " The " D .OBJ " goes out" .STR ".">
			       <COND (<EQUAL? .OBJ ,RED-CANDLE>
				      <STOP-RED-BURNING>)
				     (<EQUAL? .OBJ ,WHITE-CANDLE>
				      <STOP-WHITE-BURNING>)
				     (<EQUAL? .OBJ ,BLUE-CANDLE>
				      <STOP-BLUE-BURNING>)
				     (<EQUAL? .OBJ ,GREEN-MATCH ,RED-MATCH>
				      <DEQUEUE I-MATCH-BURN>)>)>
			<COND (<FIRST? .OBJ>
			       <BLOW-OUT-ALL-IN <FIRST? .OBJ> .STR>)>
			<SET OBJ <NEXT? .OBJ>>)>>>

<ROOM NORTHWEST-JUNCTION
      (IN ROOMS)
      (DESC "Northwest Junction")
      (LDESC
"In this corner of the backyard you can make out the enormous hedge,
which is part of the estate's hedge maze. The stone walkway splits in
three directions here: north, along the dark and towering hedge; south,
past the fragrant and inviting garden; and east, where the walkway cuts
a straight and narrow path between the hedge and the garden." CR)
      (NORTH PER TO-&-FROM-CANNON)
      (SOUTH TO SOUTHWEST-JUNCTION)
      (EAST TO ENTRANCE-TO-MAZE)
      (CAPACITY 2)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL HOUSE CHIMNEY GARDEN HEDGE-MAZE-OBJ GARDEN-WALLS)>

<ROOM NORTHEAST-JUNCTION
      (IN ROOMS)
      (DESC "Northeast Junction")
      (LDESC
"In this corner of the backyard you can make out the enormous hedge,
which is part of the estate's hedge maze. The stone walkway splits in
three directions here: north, along the dark and towering hedge; south,
past the fragrant and inviting garden; and west, where the walkway cuts
a straight and narrow path between the hedge and the garden. A slightly
worn path in the grass heads east.")
      (NORTH PER TO-&-FROM-CANNON)
      (SOUTH TO SOUTHEAST-JUNCTION)
      (WEST TO ENTRANCE-TO-MAZE)
      (EAST PER TO-&-FROM-TOP-LANDING)
      (CAPACITY 2)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT EVERYBIT) ;"for the footsteps"
      (GLOBAL HOUSE CHIMNEY GARDEN HEDGE-MAZE-OBJ GARDEN-WALLS)>

<ROUTINE TO-&-FROM-CANNON ("AUX" NEW-ROOM)
         <TELL
"You follow the walkway as it turns ">
	 <COND (<EQUAL? ,HERE ,NORTHWEST-JUNCTION>
		<SET NEW-ROOM ,CANNON-EMPLACEMENT>
		<TELL "east">)
	       (<EQUAL? ,HERE ,NORTHEAST-JUNCTION>
		<SET NEW-ROOM ,CANNON-EMPLACEMENT>
		<TELL "west">)
               (T
                <TELL "south">
                <COND (<PRSO? ,P?WEST>
                       <SET NEW-ROOM ,NORTHWEST-JUNCTION>)
		      (T
		       <SET NEW-ROOM ,NORTHEAST-JUNCTION>)>)>
	 <TELL " around the hedge leading to..." CR CR>
         .NEW-ROOM>

<ROOM CANNON-EMPLACEMENT
      (IN ROOMS)
      (DESC "Cannon Emplacement")
      (EAST PER TO-&-FROM-CANNON)
      (WEST PER TO-&-FROM-CANNON)
      (DOWN PER TO-CLIFF)
      (NORTH PER TO-CLIFF)
      (GLOBAL WATER)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (ACTION CANNON-EMPLACEMENT-F)>

<ROUTINE CANNON-EMPLACEMENT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a cannon emplacement complete with a Civil War-style cannon and
a neatly stacked pyramid of cannon balls. During the day this area
affords a spectacular view of the coastline. Stone walkways lead east
and west, and a steep path leads down.">)>>

<ROUTINE TO-CLIFF ()
         <COND (<FSET? ,SKIS ,WORNBIT>
		<JIGS-UP
"You ski down the steep path, unable to stop at the cliff. You sail off the
cliff into the air, catching a very brief glimpse of Linda Ronstadt's beach
house, then plummet to the rocks below.">)
	       (T
		<TELL
"You attempt to walk down, but end up sliding most of the way to a cliff
below." CR CR>
	        <RETURN ,CLIFF>)>>

<ROOM CLIFF
      (IN ROOMS)
      (DESC "Cliff")
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL HATCH HATCH-HOLE)
      (UP PER TO-CANNON-EMPLACEMENT)
      (SOUTH PER TO-CANNON-EMPLACEMENT)
      (DOWN PER TO-&-FROM-BOMB-SHELTER)
      (ACTION CLIFF-F)
      (THINGS <PSEUDO (<> CLIFF CLIFF-PSEUDO)>)>

<ROUTINE CLIFF-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This cliff affords the same spectacular view as from the cannon
emplacement above. Far below you and stretching east, are the white
sands of a beach">
		<COND (<NOT <G? ,MOVES 535>>
		       <TELL ", illuminated by the moon's glow">)>
		<TELL
". You can hear the faint sound of waves lapping at the shore. Nearby in
the ground is a">
		<COND (<FSET? ,HATCH ,OPENBIT>
		       <TELL
"n open hatch, forming a hole which leads down.">)
		      (T
                       <TELL " closed hatch.">)>)>>

<ROUTINE CLIFF-PSEUDO ()
	 <COND (<VERB? LEAP>
		<JIGS-UP
"You jump off the cliff and fall to your death, just as you would expect
from an Infocom story.">)>>

<ROUTINE TO-CANNON-EMPLACEMENT ()
	 <TELL "You slip and slide in the loose rock, ">
         <COND (<ULTIMATELY-IN? ,LADDER>
		<TELL
"unable to climb up the cliff because of the weight of the ladder." CR>
		<RFALSE>)
	       (T
		<TELL
"but manage to make your way up to the cannon emplacement." CR CR>
	 <RETURN ,CANNON-EMPLACEMENT>)>>

<ROUTINE TO-&-FROM-BOMB-SHELTER ()
         <COND (<NOT <FSET? ,HATCH ,OPENBIT>>
		<TELL ,YOU-CANT "go through the closed hatch." CR>
		<RFALSE>)
	       (<AND <FSET? ,HATCH ,OPENBIT>
		     <FSET? ,SKIS ,WORNBIT>>
		<TELL
"You can't fit through the opening wearing the skis." CR>
		<RFALSE>)
               (<FSET? ,LADDER ,HUNG-BIT>
		<COND (<EQUAL? ,HERE ,BOMB-SHELTER>
		       <TELL "You climb up the ladder to the cliff." CR CR>
		       <MOVE ,LADDER ,CLIFF>
                       <RETURN ,CLIFF>)
		      (T
                       <TELL
                       "You climb down the ladder to the bomb shelter." CR CR>
		       <MOVE ,LADDER ,BOMB-SHELTER>
                       <RETURN ,BOMB-SHELTER>)>)
;" no ladder " (T  
		<COND (<EQUAL? ,HERE ,BOMB-SHELTER>
                       <TELL 
"You'll have to figure that out for yourself." CR>
		       <RFALSE>)
		      (T
                       <TELL
"You drop into the hole, managing to land on your feet." CR CR>
		       <RETURN ,BOMB-SHELTER>)>)>>
<OBJECT LADDER
	(IN CLIFF)
	(DESC "ladder")
	(FDESC "There is an unusual ladder lying on the ground here.")
	(SYNONYM LADDER)
	(ADJECTIVE HEAVY METAL)
	(FLAGS TAKEBIT)
	(SIZE 90)
        (ACTION LADDER-F)>

<ROUTINE LADDER-F ()
         <COND (<AND <EQUAL? ,HERE ,CLIFF>
		     <FSET? ,LADDER ,HUNG-BIT>
		     <NOT <FSET? ,HATCH ,OPENBIT>>>
		<CANT-SEE-ANY ,LADDER>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"This straight ladder is made of heavy-duty steel bars. It resembles
a ladder you might find on a fire escape." CR>)
	      ;(<AND <VERB? PUT-ON TIE HANG-UP> ;"tie = attach, hook"
                     <PRSI? ,HOOKS>>
		<TELL "You hang the ladder from" TR ,HOOKS>
		<MOVE ,LADDER ,HERE>
		<FSET ,LADDER ,NDESCBIT>
		<FSET ,LADDER ,HUNG-BIT>)
	       (<AND <VERB? TAKE UNTIE> ;"unhook detach"
		     <FSET? ,LADDER ,HUNG-BIT>>
		<COND (<EQUAL? ,HERE ,CLIFF>
		       <TELL "It's too heavy to lift out of the hole." CR>)
		      (T
		       <COND (<NOT <ITAKE>>
			      <RTRUE>)
			     (T
			      <FCLEAR ,LADDER ,HUNG-BIT>
			      <TELL "Taken." CR>)>)>)
	       (<AND <VERB? HANG-UP>
		     <EQUAL? ,HERE ,BOMB-SHELTER>
		     <NOT ,PRSI>>
		<PERFORM ,V?HANG-UP ,LADDER ,HOOKS>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB CLIMB-DOWN>
		<COND (<FSET? ,LADDER ,HUNG-BIT>
		       <COND (<EQUAL? ,HERE ,CLIFF>
			      <COND (<VERB? CLIMB-UP>
			      	     <TELL
"The ladder only leads down, through the open hatch." CR>
			      	     <RTRUE>)
			     	    (T
			      	     <DO-WALK ,P?DOWN>)>)
			     (T
			      <COND (<VERB? CLIMB-DOWN>
				     <TELL
"The ladder only leads up, through the open hatch." CR>
				     <RTRUE>)
				    (T
				     <DO-WALK ,P?UP>)>)>)
		      (<ULTIMATELY-IN? ,LADDER>
		       <TELL "You're holding the ladder!" CR>)
		      (T
		       <TELL
"You can't climb a ladder that's lying down." CR>)>)>>

<OBJECT HOOKS
	(IN BOMB-SHELTER)
	(DESC "pair of metal hooks")
	(SYNONYM HOOK HOOKS)
	(ADJECTIVE METAL PAIR HEAVY)
	(FLAGS NDESCBIT)
	(ACTION HOOKS-F)>

<ROUTINE HOOKS-F ()
	 <COND (<VERB? HANG-UP PUT-ON TIE> ;"tie = attach, hook"
		<COND (<PRSO? ,LADDER>
		       <TELL "You hang the ladder from" TR ,HOOKS>
		       <MOVE ,LADDER ,HERE>
		       <FSET ,LADDER ,NDESCBIT>
		       <FSET ,LADDER ,HUNG-BIT>)
		      (T
		       <TELL
"You can't reach the hooks." CR>)>)>>

<OBJECT HATCH-HOLE
        (IN LOCAL-GLOBALS)
	(DESC "hole")
	(SYNONYM HOLE)
	(FLAGS NDESCBIT INVISIBLE) ;"invisible until hatch is opened"
	(ACTION HATCH-HOLE-F)>

<ROUTINE HATCH-HOLE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The hole is about the size of a manhole">
                <COND (<EQUAL? ,HERE ,CLIFF>
		       <TELL ". The " D ,HATCH-HOLE " descends down into ">
		       <COND (<LIT? ,BOMB-SHELTER>
		              <TELL "the bomb shelter">)
		             (T
		              <TELL "darkness">)>
		       <COND (<FSET? ,LADDER ,HUNG-BIT>
		              <TELL
". A " D ,LADDER " in the hole leads down">)>)>
		<TELL "." CR>)
	       (<VERB? ENTER>
		<COND (<EQUAL? ,HERE ,CLIFF>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <TELL "You can't reach it." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,HERE ,CLIFF>
		     <PRSI? ,HATCH-HOLE>>
		<TELL
"You drop" T ,PRSO " in" T ,HATCH-HOLE
" and a second later hear it hit the ground." CR>
		<COND (<AND <PRSO? ,RED-CANDLE ,WHITE-CANDLE ,BLUE-CANDLE>
			    <FSET? ,PRSO ,FLAMEBIT>>
		       <BLOW-OUT-CANDLE ,PRSO>)>
	        <COND (<OR <AND <PRSO? ,FINCH>
			        <NOT <FSET? ,FINCH ,BROKEN-BIT>>>
		           <AND <ULTIMATELY-IN? ,FINCH ,PRSO>
			        <NOT <FSET? ,FINCH ,BROKEN-BIT>>>>
		       <BREAK-FINCH T>)>
		<MOVE ,PRSO ,BOMB-SHELTER>
		<RTRUE>)>>

;"old hole"
;<ROUTINE HOLE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The hole is about the size of a manhole. ">
		<COND (<NOT <FSET? ,HATCH ,OPENBIT>>
		       <TELL
"At the bottom of the hole is a steel plate">) ;"underside"
		      (T
		       <TELL "The " D ,HATCH-HOLE " ">
		       <COND (<LIT? ,BOMB-SHELTER>
			      <TELL "leads down to the bomb shelter">)
			     (T
			      <TELL "descends into darkness">)>
		       <COND (<FSET? ,LADDER ,HUNG-BIT>
			      <TELL
". A " D ,LADDER " in the hole leads down">)>)>
		      <TELL "." CR>)>>                

"--- Cannon ---"

<OBJECT CANNON-BALL
	(IN PILE-OF-BALLS)
        (DESC "cannon ball")
	(SYNONYM BALL)
	(ADJECTIVE CANNON TOP)
	(FLAGS TAKEBIT NDESCBIT)
	(GENERIC GENERIC-BALL-F)
	(SIZE 10) ;"size is related to cannon capacity"
        ;(ACTION CANNON-BALL-F)>

;<ROUTINE CANNON-BALL-F ()
	 <COND ()>>

<OBJECT PILE-OF-BALLS
        (IN CANNON-EMPLACEMENT)
	(DESC "pile of cannon balls")
	(SYNONYM BALL BALLS PILE)
	(ADJECTIVE CANNON PILE STACK)
        (FLAGS NDESCBIT SURFACEBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 10)
	(GENERIC GENERIC-BALL-F)
	(ACTION PILE-OF-BALLS-F)>

<ROUTINE PILE-OF-BALLS-F ()
         <COND (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)
	       (<VERB? EXAMINE TAKE>
		<COND (<OR <IN? ,CANNON-BALL ,PILE-OF-BALLS>
			   <NOT <FIRST? ,PILE-OF-BALLS>>>
		       <TELL
"The pile of cannon balls appears to be strictly ornamental. All of the
balls are welded together">
		       <COND (<IN? ,CANNON-BALL ,PILE-OF-BALLS>
			      <TELL
", except for the ball on the top of the pile">)>
		       <TELL "." CR>)
		      (T
		       <RFALSE>)>)	      
	        (<VERB? LOOK-UNDER>
		<TELL
,YOU-CANT "look under" TR ,PILE-OF-BALLS>)
	      ;(<VERB? PUT-ON>
		<COND (<FIRST? ,PILE-OF-BALLS>
		       <TELL "The ">
		       <DESCRIBE-REST ,PILE-OF-BALLS>
		       <TELL " is already on" TR ,PILE-OF-BALLS>)
		      (T
		       <RFALSE>)>)>>

<ROUTINE GENERIC-BALL-F ()
	 ,CANNON-BALL>

<OBJECT FUSE
	(IN CANNON-EMPLACEMENT)
	(DESC "fuse")
	(SYNONYM FUSE)
	(ADJECTIVE CANNON)
	(FLAGS NDESCBIT BURNBIT)
        (ACTION FUSE-F)>

<ROUTINE FUSE-F ("AUX" OBJ FLAME)
	 <COND (<VERB? BURN LAMP-ON>
		<COND (<SET-FLAME-SOURCE>
		       <RTRUE>)
		      (<NOT <FSET? ,PRSI ,FLAMEBIT>>
		       <COND (<FSET? ,PRSI ,BURNBIT>
			      <TELL
"You'll have to light" T ,PRSI " first." CR>)
			     (ELSE
			      <TELL
"You can't light" T ,PRSO " with" AR ,PRSI>)>)
		      (T  ;"prsi flamebit is set"
		       <REMOVE ,FUSE>
		       <SET OBJ <FIRST? ,CANNON>>
		       <TELL
"You touch the flame to" T ,FUSE " and it sizzles.
A second later" T ,CANNON " fires">
		       <COND (<ZERO? .OBJ>
			      <TELL " with a bang." CR>)
			     (T
			     ;<TELL ",">
			      <COND (<IN? ,CANNON-BALL ,CANNON>
			      	     <FSET ,CANNON ,CANNON-MOVED-BIT>
	                             <REMOVE ,CANNON-BALL>
				     <TELL
", pushing it back a couple of feet. ">)>
			      <COND (<IN? ,FLASHLIGHT,CANNON>
				     <FCLEAR ,FLASHLIGHT ,ONBIT>)>
			      <COND (<IN? ,RED-CANDLE ,CANNON>
				     <FCLEAR ,RED-CANDLE ,FLAMEBIT>
				     <FCLEAR ,RED-CANDLE ,ONBIT>
				     <STOP-RED-BURNING>)>
			      <COND (<IN? ,WHITE-CANDLE ,CANNON>
				     <FCLEAR ,WHITE-CANDLE ,FLAMEBIT>
				     <FCLEAR ,WHITE-CANDLE ,ONBIT>
				     <STOP-WHITE-BURNING>)>
			      <COND (<IN? ,BLUE-CANDLE ,CANNON>
				     <FCLEAR ,BLUE-CANDLE ,FLAMEBIT>
				     <FCLEAR ,BLUE-CANDLE ,ONBIT>
				     <STOP-BLUE-BURNING>)>
			      <COND (<FSET? ,CANNON ,CANNON-MOVED-BIT>
				     <TELL "The " D ,CANNON-BALL>
				     <COND (<FIRST? ,CANNON>
					    <TELL " and pieces of">
					    <CLOSE-ALL-IN ,CANNON>
					    <DESCRIBE-CONTENTS ,CANNON -1>)>)
				    (<FIRST? ,CANNON>
				     <TELL " and pieces of">
		     		     <CLOSE-ALL-IN ,CANNON>
				     <DESCRIBE-CONTENTS ,CANNON -1>)>
			      <TELL " fl">
			      <COND (<FIRST? ,CANNON>
				     <TELL "y">)
				    (T
				     <TELL "ies">)>
			      <TELL
" from" T ,CANNON "'s barrel out to sea." CR>
			      <MOVE-ALL ,CANNON>)>)>)
	       (<VERB? TAKE>
		<TELL "It's stuck." CR>)>>

<ROUTINE CLOSE-ALL-IN (CONT "AUX" OBJ)
	 <SET OBJ <FIRST? .CONT>>
	 <REPEAT ()
	          <FCLEAR .OBJ ,OPENBIT>
		  <SET OBJ <NEXT? .OBJ>>
		  <COND (<NOT .OBJ>
			 <RETURN>)>>>

<ROUTINE SET-FLAME-SOURCE ("AUX" FLAME)
	 <COND (,PRSI
		<RFALSE>)
	       (<SET FLAME <FIND-IN ,PLAYER ,FLAMEBIT>>
		<SETG PRSI .FLAME>
		<TELL "[with" T .FLAME "]" CR>
		<RFALSE>)
	       (<EQUAL? ,HERE ,BEACH>
		<SETG PRSI ,FIRE>
		<TELL "[with the fire]" CR>
		<RFALSE>)
	       (T
		<TELL "You have nothing to light" T ,PRSO " with." CR>)>>

<OBJECT CANNON
	(IN CANNON-EMPLACEMENT)
	(DESC "cannon")
	(SYNONYM CANNON WHEEL)
	;(ADJECTIVE MINATURE)
	(FLAGS CONTBIT OPENBIT TRYTAKEBIT NDESCBIT SEARCHBIT)
	(CAPACITY 30) 
	(ACTION CANNON-F)>

<ROUTINE CANNON-F ()
	 <COND (<AND <VERB? TAKE PUSH PUSH-TO PULL MOVE TURN RAISE LOWER
			    EMPTY>
		     <PRSO? ,CANNON>>
		<TELL "The cannon is too heavy for you to move." CR>)
	       (<VERB? SHOOT>
		<TELL "Try lighting the fuse!" CR>)
	       ;(<AND <VERB? POINT>
		     <EQUAL? ,PRSO ,CANNON>>
		<TELL "It's already aimed." CR>)
	       (<VERB? EXAMINE>
                <TELL
"It's a replica Civil War " D ,CANNON " pointing out to sea. ">
		<COND (<IN? ,FUSE ,CANNON-EMPLACEMENT>
		       <TELL
"There is" A ,FUSE " sticking up from the cannon. ">)>
		<COND (<NOT <FSET? ,CANNON ,CANNON-MOVED-BIT>>
		       <TELL
"One of" T ,CANNON "'s wheels is on top of a small compartment.">)
		      (T
		       <TELL
"Right next to" T ,CANNON " is" A ,COMPARTMENT ".">)>
		<TELL
" The " D ,CANNON " was used in Uncle Buddy's production of \"Dracula Meets
the Confederacy.\" Uncle Buddy said he always kept it loaded in case those
big Hollywood studio types came around." CR>)
	       (<VERB? BURN LAMP-ON>
		<PERFORM ,V?BURN ,FUSE>
		<RTRUE>)
	      ;(<VERB? LOOK-INSIDE>
		<TELL "You see ">
;"You see what might be a charge, after all Uncle Buddy did say he always kept it loaded in case those Hollywood types came round."
		<COND (<FIRST? ,CANNON>
		       <COND (<AND <IN? ,FUSE ,CANNON>
				   <NEXT? ,FUSE>>
			      <DESCRIBE-CONTENTS ,CANNON -1>)
			     (<NOT <IN? ,FUSE ,CANNON>>
			      <DESCRIBE-CONTENTS ,CANNON -1>)
			     (T
			      <TELL
"a wad tightly packed, no doubt holding a charge in place">)>) 
		       (T
			<TELL "an empty " D ,CANNON " barrel">)>
		<TELL "." CR>)
	       (<AND <VERB? PUT>
		     <PRSO? ,BUCKET>>
		<TELL "It won't fit in the cannon." CR>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<OBJECT COMPARTMENT
	(IN CANNON-EMPLACEMENT)
	(DESC "small compartment")
	(SYNONYM COMPAR)
        (ADJECTIVE SMALL)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)
	(CAPACITY 11)
	(ACTION COMPARTMENT-F)>

<ROUTINE COMPARTMENT-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,CANNON ,CANNON-MOVED-BIT>>>
		<PERFORM ,V?EXAMINE ,COMPARTMENT>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,CANNON ,CANNON-MOVED-BIT>>>
		<TELL
"One of" T ,CANNON "'s wheels is on" TR ,COMPARTMENT>)>>

<ROUTINE MOVE-OBJ-DOWN ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "You ">
                <PRINTB ,P-PRSA-WORD>
		<TELL " the " D ,PRSO " and it tumbles down the stairs.">
	 	<COND (<EQUAL? ,UPSTAIRS-HALL-MIDDLE ,HERE>
		       <MOVE ,PRSO ,FOYER>)
	       	      (<EQUAL? ,FRONT-PORCH ,HERE>
		       <MOVE ,PRSO ,SOUTH-JUNCTION>)
	       	      (T
                       <MOVE ,PRSO ,CELLAR>)>)>>

<ROOM FRONT-PORCH
      (IN ROOMS)
      (DESC "Front Porch")
      (LDESC
"You're standing on the front porch of the house. Next to the front door
is a regulation mailbox endorsed by Buck Palace. Beneath the mailbox is
a doorbell once rung by Sonny Tufts. To the south is a walkway.")
      (SOUTH TO SOUTH-JUNCTION)
      (IN TO FOYER IF OAK-DOOR IS OPEN)
      (NORTH TO FOYER IF OAK-DOOR IS OPEN)
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT)
      (GLOBAL OAK-DOOR HOUSE CHIMNEY)>

<OBJECT DOOR-BELL
	(IN FRONT-PORCH)
	(DESC "doorbell")
	(SYNONYM BELL CHIME BUZZER DOORBELL)
	(ADJECTIVE DOOR)
        (FLAGS NDESCBIT)
        (ACTION DOOR-BELL-F)>

<ROUTINE DOOR-BELL-F ()
         <COND (<VERB? PUSH>
		<TELL
"The " D ,DOOR-BELL " plays a tune from one of Uncle Buddy's films. You
recognize the " <PICK-ONE ,DOOR-BELL-TUNES> ".\"" CR>)>>

<GLOBAL DOOR-BELL-TUNES
	<LTABLE 0
	"love theme from \"Chainsaw Chop Suey"
        "title song from \"10 1/2 Little Indians"
        "song from \"It Came From the Neighbor's House"
        "title track from \"Buddy Burbank's Three Minute Hollywood Workout">>

<OBJECT MAILBOX
	(IN FRONT-PORCH)
	(DESC "Buck Palace-endorsed, regulation mailbox")
	(SYNONYM BOX MAILBOX)
	(ADJECTIVE MAIL)
        (FLAGS NDESCBIT SEARCHBIT CONTBIT)
	(CAPACITY 11)>

<OBJECT OAK-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "oak door")
	(SYNONYM DOOR)
	(ADJECTIVE OAK FRONT)
        (FLAGS DOORBIT NDESCBIT LOCKEDBIT)>


"--- Beach Stairs ---"

<OBJECT SKIS
	(IN CLOSET)
	(DESC "pair of skis")
	(SYNONYM SKIS)
	(ADJECTIVE PAIR DOWNHILL)
	(FLAGS TAKEBIT WEARBIT)
	(SIZE 25)
	(ACTION SKIS-F)>

<ROUTINE SKIS-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"They're a large pair of downhill snow skis." CR>)
	       (<VERB? WEAR>
		<COND (<OR <EQUAL? ,HERE ,UPPER-BEACH-STAIRS>
			  <EQUAL? ,HERE ,LOWER-BEACH-STAIRS>>
		       	<TELL
"You can't put them on while standing on the stairs." CR>)
		      (<EQUAL? ,HERE ,ROOF-1 ,ROOF-2>
		       <JIGS-UP
"You slip the skis on, then slip off the roof.">)
		      (<EQUAL? ,HERE ,INLET ,ON-POOL-1 ,IN-POOL-1 ,UNDERPASS-1
			             ,UNDERPASS-2 ,IN-POOL-2 ,ON-POOL-2>
		       <TELL ,DOG-PADDLE CR>)
		      (<EQUAL? ,HERE ,CLOSET ,SHAFT-BOTTOM ,CLOSET-TOP
			                     ,CHIMNEY-1 ,CHIMNEY-2 ,CHIMNEY-3>
		       <TELL "The ">
		       <COND (<EQUAL? ,HERE ,CLOSET>
			      <TELL "closet">)
			     (<EQUAL? ,HERE ,CLOSET-TOP ,SHAFT-BOTTOM>
			      <TELL "shaft">)
			     (T
			      <TELL "chimney">)>
		       <TELL
" is too small for you to put on the skis." CR>)
		      (<EQUAL? ,HERE ,CRAWL-SPACE-NORTH ,CRAWL-SPACE-SOUTH
			             ,FIRST-SECRET-ROOM>
		       <TELL
,YOU-CANT "quite slip into them in this cramped space." CR>)
		      (<EQUAL? <LOC ,PLAYER> ,RIGHT-END ,LEFT-END>
		       <TELL
,YOU-CANT "seem to get them on while standing on" TR ,PLANK>)>)>>

<ROOM TOP-LANDING
      (IN ROOMS)
      (DESC "Top Landing")
      (LDESC
"This is a rickety landing at the top of a long flight of old, wooden
stairs leading down to the beach far below. You and Cousin Herman would
race down these stairs in the summertime to see who would get to the
water first. Usually Cousin Herman would trip you and win. A path in the
grass leads west.")
      (FLAGS RLANDBIT OUTDOORSBIT ONBIT EVERYBIT) ;"for skiing down points"
      (DOWN PER TO-BEACH)
      (NORTH PER TO-BEACH)
      (WEST PER TO-&-FROM-TOP-LANDING)
      (GLOBAL STAIRS)
      (ACTION TOP-LANDING-F)>

<ROUTINE TOP-LANDING-F (ARG)
	 <COND (<AND <EQUAL? .ARG ,M-BEG>
		     <VERB? WALK>
		     <PRSO? ,P?NORTH>>
		<SETG PRSO ,P?DOWN>
		<RFALSE>)>>

<ROOM UPPER-BEACH-STAIRS
      (IN ROOMS)
      (DESC "Middle of Beach Stairs")
      (LDESC
"You're about halfway down the steep staircase, which creaks under your
weight. There are several steps missing here. It's quite a gap: probably
more than you could jump across. On the other side of the gap, the stairs
continue down. Climbing up the stairs returns to the landing." CR)
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (DOWN PER TO-BEACH)
      (NORTH PER TO-BEACH)
      (UP TO TOP-LANDING)
      (SOUTH TO TOP-LANDING)      
      (GLOBAL STAIRS GAP)>

<ROUTINE TO-BEACH ()
	 <COND (<FSET? ,SKIS ,WORNBIT>
		<SKI-DOWN-STAIRS>
		,BEACH)
	       (T
		<COND (<EQUAL? ,HERE ,UPPER-BEACH-STAIRS>
                       <JIGS-UP
"You step into the gap and plunge down onto the sharp rocks below.">)
		      (T
		       <TELL
"You walk down the old, creaking stairs. You stop as you come to a wide gap
of missing steps." CR CR>
                      ;"randomly a step may give way or a rail breaks off etc."
		 ,UPPER-BEACH-STAIRS)>)>>

<OBJECT GAP
	(IN LOCAL-GLOBALS)
	(DESC "gap")
	(SYNONYM GAP)
	(ADJECTIVE WIDE)
	;(FLAGS CONTBIT OPENBIT)
	(ACTION GAP-F)>

<ROUTINE GAP-F ()
	 <COND (<VERB? LEAP CROSS>
		<TELL "You leap across the gap ">
		<COND (<PROB 50>
		       <TELL
"and just miss the first step on the other side. For a split second you
admire a view of the coastline that few if any have seen before. You then">)
		      (T
		       <TELL
"and land on the first step. Unfortunately your weight was a bit
too much for the step. It squeals with pain then breaks in half, and you">)>
		      <JIGS-UP
" plunge to the rocks below in a spectacular fall worthy of Hollywood's
best stuntmen. Your body smashes onto the rocks. Too bad you didn't have a
stunt double.">)
	       (<VERB? LOOK-INSIDE>
		<TELL "Far below are sharp rocks." CR>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? GAP>>
		<REMOVE ,PRSO>
		<TELL "The " D ,PRSO " drops to the rocks below." CR>)
	       (<VERB? ENTER>
		<FROM-LOWER-STAIRS>)>>

<ROUTINE SKI-DOWN-STAIRS ("AUX" (CANDLE 0) (MATCH 0))
	 <COND (<EQUAL? ,HERE ,TOP-LANDING>
		<COND (<FSET? ,TOP-LANDING ,EVERYBIT>
		       <FCLEAR ,TOP-LANDING ,EVERYBIT> ;"don't give ski points"
		       <SETG SCORE <+ ,SCORE 10>>)>    ;"more than once" 
                <TELL
"You shuffle over the edge of the landing, and quickly gain momentum as you
sail down the stairs.">
		<COND (<FIND-IN ,PLAYER ,FLAMEBIT>
		       <COND (<AND <IN? ,RED-CANDLE ,PLAYER>
				   <FSET? ,RED-CANDLE ,FLAMEBIT>>
			      <INC CANDLE>
			      <BLOW-OUT-CANDLE ,RED-CANDLE T>)>
		       <COND (<AND <IN? ,WHITE-CANDLE ,PLAYER>
				   <FSET? ,WHITE-CANDLE ,FLAMEBIT>>
			      <INC CANDLE>
			      <BLOW-OUT-CANDLE ,WHITE-CANDLE T>)>
		       <COND (<AND <IN? ,BLUE-CANDLE ,PLAYER>
				   <FSET? ,BLUE-CANDLE ,FLAMEBIT>>	      
			      <INC CANDLE>
			      <BLOW-OUT-CANDLE ,BLUE-CANDLE T>)>
		      <COND (<EQUAL? .CANDLE 1 2 3>
			      <TELL " The candle">
			      <COND (<EQUAL? .CANDLE 2 3>
			      	      <TELL "s">)>
			      <TELL " in your hand blow">
			      <COND (<EQUAL? .CANDLE 1>
			             <TELL "s">)>
			      <TELL " out.">)>
		       <COND (<AND <IN? ,RED-MATCH ,PLAYER>
				   <FSET? ,RED-MATCH ,FLAMEBIT>>
			      <INC MATCH>
			      <FCLEAR ,RED-MATCH ,ONBIT>
			      <FCLEAR ,RED-MATCH ,FLAMEBIT>
			      <REMOVE ,RED-MATCH>
			      <DEQUEUE I-MATCH-BURN>)>
		       <COND (<AND <IN? ,GREEN-MATCH ,PLAYER>
				          <FSET? ,GREEN-MATCH ,FLAMEBIT>>
			      <INC MATCH>
			      <FCLEAR ,GREEN-MATCH ,ONBIT>
			      <FCLEAR ,GREEN-MATCH ,FLAMEBIT>
			      <REMOVE ,GREEN-MATCH>
			      <DEQUEUE I-MATCH-BURN>)>
		       <COND (<EQUAL? .MATCH 1 2>
			      <TELL " The match">
			      <COND (<EQUAL? .MATCH 2>
			      	      <TELL "s">)>
			      <TELL " in your hand blow">
			      <COND (<EQUAL? .MATCH 1>
			             <TELL "s">)>
			      <TELL " out and you drop ">
			      <COND (<EQUAL? .MATCH 1>
				     <TELL "it.">)
				    (T
				     <TELL "them.">)>)>)>
		       <TELL
" Ahead of you is the gap in the stairs. Racing into the gap, your skis
bow slightly, but your forward momentum pulls you across the
gap. You hit the landing at the bottom of the stairs but don't stop. You
continue down a short flight of stairs then sail onto the sandy beach. You
quickly stop with the drag of the sand and a feeble attempt to snow
plow." CR CR>)>>

<ROOM LOWER-BEACH-STAIRS
      (IN ROOMS)
      (DESC "Middle of Beach Stairs")
      (LDESC
"You're about halfway up the steep stairs. There are several steps of
the stairs missing here. It's quite a gap: probably more than you could
jump across. On the other side of the gap stairs continue up. Climbing down
the stairs returns to the beach." CR)
      (FLAGS RLANDBIT CAVEBIT ONBIT)
      (DOWN TO BOTTOM-LANDING)
      (UP PER FROM-LOWER-STAIRS)
      (GLOBAL STAIRS GAP)>

<ROUTINE FROM-LOWER-STAIRS ()
	 <JIGS-UP
"You step into the gap and plunge to the rocks below in a spectacular
fall worthy of Hollywood's best stuntmen. Your body smashes onto the
rocks. Too bad you didn't have a stunt double.">
	 <RFALSE>> 

<ROOM BOTTOM-LANDING
      (IN ROOMS)
      (DESC "Bottom Landing")
      (LDESC
"This is the bottom landing. A rickety wooden walkway leads west. To the
north is a sandy beach, and steep stairs lead up a rocky cliff.")
      (NORTH TO BEACH)
      (UP TO LOWER-BEACH-STAIRS)
      (WEST PER WALKWAY-TO-BOAT-DOCK)   
      (EAST
"There's nothing interesting down on that part of the beach. Just a few
nude beach parties." CR)
      (FLAGS RLANDBIT CAVEBIT ONBIT)>

<ROUTINE WALKWAY-TO-BOAT-DOCK ()
         <TELL "You follow the wooden planking as it turns ">
         <COND (<EQUAL? ,HERE ,BOTTOM-LANDING>
		<TELL "left and enters a cave arriving at..." CR>
		<CRLF>
                ,BOAT-DOCK)
               (T
		<TELL "right and exits the cave arriving at..." CR>
		<CRLF>
                ,BOTTOM-LANDING)>>

<ROOM BEACH
      (IN ROOMS)
      (DESC "Beach")
      (LDESC
"This is the end of a beach which stretches to the east. The fine white
sand underfoot reflects the light. A slight breeze blows off the ocean to
the north. A wooden landing is south of here, and an inlet lies west.")
      (NORTH 
"Just as you start to enter the water you notice a buoy just offshore.
A sign on it reads: Hawaii - 2,000 miles. You turn back.")
      (SOUTH TO BOTTOM-LANDING)
      (WEST "If you want to swim, say so.")
      (EAST "You stroll down the beach, declining several invitations
to nude hot tub parties, then return to the end of the beach.")
      (FLAGS CAVEBIT RLANDBIT ONBIT)
      (CAPACITY 1)                                    ;"means you can dig here"
      (GLOBAL WATER SAND)>

<OBJECT FIRE
	(IN BEACH)
	(DESC "small, smoldering fire")
	(SYNONYM FIRE PIT)
	(ADJECTIVE SMOLDERING)
	(FLAGS FLAMEBIT ;ONBIT ;CONTBIT SEARCHBIT OPENBIT)
	(ACTION FIRE-F)>

<ROUTINE FIRE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's" A ,FIRE " in a shallow pit in the sand, probably left here by
Morgan Fairchild and a friend earlier in the evening." CR>)
	       (<VERB? TAKE MOVE RUB LAMP-OFF>
		<TELL
"You'd burn your hands, and besides, it might upset Morgan." CR>)
	       (<VERB? POUR>
		<REMOVE ,FIRE>
		<TELL
"With the skill of a seasoned firefighter, you extinguish the fire." CR>)
	       (<VERB? PUT PUT-ON>
		<PERFORM ,V?BURN ,PRSO ,FIRE>
		<RTRUE>)
	       (<VERB? ENTER>
		<TELL ,PYRO>)
	       (<VERB? OPEN CLOSE>
		<CANT-OPEN-CLOSE>)>>

<OBJECT SAND
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT NARTICLEBIT)
	(DESC "sand")
	(SYNONYM SAND)
	(ACTION SAND-F)>

<ROUTINE SAND-F ()
	 <COND (<VERB? TAKE>
		<TELL "It slips through your hands." CR>)>>

<ROOM INLET
      (IN ROOMS)
      (DESC "Inlet")
      (LDESC
"You are swimming in a shallow inlet, whose waters are much calmer than
in the open ocean to the north. A sandy beach lies to the east and the
mouth of a dark cave gapes open to the south.")
      (SOUTH TO ON-POOL-1)
      (NORTH
"Just as you start to swim out to sea you notice a buoy just offshore.
A sign on it reads: Hawaii - 2,000 miles. You turn back.")
      (EAST TO BEACH)
      (OUT TO BEACH)
      (DOWN "You start to go down, but feeling a strong undertow, you decide
against it.") 
      (FLAGS CAVEBIT RLANDBIT ONBIT)
      (GLOBAL WATER)>
