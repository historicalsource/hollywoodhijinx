"VERBS for ANTHILL (C)1986 Infocom Inc. All Rights Reserved."

;"subtitle describers: Mondo-tweked by Lebs for SEM from Leather"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (VERB-IS-LOOK <>)
			"AUX" (FIRST-VISIT <>))
	 <COND (<AND <NOT ,LIT>
		     <NOT <EQUAL? ,HERE ,ON-POOL-2>>>
		<NOW-BLACK>
		<CRLF>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET FIRST-VISIT T>)>
	 <TELL D ,HERE>
         <COND (<FSET? <LOC ,PLAYER> ,VEHBIT>
		<TELL ", on" T <LOC ,PLAYER>>)>
	 <CRLF>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
	       ;<TELL " 1 "> ;"when you enter room or do a look"
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<CRLF>)>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-OBJDESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE DESCRIBE-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,WINNER>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL CR ;" 2 " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<TELL ;" 3 " .STR> ;"don't forget to change this"
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <DESCRIBE-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<DESCRIBE-CONTENTS .AV <> 0>)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<DESCRIBE-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE DESCRIBE-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
			    "AUX" (F <>) N (1ST? T) (IT? <>)
			    (START? <>) (TWO? <>) (PARA? <>))
  <COND (<EQUAL? .LEVEL 2> ;"what is level 2?"
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <AND <FSET? .OBJ ,CONTBIT>
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <FSET? .OBJ ,SEARCHBIT>
		  .N>>
	 <REPEAT ()
	  <COND (<OR <NOT .N>
		     <AND <DESCRIBABLE? .N>
			  <OR <BTST .ALL? ,D-ALL?>
			      <SIMPLE-DESC? .N>>>>
		 <COND
		  (.F
		   <COND
		    (.1ST?
		     <SET 1ST? <>>
		     <COND (<EQUAL? .LEVEL <> T>
			    <COND (<NOT .START?>
				   <COND (<NOT .PARA?>
					  <COND (<NOT <EQUAL? .OBJ
							      ,PLAYER>>
						;<TELL " 4 ">
						 <CRLF>
;"4--You can see a foo here or Sitting on the foo is a... ")>
					  <SET PARA? T>)
					 (<EQUAL? .LEVEL T>
					  <TELL " ">)>
				   <COND (<EQUAL? .OBJ ,HERE>
					  <TELL ,YOU-SEE>)
					 (<EQUAL? .OBJ ,PLAYER>
					  <TELL "You have">)
					 (<FSET? .OBJ ,SURFACEBIT>
					  <TELL "Sitting on" T .OBJ " is">)
					 (T
					  <TELL "It looks as if" T .OBJ>
					  <COND (<FSET? .OBJ ,ACTORBIT>
						 <TELL " has">)
						(T
						 <TELL " contains">)>)>)>)
			   (<NOT <EQUAL? .LEVEL -1>>
			    <TELL .LEVEL>)>)
		    (T
		     <COND (.N
			    <TELL ",">)
			   (T
			    <TELL " and">)>)>
		   <TELL A .F>
		   <COND (<FSET? .F ,WORNBIT>
			  <COND ;(<EQUAL? .F ,LIP-BALM>
				 <TELL " (smeared all over your lips)">)
				;(<EQUAL? .F ,COTTON-BALLS>
				 <TELL " (stuffed in " 'EARS ")">)
				;(<EQUAL? .F ,CLOTHES-PIN>
				 <TELL " (pinned to " 'NOSE ")">)
				(T
				 <TELL " (being worn)">)>)
			 (<FSET? .F ,ONBIT>
			  <TELL " (providing light)">)
			;(<EQUAL? .F ,COMIC-BOOK>
			  <TELL " (stuck in your back pocket)">)>
		   <COND (<AND <NOT .IT?> <NOT .TWO?>>
			  <SET IT? .F>)
			 (T
			  <SET TWO? T>
			  <SET IT? <>>)>)>
		 <SET F .N>)>
	  
	  <COND (.N
		 <SET N <NEXT? .N>>)>
	  <COND (<AND <NOT .F>
		      <NOT .N>>
		 <COND (<AND .IT?
			     <NOT .TWO?>>
			<THIS-IS-IT .IT?>)>
		 <COND (<AND .1ST? .START?>
			;<SET 1ST? <>>
			<TELL " nothing">
			<RFALSE>)>
		 <COND (<AND <NOT .1ST?>
			     <EQUAL? .LEVEL <> T>>
			<COND (<EQUAL? .OBJ ,HERE>
			       <TELL " here">)>
			<TELL ".">)>
		 <RETURN>)>>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (<AND <FSET? .F ,CONTBIT>
			     <DESCRIBABLE? .F T>
			     <OR <BTST .ALL? ,D-ALL?>
				 <SIMPLE-DESC? .F>>>
			<COND (<DESCRIBE-CONTENTS .F T
						  <COND (.PARA?
							 <+ ,D-ALL? ,D-PARA?>)
							(T
							 ,D-ALL?)>>
			       <SET 1ST? <>>
			       <SET PARA? T>)>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,WINNER>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)	       
	      ;(<AND <EQUAL? .OBJ ,RAFT ,BARGE>
		     <EQUAL? ,HERE ,CANAL>
		     <NOT <ULTIMATELY-IN? .OBJ>>
		     <NOT <IN? .OBJ ,BARGE>>
	             <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

;<ROUTINE DESCRIBE-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <TELL "Other than yourself, you can see">
	 <COND (<NOT <DESCRIBE-NOTHING>>
	        <TELL " on" TR ,PRSO>)>
	 <RTRUE>>

<ROUTINE DESCRIBE-NOTHING ()
	 <COND (<DESCRIBE-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PLAYER ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

<ROUTINE V-ALARM ()
	 <COND (<EQUAL? ,PRSO ,ME ,ROOMS>
		<TELL "But you're ">)
	       (<FSET? ,PRSO ,ACTORBIT>
		<BUT-THE ,PRSO>
	        <TELL "is ">)
	       (T
		<WHAT-A-CONCEPT>
		<RTRUE>)>
	 <TELL "already wide awake!" CR>>

<ROUTINE ALREADY-OPEN ()
	 <ITS-ALREADY "open">>

<ROUTINE ALREADY-CLOSED ()
	 <ITS-ALREADY "closed">>

; <ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <PCLEAR>
	 <RFATAL>>

; <ROUTINE ANYMORE ()
	 <YOU-CANT-SEE>
	 <TELL "that anymore." CR>>

; <ROUTINE V-ASK-ABOUT ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	     ; (<FSET? ,PRSO ,ACTORBIT>
	        <TELL
"After a moment's thought," T ,PRSO " denies any knowledge of" TR ,PRSI>
	        <COND (<EQUAL? ,PRSO ,PRSI>
		       <TELL " (Rather disingenuous, eh?)">)>
	        <CRLF>)
	       (T
		<V-TELL>
		<RTRUE>)>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL ,PRSO>
		<SETG WINNER ,PLAYER>
		<RTRUE>)
	       (T
	 	<V-ASK-FOR>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<EQUAL? ,PRSO ,ME ,ROOMS>
		<PERFORM ,V?TELL ,ME>)
	       (T
		<NOT-LIKELY ,PRSO "would respond">)>
	 <PCLEAR>
	 <RFATAL>>

; <ROUTINE V-BACK ()
	 <V-WALK-AROUND>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BLOW-INTO ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)
	       (T
		<HACK-HACK "Blowing">)>>

; <ROUTINE BLT (WHO WHERE "AUX" N X (CNT 0))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .CNT>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <SET CNT <+ .CNT 1>>
		 <SET X .N>>>

; <ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,PLAYER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You're already in ">
		      ;<ARTICLE ,PRSO T>
		       <TELL D .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL ,YOU-CANT "get into ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "!" CR>)>
	 <RFATAL>>

; <ROUTINE V-BOARD ("AUX" AV)
	 #DECL ((AV) OBJECT)
	 <TELL "You are now in" TR ,PRSO>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE PRE-BOARD ()
	 <COND (<PRSO? <LOC ,PLAYER>>
		<TELL "Look around you." CR>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL "You're holding it!" CR>)>>

<ROUTINE V-BOARD ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<MOVE ,PLAYER ,PRSO>                                  
		<TELL "You are now on" T ,PRSO "." CR>
		;<APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
		;<RTRUE>)
	       (T
	        <TELL "You can't get into" T ,PRSO "!" CR>)>>

; <ROUTINE V-BOW ()
	 <HACK-HACK "Paying respect to">>

<GLOBAL YUKS
	<LTABLE 0 
	;"Get real."
	 "You can't be serious."
	 "Don't be silly.">>

<ROUTINE V-BURN ()
	 <COND (<FSET? ,PRSI ,FLAMEBIT>
		<COND (<FSET? ,PRSO ,BURNBIT>
		       <REMOVE ,PRSO>
		       <TELL
"The " D ,PRSO " catches fire and is reduced to ashes." CR>)
		      (T
		       <TELL ,PYRO>)>)
	       (T
		<TELL "With" A ,PRSI "? " <PICK-ONE ,YUKS> CR>)>>

<GLOBAL PYRO "This isn't a scene from Uncle Buddy's movie \"Pyromaniac.\"~">

<ROUTINE V-BUY ()
	 <COND (<NOT <VISIBLE? ,PRSO>>
		<CANT-SEE-ANY ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSO ,TAKEBIT>>
		     <NOT <FSET? ,PRSO ,TRYTAKEBIT>>>
		<TELL ,YOU-CANT "buy that!" CR>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL "You already have one." CR>)
	       (,PRSI
		<NOT-LIKELY ,PRSI "would buy that">)
	       (T
		<TELL "You don't have any money." CR>)>>

<ROUTINE CANT-CLOSE-THAT ()
	 <TELL ,YOU-CANT "close that!" CR>>

; <ROUTINE CANT-ENTER (LOC "OPTIONAL" (LEAVE <>))
	 <TELL ,YOU-CANT>
	 <COND (.LEAVE
		<TELL "leave">)
	       (T
		<TELL "enter">)>
	 <TELL T .LOC " from here." CR>>

<ROUTINE CANT-GO ()
	 <TELL ,YOU-CANT "go that way." CR>>

<ROUTINE CANT-LOCK ("OPTIONAL" (UN? <>))
	 <TELL ,YOU-CANT> ;<TELL ,YOU-CANT " ">
	 <COND (.UN?
		<TELL "un">)>
	 <TELL "lock" T ,PRSO "!" CR>>

<ROUTINE V-CHASTISE ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<PRSO? ,INTDIR>
		<TELL
"You'll have to go in that direction to see what's there." CR>)
	       (T
	 	<TELL
"Use prepositions to indicate precisely what you want to do. For example, LOOK AT the object, LOOK INSIDE it, LOOK UNDER it, etc." CR>)>>

<ROUTINE V-CLEAN ()
	 <NOT-A "janitor">>

; <ROUTINE V-CLEAN ()
	 <COND (<EQUAL? ,PRSO ,DUST ,ART>
		<TELL "You'd be here all day!" CR>)
	       (<AND ,PRSI
		     <NOT <EQUAL? ,PRSI ,BROOM ,BLANKET>>>
		<HARD-TIME-WITH ,PRSI>)
	       (T
		<NOT-A "janitor">)>>

"climb"

<ROUTINE V-CLIMB ()
	 <PERFORM ,V?CLIMB-UP ,PRSO>
	 <RTRUE>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<WHAT-A-CONCEPT>)>>

