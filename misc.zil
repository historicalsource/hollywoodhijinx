"MISC for ANTHILL (C)1986 Infocom Inc. All Rights Reserved."

<SETG C-ENABLED? 0>

<SETG C-ENABLED 1>

<SETG C-DISABLED 0>

<TELL-TOKENS (CRLF CR)  <CRLF>
	     D *	<DPRINT .X>
	     A *	<APRINT .X>
	     T *	<TPRINT .X>
	     AR *	<ARPRINT .X>
	     TR *	<TRPRINT .X>
	     N *	<PRINTN .X>
	     C *        <PRINTC .X>>

;<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM DPRINT .O>>)
					      (<=? <SET P <SPNAME .E>> "A">
					       <MAPRET <FORM APRINT .O>>)
					      (<=? <SET P <SPNAME .E>> "T">
					       <MAPRET <FORM TPRINT .O>>)
					      (<=? <SET P <SPNAME .E>> "AR">
					       <MAPRET <FORM ARPRINT .O>>)
					      (<=? <SET P <SPNAME .E>> "TR">
					       <MAPRET <FORM TRPRINT .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE <COND (<==? .X PRSA>
						    <PARSE
						     <STRING "V?"
							     <SPNAME .ATM>>>)
						   (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST!- .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST!- <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

; <DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

"a bunch of plus-mode stuff"
<DEFMAC GET-REXIT-ROOM ('PT)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .PT ',REXIT>)
	      (T <FORM GETB .PT ',REXIT>)>>

<DEFMAC GET-DOOR-OBJ ('PT)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .PT ',DEXITOBJ>)
	      (T <FORM GETB .PT ',DEXITOBJ>)>>

<DEFMAC GET/B ('TBL 'PTR)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .TBL .PTR>)
	      (T <FORM GETB .TBL .PTR>)>>

<DEFMAC RMGL-SIZE ('TBL)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>)
	      (T <FORM - <FORM PTSIZE .TBL> 1>)>>

;<DEFMAC IN/LOC ('LOC)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <LIST LOC .LOC>)
	      (T
	       <LIST IN .LOC>)>>

<ROUTINE APRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL " an ">)
	       (T
		<TELL " a ">)>
	 <DPRINT .OBJ>>

<ROUTINE TPRINT (OBJ)
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<TELL " ">)
	       (T
		<TELL " the ">)>
	 <DPRINT .OBJ>>

<ROUTINE ARPRINT (OBJ)
	 <APRINT .OBJ>
	 <TELL "." CR>>

<ROUTINE TRPRINT (OBJ)
	 <TPRINT .OBJ>
	 <TELL "." CR>>

<ROUTINE DPRINT (OBJ)
	 <COND (<GETP .OBJ ,P?SDESC>
		<TELL <GETP .OBJ ,P?SDESC>>)
	       (T
		<PRINTD .OBJ>)>>

<DEFINE PSEUDO ("TUPLE" V)
	<MAPF ,PLTABLE
	      <FUNCTION (OBJ)
		   <COND (<N==? <LENGTH .OBJ> 3>
			  <ERROR BAD-THING .OBJ>)>
		   <MAPRET <COND (<NTH .OBJ 2>
				  <VOC <SPNAME <NTH .OBJ 2>> NOUN>)>
			   <COND (<NTH .OBJ 1>
				  <VOC <SPNAME <NTH .OBJ 1>> ADJECTIVE>)>
			   <3 .OBJ>>>
	      .V>>

<ROUTINE ULTIMATELY-IN? (OBJ "OPTIONAL" (C <>)) ;"formerly HELD?"
	 <COND (<NOT .C>
		<SET C ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .C>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<ULTIMATELY-IN? <LOC .OBJ> .C>)>>

"*** ZCODE STARTS HERE ***"

"NOTE: This object MUST be the FIRST one defined (for MOBY-FIND)!"

<OBJECT DUMMY-OBJECT>

<ZSTART GO>

<ROUTINE GO () 
	 %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		 '<PROG ()
			<INIT-STATUS-LINE>
			<SETG LIT T>>)
		(T '<SETG LIT T>)>
	 <SETG WINNER ,PLAYER>
	 <COND (<OR <AND <EQUAL? <GETB 0 56> ,P-PLAYER>
		         <EQUAL? <GETB 0 57> ,P-WINNER>>
		    <AND <EQUAL? <GETB 0 56> 84>
			 <EQUAL? <GETB 0 57> 79>
			 <EQUAL? <GETB 0 58> 77>
			 <EQUAL? <GETB 0 59> 65>
			 <EQUAL? <GETB 0 60> 83>>>
		<SETG P-VMERGE ,PLAYER>)>
	%<COND (<GASSIGNED? ZILCH>
               '<QUEUE I-SANDS-OF-TIME 599>) ;"ZIP"
	       (T
	       '<QUEUE I-SANDS-OF-TIME 600>)> ;"ZIL"
;"setting globals here because of compilier weirdness"
        ;<SETG BUCK-TURNS 3>
	;<SETG BUCK-WON 3>
	 %<COND (<GASSIGNED? ZILCH>
               '<QUEUE I-SUNRISE 547>) ;"ZIP"
	       (T
	       '<QUEUE I-SUNRISE 548>)> ;"ZIL"
	 <SETG P-NMERGE ,P-DEBUG>
	 <SETG WHICH-END-IS-UP ,RIGHT-END>
         <SETG CLOSET-FLOOR ,FOYER>
        ;<SETG POINT> ;"a piece of something, what I don't know"
         <MOVE ,PLAYER ,SOUTH-JUNCTION>
	 <SETG HERE ,SOUTH-JUNCTION>
        ;<QUEUE I-LIGHTS-DIM 50>
	;<QUEUE I-ARMOR-MOVE 30>
         <QUEUE I-NOISE 10>
         <RESET-THEM>
        ;<QUEUE I-PROMPT 1>
	 <TELL
"As night falls the black limousine turns off the highway. It has all
happened so fast, you think to yourself. Your Aunt passing away without
any warning, the funeral this afternoon, and now this unusual
stipulation in her will. The limo pulls up to the front of the house.
\"This is the end of the line,\" says the attorney, and you step out of
the back of the limo. \"Remember, your Aunt Hildegarde's will stated you
will inherit her entire fortune -- if you can find the ten 'treasures'
in one night.\"~
~
He hands you a photo of Uncle Buddy and a letter, saying, \"Her will
instructed that I give you this photo, with the poem, to point you in the
right direction. Also this letter, and here, you'll need this.\" He gives
you a flashlight. \"Meet me at 9 a.m. in the living room with all the
'treasures' and you'll inherit her entire estate,\" he says as the limo
pulls away and disappears into the night's darkness." CR>
	;<TELL
"As night falls the black limousine turns off the highway. \"And of course
most people say the old place is haunted,\" he adds. Until now you were
only half listening, your thoughts clouded after hearing the unusual
stipulation of her will. But the word \"haunted\" clears your head,
commanding full attention. The limo pulls up to the front of the house.
\"This is the end of the line,\" says the attorney, and you step out of
the back of the limo. \"Remember, your Aunt Hildegarde's will stated you
will inherit her entire fortune -- if you can find the ten 'treasures'
in one night.\"~
~
He hands you a photo of Uncle Buddy and a letter, saying \"Her will
instructed I give you this photo, with the poem, to point you in the
right direction. Also this letter, and here you'll need this.\" He gives
you a flashlight. \"Meet me at 9 a.m. in the living room with all the
'treasures' and you'll inherit her entire estate,\" he says as the limo
pulls away and disappears into the night's darkness." CR>	 
         <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <DO-MAIN-LOOP>
	 <AGAIN>>

<ROUTINE RESET-THEM ()
	 <PCLEAR>
         <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
         <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
         <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>>

<ROUTINE PCLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

;<ZSTART GO> ;"so ZIL won't get confused between word GO and routine GO"

<ROUTINE DO-MAIN-LOOP ("AUX" X)
	 <REPEAT ()
		 <SET X <MAIN-LOOP>>>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP X)
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<NOT <EQUAL? ,QCONTEXT-ROOM ,HERE>>
	    <SETG QCONTEXT <>>)>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT
			<ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<ZERO? .OCNT>
			.OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT>
			       <SET OBJ <>>)
			      (T
			       <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T
			1)>>
	    <COND (<AND <NOT .OBJ>
			<1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<EQUAL? ,PRSA ,V?WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<ZERO? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <PCLEAR>
			  <TOO-DARK>)
			 (T
			  <PCLEAR>
			  <TELL "[There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<VERB? TELL>
				 <TELL "talk to">)
				(<OR ,P-MERGED ,P-OFLAG>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <SET V <WORD-PRINT <GETB .TMP 2>
						    <GETB .TMP 3>>>)>
			  <TELL "!]" CR>
			  <SET V <>>)>)
		; (<AND .PTBL <G? .NUM 1> <VERB? COMPARE>>
		   <SET V <PERFORM ,PRSA ,OBJECT-PAIR>>)
		  (T
		   <SET X 0>
		   ;"<SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>"
		   <SET TMP <>>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			   <COND (<G? .X 0>
				  <TELL "[The ">
				  <COND (<NOT <EQUAL? .X .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here!]" CR>)
				 (<NOT .TMP>
				  <REFERRING>)>
			   <RETURN>)
			  (T
			   <COND (.PTBL
				  <SET OBJ1 <GET ,P-PRSO .CNT>>)
				 (T
				  <SET OBJ1 <GET ,P-PRSI .CNT>>)>
	<COND (<OR <G? .NUM 1>
		   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL ,W?EVERYTHING>>
	       <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		      <SET X <+ .X 1>>
		      <AGAIN>)
		   
		     (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <DONT-ALL? .OBJ1 .OBJ>>
		      <AGAIN>)

		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB-ALL-TEST .OBJ1 .OBJ>>
		      <AGAIN>)
		   
		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB? TAKE>
		           <OR <AND <NOT <EQUAL? <LOC .OBJ1> ,WINNER ,HERE>>
				    <NOT <FSET? <LOC .OBJ1> ,SURFACEBIT>>>
			       <NOT <OR <FSET? .OBJ1 ,TAKEBIT>
				        <FSET? .OBJ1 ,TRYTAKEBIT>>>>>
		      <AGAIN>)
		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB? DROP PUT GIVE PUT-ON PUT-UNDER
				  PUT-BEHIND THROW>
			   <NOT <IN? .OBJ1 ,WINNER>>
			   <NOT <IN? ,P-IT-OBJECT ,WINNER>>>
		      <AGAIN>)
		     
		     (<NOT <ACCESSIBLE? .OBJ1>>
		      <AGAIN>)
		     (<EQUAL? .OBJ1 ,PLAYER ; ,POCKET>
		      <AGAIN>)
		     (T
		      <COND (<EQUAL? .OBJ1 ,IT>
			     <COND (<NOT <FSET? ,P-IT-OBJECT ,NARTICLEBIT>>
				    <TELL "The ">)>
			     <DPRINT ,P-IT-OBJECT>)
			    (T
			     <COND (<NOT <FSET? .OBJ1 ,NARTICLEBIT>>
				    <TELL "The ">)>
			     <DPRINT .OBJ1>)>
		      <TELL ": ">)>)>
			   <SET TMP T>
			   <SET V <QCONTEXT-CHECK <COND (.PTBL
							 .OBJ1)
							(T
							 .OBJ)>>>
			   <SETG PRSO <COND (.PTBL
					     .OBJ1)
					    (T
					     .OBJ)>>
			   <SETG PRSI <COND (.PTBL
					     .OBJ)
					    (T
					     .OBJ1)>>
		   <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
		   <COND (<EQUAL? .V ,M-FATAL>
			  <RETURN>)>)>>)>
	    ;<COND (<NOT <EQUAL? .V ,M-FATAL>>
		   <COND (<GAME-VERB?>
			  T)
			 (T
			  <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					,M-END>>)>)>
	    ;<COND (<GAME-VERB?>
		   T)
		  (<VERB? AGAIN>
		   T)
		  (,P-OFLAG
		   T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<GAME-VERB?>
		   T)
		  ;(<AND <VERB? AGAIN>
			<GAME-VERB? ,L-PRSA>>
		   T)
		  (T
		   <SET V <CLOCKER>>)>)>
     <SETG PRSA <>>
     <SETG PRSO <>>
     <SETG PRSI <>>>