; <ROUTINE V-CLIMB-FOO ()
	 <COND (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ROOMS>>
		<DO-WALK ,P?UP>)
	       (T
		<WHAT-A-CONCEPT>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (T
	        <TELL ,YOU-CANT "climb onto that." CR>)>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<V-WALK-AROUND>)
	       (T
		<TELL ,YOU-CANT "climb over that." CR>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<WHAT-A-CONCEPT>)>>

<ROUTINE V-CLOSE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<NOT-A "surgeon">)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<CANT-CLOSE-THAT>)
	       (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<PERFORM ,V?OPEN ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <NOW-CLOSED-OR-OPEN ,PRSO>
		       <SAY-IF-NOT-LIT>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <SAY-THE ,PRSO>
		       <TELL " " <PICK-ONE ,DOOR-NOISES> " as it closes." CR>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (T
		<CANT-CLOSE-THAT>)>>

; "Count # objects being carried by THING"

;<ROUTINE CCOUNT (THING "AUX" OBJ (CNT 0))
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (.OBJ
			<COND (<NOT <FSET? .OBJ ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<SET OBJ <NEXT? .OBJ>>)
		       (T
			<RETURN>)>>
	 <RETURN .CNT>>

<ROUTINE V-COMPARE ()
	 <TELL "You compare the two items and find nothing interesting." CR>>

<ROUTINE V-COUNT ()
	 <WASTE-OF-TIME>>

<ROUTINE V-COVER ()
	 <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-CROSS ()
	 <TELL ,YOU-CANT "cross that!" CR>>

; <ROUTINE V-CURSE ()
	 <TELL "Such language!" CR>>

<ROUTINE V-CUT ()
	 <NOT-LIKELY ,PRSI "could cut anything">>

<GLOBAL DEBUG <>>

<ROUTINE V-$DEBUG ()
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "Debug off." CR>)
	       (T
		<SETG DEBUG T>
		<TELL "Debug on." CR>)>>

; <ROUTINE V-DEFLATE ()
	 <WHAT-A-CONCEPT>>


;<GLOBAL FIRST-WARNING? T>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You're in good health">
	 <COND (<PROB 50>
		<TELL "... at the moment">)>
	 <TELL "." CR>>

<ROUTINE V-DIG-WITH ()
	 <PERFORM ,V?DIG ,GROUND ,PRSO>
	 <RTRUE>>

<ROUTINE V-DIG ()
	 <COND (<NOT ,PRSI>
		<COND (<IN? ,SHOVEL ,PLAYER>
		       <SETG PRSI ,SHOVEL>
		       <TELL "[with the shovel]" CR>)
		      (T 
                       <SETG PRSI ,HANDS>
		       <TELL "[with your hands]" CR>)>)>
	 <COND (<PRSO? ,GROUND ,SAND>
		<COND (<NOT <PRSI? ,SHOVEL>>
		       <TELL
"I suppose you also excavate tunnels with a teaspoon." CR>)
		      (<OR <PRSO? ,SAND>
			   <EQUAL? ,HERE ,BEACH>>
		       <TELL "You find nothing, so you fill in the hole." CR>)
		      (<EQUAL? <GETP ,HERE ,P?CAPACITY> 2> ;"walkway rooms"
		       <TELL
"You attempt to dig in the stone path, but it proves too tough for
your efforts." CR>)
		      (<EQUAL? <GETP ,HERE ,P?CAPACITY> 0>
		       <TELL "The ground is too hard here." CR>)
		      (<OR <EQUAL? <GETP ,HERE ,P?CAPACITY> 10>
			    <EQUAL? <GETP ,HERE ,P?CAPACITY> 20>>
		       <TELL "You can't dig a hole here!" CR>)
		      (T
		       <COND (<EQUAL? ,HERE ,HEART-OF-MAZE>
			      <COND (<IN? ,HEART-OF-MAZE-HOLE ,HEART-OF-MAZE>
				     <TELL "You already dug a hole here." CR>)
				    (T
			      	     <TELL
"You dig a hole and uncover" AR ,RUBBER-STAMP>
			      	     <MOVE ,HEART-OF-MAZE-HOLE
					   ,HEART-OF-MAZE>)>)
			     (T
<COND (<AND <EQUAL? <GETP ,HERE ,P?CAPACITY> 1>
	    <G? <GETB ,HM-TABLE ,HM-ROOM> 15>>
       <TELL "You've already dug a hole here." CR>)
      (<EQUAL? <GETP ,HERE ,P?CAPACITY> 1>
       <MOVE ,MAZE-HOLE ,HERE>
       <PUTB ,HM-TABLE ,HM-ROOM <ORB <GETB ,HM-TABLE ,HM-ROOM> ,X-H>>
       <SETG HM-BITS <GETB ,HM-TABLE ,HM-ROOM>>
       <TELL "You dig a good sized hole, but find nothing." CR>)>)>)>)

		      (T
	               <WASTE-OF-TIME>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT <EQUAL? <LOC ,PLAYER> ,PRSO>>
		<TELL "Look around you." CR>
		<RFATAL>)
	       (T
		<MOVE ,WINNER ,HERE>
		<TELL "You are no longer on" T ,PRSO "." CR>
		;<COND (<OR <EQUAL? <LOC ,PLAYER> ,LEFT-END>
			   <EQUAL? <LOC ,PLAYER> ,RIGHT-END>>
		       <SETG ON-PLANK <>>
		       <TELL "SETG ON-PLANK <>">)>)>>

<ROUTINE V-DRINK ()
	 <TELL ,YOU-CANT "drink that!" CR>>

<ROUTINE V-DRINK-FROM ()
	 <WHAT-A-CONCEPT>>

"drop"

; <ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE SPECIAL-DROP ()
	 <COND (<EQUAL? ,HERE ,ROOF-1 ,ROOF-2>
		<COND (<OR <AND <PRSO? ,FINCH>
				<NOT <FSET? ,FINCH ,BROKEN-BIT>>>
			   <AND <ULTIMATELY-IN? ,FINCH ,PRSO>
				<NOT <FSET? ,FINCH ,BROKEN-BIT>>>>
		       <BREAK-FINCH T>)>
		<COND (<AND
			<PRSO? ,RED-CANDLE ,WHITE-CANDLE ,BLUE-CANDLE>
			<FSET? ,PRSO ,FLAMEBIT>>
		       <BLOW-OUT-CANDLE ,PRSO T>)>
		<MOVE ,PRSO ,PATIO>
		<TELL "The " D ,PRSO " slides off the roof." CR>)
	       (<EQUAL? ,HERE ,ON-POOL-1 ,ON-POOL-2 ,INLET ,IN-POOL-1
			,IN-POOL-2>
		<PERFORM ,V?PUT ,PRSO ,WATER>
		<RTRUE>)
	       (<OR <EQUAL? ,HERE ,CHIMNEY-2>
		    <EQUAL? ,HERE ,CHIMNEY-1>>
		<PERFORM ,V?PUT ,PRSO ,CHIMNEY>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<SPECIAL-DROP>
		<RTRUE>)
	       (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE IDROP ()
	 <COND (<DONT-HAVE? ,PRSO>
		T)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL ,YOU-CANT "do that while" T ,PRSO>
		<IS-CLOSED>
		<CRLF>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You'll have to take off" T ,PRSO " first." CR>)
	       (T
		;<MOVE ,PRSO <LOC ,WINNER>>
		<MOVE ,PRSO ,HERE>
		;"stuff dropped when on plank to room not plank"
		<RTRUE>)>
	 <RFALSE>>

<ROUTINE V-EAT ()
	 <NOT-LIKELY ,PRSO "would agree with you">>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <SET OBJ <FIRST? ,PRSO>>
		       <COND (.OBJ
			      <REPEAT ()
				      <COND (.OBJ
					     <SET NXT <NEXT? .OBJ>>
					     <COND (<NOT <FSET? .OBJ
							  ,NARTICLEBIT>>
						    <TELL "The ">)>
					     <TELL D .OBJ ": ">
					     <PERFORM ,V?TAKE .OBJ ,PRSO>
					     <SET OBJ .NXT>)
					    (T
					     <RETURN>)>>)
			     (T
			      <BUT-THE ,PRSO>
			      <TELL "is already empty!" CR>)>)
		      (T
		       <ITS-CLOSED ,PRSO>)>)
	       (T
		<TELL ,YOU-CANT "empty that!" CR>)>
	 <RTRUE>>

<ROUTINE V-ENTER ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?IN>)
	       (<FSET? ,PRSO ,DOORBIT>
	        <DO-WALK <OTHER-SIDE ,PRSO>>)
	       (<IN? ,PRSO ,WINNER>
	        <TELL "That would involve quite a contortion!" CR>)
	       (<FSET? ,PRSO ,WEARBIT>
		<PRESUMABLY-YOU-WANT-TO "wear" ,PRSO>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
	        <TELL
"You hit your head against" T ,PRSO " as you attempt this feat." CR>)>>

;<ROUTINE PRE-EXAMINE ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>
		<RTRUE>)>
         ;<COND (<EQUAL? ,ROPED ,PRSO>
		<TELL "The rope is tied to" T ,PRSO "." CR>
                <RTRUE>)>>

<GLOBAL YAWNS <LTABLE 0 "unusual" "interesting" "extraordinary" "special">>

<ROUTINE V-EXAMINE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "It looks as if" T ,PRSO " is ">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "open">)
	              (T
		       <TELL "closed">)>
	        <TELL "." CR>
	        <RTRUE>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<V-LOOK-ON>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<OR <FSET? ,PRSO ,OPENBIT>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <V-LOOK-INSIDE>)
		      (T
		       <ITS-CLOSED ,PRSO>)>)
	       (<FSET? ,PRSO ,READBIT>
		<PERFORM ,V?READ ,PRSO>)
	       (T
		<TELL
"You see nothing " <PICK-ONE ,YAWNS> " about" TR ,PRSO>)>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

; <ROUTINE V-EXIT ()
	 <COND (<IN? ,PRSO ,POCKET>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

; <ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE FAILED ()
	 <TELL "Failed." CR>>

;<ROUTINE PRE-FEED ()
	 <COND (<PRE-GIVE T>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;<ROUTINE V-FEED ()
	 <V-GIVE T>>

;<ROUTINE V-SFEED ()
	 <PERFORM ,V?FEED ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (<FSET? ,PRSO ,CONTBIT>
		       <TELL "There's nothing to fill it with." CR>)
		      (T
		       <V-STAND-UNDER>)>)
	       (<EQUAL? ,PRSI ,PORTABLE-WATER ,WATER>
		<COND (<NOT <GLOBAL-IN? ,WATER ,HERE>>
		       <CANT-SEE-ANY ,WATER>)
		      (<NOT <EQUAL? ,PRSO ,BUCKET>>
		       <V-STAND-UNDER>)
		      (<AND <FIRST? ,BUCKET>
			    <NOT <EQUAL? <FIRST? ,BUCKET> ,PORTABLE-WATER>>>
		       <TELL
"That would get the stuff in the bucket all wet." CR>)
		      (T
		       <MOVE ,PORTABLE-WATER ,BUCKET>
		       <QUEUE I-DRIP 2>
		       <SETG AMOUNT-OF-WATER 26>
		       <TELL
"You fill" T ,BUCKET ", which naturally leaks slowly." CR>)>)
	       (<EQUAL? ,PRSI ,PORTABLE-WATER>
		<PERFORM ,V?POUR ,PORTABLE-WATER ,PRSO>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T 
		<V-STAND-UNDER>)>>

<ROUTINE V-FIND ("AUX" L)
	 <SET L <LOC ,PRSO>>
	 <COND (<EQUAL? ,PRSO ,ME ,HANDS>
		<TELL "You're right here">)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You're holding it">)
	       (<OR <IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<BUT-THE ,PRSO>
		<TELL "is right in front of you">)
	       (<IN? ,PRSO ,LOCAL-GLOBALS>
		<HOW?>
		<RTRUE>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "It looks as if" T .L " has it">)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<TELL "It's ">
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T .L>)
	       (T
		<TELL "You'll have to do that yourself">)>
	 <TELL "." CR>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>) "AUX" WORD)
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Do you want to restart the story, restore a saved position, or quit?~
~
(Please type RESTART, RESTORE or QUIT.) >">
	 <READ ,P-INBUF ,P-LEXV>
	 <SET WORD <GET ,P-LEXV 1>>
	 <COND (<EQUAL? .WORD ,W?RESTAR>
	        <RESTART>
		<FAILED>
		<FINISH T>)
	       (<EQUAL? .WORD ,W?RESTOR>
		<COND (<RESTORE>
		       <SAY-OKAY>)
		      (T
		       <FAILED>
		       <FINISH T>)>)
	       (<EQUAL? .WORD ,W?QUIT ,W?Q>
		<QUIT>)
	       (T
		<FINISH T>)>>

<ROUTINE V-FLY ()
	;<TELL ,YOU-CANT "do that!" CR>
	 <TELL "That's not in the script!" CR>>

<ROUTINE V-FOCUS ()
	 <TELL "It's your thinking that's out of focus." CR>>

<ROUTINE V-FOLLOW ("AUX" WHERE)
	 <SET WHERE <LOC ,PRSO>>
	 <BUT-THE ,PRSO>
	 <TELL "is ">
	 <COND (<OR <EQUAL? .WHERE ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "right here in front of you">)
	       (<EQUAL? .WHERE ,PLAYER>
		<TELL "in" D ,HANDS "s">)
	       (<IN? .WHERE ,PLAYER>
		<TELL "in" T .WHERE>)
	       (T
		<TELL "nowhere to be seen">)>
	 <TELL "!" CR>>

"give"

<ROUTINE PRE-GIVE ()
	 <COND (<OR <NOT ,PRSO>
		    <NOT ,PRSI>>
		<REFERRING>
		<RTRUE>)
	     ; (<AND <FSET? ,PRSO ,ACTORBIT>
		     <ULTIMATELY-IN? ,PRSI>>
		<PERFORM ,V?GIVE ,PRSI ,PRSO>
		<RTRUE>)
	     ; (<AND <FSET? ,PRSI ,ACTORBIT>
		     <DONT-HAVE? ,PRSO>>
		<RTRUE>)
	       (<OR <IN? ,PRSO ,LOCAL-GLOBALS>
		    <IN? ,PRSO ,PSEUDO-OBJECT>>
		<NOT-HOLDING>
		<RTRUE>)
	       (<DONT-HAVE? ,PRSO>
		<RTRUE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL ,YOU-CANT "give anything to that!" CR>
		<RTRUE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TAKE-OFF-PRSO-FIRST>)
	       (T
		<RFALSE>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Politely," T ,PRSI " refuses your offer." CR>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

; <ROUTINE GO-NEXT (TBL "AUX" VAL)
	 #DECL ((TBL) TABLE (VAL) ANY)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

;<ROUTINE V-GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT OHERE)
	 <SET OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <MOVE ,WINNER .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
         ;<ROPE-EXITS>
        ;<COND (<ULTIMATELY-IN? ,ROPE>
		<MOVE ,ROPE ,HERE>
                     <COND (<AND <NOT <ULTIMATELY-IN? ,ROPED>>
                            <FSET? ,ROPED ,TAKEBIT>>
                            <TELL 
"As you exit you drag" T ,ROPED " along with you." CR CR>
		      <MOVE ,ROPED ,HERE>)
		           (<ULTIMATELY-IN? ,ROPED>
			    <SNAKES>)
                           (<NOT <FSET? ,ROPED ,TAKEBIT>>
                            <TUG>)>)>
             ;<COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <NOT ,FIRST-WARNING?>
		     <PROB 0>> ;"change prob to 0 for now"
		<TELL
"Oh, no! Something lurked out of the darkness and devoured you!" CR>
		<FINISH>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
	       ;<V-FIRST-LOOK>)>
	 <RTRUE>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT OHERE X)
	 <SET X <APPLY <GETP ,HERE ,P?ACTION> ,M-EXIT>>
	 <SET OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <MOVE ,WINNER .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 ;<ROPE-EXITS>
	 ;<COND (<AND <NOT .OLIT>
		      <NOT ,LIT>
		      <NOT ,FIRST-WARNING?>
		      <PROB 0>> ;"change prob to 0 for now"
		 <TELL
"Oh, no! Something lurked out of the darkness and devoured you!" CR>
		 <FINISH>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND <DESCRIBE-ROOM>
                     <NOT <EQUAL? ,VERBOSITY 0>>>
		<DESCRIBE-OBJECTS>)>
	 ;<COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
	       ;<V-FIRST-LOOK>)>
	 <RTRUE>>


;"was part of routine goto"
;<COND (<ULTIMATELY-IN? ,ROPE>
		<MOVE ,ROPE ,HERE>
                     <COND (<AND <NOT <ULTIMATELY-IN? ,ROPED>>
                            <FSET? ,ROPED ,TAKEBIT>>
                            <TELL 
"As you exit you drag" T ,ROPED " along with you." CR CR>
		      <MOVE ,ROPED ,HERE>)
		           (<ULTIMATELY-IN? ,ROPE>
			    <SNAKES>)
                           (<NOT <FSET? ,ROPED ,TAKEBIT>>
                            <TUG>)>)>

<GLOBAL HO-HUM
	<LTABLE 0 
	 "doesn't do anything"
	 "accomplishes nothing"
	 "has no effect">>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO " " <PICK-ONE ,HO-HUM> "." CR>>

<ROUTINE PRE-HANG-UP ()
	 <COND (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <NOT <PRSO? ,PHONE>>>
		<NOT-HOLDING ,PRSO>)>>

<ROUTINE V-HANG-UP ()
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <TELL
"Next time, say which peg to hang it on." CR>)
		      (T
	 	       <TELL "There's no place to hang it up." CR>)>)
	       (T
		<TELL "You can't hang something on" AR ,PRSI>)>>

<ROUTINE V-HELLO ("AUX" WHO)
       <COND (,PRSO
	      <SET WHO ,PRSO>)
	     (T
	      <SET WHO <ANYONE-HERE?>>
	      <COND (.WHO
		     <SPOKEN-TO .WHO>
		     <PERFORM ,V?HELLO .WHO>
		     <RTRUE>)>)>
       <COND (.WHO
	      <COND (<FSET? .WHO ,ACTORBIT>
		     <TELL
"It's apparent that" T .WHO " didn't expect you to say that." CR>)
	            (T
		     <NOT-LIKELY .WHO "would respond">)>)
	     (T
	      <TALK-TO-SELF>)>>

<ROUTINE V-HELP ()
	 <TELL
"[If you're really stuck, maps and InvisiClues (TM) hint booklets are available
using the order form that came in your HOLLYWOOD HIJINX package.]" CR>>

<ROUTINE V-HIDE ()
	 <TELL "There aren't any good hiding places here." CR>>

; <ROUTINE V-INFLATE ()
	 <TELL "How can you inflate that?" CR>>

; <ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>


;"---- part of new describers ----"

<ROUTINE V-INVENTORY ()
	 <COND (<NOT <DESCRIBE-CONTENTS ,WINNER <>>>
		<TELL "You are empty-handed.">)>
	 <CRLF>>

;<ROUTINE PRINT-CONT (OBJ
		     "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y (1ST? T) (AV <>) STR (PV? <>) (INV? <>) (SC <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<SET AV <LOC ,WINNER>>)>
	 <COND (<EQUAL? ,PLAYER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (T
		<REPEAT ()
			<COND (<NOT .Y>
			       <RETURN <NOT .1ST?>>)
			      (<EQUAL? .Y .AV>
			       <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 ;<COND (<AND <EQUAL? .OBJ ,HERE>
		     <IN? ,SATCHEL ,HERE>>
		<DESCRIBE-OBJECT ,SATCHEL .V? .LEVEL>
		<SET SC T>)>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,PLAYER> T)
		       ;(<AND .SC <EQUAL? .Y ,SATCHEL>> T)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND ;(<AND <EQUAL? .Y ,STONE>
				    <EQUAL? ,HERE ,OUTER-LAIR>
				    <IN? .Y ,HERE>>
			       <FSET .Y ,NDESCBIT>)
			      (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y>
				    <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

;<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER>
		<PRINT-CONT ,WINNER>)
	       (T
		<TELL "You are empty-handed." CR>)>>

;<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is:" CR>)
		      (<AND <FSET? .OBJ ,ACTORBIT>
			    <NOT <EQUAL? .OBJ ,NUTRIMAT>>>
		       <TELL ,IT-LOOKS-LIKE>
		       <ARTICLE .OBJ T>
		       <TELL " is holding:" CR>)
		      (T
		       <TELL ,IT-LOOKS-LIKE>
		       <ARTICLE .OBJ T>
		       <TELL " contains:" CR>)>)>>

;"semied to allow for new describers"
;<ROUTINE V-INVENTORY ()
	 <TELL "You're ">
	 <COND (<FIRST? ,PLAYER>
		<TELL "holding ">
		<DESCRIBE-CONTENTS ,PLAYER>)
	       (T
		<TELL "not holding anything">)>
	 <TELL "." CR>>

<ROUTINE ITS-ALREADY (STR)
	 <TELL "It's already " .STR "." CR>>

<ROUTINE JIGS-UP ("OPTIONAL" (REASON <>))
	 <COND (.REASON 
		<TELL .REASON CR>)>
	 <KILL-INTERRUPTS>	       
	 <TELL CR "Fade to black:~
~         ****  You have died  ****" CR>
	 <FINISH>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL ,YOU-CANT "attack" T ,PRSO "!">)
	       (T
		<TELL "Attacking" T ,PRSO>
		<COND (,PRSI
		       <TELL " with" T ,PRSI>)>
		<TELL " isn't likely to help matters.">)>
	 <CRLF>> 

; <ROUTINE V-KILL ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL "How can you attack" A ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL
"Attacking" A ,PRSO " with your bare hands is suicidal." CR>)
	       ;(<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Attacking" T ,PRSO " with " A ,PRSI " is suicidal." CR>)
	       (T
	        <TELL "Agilely," T ,PRSO " dodges your blow." CR>)>>

<ROUTINE KILL-INTERRUPTS ()
	 <RTRUE>>

<ROUTINE V-KISS ()
	 <TELL "Smack!" CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<NO-ANSWER>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?USE ,PRSO>
		<RTRUE>)
	       (T
		<WASTE-OF-TIME>)>>