<ROUTINE DONT-ALL? (O I "AUX" L)
	 <SET L <LOC .O>>
	 <COND (<EQUAL? .O .I>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<AND .I <NOT <ULTIMATELY-IN? .O .I>>>
		       <RTRUE>)
		      (<AND <NOT .I> <ULTIMATELY-IN? .O>>
		       <RTRUE>)
		      (<AND <NOT <FSET? .O ,TAKEBIT>>
			    <NOT <FSET? .O ,TRYTAKEBIT>>>
		       <RTRUE>)
		      (.I
		       <COND (<NOT <EQUAL? .L .I>>
			      <RTRUE>)
			     (<SEE-INSIDE? .I>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (<EQUAL? <META-LOC .O> ,PLAYER>
		       <RFALSE>)
		      (<EQUAL? .L ,HERE>
		       <RFALSE>)
		      (<FSET? .L ,SURFACEBIT>
		       <RFALSE>)
		      (<FSET? .L ,ACTORBIT>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<VERB? DROP PUT PUT-ON THROW>
		<COND (<NOT <FSET? .O ,TAKEBIT>>
		       <RTRUE>)
		      (<EQUAL? .L ,PLAYER ,WINNER>
		       <RFALSE>)
		      ;(<AND .L
			    <EQUAL? <LOC .L> ,PLAYER ,WINNER>>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (T
		<RFALSE>)>>

; <ROUTINE ENABLED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-ENABLED?>> <RFALSE>)
			      (T <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

; <ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-ENABLED?>>
				   <ZERO? <GET .C ,C-TICK>>>
			       <RFALSE>)
			      (T <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE GAME-VERB? ("OPTIONAL" (V <>))
	<COND (<NOT .V>
	       <SET V ,PRSA>)>
	<COND (<OR <EQUAL? .V ,V?BRIEF ,V?SCORE ,V?VERBOSE>
	           <EQUAL? .V ,V?QUIT ,V?RESTART ,V?RESTORE>
	           <EQUAL? .V ,V?SAVE ,V?SCRIPT ,V?SUPER-BRIEF>
	           <EQUAL? .V ,V?TELL ,V?UNSCRIPT ,V?VERSION>
		   <EQUAL? .V ,V?TIME ; ,V?INVENTORY>>
	       <RTRUE>)
	      (T
	       <RFALSE>)>>

<ROUTINE QCONTEXT-CHECK (PRSO "AUX" OTHER (WHO <>) (N 0))
	 <COND (<OR <VERB? HELP ; FIND ; WHAT>
		    <AND <VERB? TELL ;SHOW>
			 <==? .PRSO ,PLAYER>>> ;"? more?"
		<SET OTHER <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<NOT .OTHER>
			       <RETURN>)
			      (<AND <FSET? .OTHER ,ACTORBIT>
				  ; <NOT <FSET? .OTHER ,INVISIBLE>>
				    <NOT <==? .OTHER ,PLAYER>>>
			       <SET N <+ 1 .N>>
			       <SET WHO .OTHER>)>
			<SET OTHER <NEXT? .OTHER>>>
		<COND (<AND <==? 1 .N>
			    <NOT ,QCONTEXT>>
		       <SAID-TO .WHO>)>
		<COND (<AND <QCONTEXT-GOOD?>
			    <==? ,WINNER ,PLAYER>> ;"? more?"
		       ;<SETG L-WINNER ,WINNER>
		       <SETG WINNER ,QCONTEXT>
		     ; <TELL "[said to" D ,QCONTEXT "]" CR>
		       <SPOKEN-TO ,QCONTEXT>)>)>>

<ROUTINE SAID-TO (WHO)
	<SETG QCONTEXT .WHO>
	<SETG QCONTEXT-ROOM <LOC .WHO>>>

<ROUTINE SPOKEN-TO (WHO)
         <PCLEAR>
	 <TELL "[spoken to" T .WHO "]" CR>>

<ROUTINE QCONTEXT-GOOD? ()
         <COND (<AND <NOT <ZERO? ,QCONTEXT>>
	             <FSET? ,QCONTEXT ,ACTORBIT>
	           ; <NOT <FSET? ,QCONTEXT ,INVISIBLE>>
	             <==? ,HERE ,QCONTEXT-ROOM>
	             <==? ,HERE <META-LOC ,QCONTEXT>>>
	        <RTRUE>)>>

<ROUTINE ACCESSIBLE? (OBJ)
         <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? <META-LOC .OBJ> ,WINNER ,HERE ,GLOBAL-OBJECTS>
	        <RTRUE>)
	       (<VISIBLE? .OBJ>
	        <RTRUE>)
	       (T 
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L)
         <SET L <LOC .OBJ>>
	 <COND (<NOT .L> 
		<RFALSE>)
               (<FSET? .OBJ ,INVISIBLE>
	        <RFALSE>)
               (<EQUAL? .L ,GLOBAL-OBJECTS>
	        <RFALSE>)
               (<EQUAL? .L ,PLAYER ,HERE ,WINNER>
	        <RTRUE>)
               (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
               (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <RTRUE>)
               (T
	        <RFALSE>)>>

<ROUTINE SEE-INSIDE? (CONTAINER)
	 <COND (,P-MOBY-FLAG
		<RTRUE>)
	       (<FSET? .CONTAINER ,SURFACEBIT>
		<RTRUE>)
	       (<FSET? .CONTAINER ,CONTBIT>
		<COND (<OR <FSET? .CONTAINER ,OPENBIT>
		           <FSET? .CONTAINER ,TRANSBIT>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <FSET? .CONTAINER ,ACTORBIT>
		     <NOT <EQUAL? .CONTAINER ,PLAYER>>>
		<RTRUE>)
	       (T
	    	<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)
		       (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       ;(<FSET? .OBJ ,INVISIBLE>
			<RFALSE>) ;"PDL SAID NO WAY"
		       (T
			<SET OBJ <LOC .OBJ>>)>>>


;"------ New Clock Stuff from Spellbreaker ------"

;"former CLOCK.ZIL stuff"

<GLOBAL CLOCK-WAIT <>>

<GLOBAL C-TABLE %<COND (<GASSIGNED? ZILCH>
			'<ITABLE NONE 26>)
		       (T
			'<ITABLE NONE 52>)>>

<CONSTANT C-TABLELEN 52>
<GLOBAL C-INTS 52>
;<DEBUG-CODE <GLOBAL C-MAXINTS 52>>

<CONSTANT C-INTLEN 4>	;"length of an interrupt entry"
<CONSTANT C-RTN 0>	;"offset of routine name"
<CONSTANT C-TICK 1>	;"offset of count"

<ROUTINE DEQUEUE (RTN)
	 <COND (<SET RTN <QUEUED? .RTN>>
		<PUT .RTN ,C-RTN 0>)>>

"this version of QUEUE automatically enables as well"

<ROUTINE QUEUE (RTN TICK "AUX" C E (INT <>))
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<COND (.INT
			       <SET C .INT>)
			      (ELSE
			       ;<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-INTLEN>
					<TELL
					  "[**Too many interrupts!**]" CR>)>>
			       <SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			       ;<DEBUG-CODE
				 <COND (<L? ,C-INTS ,C-MAXINTS>
					<SETG C-MAXINTS ,C-INTS>)>>
			       <SET INT <REST ,C-TABLE ,C-INTS>>)>
			<PUT .INT ,C-RTN .RTN>
			<RETURN>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<SET INT .C>
			<RETURN>)
		       (<ZERO? <GET .C ,C-RTN>>
			<SET INT .C>)>
		 <SET C <REST .C ,C-INTLEN>>>
	 <COND (%<COND (<GASSIGNED? ZILCH>
			'<G? .INT ,CLOCK-HAND>)
		       (ELSE
			'<L? <LENGTH .INT> <LENGTH ,CLOCK-HAND>>)>
		<SET TICK <- <+ .TICK 3>>>)>
	 <PUT .INT ,C-TICK .TICK>
	 .INT>

<ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-TICK>>
			       <RFALSE>)
			      (T <RETURN .C>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<GLOBAL CLOCK-HAND <>>

<ROUTINE CLOCKER ("AUX" E TICK RTN (FLG <>) (Q? <>) OWINNER)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SETG CLOCK-HAND <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET OWINNER ,WINNER>
	 <SETG WINNER ,PLAYER>
	 <REPEAT ()
		 <COND (<EQUAL? ,CLOCK-HAND .E>
			<SETG MOVES <+ ,MOVES 1>>
			<SETG WINNER .OWINNER>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET ,CLOCK-HAND ,C-RTN>>>
			<SET TICK <GET ,CLOCK-HAND ,C-TICK>>
			<COND (<L? .TICK -1>
			       <PUT ,CLOCK-HAND ,C-TICK <- <- .TICK> 3>>
			       <SET Q? ,CLOCK-HAND>)
			      (<NOT <ZERO? .TICK>>
			       <COND (<G? .TICK 0>
				      <SET TICK <- .TICK 1>>
				      <PUT ,CLOCK-HAND ,C-TICK .TICK>)>
			       <COND (<NOT <ZERO? .TICK>>
				      <SET Q? ,CLOCK-HAND>)>
			       <COND (<NOT <G? .TICK 0>>
				      <SET RTN
					   %<COND (<GASSIGNED? ZILCH>
						   '<GET ,CLOCK-HAND ,C-RTN>)
						  (ELSE
						   '<NTH ,CLOCK-HAND
							 <+ <* ,C-RTN 2>
							    1>>)>>
				      <COND (<ZERO? .TICK>
					     <PUT ,CLOCK-HAND ,C-RTN 0>)>
				      <COND (%<COND
					      ;(,ZDEBUGGING?
						'<II-APPLY "Int" .RTN>)
					       (ELSE
						'<APPLY .RTN>)>
					     <SET FLG T>)>
				      <COND (<AND <NOT .Q?>
						  <NOT
						   <ZERO?
						    <GET ,CLOCK-HAND
							 ,C-RTN>>>>
					     <SET Q? T>)>)>)>)>
		 <SETG CLOCK-HAND <REST ,CLOCK-HAND ,C-INTLEN>>
		 <COND (<NOT .Q?>
			<SETG C-INTS <+ ,C-INTS ,C-INTLEN>>)>>>



"-------- Old clocker stuff ------"

;<CONSTANT C-TABLELEN 330>

;"already semied" ; <GLOBAL C-TABLE <ITABLE NONE 300>>

;<GLOBAL C-TABLE %<COND (<GASSIGNED? PREDGEN>
			'<ITABLE NONE 165>)
		       (T
			'<ITABLE NONE 330>)>>

;<GLOBAL C-DEMONS 330>
;<GLOBAL C-INTS 330>

;<CONSTANT C-INTLEN 6>
;<CONSTANT C-ENABLED? 0>
;<CONSTANT C-TICK 1>
;<CONSTANT C-RTN 2>

;"already semied" ; <ROUTINE DEMON (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

;<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

;<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<GLOBAL CLOCK-WAIT <>>

;<ROUTINE CLOCKER ("AUX" C E I TICK (FLG <>))
	 #DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX (FLG) <OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<SETG MOVES <+ ,MOVES 1>>
	                <COND (<G? ,MOVES 59>
		               <SETG MOVES 0>
		               <SETG SCORE <+ ,SCORE 1>>
		               <COND (<G? ,SCORE 23>
		                      <SETG SCORE 0>)>)>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<ZERO? .TICK>)
			      (T
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
					   <APPLY <GET .C ,C-RTN>>>
				      <SET FLG T>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

; <ROUTINE MACINTOSH? ("AUX" MODE)
	 <SET MODE <GETB 0 1>>
	 <COND (<OR <ZERO? <BAND .MODE 32>>
	            <NOT <ZERO? <BAND .MODE 64>>>>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE CARRIAGE-RETURNS ("AUX" (CNT 22))
	 <RESET-THEM>
	 <REPEAT ()
		 <CRLF>
	         <SET CNT <- .CNT 1>>
		 <COND (<ZERO? .CNT>
			<RTRUE>)>>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 2) (T 1)>>
<CONSTANT NEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 3) (T 2)>>
<CONSTANT FEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 4) (T 3)>>
<CONSTANT CEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 5) (T 4)>>
<CONSTANT DEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 6) (T 5)>>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 4) (T 1)>>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 2) (T 1)>>

<ROUTINE FIXED-FONT-ON ()
	 <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF ()
	 <PUT 0 8 <BAND <GET 0 8> -3>>>

<CONSTANT P-PLAYER 68> ;"Char D"
<CONSTANT P-WINNER 65> ;"Char A"

<ASCII 84> ;"Char T"
<ASCII 79> ;"Char O"
<ASCII 77> ;"Char M"
<ASCII 65> ;"Char A"
<ASCII 83> ;"Char S"



<DEFMAC ZIL? ()
	<FORM ZERO? '<GETB 0 18>>>