<GLOBAL OKAY "Okay, ">

; <ROUTINE V-LAMP-OFF ()
	 <COND (<EQUAL? ,PRSO ,LANTERN>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <ITS-ALREADY "off">)
	              (T
		       <FCLEAR ,PRSO ,ONBIT>
		     ; <COND (,LIT
		              <SETG LIT <LIT? ,HERE>>)>
		       <TELL ,OKAY "the" ,PRSO " is off." CR>
		       <SAY-IF-NOT-LIT>)>)
	       (T
		<TELL ,YOU-CANT "turn that off." CR>)>
	 <RTRUE>>

;<ROUTINE V-LAMP-OFF ()
	 <V-LAMP-ON T>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<AND <EQUAL? ,P-PRSA-WORD ,W?BLOW>
		     <EQUAL? ,PRSO ,FLASHLIGHT ,COMPUTER ,FILM-PROJECTOR
			           ,SLIDE-PROJECTOR>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<OR <FSET? ,PRSO ,LIGHTBIT>
		    <FSET? ,PRSO ,BURNBIT>>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now off." CR>
		       <SAY-IF-NOT-LIT>
		       <RTRUE>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-TURN "ff">)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
                <COND (<FSET? ,PRSO ,ONBIT>
		       <ITS-ALREADY "on">)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       <NOW-LIT?>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<SET-FLAME-SOURCE>
		       <RTRUE>)
		      (ELSE
		       <PERFORM ,V?BURN ,PRSO ,PRSI>
		       <RTRUE>)>)
	       (T
		<CANT-TURN "n">)>>

<GLOBAL YOU-CANT "You can't ">

<ROUTINE CANT-TURN (STRING)
	 <TELL ,YOU-CANT "turn that o" .STRING "." CR>>
 
;<ROUTINE V-LAMP-ON ("OPTIONAL" (OFF? <>))
	 <TELL ,YOU-CANT "turn that ">
	 <COND (.OFF?
		<TELL "off">)
	       (T
		<TELL "on">)>
	 <TELL "." CR>>

; <ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL ,YOU-CANT "launch that by saying \"launch\"!" CR>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-LEAP ()
	 <COND (<NOT <EQUAL? ,PRSO ,ROOMS>>
		<TELL "That'd be a cute trick." CR>)
	       (<EQUAL? ,HERE ,IN-POOL-1 ,IN-POOL-2 ,ON-POOL-1 ,ON-POOL-2
			      ,INLET ,UNDERPASS-1 ,UNDERPASS-2>
		<DO-WALK ,P?DOWN>)
	       (<GLOBAL-IN? ,WATER ,HERE>
		<PERFORM ,V?SWIM ,WATER>
		<RTRUE>)
	       (T
		<WASTE-OF-TIME>)>>

; <ROUTINE V-LEAP ()
	 <COND (,PRSO
		<DO-WALK ,P?OUT>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LEAVE ()
	 <COND (<OR <EQUAL? ,PRSO ,ROOMS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<DO-WALK ,P?OUT>)
	       (<NOT <DONT-HAVE? ,PRSO>>
		<PERFORM ,V?DROP ,PRSO>)>
	 <RTRUE>>

<ROUTINE V-LET-GO ()
	 <PERFORM ,V?DROP ,PRSO>
	 <RTRUE>>

<ROUTINE V-LIE-DOWN ()
	 <TELL "This is no time for resting." CR>
	 <RTRUE>>

<ROUTINE V-LISTEN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<COND (<AND <EQUAL? ,HERE ,CLOSET>
			    ,BUCKET-PEG>
		       <TELL "\"Hummm.\"" CR>)
		      (T
		       <TELL "You hear nothing special." CR>)>)
	       (T
	 	<TELL "At the moment," T ,PRSO " makes no sound." CR>)>>

; <ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 #DECL ((ITM) ANY (TBL) TABLE (CNT LEN) FIX)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

"lock"

<ROUTINE V-LOCK ()
	 <COND (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
	        <COND (<NOT <FSET? ,HERE ,LOCKEDBIT>>
		       <TELL
,YOU-CANT "lock it from here." CR>)
                      (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"You can't lock" T ,PRSO " when it's open. You should have eaten more fish
(brain food) as Aunt Hildegarde told you to." CR>)
		      (<FSET? ,PRSO ,LOCKEDBIT>
		       <TELL
"You attempt to lock" T ,PRSO " and find it's already locked." CR>)
		      (,PRSI
		       <TELL
"When was the last time you locked something with" AR ,PRSI>)
                      (<FSET? ,HERE ,LOCKEDBIT>
		       <FSET ,PRSO ,LOCKEDBIT>
 			      <TELL "You lock" TR ,PRSO>)
	       	      (T
		       <THING-WONT-LOCK ,PRSI ,PRSO>)>)
	       (T
		<CANT-LOCK>)>>

<ROUTINE THING-WONT-LOCK (THING CLOSED-THING "OPTIONAL" (UN? <>))
	 <TELL "A quick test shows that" T .THING " won't ">
	 <COND (.UN?
		<TELL "un">)>
	 <TELL "lock" TR .CLOSED-THING>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS ;T>)>
	 <RTRUE>>

;<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT <EQUAL? ,VERBOSITY 0>>
		       <DESCRIBE-OBJECTS ;T>)>)>
	 <RTRUE>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (T
		<TELL "There's nothing behind" TR ,PRSO>)>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<EQUAL? ,HERE ,UPPER-BEACH-STAIRS ,LOWER-BEACH-STAIRS>
		<PERFORM ,V?LOOK-INSIDE ,GAP>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>		
	       ;<TELL "You see">
	       ;<DESCRIBE-REST ,HERE>
	       ;<COND (<EQUAL? ,HERE ,INLET ,ON-POOL-1 ,IN-POOL-1
			             ,UNDERPASS-1 ,UNDERPASS-2
				     ,IN-POOL-2 ,ON-POOL-2>
		       <TELL " in the water." CR>)
		      (<OR <FSET? ,HERE ,OUTDOORSBIT>
			   <FSET? ,HERE ,CAVEBIT>>
		       <TELL " on the ground." CR>)
		      (T <TELL " on the floor." CR>)>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <RTRUE>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<NOT-A "surgeon">)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<AND <PRSO? ,CELLAR-CD ,FOYER-CD ,UPSTAIRS-CD ,ATTIC-CD>
			    <NOT <EQUAL? ,HERE ,CLOSET>>
			    <FSET? ,PRSO ,OPENBIT>>
		       <PERFORM ,V?LOOK-INSIDE ,CLOSET-REF>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?EXAMINE ,PRSO>
		       <RTRUE>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		       <V-LOOK>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <NOT <FSET? ,PRSO ,TRANSBIT>>>
		       <ITS-CLOSED ,PRSO>)
		      (T
		       <TELL ,YOU-SEE>
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL " in" TR ,PRSO>)>
		       <RTRUE> ;<DESCRIBE-REST ,PRSO>)>)
	       (T
		<TELL ,YOU-CANT "look inside" AR ,PRSO>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>
		<RTRUE>)>
	 <TELL ,YOU-SEE>
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL " on" TR ,PRSO>)>
		<RTRUE>)
	       (T
		<TELL " nothing " <PICK-ONE ,YAWNS> " on" TR ,PRSO>)>>

<ROUTINE V-LOOK-THRU ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL ,YOU-CANT "look through that!" CR>)
	       (T
		<NOTHING-INTERESTING T>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<IN? ,PRSO ,PLAYER>
		<TELL "You're already ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "wear">)
		      (T
		       <TELL "hold">)>
		<TELL "ing that!" CR>)
	       (T
		<NOTHING-INTERESTING T>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<EQUAL? ,HERE ,UPSTAIRS-HALL-MIDDLE>
		<COND (<FSET? ,ATTIC-DOOR ,OPENBIT>
		       <TELL
"You see an opening in the ceiling previously covered by the small panel.
A ladder attached to the small door hangs down from the opening." CR>)
		      (T
		       <TELL
"You see the outline of a small panel in the ceiling." CR>)>)
	       (<EQUAL? ,HERE ,CLOSET-TOP>
		<TELL "The shaft continues upward." CR>)
	       (<EQUAL? ,HERE ,SHAFT-BOTTOM>
		<TELL
"You see the bottom of the closet ">
		<COND (<EQUAL? ,CLOSET-FLOOR ,UPSTAIRS-HALL-MIDDLE ,ATTIC>
		       <TELL "far ">)>
		<TELL "above you." CR>)
	       (<OR <EQUAL? ,HERE ,FIREPLACE ,CHIMNEY-1 ,CHIMNEY-2 ,CHIMNEY-3>
		    <FSET? ,HERE ,OUTDOORSBIT>>
		<COND (<G? ,MOVES 556>
		       <TELL "You see the blue sky of a new day." CR>)
		      (T
		       <TELL "You see the night's sky." CR>)>)
	       (T
		<TELL "You begin to get a stiff neck." CR>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

; <ROUTINE V-MELT ()
	 <TELL ,YOU-CANT "melt that!" CR>>

<ROUTINE V-MOVE ()
	 <COND ; (<ULTIMATELY-IN? ,PRSO>
		  <TELL "Why juggle objects?" CR>)
	       (<EQUAL? ,PRSO ,ROOMS>
		<V-WALK-AROUND>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL
"Moving" T ,PRSO " reveals nothing " <PICK-ONE ,YAWNS> "." CR>)
	       (T
		<TELL ,YOU-CANT "move" TR ,PRSO>)>>

<ROUTINE V-MUNG ()
	 ;<HACK-HACK "Trying to destroy">
	 <TELL "Let's leave the violence to the movies." CR>>

<ROUTINE NO-ANSWER ()
	 <TELL "There's no answer." CR>>

<ROUTINE NOT-A (STR)
	 <TELL "You're not a " .STR "!" CR>>

; <ROUTINE NOTHING-HELD? ("AUX" X N)
	 <SET X <FIRST? ,PLAYER>>
	 <REPEAT ()
		 <COND (.X
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <RFALSE>)>
			<SET X <NEXT? .X>>)
		       (T
			<RTRUE>)>>>

<ROUTINE NOTHING-INTERESTING ("OPTIONAL" (SEE? <>))
	 <TELL "You ">
	 <COND (.SEE?
		<TELL "see">)
	       (T
		<TELL "find">)>
	 <TELL " nothing " <PICK-ONE ,YAWNS> "." CR>>

<ROUTINE NOW-BLACK ()
	 <TELL "It is pitch black.">>

<ROUTINE NOW-CLOSED-OR-OPEN (THING "OPTIONAL" (OPEN? <>))
	 <THIS-IS-IT .THING>
	 <TELL ,OKAY "the " D ,PRSO " is now ">
	 <COND (.OPEN?
		<FSET .THING ,OPENBIT>
		<TELL "open">)
	       (T
		<FCLEAR .THING ,OPENBIT>
		<TELL "closed">)>
	 <TELL "." CR>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<NOT-A "surgeon">)
	       (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<TELL "Huh?" CR>)
	       (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "How can you do that to">
		<TELL A ,PRSO "?" CR>)
	       (<FSET? ,PRSO ,OPENBIT>
		<ALREADY-OPEN>)
	       ;(<AND ,PRSI
		     <NOT <FSET? ,PRSI ,TOOLBIT>>>
		<TELL "With" A ,PRSI "!" CR>)
; "Locked"     (<FSET? ,PRSO ,LOCKEDBIT>
		<TELL "You'll have to unlock it first." CR>)
               
; "Container"  (<FSET? ,PRSO ,CONTBIT>
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <NOW-CLOSED-OR-OPEN ,PRSO T>)
		      ;(<AND <SET F <FIRST? ,PRSO>>
			    <NOT <NEXT? .F>>
			    <SET STR <GETP .F ,P?FDESC>>>
		       <TELL
,OKAY "the " D ,PRSO " is now open." CR CR .STR CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals">
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL "." CR>)>
		       <RTRUE>
		      ;<DESCRIBE-REST ,PRSO>
		      ;<TELL "." CR>)>)
	       
; "Door"       (T
	        <FSET ,PRSO ,OPENBIT>
		<SAY-THE ,PRSO>
		<COND (<AND ,MYSTERY-GUEST 
                       <PRSO? OAK-DOOR>>
		       <SETG MYSTERY-GUEST <>>
                       <TELL
" opens with a long squeal, and you hear hurried footsteps
several rooms away." CR>)
		      (T
		       <TELL
" " <PICK-ONE ,DOOR-NOISES> " as it opens." CR>)>)>>

<GLOBAL MYSTERY-GUEST T>

<ROUTINE CANT-OPEN-CLOSE ()
	 <TELL "You can't ">
	 <COND (<VERB? OPEN>
		<TELL "open">)
	       (T
		<TELL "close">)>
	 <TELL A ,PRSO "!" CR>>

<GLOBAL DOOR-NOISES
	<LTABLE 0
	 "squeaks"
	 "squeals"
	 "whines"
	 "creaks"
	 "whinnies"
	 "breaks into its nightclub act">>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T) 
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T <SET T <GETPT ,HERE .P>>
                          <COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
				      <EQUAL? <GET-DOOR-OBJ .T> .DOBJ>>
				 <RETURN .P>)>)>>>

;<ROUTINE V-PAY ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-PICK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<NOT-A "locksmith">)
	       (T
		<WHAT-A-CONCEPT>)>>

<ROUTINE V-PLAY ("AUX" WD PTR)
	 ;<COND (<ZERO? ,P-CONT>
		<SET WD <GET ,P-LEXV <+ 1 <GETB ,P-LEXV ,P-LEXWORDS>>>>)
	       (ELSE
		<SET WD <GET ,P-LEXV ,P-CONT>>)>
	 <SET WD <GET ,P-LEXV <SET PTR <+ ,P-SENTENCE ,P-LEXELEN>>>>
	 <COND (<EQUAL? .WD ,W?QUOTE>
		<SET WD <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)> 
	 <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,PIANO>>>
		<TELL "You can't play" AR ,PRSI>)
	       (<AND ,PRSO <NOT <EQUAL? ,PRSO ,PIANO>>>
		<TELL "You can't play" AR ,PRSO>)
	       (<NOT <IN? ,PIANO ,HERE>>
		<TELL "There's not a musical instrument in sight." CR>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 0>
		     <EQUAL? .WD ,W?YESTER>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 1>
		     <EQUAL? .WD ,W?GREENS>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 2>
		     <EQUAL? .WD ,W?CAMELO>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 3>
		     <EQUAL? .WD ,W?STARDU>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 4>
		     <EQUAL? .WD ,W?MISTY>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 5>
		     <EQUAL? .WD ,W?PEOPLE>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 6>
		     <EQUAL? .WD ,W?FEELIN>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 7>
		     <EQUAL? .WD ,W?TOMORR>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 8>
		     <EQUAL? .WD ,W?TONIGH>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (<AND <EQUAL? ,SONG-NUMBER 9>
		     <EQUAL? .WD ,W?OKLAHO>>		
		<OPEN-CRAWL-SPACE-DOOR?>
		<PCLEAR>)
	       (T
		<COND (<AND <NOT ,PRSO> <NOT ,PRSI>>
		       <TELL "[on the piano]" CR>)>
		<TELL
"You play for a few moments. It's very beautiful and melodious." CR>
		<PCLEAR>)>>

<ROUTINE OPEN-CRAWL-SPACE-DOOR? ()
	 <COND (,SONG-PLAYED
		<TELL
"You play \"" <GET ,SONGS ,SONG-NUMBER> "\" again. You tell yourself
you're getting better and promise to begin taking lessons again soon." CR>)
	       (T
		<FSET ,CRAWL-SPACE-DOOR ,OPENBIT>
		<SETG SONG-PLAYED T>
		<TELL
"Although a little rusty, you begin to play \"" <GET ,SONGS ,SONG-NUMBER>
".\" Just as you start to seriously consider taking lessons again, a door
in the floor opens." CR>)>>

; <ROUTINE V-PLUG ()
	 <TELL "This has no effect." CR>>

"pocket"

; <ROUTINE PRE-POCKET ()
	 <PERFORM ,V?PUT ,PRSO ,POCKET>
	 <RTRUE>>

; <ROUTINE V-POCKET ()
	 <WASTE-OF-TIME>>

;<ROUTINE V-POINT ()
	 <TELL "It's not polite to point." CR>>

<ROUTINE V-POUR ()
	 <TELL ,YOU-CANT "pour that!" CR>>
		
<ROUTINE V-PULL ()
	 <HACK-HACK "Pulling on">>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing around">>

<ROUTINE V-PUSH-DOWN ()
	 <COND (,PRSI
		<TELL ,YOU-CANT "push things down that." CR>)
	       (T
         	<HACK-HACK "Pushing down">)>>

<ROUTINE V-PUSH-TO ()
	 <TELL ,YOU-CANT "push things to that." CR>>

<ROUTINE V-PUSH-UP ()
         <HACK-HACK "Pushing up">>

<ROUTINE PRE-PUT ()
	 <COND (<AND <EQUAL? ,PRSO ,WHITE-WAX ,RED-WAX ,BLUE-WAX>
		     <VERB? PUT PUT-ON>
		     <ULTIMATELY-IN? ,PRSO>>
		<RFALSE>)
	       (<AND <PRSO? ,YOUR-FEET>
		     <PRSI? ,BRICK-HOLE>>
		<TELL "If you want to climb up the chimney, say so." CR>)
	       (<EQUAL? ,PRSO ,WATER ,PORTABLE-WATER>
		<RFALSE>)
	       (<ULTIMATELY-IN? ,PRSI ,PRSO>
		<TELL ,YOU-CANT "put" T ,PRSO>
		<COND (<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
		       <TELL " on">)
		      (T
		       <TELL " in">)>
		<TELL T ,PRSI " when" T ,PRSI " is already ">
		<COND (<FSET? ,PRSO ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSO "!" CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL <PICK-ONE ,YUKS> CR>)	       
	       (<DONT-HAVE? ,PRSO>
		<RTRUE>)
	       (<PRSI? ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)	     
	       (<AND ,PRSI
		     <NOT <ACCESSIBLE? ,PRSI>>>
		<CANT-SEE-ANY ,PRSI>
		<RTRUE>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TAKE-OFF-PRSO-FIRST>)
	       (T
		<RFALSE>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <PRSO? ,SKIS>
		     <EQUAL? ,PRSI ,BS-SAFE ,WALL-SAFE ,SACK ,COMPARTMENT>>
		<TELL "The skis can't possibly fit in there." CR>)
	       (<AND ,PRSI
		     <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     ;<NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "possibly do that!" CR>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<BUT-THE ,PRSI>
		<TELL "isn't open!" CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<WHAT-A-CONCEPT>)
	       (<IN? ,PRSO ,PRSI>
		<BUT-THE ,PRSO>
		<TELL "is already ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on ">)
		      (T
		       <TELL "in ">)>
		<TELL T ,PRSI "!" CR>)
	       (<AND <FSET? ,PRSI ,BURNBIT>
		     <FSET? ,PRSO ,FLAMEBIT>>
		<PERFORM ,V?BURN ,PRSI ,PRSO>
		<RTRUE>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room.">
		<CRLF>)
	       (<AND <NOT <IN? ,PRSO ,PLAYER>>
		     <EQUAL? <ITAKE> <> ,M-FATAL>>
		<RTRUE>)
	       (T
	        <MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

;"leather v-put"
;<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<OR <FSET? ,PRSI ,ACTORBIT>
		    <PRSI? ,STALLION ,BABY>>
		<TELL ,HUH>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <ULTIMATELY-IN? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (<AND <OR <PRSO? ,TORCH>
			 <ULTIMATELY-IN? ,TORCH ,PRSO>>
		     <FSET? ,TORCH ,ONBIT>
		     <PRSI? ,BASKET ,SACK>>
		<DO-FIRST "extinguish" ,TORCH>)
	       (<IN? ,PRSI ,ODD-MACHINE>
		<TELL ,ONLY-ONE-THING-IN-COMPARTMENT>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (<EQUAL? ,PRSI ,FILM-PROJECTOR>
		<V-PUT>) ;"SEM"
	       (T
		<TELL "There's no good surface on">
		<COND (,PRSI
		       <TELL T ,PRSI>)
		      (T
		       <TELL " that">)>
		<TELL "." CR>)>>

<ROUTINE V-PUT-UNDER ()
         <TELL ,YOU-CANT "put anything under that." CR>>

<ROUTINE V-QUESTION ()
	 <V-ASK-FOR>>

; <ROUTINE V-QUESTION ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<NOT-LIKELY ,PRSO "is interested">)
	       (T
		<NOT-LIKELY ,PRSO "would reply">)>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T))
	 <V-SCORE>
	 <COND (.ASK?
		<SAY-SURE>
		<TELL "leave the story now?">
		<COND (<YES?>
		       <TELL CR "Cut! That's a take." CR>
		       <QUIT>)
		      (T
		       <TELL ,OKAY "continuing." CR>)>)
	       (T
		<QUIT>)>>

; <ROUTINE RANDOMIZE-OBJECTS ("AUX" (F <FIRST? ,WINNER>) N)
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<MOVE .F ,HERE>
			<SET F .N>)
		       (T
			<RETURN>)>>
	 <RTRUE>>

<ROUTINE V-RAPE ()
	 <TELL "What a wholesome idea." CR>>

<ROUTINE V-RAISE ()
	 <COND (<PRSO? ,ROOMS> ;"input was GET UP"
		<PERFORM ,V?STAND ,ROOMS>
		<RTRUE>)
	       (T
	 	<HACK-HACK "Toying in this way with">)>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<NOT-A "surgeon">)
	       (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "It's empty." CR>)
	       (T
		<TELL "You reach into" T ,PRSO " and feel something." CR>
		<RTRUE>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <CANT-VERB-A-PRSO "read">)>>

<ROUTINE CANT-VERB-A-PRSO! (STRING)
	 <TELL ,YOU-CANT .STRING A ,PRSO "!" CR>>

;<ROUTINE V-READ ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<NOT <FSET? ,PRSO ,READBIT>>
		<HOW-READ>
		<TELL "?" CR>)
	       (T
		<TELL "It's undecipherable." CR>)>>

<ROUTINE V-READ-TO ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<NOT <FSET? ,PRSO ,READBIT>>
		<HOW-READ>
		<TELL " to" A ,PRSI "?" CR>)
	       (T
		<NOT-LIKELY ,PRSI "would appreciate your reading">)>>

<ROUTINE HOW-READ ()
	 <TELL "How can you read" A ,PRSO>>

;<ROUTINE REFERRING ()
	 <TELL "[Please be more specific.]" CR>> ;"I HAVE TWO VERSIONS OF THIS"
						;"SEM"

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-REMOVE-FROM ()
	 <COND (<AND <PRSO? ,WAX-COAT-1 ,WAX-COAT-2>
		     <PRSI? ,RED-MATCH ,GREEN-MATCH>>
		<PERFORM ,V?SCRAPE-OFF ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-REPLACE ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<TELL "That's easy">)
	       (T
		<BUT-THE ,PRSO>
	        <TELL "doesn't need replacement">)>
	 <TELL "." CR>>

<ROUTINE V-REPLY ()
	 <NOT-LIKELY ,PRSO "is interested">
	 <PCLEAR>
	 <RFATAL>>

<ROUTINE V-RESCUE ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<V-HELP>)
	       ;(<EQUAL? ,PRSO ,AUNT>
		<TELL "Yes, that's the idea." CR>)
	       (T
		<BUT-THE ,PRSO>
	        <TELL "doesn't need any help." CR>)>>

<ROUTINE V-RESET ()
	 <TELL "You don't need to reset that." CR>>

<ROUTINE V-RESTART ()
	 <V-SCORE>
	 <SAY-SURE>
	 <TELL "restart the story?">
	 <COND (<YES?>
		<RESTART>
		<FAILED>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
	        <SAY-OKAY>)
	       (T
		<FAILED>)>>

<ROUTINE V-RIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<NOT-LIKELY ,PRSO "wants to play piggyback">)
	       (T
		<TELL ,YOU-CANT "ride that!" CR>)>
	 <CRLF>>

; <ROUTINE RIPOFF (X WHERE)
	 <COND (<AND <NOT <IN? .X .WHERE>>
		     <NOT <FSET? .X ,INVISIBLE>>
		     <FSET? .X ,TOUCHBIT>
		     <FSET? .X ,TAKEBIT>>
		<COND (.WHERE <MOVE .X .WHERE>)
		      (T <MOVE .X ,ROOMS>)>
		<RTRUE>)>>

<ROUTINE ROB (WHO WHERE "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (.X
		        <SET N <NEXT? .X>>
		        <COND (<FSET? .X ,TAKEBIT>
			       <MOVE .X .WHERE>)>
		        <SET X .N>)
		       (T
			<RTRUE>)>>>

; <ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) (HIDE? <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<RIPOFF .X .WHERE>
			<COND (.HIDE? <FSET .X ,NDESCBIT>)>
			<SET ROBBED? .X>)>
		 <SET X .N>>>

<ROUTINE V-ROLL-UP ()
         <TELL ,YOU-CANT "roll up" A ,PRSO "." CR>>

<ROUTINE V-RUB ()
	 <HACK-HACK "Fiddling with">>

<ROUTINE V-SAVE ()
	 <TELL
"You can almost hear Buck Palace saying, \"Wimp!\"" CR CR>
	 <COND (<SAVE>	        
                <SAY-OKAY>)
	       (T
		<FAILED>)>>

<GLOBAL SAYING? <>>

<ROUTINE V-SAY ()
	 <COND (<ANYONE-HERE?>
		<WAY-TO-TALK>
		<PCLEAR>
		<RFATAL>)
	       (T
		<TALK-TO-SELF>)>>

<ROUTINE SAY-IF-NOT-LIT ()
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<NOT ,LIT>
		<CRLF>
		<NOW-BLACK>
		<CRLF>)>>

<ROUTINE SAY-OKAY ()
	 <TELL ,OKAY "done." CR>>

<ROUTINE SAY-SURE ()
	 <TELL "Are you sure you want to ">>

<ROUTINE V-SCORE ()
	 <TELL "Your score is " N ,SCORE " point">
	 <COND (<NOT <1? ,SCORE>>
	        <TELL "s">)>
	 <TELL " out of " N ,SCORE-MAX ", in " N ,MOVES " move">
	 <COND (<NOT <1? ,MOVES>>
	        <TELL "s">)>
	 <TELL "." CR>>

<CONSTANT SCORE-MAX 150>

<ROUTINE V-SCRAPE-OFF ()
	 <COND (,PRSI
		<TELL "You can't scrape" T ,PRSO " off" T ,PRSI "!" CR>)
	       (T
		<TELL "There's nothing to scrape off" TR ,PRSO>)>>

"scripting"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TRANSCRIPT "begin">
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TRANSCRIPT "end">
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE TRANSCRIPT (STR)
	 <TELL "Here " .STR "s a transcript of interaction with" CR>
	 <V-VERSION>>

<ROUTINE V-SEARCH ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<V-HELP>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <NOT <FSET? ,PRSO ,TRANSBIT>>>
		       <YOUD-HAVE-TO "open" ,PRSO>)
		      (T
		       <TELL "You find">
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL "." CR>)>
		       <RTRUE>
		       ;<TELL ,YOU-SEE>
		       ;<DESCRIBE-REST ,PRSO>
		       ;<TELL " inside" TR ,PRSO>)>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "You find">
                <COND (<NOT <DESCRIBE-NOTHING>>
			    <TELL "." CR>)>
		<RTRUE>
		;<TELL ,YOU-SEE>
		;<DESCRIBE-REST ,PRSO>
		;<TELL " on" TR ,PRSO>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?USE ,PRSO>
	        <RTRUE>) 
	       (T
		<NOTHING-INTERESTING>)>>

; <ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Why would you send for" T ,PRSO "?" CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ALARM ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSO ,TAKEBIT>>
		     <NOT <FSET? ,PRSO ,TRYTAKEBIT>>>
		<HACK-HACK "Shaking">)
	       (T
		<WASTE-OF-TIME>)>>

; <ROUTINE V-SHARPEN ()
	 <TELL "You'll never sharpen anything with that!" CR>>

<ROUTINE V-SHOOT ()
	 <COND (<AND <NOT ,PRSI>
		     <ULTIMATELY-IN? ,GUN>>
		<PERFORM ,V?SHOOT ,GUN ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "You haven't got a gun." CR>)
	       (T
	 	<TELL "You can't shoot that." CR>)>>

<ROUTINE V-SSHOOT ()
	 <PERFORM ,V?SHOOT ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHOW ()
	 <TELL "It isn't likely that" T ,PRSI " is interested." CR>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<AND <PRSO? ,ROOMS>
		     <GLOBAL-IN? ,SEAT ,HERE>>
		<PERFORM ,V?BOARD ,SEAT>
		<RTRUE>)
	       ;(<AND <PRSO? ,ROOMS>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (T
	        <WASTE-OF-TIME>)>>

<ROUTINE PRE-SKI ()
	 <COND (<NOT <FSET? ,SKIS ,WORNBIT>>
		<TELL "You're not wearing skis!" CR>)>>

<ROUTINE V-SKI ()
	 <COND (<PRSO? ,INTDIR>
		<COND (<EQUAL? ,P-DIRECTION ,P?UP>
		       <TELL "There's no tow rope here." CR>)
		      (T
		       ;<TELL "\"Ski slide shuffle shuffle...\"" CR CR>
		       <DO-WALK ,P-DIRECTION>)>)
	       (T
         	<TELL "You can't ski down that!" CR>)>>

; <ROUTINE V-SKIP ()
	 <TELL "Wheeee! Wasn't that fun?" CR>>

<ROUTINE V-SLEEP ()
	 <TELL
"Maybe you should've had a nap before the lawyer dropped you off." CR>>

<ROUTINE V-SMELL ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<TELL "You smell nothing " <PICK-ONE ,YAWNS>>)
	       (T
		<TELL "It smells just like" A ,PRSO>)>
	 <TELL "." CR>>

; <ROUTINE SPEAKING-TO-SOMEONE-ABOUT? (OBJ "AUX" ACTOR)
	 <COND (<SET ACTOR <ANYONE-HERE?>>
		<TELL "[spoken to" T .ACTOR "]" CR>
		<PERFORM ,V?ASK-ABOUT .ACTOR .OBJ>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-SPLICE ()
	 <TELL ,YOU-CANT "splice that!" CR>>

<ROUTINE V-SQUEEZE ()
	 <WASTE-OF-TIME>>

<ROUTINE V-STAND ()
	 <COND ;(<FSET? <LOC ,PLAYER> ,VEHBIT>
		<MOVE ,PLAYER ,HERE>
		<TELL "You're now standing again." CR>)
	       (<OR <NOT ,PRSO>
		    <PRSO? ,ROOMS>>
		<TELL "You're already standing." CR>)
	       (T
		<TELL ,YOU-CANT "stand that up." CR>)>>

<ROUTINE V-STAND-ON ()
	 <WASTE-OF-TIME>>

<ROUTINE V-STAND-UNDER ()
	 <TELL <PICK-ONE ,YUKS> CR>>

;<ROUTINE V-STRIKE ()
	 <PERFORM ,V?KILL ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND (,PRSO
		<COND (<PRSO? ,INTDIR>
		       <COND (<FSET? ,PLAYER ,WETBIT>
			      <DO-WALK ,P-DIRECTION>)
			     (T
			      <TELL "You'd be swimming in air." CR>)>)
		      (T
		       <TELL "You can't swim in" AR ,PRSO>)>)
	       (<GLOBAL-IN? ,WATER ,HERE>
		<PERFORM ,V?SWIM ,WATER>
		<RTRUE>)
	       (T
		<TELL ,YOU-CANT "swim here!" CR>)>>

<GLOBAL DOG-PADDLE
"You wouldn't even be able to dog paddle wearing a pair of skis.">

<ROUTINE V-SWIM-UP ()
	 <DO-WALK ,P?UP>>

<ROUTINE V-SWIM-DOWN ()
	 <DO-WALK ,P?DOWN>>

"take"

<ROUTINE PRE-TAKE ("OPTIONAL" CONTAINER)
	 <SET CONTAINER <LOC ,PRSO>>
	 <COND (<IN? ,PRSO ,WINNER>
		<TELL "You're already ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "wear">)
		      (T
		       <TELL "hold">)>
		<TELL "ing it." CR>
		<RTRUE>)
	       (<AND .CONTAINER
		     <FSET? .CONTAINER ,CONTBIT>
		     <NOT <FSET? .CONTAINER ,OPENBIT>>>
		<TELL ,YOU-CANT "reach into" T .CONTAINER ". It's closed." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSO ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<AND <EQUAL? ,PRSO ,WATER>
			    <EQUAL? ,PRSI ,POND>>
		       <RFALSE>)
		      (<NOT <IN? ,PRSO ,PRSI>>
		       <COND (<AND <PRSO? ,RING>
				   <PRSI? ,DOG>
				   <FSET? ,DOG ,CLUTCHING-BIT>>
			      ;"TAKE RING FROM DOG"
			      <RFALSE>)
			     (<AND <PRSO? ,LADDER>
				   <PRSI? ,HATCH-HOLE>
				   <FSET? ,LADDER ,HUNG-BIT>>
			      <RFALSE>)
			     (<AND <PRSO? ,LENS-CAP>
				   <PRSI? ,FILM-PROJECTOR-LENS>
				   <FSET? ,LENS-CAP ,NDESCBIT>>
			      <RFALSE>)> ;"for TAKE LENS CAP FROM LENS"
		       <COND (<OR <FSET? ,PRSI ,ACTORBIT>
				  <EQUAL? ,PRSI ,DOG>>
			      <BUT-THE ,PRSI>
			      <TELL "doesn't have" A ,PRSO>)
			     (T
			      <BUT-THE ,PRSO>
			      <TELL "isn't in" T ,PRSI>)>
		       <TELL "." CR>
		       <RTRUE>)
		      (<AND <ULTIMATELY-IN? ,PRSO ,BUCKET>
		     	    ,BUCKET-PEG>
		       <TELL ,PEG-IN-WAY>)
		      (T
		       ;<SETG PRSI <>>
		       <RFALSE>)>
		<RTRUE>)
	       (<AND <ULTIMATELY-IN? ,PRSO ,BUCKET>
		     ,BUCKET-PEG>
		<TELL ,PEG-IN-WAY>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "You're in it!" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL PEG-IN-WAY
"You'd better take the bucket off the peg first.~">

<ROUTINE V-TAKE ()
	 <COND (<ITAKE>
		<TELL "Taken." CR>)>>

<GLOBAL TREASURES-FOUND 0>

;(;<AND <GETP ,PRSO ,P?VALUE>
	<NOT <EQUAL? <GETP ,PRSO ,P?VALUE> 0>>>
   <NOT <EQUAL? <GETP ,PRSO ,P?VALUE> 0>>
	<SETG SCORE <+ ,SCORE <GETP ,PRSO ,P?VALUE>>>
	<PUTP ,PRSO ,P?VALUE 0>
	<SETG TREASURES-FOUND <+ ,TREASURES-FOUND 1>>
	<COND (<EQUAL? ,TREASURES-FOUND 10>
	       <MOVE ,PEG-0 <LOC ,PRSO>>
	       <MOVE ,NOTE <LOC ,PRSO>>
	       <MOVE ,PRSO ,WINNER>
	       <FSET ,PRSO ,TOUCHBIT>
	       <FCLEAR ,PRSO ,NDESCBIT>
	       <COND (<PRSO? ,RING>
		      <TELL
"As you take" T ,PRSO ", a small peg and a note drop out from
under the model." CR>
		      <MOVE ,PEG-0 ,HERE>
		      <MOVE ,NOTE ,HERE>)
		     (T
		      <TELL
"As you take" T ,PRSO " you notice a chipped peg and a note ">
		      <COND (<PRSO? ,CORPSE-LINE ,GRATER
				    ,PARKING-METER>
			     <TELL "behind">)
			    ;"else PENGUIN RUBBER-STAMP MASK TOUPEE FINCH FIRE-HYDRANT"
			    (T
			     <TELL "beneath">)>
		      <TELL " it." CR>)>
	       <RFALSE> ;"don't print TAKEN for 10th treasure")>
	;"following is for all treasures except the tenth"
	<MOVE ,PRSO ,WINNER>
	<FSET ,PRSO ,TOUCHBIT>
	<FCLEAR ,PRSO ,NDESCBIT>		
	<RTRUE>)

<ROUTINE ITAKE ("OPTIONAL" (VB T))
	 <THIS-IS-IT ,PRSO>
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<TOO-MUCH-JUNK? .VB>
		<RFALSE>)
	       (<AND <BOKS-BIG-ONE ,PRSO>
		     <EQUAL? ,TREASURES-FOUND 10>>
		<RFALSE>)
	       (T ;"following is for all objects except the treasures"
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>		
		<RTRUE>)>>

<ROUTINE BOKS-BIG-ONE (T-OBJ)
	 <COND (<NOT <EQUAL? <GETP .T-OBJ ,P?VALUE> 0>>
		<SETG SCORE <+ ,SCORE <GETP .T-OBJ ,P?VALUE>>>
		<PUTP .T-OBJ ,P?VALUE 0>
		<SETG TREASURES-FOUND <+ ,TREASURES-FOUND 1>>
	        <COND (<EQUAL? ,TREASURES-FOUND 10>
		       <MOVE ,PEG-0 <LOC .T-OBJ>>
		       <MOVE ,NOTE <LOC .T-OBJ>>
		       <COND (<NOT <EQUAL? .T-OBJ ,FINCH>>
			      <MOVE .T-OBJ ,WINNER>)>
		       <FSET .T-OBJ ,TOUCHBIT>
	      	       <FCLEAR .T-OBJ ,NDESCBIT>
		       <COND (<EQUAL? .T-OBJ ,RING>
		              <TELL
"As you take" T ,PRSO ", a small peg and a note drop out from
under the model." CR>
		              <MOVE ,PEG-0 ,HERE>
		              <MOVE ,NOTE ,HERE>)
			     (T
			      <TELL "As you ">
			      <PRINTB ,P-PRSA-WORD>
			      <TELL
 T ,PRSO " you notice a wooden peg and a note ">
			      <COND (<EQUAL? .T-OBJ ,CORPSE-LINE ,GRATER
					    ,PARKING-METER>
			             <TELL "behind">)
				    (<EQUAL? .T-OBJ ,FINCH>
				     <TELL "next to" AR ,FINCH>
				     <RTRUE>)
		    	;"else PENGUIN RUBBER-STAMP MASK TOUPEE FIRE-HYDRANT"
			            (T
			             <TELL "beneath">)>
			      <TELL " it." CR>)>
		       <RTRUE> ;"don't print TAKEN for 10th treasure")>

		;<;"following is for all treasures except the tenth"
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
	      	<FCLEAR ,PRSO ,NDESCBIT>>		
		<RTRUE>)
	 (T
	  <RFALSE>)>>

<ROUTINE V-TAKE-OFF ("AUX" WHERE)
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?GET>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<AND <IN? ,PRSO ,PLAYER>
		     <FSET? ,PRSO ,WORNBIT>>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL ,OKAY "you're no longer wearing" TR ,PRSO>)
	       (T
		<TELL "You aren't wearing that!" CR>)>>

<ROUTINE TAKE-OFF-PRSO-FIRST ()
	 <TELL "You'll have to remove" T ,PRSO " first." CR>>

<ROUTINE V-TASTE ()
	 <PERFORM ,V?EAT ,PRSO>
	 <RTRUE>>

<ROUTINE V-TELL ()
	 <COND (<EQUAL? ,PRSO ,ME ,ROOMS>
		<TALK-TO-SELF>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <NO-ANSWER>)>)
	       (T
		<TELL ,YOU-CANT "talk to" A ,PRSO "!" CR>
		<PCLEAR>
		<RFATAL>)>>

<ROUTINE TELL-TIME ("AUX" MINUTES HOURS (PM <>))
	 <SET MINUTES <+ ,MOVES 1260>>
	 <COND (<G? .MINUTES 1439> ;"11:59 pm."
		<SET MINUTES <- .MINUTES 1440>>)>
	 <SET HOURS </ .MINUTES 60>>
	 <COND (<G? .HOURS 11> ;"after noon"
		<SET PM T>
		<SET HOURS <- .HOURS 12>>)>
	 <COND (<EQUAL? .HOURS 0> ;"between 12am and 1am, or 12pm and 1pm"
		<SET HOURS 12>)>
	 <TELL N .HOURS ":">
	 <SET MINUTES <MOD .MINUTES 60>> ;"remainder"
	 <COND (<L? .MINUTES 10>
		<TELL "0">)>
	 <TELL N .MINUTES>
	 <COND (.PM
		<TELL " pm">)
	       (T
		<TELL " am">)>>

;<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"You do so, but" T ,PRSO " seems less than overjoyed by your gratitude." CR>)
	       (T
		<TELL "You're loony." CR>)>>

<ROUTINE V-TIME ()
	 <TELL "It's ">
	 <TELL-TIME>
	 <TELL "." CR>>

;<ROUTINE V-TIP ()                   ;"these two routines need to be fixed up"
	;<TELL
"If Aunt Hildegarde saw you trying that she'd">
	;<ASS-KICK>>

;<ROUTINE ASS-KICK ()
	 <TELL
" kick you in the ass so hard you'd have to take your shirt off to shit!" CR>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<SPECIAL-DROP>
		       <RTRUE>)
		      (,PRSI
		       <TELL "You missed." CR>)
		      (T
		       <TELL "Thrown." CR>)>)>>

<ROUTINE V-THROW-OFF ()
	 <WASTE-OF-TIME>>

<ROUTINE V-TIE ()
	 <TELL ,YOU-CANT "tie" T ,PRSO " to that." CR>>

<ROUTINE V-TIE-UP ()
	 <TELL  ,YOU-CANT "tie anything with that!" CR>>

<ROUTINE TOO-DARK ()
	 <TELL "It's too dark to see!" CR>>

;<CONSTANT FUMBLE-NUMBER 10>
<CONSTANT LOAD-ALLOWED 100>

<ROUTINE TOO-MUCH-JUNK? ("OPTIONAL" (VB T))
         <COND (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
	        <COND (.VB
		       <COND (<FIRST? ,PLAYER>
			      <TELL "Your load is">)
			     (T
			      <TELL "It's a little">)>
		       <TELL " too heavy." CR>)>
		<RTRUE>)
	       ;(<G? <CCOUNT ,WINNER> ,FUMBLE-NUMBER>
		<COND (.VB
		       <TELL "You're holding too many things already!" CR>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-TURN ()
	 <COND (<AND <NOT <FSET? ,PRSO ,TAKEBIT>>
		     <NOT <FSET? ,PRSO ,TRYTAKEBIT>>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (T
		<HACK-HACK "Turning">)>>

<ROUTINE V-TURN-LEFT ()
	 <V-TURN>>

<ROUTINE V-TURN-RIGHT ()
	 <V-TURN>>

<ROUTINE V-USE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<BUT-THE ,PRSO>
		<TELL "might resent that." CR>
		<RTRUE>)
	       (T
		<HOW?>)>>

<GLOBAL VERBOSITY 1> ;"0 = superbrief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "[Maximum verbosity.]" CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "[Brief descriptions.]" CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "[Superbrief descriptions.]" CR>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL CR
"HOLLYWOOD HIJINX~
Infocom interactive fiction -- a zany treasure hunt~
Copyright (C) 1986 Infocom, Inc. All rights reserved.~" >
         %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		 '<SET V .V>)
		(T
		 '<COND (<NOT <ZERO? <BAND <GETB 0 1> 8>>>
			 <TELL
"Licensed to Tandy Corporation. Version 00.00." N .V CR>)>)>
	 <TELL "HOLLYWOOD HIJINX is a trademark of Infocom, Inc.~
Release " N .V " / Serial Number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>


<ROUTINE V-$VERIFY ()
         <COND (,PRSO
	        <COND (<AND <EQUAL? ,PRSO ,INTNUM>
		            <EQUAL? ,P-NUMBER 57>>
	               <TELL N ,SERIAL CR>)
	              (T 
		       <DONT-UNDERSTAND>)>)
               (T
	        <TELL "Verifying disk." CR>
	        <COND (<VERIFY> 
		       <TELL "Correct." CR>)
	              (T 
		       <FAILED>)>)>>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO INTNUM>>
		<TELL "Illegal." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

;"lockedbit for object and in rooms where you can lock the door"

<ROUTINE V-UNLOCK ()
	 <COND (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The " D ,PRSO " is already open. You should have eaten more carrots as
Aunt Hildegarde always told you." CR>)
		      (<NOT <FSET? ,PRSO ,LOCKEDBIT>>
		       <TELL 
"You attempt to unlock" T ,PRSO " and find it isn't locked." CR>)
		      (,PRSI
		       <TELL
"When was the last time you unlocked something with" A ,PRSI "?" CR>)
                      (<FSET? ,PRSO ,DOORBIT>
		       <COND (<NOT <FSET? ,HERE ,LOCKEDBIT>>
			      <TELL ,YOU-CANT "unlock it from this side." CR>)
			     (T
			      <TELL "With a click you unlock" TR ,PRSO>
		              <FCLEAR ,PRSO ,LOCKEDBIT>)>)
		      (<AND <FSET? ,PRSO ,CONTBIT>     ;"its one of the safes"
                            <FSET? ,PRSO ,LOCKEDBIT>>
		       <TELL "Perhaps if you had the combination..." CR>) 
                      (T
		       <THING-WONT-LOCK ,PRSI ,PRSO T>)>)
	       (T
		<CANT-LOCK T>)>>

<ROUTINE V-UNROLL ()
	 <TELL ,YOU-CANT "unroll" AR ,PRSO>>

<ROUTINE V-UNTIE ()
         <TELL "You don't need to untie it. It's not tied to anything." CR>>

"walk"

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>
	 <RTRUE>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<AND <FSET? ,SKIS ,WORNBIT>
		     <NOT <PRSO? ,P?DOWN>>>
		<TELL
"These are downhill skis, not cross-country skis!" CR>
		<RFATAL>)
               (<NOT ,P-WALK-DIR>
		<COND (,PRSO
		       <PRESUMABLY-YOU-WANT-TO  "walk to" ,PRSO>
		       <PERFORM ,V?WALK-TO ,PRSO>)
		      (T
		       <V-WALK-AROUND>)>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,PLAYER> ,HERE>>
		<TELL
"You're not going anywhere while you're on" TR <LOC ,PLAYER>>
		<RFATAL>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GET-REXIT-ROOM .PT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GET-REXIT-ROOM .PT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GET-DOOR-OBJ .PT>> ,OPENBIT>
			      <GOTO <GET-REXIT-ROOM .PT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <ITS-CLOSED .OBJ>
			      <RFATAL>)>)>)
	       (T
		<COND (<EQUAL? ,P-WALK-DIR ,P?IN ,P?OUT>
		       <TELL
"Please use compass directions." CR>)
		      (T
                       <CANT-GO>
		       <RFATAL>)>)>>  ;"rfatal in right place?"

<ROUTINE V-WALK-AROUND ()
	 <TELL "[Do you have any particular direction in mind?]" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<EQUAL? ,PRSO ,INTDIR>
		<DO-WALK ,P-DIRECTION>)
	       (T
		<V-WALK-AROUND>)>>

; <ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO <OR <IN? ,PRSO ,HERE>
		               <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "It's right here in front of you!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-$WAIT ("AUX" NUM)
	 <COND (<PRSO? ,INTNUM>
		<SET NUM ,P-NUMBER>
	 	<TELL "Time passes." CR>
	 	<REPEAT ()
			<COND (<L? <SET NUM <- .NUM 1>> 0>
			       <RETURN>)
			      (<CLOCKER>
			       <RETURN>)>>
		<SETG CLOCK-WAIT T>)
	       (T
		<TELL "Youse should use a numba." CR>)>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? <LOC ,PRSO> ,HERE ,WINNER>
		<BUT-THE ,PRSO>
		<TELL "is already here!">)
	       (T
		<TELL "You may be waiting quite a while.">)>
	 <CRLF>>

<ROUTINE PRE-WATER ()
	 <COND (,PRSI
		<COND (<PRSI? ,PORTABLE-WATER>
		       <RFALSE>)
		      (<AND <PRSI? ,BUCKET>
			    <IN? ,PORTABLE-WATER ,BUCKET>>
		       <SETG PRSI ,PORTABLE-WATER>
		       <RFALSE>)
		      (T
		       <TELL
"As the word implies, you can only water" A ,PRSO " with water." CR>)>)
	       (T
		<COND (<ULTIMATELY-IN? ,PORTABLE-WATER>
		       <SETG PRSI ,PORTABLE-WATER>
		       <RFALSE>)
		      (T
		       <TELL
"You don't have any water to water" T ,PRSO " with!" CR>)>)>>

<ROUTINE V-WATER ()
	 <TELL "A nice thought, but" T ,PRSO " doesn't need watering." CR>>

; <ROUTINE V-WAVE-AT ()
	 <NOT-LIKELY ,PRSO "will respond to your friendly gesture">>

<ROUTINE V-WAVE-AT ()
	 <V-ASK-FOR>>

; <ROUTINE V-WAVE ()
	 <HACK-HACK "Waving">>

<ROUTINE V-WEAR ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<TELL "You're already wearing" TR ,PRSO>)
	       (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL ,YOU-CANT "wear" AR ,PRSO>)
	       (<DONT-HAVE? ,PRSO>
		<RTRUE>)
	       (T
		<FSET ,PRSO ,WORNBIT>
		<COND (<PRSO? ,TOUPEE>
		       <TELL
"You put on " D ,TOUPEE " in an attempt to cover that Burbank bald
spot." CR>)
		      (<PRSO? ,MASK>
		       <TELL
"You slip on" T ,MASK " and feel an unexplainable urge to go to
summer camp." CR>)
		      (T
		       <TELL ,OKAY "you're now wearing" TR ,PRSO>)>)>>

; "Return total weight of objects in THING"

<ROUTINE WEIGHT (THING "AUX" OBJ (WT 0))
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (.OBJ
			<COND (<AND <EQUAL? .THING ,PLAYER>
				    <FSET? .OBJ ,WORNBIT>>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .OBJ>>>)>
			<SET OBJ <NEXT? .OBJ>>)
		       (T
			<RETURN>)>>
	 <SET WT <+ .WT <GETP .THING ,P?SIZE>>>
	 <RETURN .WT>>

;<ROUTINE V-WHAT ("AUX" ACTOR)
	 <COND (<SPEAKING-TO-SOMEONE-ABOUT? ,PRSO>
		<RTRUE>)
	       (T
		<Q-CHASTISE>)>>

; <ROUTINE V-WHAT-ABOUT ("AUX" ACTOR)
	 <COND (<SPEAKING-TO-SOMEONE-ABOUT? ,PRSO>
		<RTRUE>)
	       (T
		<TELL "(Well, what about it?)" CR>)>>

; <ROUTINE V-WHERE ()
	 <V-FIND T>>

; <ROUTINE V-WHO ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL ,I-ASSUME " WHAT is" T ,PRSO ".)" CR>)>
	 <PERFORM ,V?WHAT ,PRSO>
	 <RTRUE>>

; <ROUTINE V-WHY ("AUX" ACTOR)
	 <COND (<SPEAKING-TO-SOMEONE-ABOUT? ,PRSO>
		<RTRUE>)>
	 <TELL "(">
	 <COND (<PROB 50>
		<TELL "Why not?">)
	       (T
		<TELL "Because.">)>
	 <TELL ")">
	 <CRLF>>

; <ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	 #DECL ((OBJ) OBJECT (WORD SYNS) TABLE)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-YELL ()
	 <PCLEAR>
	 <COND (<ANYONE-HERE?>
		<WAY-TO-TALK>
		<RFATAL>)
	       (T
		<TELL "You begin to get a sore throat." CR>)>>

<GLOBAL YES-INBUF <ITABLE BYTE 12>>
<GLOBAL YES-LEXV  <ITABLE BYTE 10>>

<ROUTINE YES? ("AUX" WORD)
	 <CRLF>
	 <REPEAT ()
		 <TELL CR "(Please type YES or NO.) >">
	         <PUTB ,YES-LEXV 0 4>
		 <READ ,YES-INBUF ,YES-LEXV>
	         <SET WORD <GET ,YES-LEXV ,P-LEXSTART>>
	         <COND (<ZERO? <GETB ,YES-LEXV ,P-LEXWORDS>>
		        T)
	               (<NOT <ZERO? .WORD>>
			<COND (<OR <EQUAL? .WORD ,W?YES ,W?Y ,W?YUP>
				   <EQUAL? .WORD ,W?OKAY ,W?OK ,W?AYE>
				   <EQUAL? .WORD ,W?SURE ,W?AFFIRM ,W?POSITI>>
		               <RTRUE>)
	                      (<OR <EQUAL? .WORD ,W?NO ,W?N ,W?NOPE>
				   <EQUAL? .WORD ,W?NAY ,W?NAW ,W?NEGATIVE>>
		               <RFALSE>)>)>>>

<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE WASTE-OF-TIME ()
	 <TELL <PICK-ONE ,USELESSNESS> "." CR>>

<GLOBAL USELESSNESS
	<LTABLE 0
         "That's not in the script"
	 "That would be a waste of time"
	 "That would be a pointless thing to do"
	 "That would be useless effort">>

;<ROUTINE WASTE-OF-TIME ()
	 <TELL "That would be a " <PICK-ONE ,USELESSNESS> "." CR>>

;<GLOBAL USELESSNESS
	<LTABLE 0
         "waste of time"
	 "useless effort"
	 "pointless thing to do">>

"never called"

;<ROUTINE 2OBJS? ()
	 <COND (<NOT <EQUAL? <GET ,P-PRSO 0> 2>>
		<PUT ,P-PRSO 0 1>
		<TELL "That sentence doesn't make sense." CR>
		<RFALSE>)
	       (T
		<RTRUE>)>>