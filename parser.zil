"PARSER for ANTHILL (C)1986 Infocom Inc. All rights reserved."

<SETG SIBREAKS ".,\"!?">

;<GLOBAL GWIM-DISABLE <>> 

<GLOBAL PRSA 0>
<GLOBAL PRSI 0>
<GLOBAL PRSO 0>
<GLOBAL P-TABLE 0>  
;<GLOBAL P-ONEOBJ 0> 
<GLOBAL P-SYNTAX 0> 
<GLOBAL P-LEN 0>    
;<GLOBAL P-DIR 0>
<GLOBAL LAST-PLAYER-LOC 0>
<GLOBAL WINNER 0>   
<GLOBAL P-LEXV <ITABLE BYTE 120>>

<GLOBAL QCONTEXT <>>
<GLOBAL QCONTEXT-ROOM <>>
<GLOBAL LAST-PSEUDO-LOC <>>
<GLOBAL ITAKE-LOC <>>

<GLOBAL P-VMERGE <>>
<GLOBAL P-NMERGE <>>

; <GLOBAL L-HERE <>>

"INBUF - Input buffer for READ"

<GLOBAL P-INBUF <ITABLE BYTE 100>>

"Parse-cont variable"

<GLOBAL P-SENTENCE <>> ;"start of sentence"
<GLOBAL P-CONT <>>  

<GLOBAL P-IT-OBJECT <>>
<GLOBAL P-HER-OBJECT <>>
<GLOBAL P-HIM-OBJECT <>>
<GLOBAL P-THEM-OBJECT <>>

"Orphan flag"

<GLOBAL P-OFLAG <>> 

<GLOBAL P-MERGED <>>
<GLOBAL P-ACLAUSE <>>    
<GLOBAL P-ANAM <>>  
<GLOBAL P-AADJ <>>

"Parser variables and temporaries"

;<CONSTANT P-PHRLEN 3>
;<CONSTANT P-ORPHLEN 7>
;<CONSTANT P-RTLEN 3>

"Byte offset to # of entries in LEXV"

<CONSTANT P-LEXWORDS 1>

"Word offset to start of LEXV entries"

<CONSTANT P-LEXSTART 1>

"Number of words per LEXV entry"

<CONSTANT P-LEXELEN 2>   
<CONSTANT P-WORDLEN 4>

"Offset to parts of speech byte"

<CONSTANT P-PSOFF %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 6) (T 4)>>

"Offset to first part of speech"

<CONSTANT P-P1OFF %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 7) (T 5)>>

"First part of speech bit mask in PSOFF byte"

<CONSTANT P-P1BITS 3>    
<CONSTANT P-ITBLLEN 9>   

<GLOBAL P-ITBL <TABLE 0 0 0 0 0 0 0 0 0 0>>  
<GLOBAL P-OTBL <TABLE 0 0 0 0 0 0 0 0 0 0>>  
<GLOBAL P-VTBL <TABLE 0 0 0 0>>
<GLOBAL P-OVTBL <TABLE 0 0 0 0>>
<GLOBAL P-NCN 0>    

<CONSTANT P-VERB 0> 
<CONSTANT P-VERBN 1>
<CONSTANT P-PREP1 2>
<CONSTANT P-PREP1N 3>    
<CONSTANT P-PREP2 4>

;<CONSTANT P-PREP2N 5>    

<CONSTANT P-NC1 6>  
<CONSTANT P-NC1L 7> 
<CONSTANT P-NC2 8>  
<CONSTANT P-NC2L 9> 

<GLOBAL QUOTE-FLAG <>>
<GLOBAL P-ADVERB <>>

;<GLOBAL P-WHAT-IGNORED <>>

<GLOBAL P-WON <>>
<CONSTANT M-FATAL 2>

;<CONSTANT M-HANDLED 1>   
;<CONSTANT M-NOT-HANDLED <>>   

<CONSTANT M-BEG 1>  
<CONSTANT M-ENTER 2>
<CONSTANT M-LOOK 3> 
<CONSTANT M-EXIT 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6> 
<CONSTANT M-CONT 7>

<GLOBAL P-WALK-DIR <>>
<GLOBAL P-END-ON-PREP <>>

<GLOBAL AGAIN-LEXV <ITABLE BYTE 120>>
<GLOBAL RESERVE-LEXV <ITABLE BYTE 120>>
<GLOBAL RESERVE-PTR <>>

<GLOBAL P-PRSA-WORD <>>

<GLOBAL OOPS-INBUF <ITABLE BYTE 60>>
<GLOBAL OOPS-TABLE <TABLE <> <> <> <>>>
<CONSTANT O-PTR 0>
<CONSTANT O-START 1>
<CONSTANT O-LENGTH 2>
<CONSTANT O-END 3>

" Grovel down the input finding the verb, prepositions, and noun clauses.
   If the input is <direction> or <walk> <direction>, fall out immediately
   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform
   all required orphaning, syntax checking, and noun clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>)
		       LEN (DIR <>) (NW 0) (LW 0) (CNT -1) OWINNER
		       OMERGED (TEMP 0))
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN> <RETURN>)
		      (T
		       <COND (<NOT ,P-OFLAG>
			      <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>
		       <PUT ,P-ITBL .CNT 0>)>>
	<SET OMERGED ,P-MERGED>
	<SETG P-MERGED <>>
	<SETG P-END-ON-PREP <>>
	;<SETG P-WHAT-IGNORED <>>
	<PUT ,P-PRSO ,P-MATCHLEN 0>
	<PUT ,P-PRSI ,P-MATCHLEN 0>
	<PUT ,P-BUTS ,P-MATCHLEN 0>
	<SET OWINNER ,WINNER>
	<COND (<ZERO? ,P-OFLAG>
	       <SETG P-PRSA-WORD <>>)> ;"CLEAR P-ADJW & P-NAMW IN THIS COND"
	<COND (<AND <NOT ,QUOTE-FLAG>
		    <N==? ,WINNER ,PLAYER>>
	       ;<SETG L-WINNER ,WINNER>
	       <SETG WINNER ,PLAYER>
	       <SETG LAST-PLAYER-LOC ,HERE>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG LAST-PLAYER-LOC ,HERE>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>)>
	<COND (,RESERVE-PTR
	       <SET PTR ,RESERVE-PTR>
	       <STUFF ,P-LEXV ,RESERVE-LEXV>
	       <COND (<AND <NOT <EQUAL? ,VERBOSITY 0>>
			   <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	      ;<COND (<AND <EQUAL? ,VERBOSITY 1 2>
			   <==? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG RESERVE-PTR <>>
	       <SETG P-CONT <>>)
	      (,P-CONT
	       <SET PTR ,P-CONT>
	       <SETG P-CONT <>>
	       <COND (,SAYING?
		      <SETG SAYING? <>>)
		     (<AND <NOT <EQUAL? ,VERBOSITY 0>>
			   <==? ,PLAYER ,WINNER>>
		      <CRLF>)>
	     ; <COND (<NOT <VERB? ASK TELL SAY>>
		      <CRLF>)>)
	      (T
	       <SETG SAYING? <>>
	       ;<SETG L-WINNER ,WINNER>
	       <SETG WINNER ,PLAYER>
	       <SETG QUOTE-FLAG <>>
	       <SETG LAST-PLAYER-LOC ,HERE>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG LAST-PLAYER-LOC ,HERE>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>
	       <COND (<NOT <EQUAL? ,VERBOSITY 0>>
		      <CRLF>)>
	     ; <COND (<AND ,P-PROMPT
			   <NOT ,P-OFLAG>>
		      <COND (<EQUAL? ,P-PROMPT ,P-PROMPT-START>
			     <TELL ,OKAY "what do you want to do now?">)
			    (<DLESS? P-PROMPT 1>
			     <TELL
"(You won't see \"What next?\" any more.)~
">)
			    (T
			     <TELL "What next?">)>
		      <CRLF>)>
	       <PUTB ,P-LEXV 0 59>
	       %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		       '<PROG ()
			      <USL>
			      <TELL ">">>)
		      (T
		       '<TELL ">">)>
	       <READ ,P-INBUF ,P-LEXV>
	     ; <SET OLEN <GETB ,P-LEXV ,P-LEXWORDS>>)>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	<COND (<AND <==? ,W?QUOTE <GET ,P-LEXV .PTR>>
		    <QCONTEXT-GOOD?>>		;"Is quote first input token?"
	       <SET PTR <+ .PTR ,P-LEXELEN>>	;"If so, ignore it."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<COND (<==? ,W?THEN <GET ,P-LEXV .PTR>>	;"Is THEN first input word?"
	       <SET PTR <+ .PTR ,P-LEXELEN>>	;"If so, ignore it."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<COND (<AND <L? 1 ,P-LEN>
		    <==? ,W?GO <GET ,P-LEXV .PTR>> ;"Is GO first input word?"
		    <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		    <WT? .NW ,PS?VERB ;,P1?VERB>   ;" followed by verb?">
	       <SET PTR <+ .PTR ,P-LEXELEN>>	;"If so, ignore it."
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN>
	       <TELL "[Beg pardon?]" CR>
	       <RFALSE>)
	      (<EQUAL? <GET ,P-LEXV .PTR> ,W?OOPS>
	       <COND (<NOT <G? ,P-LEN 1>>
		      <TELL "[You can't use OOPS that way.]" CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER>
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
				 <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN>3>>
		      <STUFF ,P-LEXV ,AGAIN-LEXV>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>> 
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL "[There was no word to replace!]" CR>
		      <RFALSE>)>)
	      (T <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <COND (<OR ,P-OFLAG
			  <NOT ,P-WON>>
		      <TELL "[You can't use AGAIN that way.]" CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <TELL "[I couldn't understand that sentence.]" CR>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS 
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <STUFF ,RESERVE-LEXV ,P-LEXV>
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	       ;<SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <SET CNT -1>
	       <SET DIR ,P-WALK-DIR>
	       <REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <SETG P-NUMBER -1>
	       <SETG P-NAM <>>
	       <SETG P-ADJ <>>
	       <SETG P-ADVERB <>>
	       <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       ;<SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <PUT ,P-ITBL ,P-VERBN 0>
	       <SETG P-SENTENCE .PTR>
	       <REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)
		      (<BUZZER-WORD? <SET WRD <GET ,P-LEXV .PTR>>>
		       <RFALSE>)
		      (<OR .WRD
			   <SET WRD <NUMBER? .PTR>>
			   ;<SET WRD <NAME? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <==? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ,ACT?ASK>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			      ;<SET VERB ,ACT?TELL>
			      <SET WRD ,W?QUOTE>)
			     (<AND <==? .WRD ,W?THEN>
				   <NOT .VERB>
				   <NOT ,QUOTE-FLAG>
				   <GET ,P-ITBL ,P-NC1>>
			      <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
			      <PUT ,P-ITBL ,P-VERBN 0>
			      <SET WRD ,W?QUOTE>)>
		       <COND (<AND <EQUAL? .WRD ,W?PERIOD>
				   <EQUAL? .LW  ,W?MR ,W?MISS ,W?MRS>>
			      <SET LW 0>)
			     (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE> 
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND (,QUOTE-FLAG
					    <SETG QUOTE-FLAG <>>)
					   (T
					    <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)
			     (<AND <SET VAL
					<WT? .WRD
					     ,PS?DIRECTION
					     ,P1?DIRECTION>>
				   <EQUAL? .VERB <> ,ACT?WALK ,ACT?GO>
				   <OR <==? .LEN 1>
				       <AND <==? .LEN 2>
					   <EQUAL? .VERB ,ACT?WALK ,ACT?GO>>
				       <AND <EQUAL? .NW
					            ,W?THEN ,W?PERIOD ,W?QUOTE>
					    <G? .LEN 1 ;2>>
				     ; <AND <EQUAL? .NW ,W?PERIOD>
					    <G? .LEN 1>>
				       <AND ,QUOTE-FLAG
					    <==? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <CHANGE-LEXV <+ .PTR ,P-LEXELEN>
						  ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <SET VAL <WT? .WRD ,PS?VERB ,P1?VERB>>
				   <ZERO? .VERB>
				   ;<OR <NOT .VERB>
				       <EQUAL? .VERB ,ACT?WHAT>>>
			    ; <COND (<EQUAL? .VERB ,ACT?WHAT>
				     <SETG P-WHAT-IGNORED T>)>
			      <SETG P-PRSA-WORD .WRD>
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV
						    <SET TEMP
							 <+ <* .PTR 2> 2>>>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .TEMP 1>>>)
			     (<OR <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				  <AND <OR <EQUAL? .WRD ; ,W?ONE ,W?A>
					   <EQUAL? .WRD ,W?BOTH ,W?ALL
						        ,W?EVERYTHING>
					   <WT? .WRD ,PS?ADJECTIVE>
					   <WT? .WRD ,PS?OBJECT>>
				       <SET VAL 0>>>
			      <COND (<AND <G? ,P-LEN 1> ; "1 IN RETROFIX #34"
					  <==? .NW ,W?OF>
					  <NOT <EQUAL? .VERB
						       ;,ACT?MAKE ,ACT?TAKE>>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD ; ,W?ONE ,W?A>>
					  <NOT <EQUAL? .WRD ,W?ALL ,W?BOTH
						            ,W?EVERYTHING>>>
				   ; <COND (<EQUAL? .WRD ,W?BOTTOM>
					    <SET BOTTOM T>)>
				     <SET OF-FLAG T>)
				    (<AND <NOT <ZERO? .VAL>>
				          <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<==? ,P-NCN 2>
				     <TELL
"[There are too many nouns in that sentence!]" CR>
				     <RFALSE>)
				    (T
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <OR <SET PTR <CLAUSE .PTR .VAL .WRD>>
					 <RFALSE>>
				     <COND (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)
			     ;(<==? .WRD ,W?CLOSELY>
			      <SETG P-ADVERB ,W?CAREFULLY>)
			     ;(<OR <EQUAL? .WRD
					 ,W?CAREFULLY ,W?QUIETLY ,W?PRIVATELY>
				  <EQUAL? .WRD
					  ,W?SLOWLY ,W?QUICKLY ,W?BRIEFLY>>
			      <SETG P-ADVERB .WRD>)
			     (<EQUAL? .WRD ,W?OF> ; "RETROFIX #34"
			      <COND (<OR <NOT .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <WT? .WRD ,PS?VERB ;,P1?VERB>>
			      <WAY-TO-TALK>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (.DIR
	       <SETG PRSA ,V?WALK>
	       <SETG P-WALK-DIR .DIR>
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <RTRUE>)>
	<SETG P-WALK-DIR <>>
	<COND (<AND ,P-OFLAG
		    <ORPHAN-MERGE>>
	       <SETG WINNER .OWINNER>)
	    ; (T
	       <SETG BOTTOM? .BOTTOM>)>
	<COND (<AND ,P-CONT
		    <==? <GET ,P-ITBL ,P-VERB> 0>
		    <GET ,P-ITBL ,P-NC1>>
	       <PUT ,P-ITBL ,P-VERB ,ACT?TELL>)>
	<COND (<AND <SYNTAX-CHECK>
		    <SNARF-OBJECTS>
		    <MANY-CHECK>
		    <TAKE-CHECK>>
	       T)>>

<ROUTINE CHANGE-LEXV (PTR WRD)
	 <PUT ,P-LEXV .PTR .WRD>
	 <PUT ,AGAIN-LEXV .PTR .WRD>>

<ROUTINE WAY-TO-TALK ()
	 <TELL
"[Refer to your HOLLYWOOD HIJINX manual for the correct way to talk
to characters.]" CR>>

"Check whether word pointed at by PTR is the correct part of speech.
   The second argument is the part of speech (,PS?<part of speech>).  The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."
 
<ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP) 
	<COND (<BTST <SET TYP <GETB .PTR ,P-PSOFF>> .BIT>
	       <COND (<G? .B1 4> <RTRUE>)
		     (T
		      <SET TYP <BAND .TYP ,P-P1BITS>>
		      <COND (<NOT <==? .TYP .B1>> <SET OFFS <+ .OFFS 1>>)>
		      <GETB .PTR .OFFS>)>)>>

"Scan through a noun phrase, leaving a pointer to its starting location:"

<ROUTINE CLAUSE (PTR VAL WRD
		 "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0) LEN)
	;#DECL ((PTR VAL OFF NUM) FIX (WRD NW) <OR FALSE FIX TABLE>
	       (ANDFLG FIRST??) <OR ATOM FALSE>)
	<SET OFF <* <- ,P-NCN 1> 2>>
	<COND (<AND .VAL
		    <EQUAL? <GET ,P-LEXV .PTR> ,W?RIGHT ,W?LEFT>
		    <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			    ,W?END>> ;"kludge for 'right end' etc."
	       <SET VAL 0>
	       <SETG P-LEN <+ ,P-LEN 1>>)
	      (<NOT <==? .VAL 0>>
	       <SET NUM <+ ,P-PREP1 .OFF>>
	       <PUT ,P-ITBL .NUM .VAL>
	       <PUT ,P-ITBL <+ .NUM 1> .WRD>
	       <SET PTR <+ .PTR ,P-LEXELEN>>
	       <COND (<NOT <==? .WRD ,W?TO>>
		      <SET LEN ,P-LEN>
		      <REPEAT ()
			      <SET LEN <- .LEN 1>>
			      <COND (<AND <EQUAL? <SET WRD <GET ,P-LEXV .PTR>>
						  ,W?LEFT ,W?RIGHT>
					  <G? .LEN 0>
					   ;"don't look if L/R was last!"
					  <NOT
					    <EQUAL?
					      <GET ,P-LEXV
						   <+ .PTR ,P-LEXELEN>>
					      ,W?END>>>
				     <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				     <PUT ,P-ITBL .NUM .VAL>
				     <PUT ,P-ITBL <+ .NUM 1> .WRD>)
				    (ELSE
				     <RETURN>)>
			      <SET PTR <+ .PTR ,P-LEXELEN>>>)>)
	      (T <SETG P-LEN <+ ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN> <SETG P-NCN <- ,P-NCN 1>> <RETURN -1>)>
	<PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
	       <PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>
	       <SET PTR <+ .PTR ,P-LEXELEN>>
	       <SETG P-LEN <- ,P-LEN 1>>)>
	<REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
		       <RETURN -1>)>
		<COND (<BUZZER-WORD? <SET WRD <GET ,P-LEXV .PTR>>>
		       <RFALSE>)
		      (<OR .WRD
			   <SET WRD <NUMBER? .PTR>>
			   ;<SET WRD <NAME? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       ;<COND (<AND <==? .WRD ,W?OF>
				   <EQUAL? <GET ,P-ITBL ,P-VERB>
					   ,ACT?MAKE ,ACT?TAKE>>
			      <CHANGE-LEXV .PTR ,W?WITH>
			      <SET WRD ,W?WITH>)>
		       <COND (<AND <EQUAL? .WRD ,W?PERIOD>
				   <EQUAL? .LW ,W?MR ,W?MRS ,W?MISS>>
			      <SET LW 0>)
			     (<EQUAL? .WRD ,W?AND ,W?COMMA>
			      <SET ANDFLG T>)
			     (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			    ; <OR <EQUAL? .WRD ,W?ALL ,W?BOTH ,W?ONE>
				  <EQUAL? .WRD ,W?EVERYTHING>>
			      <COND (<==? .NW ,W?OF>
				     <SETG P-LEN <- ,P-LEN 1>>
				     <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			     (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				  <AND <WT? .WRD ,PS?PREPOSITION>
				       <GET ,P-ITBL ,P-VERB>
				       <NOT .FIRST??>>>
			      <SETG P-LEN <+ ,P-LEN 1>>
			      <PUT ,P-ITBL
				   <+ .NUM 1>
				   <REST ,P-LEXV <* .PTR 2>>>
			      <RETURN <- .PTR ,P-LEXELEN>>)
			     ;"3/16/83: This clause used to be later."
			     (<AND .ANDFLG
				   <OR ;"3/25/83: next statement added."
				       <EQUAL? <GET ,P-ITBL ,P-VERBN> 0>
				       ;"10/26/84: next stmt changed"
				       <VERB-DIR-ONLY? .WRD>>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?OBJECT>
			      <COND (<AND <G? ,P-LEN 0>
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .WRD ,W?ALL ; ,W?ONE
						            ,W?EVERYTHING>>>
				     T)
				    (<AND <WT? .WRD
					       ,PS?ADJECTIVE
					       ;,P1?ADJECTIVE>
					  <NOT <ZERO? .NW>>
					  <WT? .NW ,PS?OBJECT>>)
				    (<AND <NOT .ANDFLG>
					  <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
					  <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				     <PUT ,P-ITBL
					  <+ .NUM 1>
					  <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				     <RETURN .PTR>)
				    (T <SET ANDFLG <>>)>)
			     ;"Next clause replaced by following one to enable
			       OLD WOMAN, HELLO"
			     ;(<AND <OR ,P-MERGED
				       ,P-OFLAG
				       <NOT <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>>
				   <OR <WT? .WRD ,PS?ADJECTIVE>
				       <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<OR <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?BUZZ-WORD>>)
			     (<AND .ANDFLG
				   <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>
			      <SET PTR <- .PTR 4>>
			      <CHANGE-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?PREPOSITION> T)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T <UNKNOWN-WORD .PTR> <RFALSE>)>
		<SET LW .WRD>
		<SET FIRST?? <>>
		<SET PTR <+ .PTR ,P-LEXELEN>>>>

<ROUTINE THIS-IS-IT (OBJ)
         <COND (<OR <EQUAL? .OBJ <> ,PLAYER ,NOT-HERE-OBJECT>
		    <EQUAL? .OBJ ,INTDIR>>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSA ,V?WALK ,V?WALK-TO>
		     <EQUAL? .OBJ ,PRSO>>
		<RTRUE>)
	       (T
		<SETG P-THEM-OBJECT .OBJ>
		<SETG P-IT-OBJECT .OBJ>
		<RTRUE>)>>  

<ROUTINE REFERRING ("OPTIONAL" (WHO <>))
	 <TELL "[I don't see wh">
	 <COND (.WHO
		<TELL "om">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to.]" CR>>

<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <TELL "[Be specific: what object do you want to ">
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<EQUAL? .TMP 0>
		<TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <TELL "?]" CR>>

; <GLOBAL NOW-PRSI <>>

; <ROUTINE FIX-HIM-HER (HEM-OBJECT "AUX" C P)
      ; <SET C <GETP .HEM-OBJECT ,P?CHARACTER>>
	<COND (<NOT <VISIBLE? .HEM-OBJECT>>
	     ; <COND (,DEBUG
		      <TELL "[" D .HEM-OBJECT ":NA]" CR>)>
	     ; <SET P <GET ,GLOBAL-CHARACTER-TABLE .C>>
	       <RFALSE>
	     ; <RETURN <AND .C
			    <NOT <==? .P <GET ,CHARACTER-TABLE .C>>>
			    .P>>)>
	<SET P .HEM-OBJECT>
      ; <COND (<IN? .HEM-OBJECT ,GLOBAL-OBJECTS>
	       <SET P <GET ,CHARACTER-TABLE .C>>)
	      (T
	       <SET P .HEM-OBJECT>)>
	<COND (<EQUAL? ,HERE <LOC .P>>
	     ; <COND (,DEBUG
		      <TELL "[" D .HEM-OBJECT ":LO]" CR>)>
	       <RETURN .P>)>>

<ROUTINE SEE-VERB? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?LOOK ,V?EXAMINE ,V?LOOK-INSIDE>
		    <EQUAL? ,PRSA ,V?SEARCH ,V?FIND ,V?LOOK-ON ,V?OPEN>
		    <EQUAL? ,PRSA ,V?LOOK-UNDER ,V?LOOK-BEHIND ,V?READ>
		    <EQUAL? ,PRSA ,V?LOOK-THRU ,V?LOOK-DOWN ,V?COUNT ,V?PLAY>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (.O
		      <TELL "/">
		      <COND (<EQUAL? .A ,V?WALK> <TELL N .O>)
			    (T <TELL D .O>)>)>
	       <COND (.I
		      <TELL "/">
		      <TELL D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<AND <NOT ,LIT>
		    <SEE-VERB?>>
	       <TOO-DARK>
	       <RFATAL>)
	      (<NOT <EQUAL? .A ,V?WALK>>
	       <COND (<EQUAL? ,IT .I .O>
		      <COND (<AND ,P-IT-OBJECT
				  <ACCESSIBLE? ,P-IT-OBJECT>>)
			    (T
			     <COND (<NOT .I> <FAKE-ORPHAN>)
				   (T <REFERRING>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,THEM .I .O>
		      <COND (<AND ,P-THEM-OBJECT
				  <VISIBLE? ,P-THEM-OBJECT>>
			     <COND (,DEBUG
				    <TELL "[them=" D ,P-THEM-OBJECT "]" CR>)>
			     <COND (<==? ,THEM .O>
				    <SET O ,P-THEM-OBJECT>)>
			     <COND (<==? ,THEM .I>
				    <SET I ,P-THEM-OBJECT>)>)
			    (T
			     <COND (<NOT .I>
				    <FAKE-ORPHAN>)
				   (T
				    <REFERRING T>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HER .I .O>
		      <COND (<AND ,P-HER-OBJECT
				  <VISIBLE? ,P-HER-OBJECT>>
			     <COND (,DEBUG
				    <TELL "[her=" D ,P-HER-OBJECT "]" CR>)>
			     <COND (<==? ,HER .O>
				    <SET O ,P-HER-OBJECT>)>
			     <COND (<==? ,HER .I>
				    <SET I ,P-HER-OBJECT>)>)
			    (T
			     <COND (<NOT .I>
				    <FAKE-ORPHAN>)
				   (T 
				    <REFERRING T>)>
			     <RFATAL>)>)>
	       <COND (<EQUAL? ,HIM .I .O>
		      <COND (<AND ,P-HIM-OBJECT
				  <VISIBLE? ,P-HIM-OBJECT>>
			     <COND (,DEBUG
				    <TELL "[him=" D ,P-HIM-OBJECT "]" CR>)>
			     <COND (<==? ,HIM .O>
				    <SET O ,P-HIM-OBJECT>)>
			     <COND (<==? ,HIM .I>
				    <SET I ,P-HIM-OBJECT>)>)
			    (T
			     <COND (<NOT .I>
				    <FAKE-ORPHAN>)
				   (T 
				    <REFERRING T>)>
			     <RFATAL>)>)>
	       <COND (<==? .O ,IT>
		      <SET O ,P-IT-OBJECT>
		      <COND (,DEBUG
			     <TELL "[it=" D .O "]" CR>)>)
		     ;"(<==? .O ,THEM><SET O ,P-THEM-OBJECT>)
		     (<==? .O ,HER> <SET O ,P-HER-OBJECT>)
		     (<==? .O ,HIM> <SET O ,P-HIM-OBJECT>)">
	       <COND (<==? .I ,IT>
		      <SET I ,P-IT-OBJECT>
		      <COND (,DEBUG
			     <TELL "[it=" D .O "]" CR>)>)
		     ;"(<==? .I ,THEM><SET I ,P-THEM-OBJECT>)
		     (<==? .I ,HER> <SET I ,P-HER-OBJECT>)
		     (<==? .I ,HIM> <SET I ,P-HIM-OBJECT>)">)>
	<SETG PRSI .I>
	<SETG PRSO .O>
	<SET V <>>
	<COND (<AND <NOT <EQUAL? .A ,V?WALK>>
		    <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>>
	       <SET V <APPLY ,NOT-HERE-OBJECT-F>>
	       <COND (.V
		      <SETG P-WON <>>)>)>
	<THIS-IS-IT ,PRSI>
	<THIS-IS-IT ,PRSO>
	<SET O ,PRSO>
	<SET I ,PRSI>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP ,WINNER ,P?ACTION>>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,PREACTIONS .A>>>)>
	<COND (<AND <ZERO? .V>
		    .I
		    <NOT <EQUAL? .A ,V?WALK>>
		    <LOC .I>>
	       <SET V <GETP <LOC .I> ,P?CONTFCN>>
	       <COND (.V
		      <SET V <APPLY .V ,M-CONT>>)>)>
	<COND (<AND <ZERO? .V> .I>
	       <SET V <APPLY <GETP .I ,P?ACTION>>>)>
	<COND (<AND <ZERO? .V>
		    .O
		    <NOT <EQUAL? .A ,V?WALK>>
		    <LOC .O>>
	       <SET V <GETP <LOC .O> ,P?CONTFCN>>
	       <COND (.V
		      <SET V <APPLY .V ,M-CONT>>)>)>
	<COND (<AND <ZERO? .V>
		    .O
		    <NOT <EQUAL? .A ,V?WALK>>>
	       <SET V <APPLY <GETP .O ,P?ACTION>>>
	       <COND (.V
		      <THIS-IS-IT .O>)>)>
	<COND (<ZERO? .V>
	       <SET V <APPLY <GET ,ACTIONS .A>>>)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<NOT <GAME-VERB?>>
		      ;<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>
		      <SET V <APPLY <GETP ,HERE ,P?ACTION> ,M-END>>)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE BUZZER-WORD? (WORD)
         <COND ;(<QUESTION-WORD? .WORD>
	        <RTRUE>)
               (<NUMBER-WORD? .WORD>
                <RTRUE>)
               (<NAUGHTY-WORD? .WORD>
		<RTRUE>)
              ; (<OR <EQUAL? .WORD ,W?NW ,W?NORTHW ,W?NE>
	            <EQUAL? .WORD ,W?SW ,W?SOUTHW ,W?NORTHE>
	            <EQUAL? .WORD ,W?SE ,W?SOUTHE>>
	        <TELL "[You don't need to use \"">
	        <PRINTB .WORD>
	        <TELL "\" directions in this story.]" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<BUZZ	AM ANY ARE DO HAS HAVE HE\'S IS IT\'S I\'LL I\'M I\'VE LET\'S
	SHALL SHE\'S THAT\'S THEY\'RE WERE WE\'RE YOU\'RE>

;<GLOBAL QUESTION-WORD-COUNT 0>

;<ROUTINE QUESTION-WORD? (WORD)
	<COND (<NOT <EQUAL? ,P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>>
	       <RFALSE>)
	      (<EQUAL? .WORD ,W?WHERE>
	       <TO-DO-THING-USE "locate" "FIND">
	       <RTRUE>)
	      
	      (<OR <EQUAL? .WORD ,W?WHAT ,W?WHAT\'S ,W?WHO>
		   <EQUAL? .WORD ,W?WHO\'S ,W?WHY ,W?HOW>
		   <EQUAL? .WORD ,W?WHEN ,W?WHEN\'S ,W?AM>
		   <EQUAL? .WORD ,W?WOULD ,W?COULD ,W?SHOULD>>
	       <TO-DO-THING-USE "ask about" "ASK CHARACTER ABOUT">
	       <RTRUE>)
	      
	      (<OR <EQUAL? .WORD ,W?THAT\'S	,W?IT\'S        ,W?I\'M>
		   <EQUAL? .WORD ,W?IS		,W?DID		,W?ARE>
		   <EQUAL? .WORD ,W?DO		,W?HAVE		,W?ANY>
		   <EQUAL? .WORD ,W?WILL	,W?WAS		,W?WERE>
		   <EQUAL? .WORD ,W?I\'LL	,W?WHICH        ,W?WE\'RE>
		   <EQUAL? .WORD ,W?I\'VE	,W?WON\'T	,W?HAS>
		   <EQUAL? .WORD ,W?YOU\'RE	,W?HE\'S	,W?SHE\'S>
		   <EQUAL? .WORD ,W?THEY\'RE	,W?SHALL>>
	       <TELL "(Please use commands">
	       <INC QUESTION-WORD-COUNT>
	       <COND (<G? ,QUESTION-WORD-COUNT 4>
		      <SETG QUESTION-WORD-COUNT 0>
		      <TELL
"! Your commands tell the computer what you want to do in the story. Here are examples of commands:~
~
   TURN ON THE LAMP~
   LOOK INSIDE THE HOLE~
~
Now you can try again">)
		     (T
		      <TELL ", not statements or questions">)>
	       <TELL ".)" CR>
	       <RTRUE>)
	      (T
	       <RFALSE>)>>

<BUZZ	ZERO ONE TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE TEN
	ELEVEN TWELVE THIRTE FOURTE FIFTEE SIXTEE SEVENT EIGHTE NINETE TWENTY
	THIRTY FORTY FIFTY SIXTY EIGHTY NINETY HUNDRE
	THOUSA MILLIO BILLIO>

<ROUTINE NUMBER-WORD? (WRD)
	<COND (<OR <EQUAL? .WRD ,W?ONE>
		   <EQUAL? .WRD ,W?TWO ,W?THREE ,W?FOUR>
		   <EQUAL? .WRD ,W?FIVE ,W?SIX ,W?SEVEN>
		   <EQUAL? .WRD ,W?EIGHT ,W?NINE ,W?TEN>
		   <EQUAL? .WRD ,W?ELEVEN ,W?TWELVE ,W?THIRTE>
		   <EQUAL? .WRD ,W?FOURTE ,W?FIFTEE ,W?SIXTEE>
		   <EQUAL? .WRD ,W?SEVENT ,W?EIGHTE ,W?NINETE>
		   <EQUAL? .WRD ,W?TWENTY ,W?THIRTY ,W?FORTY>
		   <EQUAL? .WRD ,W?FIFTY ,W?SIXTY ,W?EIGHTY>
		   <EQUAL? .WRD ,W?NINETY ,W?HUNDRE ,W?THOUSA>
		   <EQUAL? .WRD ,W?MILLIO ,W?BILLIO ,W?ZERO>>
	       <TELL "[Use numerals for numbers, for example \"10.\"]" CR>
	       <RTRUE>)
	      (T
	       <RFALSE>)>>

<BUZZ FUCK FUCKED CURSE GODDAMNED CUSS DAMN SHIT ASSHOLE CUNT
      SHITHEAD PISS SUCK BASTARD SCREW FUCKING DAMNED PEE COCKSUCKER BITCH>

<ROUTINE NAUGHTY-WORD? (WORD)
         <COND (<OR <EQUAL? .WORD ,W?CURSE ,W?GODDAMNED ,W?CUSS>
	            <EQUAL? .WORD ,W?DAMN ,W?SHIT ,W?FUCK>
	            <EQUAL? .WORD ,W?SHITHEAD ,W?PISS ,W?SUCK>
	            <EQUAL? .WORD ,W?BASTARD ,W?SCREW ,W?FUCKING>
	            <EQUAL? .WORD ,W?DAMNED ,W?PEE ,W?COCKSUCKER>
		    <EQUAL? .WORD ,W?FUCKED ,W?CUNT ,W?ASSHOLE>
		    <EQUAL? .WORD ,W?BITCH>>
	        <TELL <PICK-ONE ,OFFENDED> CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL OFFENDED
       <LTABLE
	 0
	"You've earned an 'R' rating."
	"You can almost feel Aunt Hildegarde washing out your mouth with soap."
       ;"Yes, this program understands that word. What a thrill, eh?">>

<ROUTINE VERB-DIR-ONLY? (WRD)
	<AND <NOT <WT? .WRD ,PS?OBJECT>>
	     <NOT <WT? .WRD ,PS?ADJECTIVE>>
	     <OR <WT? .WRD ,PS?DIRECTION>
		 <WT? .WRD ,PS?VERB>>>>

<BUZZ AGAIN G OOPS>

"For AGAIN purposes, put contents of one LEXV table into another:"

<ROUTINE STUFF (DEST SRC "OPTIONAL" (MAX 29) "AUX" (PTR ,P-LEXSTART) (CTR 1)
						   BPTR)
	 <PUTB .DEST 0 <GETB .SRC 0>>
	 <PUTB .DEST 1 <GETB .SRC 1>>
	 <REPEAT ()
	  <PUT .DEST .PTR <GET .SRC .PTR>>
	  <SET BPTR <+ <* .PTR 2> 2>>
	  <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	  <SET BPTR <+ <* .PTR 2> 3>>
	  <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	  <SET PTR <+ .PTR ,P-LEXELEN>>
	  <COND (<IGRTR? CTR .MAX>
		 <RETURN>)>>>

"Put contents of one INBUF into another:"

<ROUTINE INBUF-STUFF (DEST SRC "AUX" (CNT -1))
	 <REPEAT ()
	  <COND (<IGRTR? CNT 59> <RETURN>)
		(T <PUTB .DEST .CNT <GETB .SRC .CNT>>)>>> 

"Put the word in the positions specified from P-INBUF to the end of
OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV:"

<ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)
	 <COND (<SET TMP <GET ,OOPS-TABLE ,O-END>>
		<SET DBEG .TMP>)
	       (T
		<SET DBEG <+ <GETB ,AGAIN-LEXV
				   <SET TMP <GET ,OOPS-TABLE ,O-LENGTH>>>
			     <GETB ,AGAIN-LEXV <+ .TMP 1>>>>)>
	 <PUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <REPEAT ()
	  <PUTB ,OOPS-INBUF <+ .DBEG .CTR> <GETB ,P-INBUF <+ .BEG .CTR>>>
	  <SET CTR <+ .CTR 1>>
	  <COND (<EQUAL? .CTR .LEN> <RETURN>)>>
	 <PUTB ,AGAIN-LEXV .SLOT .DBEG>
	 <PUTB ,AGAIN-LEXV <- .SLOT 1> .LEN>>


;"new number routine--from Suspect for handling phone numbers"

<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>) (EXC <>)
		  (NOHYP? <>))
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <COND (<EQUAL? .CNT 7> <SET NOHYP? T>)>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0> <RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<AND .NOHYP?
				    <EQUAL? .CNT 3>
				    <NOT <EQUAL? .CHR 45>>>
			       <COND (.TIM <RFALSE>)>
			       <SET EXC .SUM>
			       <SET SUM 0>)>
			<COND (<==? .CHR 58> ;"Char :"
			       <COND (.EXC <RFALSE>)>
			       <SET TIM .SUM>
			       <SET SUM 0>)
			      (<==? .CHR 45> ;"Char -"
			       <SET NOHYP? <>>
			       <COND (.TIM <RFALSE>)>
			       <SET EXC .SUM>
			       <SET SUM 0>)
			      (<G? .SUM 9999>
			       <SET SUM 10000>
			       <RETURN>)
			      (<AND <L? .CHR 58> <G? .CHR 47>>
			       <SET SUM <+ <* .SUM 10> <- .CHR 48>>>)
			      (T <RFALSE>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <PUT ,P-LEXV .PTR ,W?INTNUM>
	 <PUT ,AGAIN-LEXV .PTR ,W?INTNUM>
	 <COND ;(<G? .SUM 9999> <RFALSE>)
	       (.EXC
		<SETG P-EXCHANGE .EXC>)
	       (.TIM
		<SETG P-EXCHANGE 0>
		<COND (<G? .TIM 23> <RFALSE>)
		      (<G? .TIM 19> T)
		      (<G? .TIM 12> <RFALSE>)
		      (<G? .TIM  7> T)
		      (T <SET TIM <+ 12 .TIM>>)>
		<SET SUM <+ .SUM <* .TIM 60>>>)
	       (T <SETG P-EXCHANGE 0>)>
	 <SETG P-NUMBER .SUM>
	 ,W?INTNUM>

<GLOBAL P-NUMBER 0>
<GLOBAL P-EXCHANGE 0>


;"old numbers routine--doesn't handle phone numbers."

;<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>) (DOLLAR <>))
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 ;<SETG P-DOLLAR-FLAG <>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0> <RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<==? .CHR %<ASCII !\:>>
			       <SET TIM .SUM>
			       <SET SUM 0>)
			      (<G? .SUM 9999> <RFALSE>)
			      (<EQUAL? .CHR ,CURRENCY-SYMBOL>
			       <SET DOLLAR T>)
			      (<OR <G? .CHR %<ASCII !\9>>
				   <L? .CHR %<ASCII !\0>>>
			       <RFALSE>)
			      (T
			       <SET SUM <+ <* .SUM 10>
					   <- .CHR %<ASCII !\0>>>>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <CHANGE-LEXV .PTR ,W?INTNUM>
	 <COND (<G? .SUM 9999> <RFALSE>)
	       (.TIM
		<COND ;"(<L? .TIM 8> <SET TIM <+ .TIM 12>>)"
		      (<G? .TIM 23> <RFALSE>)
		      ;"(<G? .TIM 19> T)
		      (<G? .TIM 12> <RFALSE>)
		      (<G? .TIM  7> T)
		      (T <SET TIM <+ 12 .TIM>>)">
		<SET SUM <+ .SUM <* .TIM 60>>>)>
	 <SETG P-DOLLAR-FLAG .DOLLAR>
	 <COND (<AND .DOLLAR <G? .SUM 0>>
		<SETG P-AMOUNT .SUM>
		,W?MONEY
		;<FSET ,INTNUM ,VOWELBIT>
		;<PUTP ,INTNUM ,P?SDESC "amount of money">)
	       (T
		<SETG P-NUMBER .SUM>
		<SETG P-DOLLAR-FLAG <>>
		,W?INTNUM
		;<FCLEAR ,INTNUM ,VOWELBIT>
		;<PUTP ,INTNUM ,P?SDESC "number">)>>

<GLOBAL P-NUMBER -1>
;<GLOBAL P-AMOUNT 0>
;<GLOBAL P-DOLLAR-FLAG <>>
<CONSTANT CURRENCY-SYMBOL %<ASCII !\$>>

<GLOBAL P-DIRECTION 0>

<ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD) 
   <SETG P-OFLAG <>>
   <COND (<OR <EQUAL? <WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   ,PS?VERB ,P1?VERB>
		      <GET ,P-OTBL ,P-VERB>>
	      <WT? .WRD ,PS?ADJECTIVE>>
	  <SET ADJ T>)
	 (<AND <WT? .WRD ,PS?OBJECT ,P1?OBJECT>
	       <EQUAL? ,P-NCN 0>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <NOT <ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>>
	       <NOT .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2> <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<OR <ZERO? <SET TEMP <GET ,P-ITBL ,P-PREP1>>>
		     <EQUAL? .TEMP <GET ,P-OTBL ,P-PREP1>>>
		 <COND (.ADJ
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>
			;<PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<OR <ZERO? <SET TEMP <GET ,P-ITBL ,P-PREP1>>>
		     <EQUAL? .TEMP <GET ,P-OTBL ,P-PREP2>>>
		 <COND (.ADJ
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T <RFALSE>)>)
	 (,P-ACLAUSE
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (.ADJ <SET BEG <REST ,P-LEXV 2>> <SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (.ADJ <CLAUSE-WIN .ADJ> <RETURN>)
				      (T <SETG P-ACLAUSE <>> <RFALSE>)>)
			       (<OR <EQUAL? .WRD ,W?ALL ;,W?EVERYT ,W?ONE> 
				    <AND <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE> ;"same as WT?"
					 <ADJ-CHECK .WRD .ADJ>>>
				<SET ADJ .WRD>)
			       (<EQUAL? .WRD ,W?ONE>
				<CLAUSE-WIN .ADJ>
				<RETURN>)
			       (<AND <BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				     <EQUAL? <+ .BEG ,P-WORDLEN> .END>>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <CLAUSE-WIN .ADJ>)
				      (T
				       <CLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<EQUAL? .END 0>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   ;<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
   <REPEAT ()
	   <COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)
		 (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>
   T>

<ROUTINE CLAUSE-WIN ("OPT" (ADJ <>)) 
	<COND (.ADJ
	       <PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>)
	      (ELSE <SET ADJ T>)>
	<PUT ,P-CCTBL ,CC-SBPTR ,P-ACLAUSE>
	<PUT ,P-CCTBL ,CC-SEPTR <+ ,P-ACLAUSE 1>>
	<COND (<EQUAL? ,P-ACLAUSE ,P-NC1>
	       <PUT ,P-CCTBL ,CC-OCLAUSE ,P-OCL1>)
	      (ELSE
	       <PUT ,P-CCTBL ,CC-OCLAUSE ,P-OCL2>)>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL .ADJ>
	<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

;<ROUTINE ACLAUSE-WIN (ADJ "AUX" X) 
	<PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>
	<SET X <+ ,P-ACLAUSE 1>>
	%<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	      '<CLAUSE-COPY ,P-OTBL ,P-OTBL ,P-ACLAUSE .X ,P-ACLAUSE .X .ADJ>)
	       (T
		'<PROG ()
		       <PUT ,P-CCTBL ,CC-SBPTR ,P-ACLAUSE>
		       <PUT ,P-CCTBL ,CC-SEPTR .X>
		       <PUT ,P-CCTBL ,CC-DBPTR ,P-ACLAUSE>
		       <PUT ,P-CCTBL ,CC-DEPTR .X>
		       <CLAUSE-COPY ,P-OTBL ,P-OTBL .ADJ>>)>
	<AND <NOT <==? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

;<ROUTINE NCLAUSE-WIN ()
        %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		'<CLAUSE-COPY ,P-ITBL ,P-OTBL ,P-NC1 ,P-NC1L
			      ,P-ACLAUSE <+ ,P-ACLAUSE 1>>)
	       (T
		'<PROG ()
		       <PUT ,P-CCTBL ,CC-SBPTR ,P-NC1>
		       <PUT ,P-CCTBL ,CC-SEPTR ,P-NC1L>
		       <PUT ,P-CCTBL ,CC-DBPTR ,P-ACLAUSE>
		       <PUT ,P-CCTBL ,CC-DEPTR <+ ,P-ACLAUSE 1>>
		       <CLAUSE-COPY ,P-ITBL ,P-OTBL>>)>
	<AND <NOT <==? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

"Print undefined word in input. PTR points to the unknown word in P-LEXV"   

<ROUTINE WORD-PRINT (CNT BUF)
	 ;<COND (<G? .CNT 6> <SET CNT 6>)>
	 <REPEAT ()
		 <COND (<DLESS? CNT 0> <RETURN>)
		       (ELSE
			<PRINTC <GETB ,P-INBUF .BUF>>
			<SET BUF <+ .BUF 1>>)>>>

<GLOBAL UNKNOWN-MSGS
        <LTABLE 0 
  <PTABLE "This story doesn't know the word \""
	 ".\"">
  <PTABLE "Sorry, but the word \""
	 "\" is not in the vocabulary you can use.">
  <PTABLE "You don't need to use the word \""
	 "\" to finish this story.">
  <PTABLE "Sorry, but this story doesn't recognize the word \""
	 ".\"">>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" BUF MSG)
	<PUT ,OOPS-TABLE ,O-PTR .PTR>
	<SET MSG <PICK-ONE ,UNKNOWN-MSGS>>
	<TELL "[" <GET .MSG 0>>
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<TELL <GET .MSG 1> "]" CR>>

" Perform syntax matching operations, using P-ITBL as the source of
   the verb and adjectives for this input.  Returns false if no
   syntax matches, and does it's own orphaning.  If return is true,
   the syntax is saved in P-SYNTAX."   
 
<GLOBAL P-SLOCBITS 0>    
 
<CONSTANT P-SYNLEN 8>    
 
<CONSTANT P-SBITS 0>
 
<CONSTANT P-SPREP1 1>    
 
<CONSTANT P-SPREP2 2>    
 
<CONSTANT P-SFWIM1 3>    
 
<CONSTANT P-SFWIM2 4>    
 
<CONSTANT P-SLOC1 5>
 
<CONSTANT P-SLOC2 6>
 
<CONSTANT P-SACTION 7>   
 
<CONSTANT P-SONUMS 3>    

<ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ (DRIVE1 <>) (DRIVE2 <>)
			     PREP VERB) 
	;#DECL ((DRIVE1 DRIVE2) <OR FALSE <PRIMTYPE VECTOR>>
	       (SYN) <PRIMTYPE VECTOR> (LEN NUM VERB PREP) FIX
	       (OBJ) <OR FALSE OBJECT>)
	<SET VERB <GET ,P-ITBL ,P-VERB>>
	<COND (<ZERO? .VERB>
	       <NOT-IN-SENTENCE "any verbs">
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
		<SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
		<COND (<G? ,P-NCN .NUM> T) ;"Added 4/27/83"
		      (<AND <NOT <L? .NUM 1>>
			    <ZERO? ,P-NCN>
			    <OR <ZERO? <SET PREP <GET ,P-ITBL ,P-PREP1>>>
				<==? .PREP <GETB .SYN ,P-SPREP1>>>>
		       <SET DRIVE1 .SYN>)
		      (<==? <GETB .SYN ,P-SPREP1> <GET ,P-ITBL ,P-PREP1>>
		       <COND (<AND <==? .NUM 2> <==? ,P-NCN 1>>
			      <SET DRIVE2 .SYN>)
			     (<==? <GETB .SYN ,P-SPREP2>
				   <GET ,P-ITBL ,P-PREP2>>
			      <SYNTAX-FOUND .SYN>
			      <RTRUE>)>)>
		<COND (<DLESS? LEN 1>
		       <COND (<OR .DRIVE1 .DRIVE2> <RETURN>)
			     (T
			      <DONT-UNDERSTAND>
			      <RFALSE>)>)
		      (T <SET SYN <REST .SYN ,P-SYNLEN>>)>>
	<COND (<AND .DRIVE1
		    <SET OBJ
			 <GWIM <GETB .DRIVE1 ,P-SFWIM1>
			       <GETB .DRIVE1 ,P-SLOC1>
			       <GETB .DRIVE1 ,P-SPREP1>>>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE1>)
	      (<AND .DRIVE2
		    <SET OBJ
			 <GWIM <GETB .DRIVE2 ,P-SFWIM2>
			       <GETB .DRIVE2 ,P-SLOC2>
			       <GETB .DRIVE2 ,P-SPREP2>>>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE2>)
	      (<EQUAL? .VERB ,ACT?FIND ; ,ACT?WHAT>
	       <TELL "That's your problem!" CR>
	       <RFALSE>)
	      (T
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <ORPHAN .DRIVE1 .DRIVE2>
		      <TELL "[Wh">)
		     (T
		      <TELL
"[Your command wasn't complete. Next time, type wh">)>
	       <COND (<EQUAL? .VERB ,ACT?WALK ,ACT?GO>
		      <TELL "ere">)
		     (<OR <AND .DRIVE1
			       <==? <GETB .DRIVE1 ,P-SFWIM1> ,ACTORBIT>>
			  <AND .DRIVE2
			       <==? <GETB .DRIVE2 ,P-SFWIM2> ,ACTORBIT>>>
		      <TELL "om">)
		     (T <TELL "at">)>
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <TELL " do you want to ">)
		     (T
		      <TELL " you want" T ,WINNER " to ">)>
	       <VERB-PRINT>
	       <COND (.DRIVE2
		      <CLAUSE-PRINT ,P-NC1 ,P-NC1L>)>
	       <SETG P-END-ON-PREP <>>
	       <PREP-PRINT <COND (.DRIVE1 <GETB .DRIVE1 ,P-SPREP1>)
				 (T <GETB .DRIVE2 ,P-SPREP2>)>>
	       <COND (<EQUAL? ,WINNER ,PLAYER>
		      <SETG P-OFLAG T>
		      <TELL "?]" CR>)
		     (T
		      <SETG P-OFLAG <>>
		      <TELL ".]" CR>)>
	       <RFALSE>)>>

<ROUTINE VERB-PRINT ("AUX" TMP)
	<SET TMP <GET ,P-ITBL ,P-VERBN>>	;"? ,P-OTBL?"
	<COND (<==? .TMP 0> <TELL "tell">)
	      (<ZERO? <GETB ,P-VTBL 2>>
	       <PRINTB <GET .TMP 0>>)
	      (T
	       <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
	       <PUTB ,P-VTBL 2 0>)>>

<ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))
	<COND (<NOT ,P-MERGED>
	       <PUT ,P-OCL1 ,P-MATCHLEN 0>
	       <PUT ,P-OCL2 ,P-MATCHLEN 0>)>
	<PUT ,P-OVTBL 0 <GET ,P-VTBL 0>>
	<PUTB ,P-OVTBL 2 <GETB ,P-VTBL 2>>
	<PUTB ,P-OVTBL 3 <GETB ,P-VTBL 3>>
	<REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>>
	<COND (<EQUAL? ,P-NCN 2>
	       <PUT ,P-CCTBL ,CC-SBPTR ,P-NC2>
	       <PUT ,P-CCTBL ,CC-SEPTR ,P-NC2L>
	       <PUT ,P-CCTBL ,CC-OCLAUSE ,P-OCL2>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (<NOT <L? ,P-NCN 1>>
	       <PUT ,P-CCTBL ,CC-SBPTR ,P-NC1>
	       <PUT ,P-CCTBL ,CC-SEPTR ,P-NC1L>
	       <PUT ,P-CCTBL ,CC-OCLAUSE ,P-OCL1>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (.D1
	       <PUT ,P-OTBL ,P-PREP1 <GETB .D1 ,P-SPREP1>>
	       <PUT ,P-OTBL ,P-NC1 1>)
	      (.D2
	       <PUT ,P-OTBL ,P-PREP2 <GETB .D2 ,P-SPREP2>>
	       <PUT ,P-OTBL ,P-NC2 1>)>> 

<ROUTINE CLAUSE-PRINT (BPTR EPTR "OPTIONAL" (THE? T)) 
	<BUFFER-PRINT <GET ,P-ITBL .BPTR> <GET ,P-ITBL .EPTR> .THE?>>    

<ROUTINE BUFFER-PRINT (BEG END CP "AUX" (NOSP <>) WRD (FIRST?? T) (PN <>))
	 <REPEAT ()
		<COND (<==? .BEG .END> <RETURN>)
		      (T
		       <COND (.NOSP <SET NOSP <>>)
			     (T <TELL " ">)>
		       <SET WRD <GET .BEG 0>>
		       <COND (<OR <AND <EQUAL? .WRD ,W?HIM>
				       <NOT <VISIBLE? ,P-HIM-OBJECT>>>
				  <AND <EQUAL? .WRD ,W?HER>
				       <NOT <VISIBLE? ,P-HER-OBJECT>>>
				  <AND <EQUAL? .WRD ,W?THEM>
				       <NOT <VISIBLE? ,P-THEM-OBJECT>>>>
			      <SET PN T>)>
		       <COND (<==? .WRD ,W?PERIOD>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ALL>
			      <TELL "all">)
			     (<AND <OR <WT? .WRD ,PS?BUZZ-WORD>
				       <WT? .WRD ,PS?PREPOSITION>>
				   <NOT <WT? .WRD ,PS?ADJECTIVE>>
				   <NOT <WT? .WRD ,PS?OBJECT>>>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ME>
			      <DPRINT ,PLAYER>
			      <SET PN T>)
			     (<NAME? .WRD>
			      <CAPITALIZE .BEG>
			      <SET PN T>)
			     (T
			      <COND (<AND .FIRST?? <NOT .PN> .CP>
				     <TELL "the ">)>
			      <COND (<OR ,P-OFLAG ,P-MERGED> <PRINTB .WRD>)
				    (<AND <==? .WRD ,W?IT>
					  <VISIBLE? ,P-IT-OBJECT>>
				     <DPRINT ,P-IT-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?HER>
					  <NOT .PN>	;"VISIBLE check above"
					  ;<VISIBLE? ,P-HER-OBJECT>>
				     <DPRINT ,P-HER-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?THEM>
					  <NOT .PN>
					  ;<VISIBLE? ,P-THEM-OBJECT>>
				     <DPRINT ,P-THEM-OBJECT>)
				    (<AND <EQUAL? .WRD ,W?HIM>
					  <NOT .PN>
					  ;<VISIBLE? ,P-HIM-OBJECT>>
				     <DPRINT ,P-HIM-OBJECT>)
				    (T
				     <WORD-PRINT <GETB .BEG 2>
						 <GETB .BEG 3>>)>
			      <SET FIRST?? <>>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

"Check for words to be capitalized here"

<ROUTINE NAME? (WRD)
	<COND (<OR <EQUAL? .WRD ,W?MR ,W?MRS ,W?MISS>
		   <EQUAL? .WRD ,W?BUCK ,W?PALACE ,W?HERMAN>
		   <EQUAL? .WRD ,W?HILDEG ,W?BURBAN ,W?AUNT>
		   <EQUAL? .WRD ,W?COUSIN ,W?UNCLE ,W?BUDDY>>
	       <RTRUE>)
	      (T
	       <RFALSE>)>>

<ROUTINE CAPITALIZE (PTR)
	 <COND (<OR ,P-OFLAG ,P-MERGED>
		<PRINTB <GET .PTR 0>>)
	       (T
		<PRINTC <- <GETB ,P-INBUF <GETB .PTR 3>> 32>>
		<WORD-PRINT <- <GETB .PTR 2> 1> <+ <GETB .PTR 3> 1>>)>>

<ROUTINE PREP-PRINT (PREP "OPTIONAL" (SP? T) "AUX" WRD)
	<COND (<AND <NOT <ZERO? .PREP>>
		    <NOT ,P-END-ON-PREP>>
	       <COND (.SP? <TELL " ">)>
	       <SET WRD <PREP-FIND .PREP>>
	       <COND ;(<==? .WRD ,W?AGAINST> <TELL "against">)
		     (<==? .WRD ,W?THROUGH> <TELL "through">)
		     (T <PRINTB .WRD>)>
	       <COND (<AND <==? ,W?SIT <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <==? ,W?DOWN .WRD>>
		      <TELL " on">)>
	       <COND (<AND <==? ,W?GET <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   <==? ,W?OUT .WRD>>	;"Will it ever work? --SWG"
		      <TELL " of">)>
	       <RTRUE>)>>    


"pointers used by CLAUSE-COPY (source/destination beginning/end pointers):"
<CONSTANT CC-SBPTR 0>
<CONSTANT CC-SEPTR 1>
<CONSTANT CC-OCLAUSE 2>

<GLOBAL P-CCTBL <TABLE 0 0 0 0 0>>

<ROUTINE CLAUSE-COPY (SRC DEST "OPT" (INSRT <>)
		      "AUX" OCL BEG END BB EE OBEG CNT B E)
	<SET BB <GET ,P-CCTBL ,CC-SBPTR>>
	<SET EE <GET ,P-CCTBL ,CC-SEPTR>>
	<SET OCL <GET ,P-CCTBL ,CC-OCLAUSE>>
	<SET BEG <GET .SRC .BB>>
	<SET END <GET .SRC .EE>>
	<SET OBEG <GET .OCL ,P-MATCHLEN>>
	<REPEAT ()
		<COND (<EQUAL? .BEG .END> <RETURN>)>
		<COND (<AND .INSRT
			    <EQUAL? ,P-ANAM <GET .BEG 0>>>
		       <COND (<EQUAL? .INSRT T>
			      <SET B <GET ,P-ITBL ,P-NC1>>
			      <SET E <GET ,P-ITBL ,P-NC1L>>
			      <REPEAT ()
				      <COND (<EQUAL? .B .E> <RETURN>)>
				      <CLAUSE-ADD <GET .B 0>>
				      <SET B <REST .B ,P-WORDLEN>>>)
			     (ELSE
			      <COND (<NOT <EQUAL? .INSRT <GET .OCL 1>>>
				     <CLAUSE-ADD .INSRT>)>
			      <CLAUSE-ADD ,P-ANAM>)>)
		      (ELSE
		       <CLAUSE-ADD <GET .BEG 0>>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>
	<COND (<AND <EQUAL? .SRC .DEST>
		    <G? .OBEG 0>
		    <L? 0 <SET CNT <- <GET .OCL ,P-MATCHLEN> .OBEG>>>>
	       <PUT .OCL ,P-MATCHLEN 0>
	       <SET OBEG <+ .OBEG 1>>
	       <REPEAT ()
		       <CLAUSE-ADD <GET .OCL .OBEG> T>
		       <COND (<ZERO? <SET CNT <- .CNT 2>>>
			      <RETURN>)>
		       <SET OBEG <+ .OBEG 2>>>
	       <SET OBEG 0>)>
	<PUT .DEST
	     .BB
	     <REST .OCL <+ <* .OBEG ,P-LEXELEN> 2>>>
	<PUT .DEST
	     .EE
	     <REST .OCL
		   <+ <* <GET .OCL ,P-MATCHLEN> ,P-LEXELEN> 2>>>>

<ROUTINE CLAUSE-ADD (WRD "OPT" (CHECK? <>) "AUX" OCL PTR)
	<SET OCL <GET ,P-CCTBL ,CC-OCLAUSE>>
	<SET PTR <GET .OCL ,P-MATCHLEN>>
	<COND (<AND .CHECK? <NOT <ZERO? .PTR>> <ZMEMQ .WRD .OCL>>
	       <RFALSE>)
	      (ELSE
	       <SET PTR <+ .PTR 2>>
	       <PUT .OCL <- .PTR 1> .WRD>
	       <PUT .OCL .PTR 0>
	       <PUT .OCL ,P-MATCHLEN .PTR>)>>   
 
<ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE) 
	;#DECL ((PREP CNT SIZE) FIX)
	<SET SIZE <* <GET ,PREPOSITIONS 0> 2>>
	<REPEAT ()
		<COND (<IGRTR? CNT .SIZE> <RFALSE>)
		      (<==? <GET ,PREPOSITIONS .CNT> .PREP>
		       <RETURN <GET ,PREPOSITIONS <- .CNT 1>>>)>>>  
 
<ROUTINE SYNTAX-FOUND (SYN) 
	;#DECL ((SYN) <PRIMTYPE VECTOR>)
	<SETG P-SYNTAX .SYN>
	<SETG PRSA <GETB .SYN ,P-SACTION>>>   
 
<GLOBAL P-GWIMBIT 0>
 
<ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ ;WPREP)
	<COND (<EQUAL? .GBIT ,RLANDBIT>
	       <RETURN ,ROOMS>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<==? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <TELL "[">
		      <COND (<PREP-PRINT .PREP <>>
			     <TELL T .OBJ>)
			    (ELSE
			     <TELL D .OBJ>)>
		      <TELL "]" CR>
		      .OBJ)>)
	      (T
	       <SETG P-GWIMBIT 0>
	       <RFALSE>)>>   

<ROUTINE SNARF-OBJECTS ("AUX" PTR) 
	;#DECL ((PTR) <OR FIX <PRIMTYPE VECTOR>>)
	<COND (<NOT <==? <SET PTR <GET ,P-ITBL ,P-NC1>> 0>>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC1>>
	       <OR <SNARFEM .PTR <GET ,P-ITBL ,P-NC1L> ,P-PRSO> <RFALSE>>
	       <OR <ZERO? <GET ,P-BUTS ,P-MATCHLEN>>
		   <SETG P-PRSO <BUT-MERGE ,P-PRSO>>>)>
	<COND (<NOT <==? <SET PTR <GET ,P-ITBL ,P-NC2>> 0>>
	       <SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC2>>
	       <OR <SNARFEM .PTR <GET ,P-ITBL ,P-NC2L> ,P-PRSI> <RFALSE>>
	       <COND (<NOT <ZERO? <GET ,P-BUTS ,P-MATCHLEN>>>
		      <COND (<==? <GET ,P-PRSI ,P-MATCHLEN> 1>
			     <SETG P-PRSO <BUT-MERGE ,P-PRSO>>)
			    (T <SETG P-PRSI <BUT-MERGE ,P-PRSI>>)>)>)>
	<RTRUE>>  

<ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<REPEAT ()
		<COND (<DLESS? LEN 0> <RETURN>)
		      (<ZMEMQ <SET OBJ <GET .TBL .CNT>> ,P-BUTS>)
		      (T
		       <PUT ,P-MERGE <+ .MATCHES 1> .OBJ>
		       <SET MATCHES <+ .MATCHES 1>>)>
		<SET CNT <+ .CNT 1>>>
	<PUT ,P-MERGE ,P-MATCHLEN .MATCHES>
	<SET NTBL ,P-MERGE>
	<SETG P-MERGE .TBL>
	.NTBL>    
 
<GLOBAL P-NAM <>>   
 
<GLOBAL P-XNAM <>>

<GLOBAL P-ADJ <>>   
 
<GLOBAL P-XADJ <>>

%<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>)
       (T
'(<GLOBAL P-ADJN <>>
  <GLOBAL P-XADJN <>>))>

<GLOBAL P-PRSO <ITABLE NONE 50>>   
 
<GLOBAL P-PRSI <ITABLE NONE 50>>   
 
<GLOBAL P-BUTS <ITABLE NONE 50>>   
 
<GLOBAL P-MERGE <ITABLE NONE 50>>  
 
<GLOBAL P-OCL1 <ITABLE NONE 50>>
<GLOBAL P-OCL2 <ITABLE NONE 50>>

;<GLOBAL P-OCLAUSE <ITABLE NONE 50>>
 
<CONSTANT P-MATCHLEN 0>    
 
<GLOBAL P-GETFLAGS 0>    
 
<CONSTANT P-ALL 1>  
 
<CONSTANT P-ONE 2>  
 
<CONSTANT P-INHIBIT 4>   

<GLOBAL P-AND <>>

<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL? <>)
				     ONEOBJ) 
   ;"Next SETG 6/21/84 for WHICH retrofix"
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL? T>)>
   <SETG P-GETFLAGS 0>
   <PUT ,P-BUTS ,P-MATCHLEN 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (.WAS-ALL?
			 <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<==? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ,W?BOTH ,W?EVERYTHING>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<==? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<BUZZER-WORD? .WRD>
			 <RFALSE>)
			(<EQUAL? .WRD ,W?A ; ,W?ONE>
			 <COND (<NOT ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<==? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM .ONEOBJ>
				<OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
				<AND <ZERO? .NW> <RTRUE>>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 ;"Next SETG 6/21/84 for WHICH retrofix"
			 <SETG P-AND T>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 T)
			(<WT? .WRD ,PS?BUZZ-WORD>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<==? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			%<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
				'(<AND <WT? .WRD ,PS?ADJECTIVE>
				       <ADJ-CHECK .WRD ,P-ADJ>>
				  <SETG P-ADJ .WRD>))
			       (T
				'(<AND <SET WV <WT? .WRD ,PS?ADJECTIVE
							 ,P1?ADJECTIVE>>
				       <ADJ-CHECK .WRD ,P-ADJ>> ;"DA"
				  <SETG P-ADJ .WV>
				  <SETG P-ADJN .WRD>))>
			(<WT? .WRD ,PS?OBJECT ;,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SET ONEOBJ .WRD>)>)>
	   <COND (<NOT <==? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>   

<ROUTINE ADJ-CHECK (WRD ADJ)
	 <COND (<NOT .ADJ>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?COPY ,W?FILM ,W?SLIDE>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?FIRST ,W?SECOND ,W?THIRD ,W?SAWED>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?RED ,W?WHITE ,W?BLUE>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?ORANGE ,W?YELLOW ,W?GREEN>
		<RTRUE>)
	       (<EQUAL? .WRD ,W?INDIGO ,W?VIOLET>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<CONSTANT SH 128>   
<CONSTANT SC 64>    
<CONSTANT SIR 32>   
<CONSTANT SOG 16>
<CONSTANT STAKE 8>  
<CONSTANT SMANY 4>  
<CONSTANT SHAVE 2>  

<ROUTINE GET-OBJECT (TBL
		    "OPTIONAL" (VRB T)
		    "AUX" BTS LEN XBITS TLEN (GCHECK <>) (OLEN 0) OBJ ADJ X)
 <SET XBITS ,P-SLOCBITS>
 <SET TLEN <GET .TBL ,P-MATCHLEN>>
 ;<COND (,DEBUG <TELL "[GETOBJ: TLEN=" N .TLEN "]" CR>)>
 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT> <RTRUE>)>
 <SET ADJ %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		  ',P-ADJ)
		 (T
		  ',P-ADJN)>>
 <COND (<AND <NOT ,P-NAM> ,P-ADJ>
	<COND (<WT? %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
			    ',P-ADJ)
			   (T ',P-ADJN)>
		    ,PS?OBJECT>
	       <SETG P-NAM %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
				   ',P-ADJ)
				  (T ',P-ADJN)>>
	       <SETG P-ADJ <>>)
	      (<SET BTS <WT? %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
				     ',P-ADJ)
				    (T ',P-ADJN)>
			     ,PS?DIRECTION ,P1?DIRECTION>>
	       <SETG P-ADJ <>>
	       <PUT .TBL ,P-MATCHLEN 1>
	       <PUT .TBL 1 ,INTDIR>
	       <SETG P-DIRECTION .BTS>
	       <RTRUE>)>)>
 <COND (<AND <NOT ,P-NAM>
	     <NOT ,P-ADJ>
	     <NOT <==? ,P-GETFLAGS ,P-ALL>>
	     <ZERO? ,P-GWIMBIT>>
	<COND (.VRB 
	       <NOT-IN-SENTENCE "enough nouns">)> ;"[1]"
	<RFALSE>)>
 <COND (<OR <NOT <==? ,P-GETFLAGS ,P-ALL>> <ZERO? ,P-SLOCBITS>>
	<SETG P-SLOCBITS -1>)>
 <SETG P-TABLE .TBL>
 <PROG ()
  ;<COND (,DEBUG <TELL "[GETOBJ: GCHECK=" N .GCHECK "]" CR>)>
  <COND (.GCHECK
	 ;<COND (,DEBUG <TELL "[GETOBJ: calling GLOBAL-CHECK]" CR>)>
	 <GLOBAL-CHECK .TBL>)
	(T
	 <COND (,LIT
		<FCLEAR ,PLAYER ,TRANSBIT>
		<DO-SL ,HERE ,SOG ,SIR>
		<FSET ,PLAYER ,TRANSBIT>)>
	 <DO-SL ,PLAYER ,SH ,SC>)>
  <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
  ;<COND (,DEBUG <TELL "[GETOBJ: LEN=" N .LEN "]" CR>)>
  <COND (<BTST ,P-GETFLAGS ,P-ALL>)
	(<AND <BTST ,P-GETFLAGS ,P-ONE>
	      <NOT <ZERO? .LEN>>>
	 <COND (<NOT <==? .LEN 1>>
		<PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
		<TELL "[How about" T <GET .TBL 1> "?]" CR>)>
	 <PUT .TBL ,P-MATCHLEN 1>)
	(<OR <G? .LEN 1>
	     <AND <ZERO? .LEN> <NOT <==? ,P-SLOCBITS -1>>>>
	 <COND (<==? ,P-SLOCBITS -1>
		<SETG P-SLOCBITS .XBITS>
		<SET OLEN .LEN>
		<PUT .TBL ,P-MATCHLEN <- <GET .TBL ,P-MATCHLEN> .LEN>>
		<AGAIN>)
	       (T
		<COND (<ZERO? .LEN> <SET LEN .OLEN>)>
		<COND (<AND ,P-NAM
			    ;<REMOTE-VERB?>
			    <SET OBJ <GET .TBL <+ .TLEN 1>>>
			    <SET OBJ <APPLY <GETP .OBJ ,P?GENERIC> ;.TBL>>>
		       <COND (<==? .OBJ ,NOT-HERE-OBJECT>
			      <RFALSE>)>
		       <PUT .TBL 1 .OBJ>
		       <PUT .TBL ,P-MATCHLEN 1>
		       <SETG P-NAM <>>
		       %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
			       '<SETG P-ADJ <>>)
			      (T
			       '<PROG ()
				      <SETG P-ADJ <>>
				      <SETG P-ADJN <>>>)>
		       <RTRUE>)
		      (<AND .VRB ;".VRB added 8/14/84 by JW"
			    <NOT <==? ,WINNER ,PLAYER>>>
		       <TELL "[Please try saying that another way.]" CR>
		       <RFALSE>)
		      (<AND .VRB ,P-NAM>
		       <WHICH-PRINT .TLEN .LEN .TBL>
		       <SETG P-ACLAUSE
			     <COND (<==? .TBL ,P-PRSO> ,P-NC1)
				   (T ,P-NC2)>>
		       <SETG P-AADJ ,P-ADJ>
		       <SETG P-ANAM ,P-NAM>
		       <ORPHAN <> <>>
		       <SETG P-OFLAG T>)
		      (.VRB
		       <NOT-IN-SENTENCE "enough nouns">)> ;"[2]"
		<SETG P-NAM <>>
		<SETG P-ADJ <>>
		<RFALSE>)>)
	(<AND <ZERO? .LEN> .GCHECK>
	 <COND (.VRB
		<SETG P-SLOCBITS .XBITS> ; "RETROFIX #33"
		<COND (<OR ,LIT <SPEAKING-VERB?>>
		       <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
		       <SETG P-XNAM ,P-NAM>
		       <SETG P-NAM <>>
		       %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
			       '<PROG ()
				      <SETG P-XADJ ,P-ADJ>
				      <SETG P-ADJ <>>>)
			      (T
			       '<PROG ()
				      <SETG P-XADJ ,P-ADJ>
				      <SETG P-XADJN ,P-ADJN>
				      <SETG P-ADJ <>>
				      <SETG P-ADJN <>>>)>
		       <RTRUE>)
		      (T
		       <TOO-DARK>)>)>
	 <SETG P-NAM <>>
	 <SETG P-ADJ <>>
	 <RFALSE>)
	(<ZERO? .LEN>
	 <SET GCHECK T>
	 ;<COND (,DEBUG <TELL "[GETOBJ: GCHECK set to " N .GCHECK "]" CR>)>
	 <AGAIN>)>
  <SET X <GET .TBL <+ .TLEN 1>>>
  ;<COND (<AND ,P-ADJ <NOT ,P-NAM> .X>
	 <TELL ,I-ASSUME T .X ".)" CR>)>
  <SETG P-SLOCBITS .XBITS>
  <SETG P-NAM <>>
  <SETG P-ADJ <>>
  <RTRUE>>>

<ROUTINE SPEAKING-VERB? ("OPTIONAL" (V <>))
	 <COND (<NOT .V> 
		<SET V ,PRSA>)>
	 <COND (<OR <EQUAL? .V ,V?ASK-ABOUT ,V?ASK-FOR ,V?HELLO>
		    <EQUAL? .V ,V?TELL ,V?QUESTION ,V?REPLY>
		    ;<EQUAL? .V ,V?WHAT-ABOUT ,V?GOODBYE>>
	       <RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL P-MOBY-FOUND <>>

<GLOBAL P-MOBY-FLAG <>> ; "Needed only for ZIL"

; "This MOBY-FIND works in ZIP only!"

; <ROUTINE MOBY-FIND (TBL "AUX" (OBJ 1) LEN FOO)
         <SETG P-NAM ,P-XNAM>
         <SETG P-ADJ ,P-XADJ>
         <PUT .TBL ,P-MATCHLEN 0>
         <REPEAT ()
		 <COND (<AND <SET FOO <META-LOC .OBJ>>
			     <SET FOO <THIS-IT? .OBJ>>>
			<SET FOO <OBJ-FOUND .OBJ .TBL>>)>
		 <COND (<IGRTR? OBJ ,DUMMY-OBJECT>
			<RETURN>)>>
	 <SET LEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<EQUAL? .LEN 1>
		<SETG P-MOBY-FOUND <GET .TBL 1>>)>
	 .LEN>

"This MOBY-FIND works in both ZIL and ZIP."

<ROUTINE MOBY-FIND (TBL "AUX" (OBJ 1) LEN FOO)
           <SETG P-NAM ,P-XNAM>
           <SETG P-ADJ ,P-XADJ>
           <PUT .TBL ,P-MATCHLEN 0>
           <COND (<NOT <ZERO? <GETB 0 18>>>	;"ZIP case"
	          <REPEAT ()
		          <COND (<AND <SET FOO <META-LOC .OBJ>>
			              <SET FOO <THIS-IT? .OBJ>>>
			         <SET FOO <OBJ-FOUND .OBJ .TBL>>)>
		          <COND (<IGRTR? OBJ ,DUMMY-OBJECT>
			         <RETURN>)>>
	          <SET LEN <GET .TBL ,P-MATCHLEN>>
	          <COND (<EQUAL? .LEN 1>
		         <SETG P-MOBY-FOUND <GET .TBL 1>>)>
	          <SETG P-NAM <>>
		  <SETG P-ADJ <>>
		  .LEN)
	         (T		;"ZIL case"
	          <SETG P-MOBY-FLAG T>
	          <SETG P-TABLE .TBL>
	          <SETG P-SLOCBITS -1>
	          <SET FOO <FIRST? ,ROOMS>>
	          <REPEAT ()
		          <COND (<NOT .FOO>
				 <RETURN>)
		                (T
			         <SEARCH-LIST .FOO .TBL ,P-SRCALL>
			         <SET FOO <NEXT? .FOO>>)>>
		  <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
		         <DO-SL ,LOCAL-GLOBALS 1 1>)>
	          <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
		         <DO-SL ,ROOMS 1 1>)>
	          <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
		         <SETG P-MOBY-FOUND <GET .TBL 1>>)>
	          <SETG P-MOBY-FLAG <>>
	          <SETG P-NAM <>>
		  <SETG P-ADJ <>>
		  .LEN)>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <SET RLEN .LEN>
	 <TELL "[Which">
         <COND (<EQUAL? ,P-NAM ,W?PLANK>
		<TELL " end">)
	       (<OR ,P-OFLAG ,P-MERGED ,P-AND>
	        <TELL " ">
	        <PRINTB ,P-NAM>)
	       (<==? .TBL ,P-PRSO>
		<CLAUSE-PRINT ,P-NC1 ,P-NC1L <>>)
	       (T <CLAUSE-PRINT ,P-NC2 ,P-NC2L <>>)>
	 <TELL " do you mean,">
	 <REPEAT ()
		 <SET TLEN <+ .TLEN 1>>
		 <SET OBJ <GET .TBL .TLEN>>
		 <TELL T .OBJ>
		 <COND (<==? .LEN 2>
		        <COND (<NOT <==? .RLEN 2>> <TELL ",">)>
		        <TELL " or">)
		       (<G? .LEN 2> <TELL ",">)>
		 <COND (<L? <SET LEN <- .LEN 1>> 1>
		        <TELL "?]" CR>
		        <RETURN>)>>>

<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<COND (<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	       <SET RMGL <RMGL-SIZE .RMG>>
	       ;<COND (,DEBUG <TELL "[GLBCHK: (LG) RMGL=" N .RMGL "]" CR>)>
	       <REPEAT ()
		       <SET OBJ <GET/B .RMG .CNT>>
		       <COND (<FIRST? .OBJ>
			      <SEARCH-LIST .OBJ .TBL ,P-SRCALL>)>
		       <COND (<THIS-IT? .OBJ>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<SET RMG <GETP ,HERE ,P?THINGS>>
	       <SET RMGL <GET .RMG 0>>
	       <SET CNT 0>
	       <REPEAT ()
		<COND (<AND ,P-NAM
			    <NOT <EQUAL? ,P-NAM <GET .RMG <+ .CNT 1>>>>>)
		      (<AND ,P-ADJ
			    <NOT <EQUAL? ,P-ADJN <GET .RMG <+ .CNT 2>>>>>)
		      (<OR ,P-NAM ,P-ADJ>
		       ;<SETG P-PNAM ,P-NAM>
		       ;<COND (,P-ADJ
			      <SETG P-PADJN ,P-ADJN>)
			     (T
			      <SETG P-PADJN <>>)>
		       <SETG LAST-PSEUDO-LOC ,HERE>
		       <PUTP ,PSEUDO-OBJECT ,P?ACTION <GET .RMG <+ .CNT 3>>>
		       <SET FOO <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5>>
		       <SET RMG <GET .RMG <+ .CNT 1>>>
		       <PUT .FOO 0 <GET .RMG 0>>
		       <PUT .FOO 1 <GET .RMG 1>>
		       <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
		       <RETURN>)>
		<SET CNT <+ .CNT 3>>
		<COND (<NOT <L? .CNT .RMGL>>
		       <RETURN>)>>)>
	;<COND (<SET RMG <GETPT ,HERE ,P?PSEUDO>>
	       <SET RMGL <- </ <PTSIZE .RMG> 4> 1>>
	       <SET CNT 0>
	       ;<COND (,DEBUG <TELL "[GLBCHK: (PS) RMGL=" N .RMGL "]" CR>)>
	       <REPEAT ()
		       <COND (<==? ,P-NAM <GET .RMG <* .CNT 2>>>
			      <SETG LAST-PSEUDO-LOC ,HERE>
			      <PUTP ,PSEUDO-OBJECT
				    ,P?ACTION
				    <GET .RMG <+ <* .CNT 2> 1>>>
			      <SET FOO
				   <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5>>
			      <PUT .FOO 0 <GET ,P-NAM 0>>
			      <PUT .FOO 1 <GET ,P-NAM 1>>
			      <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
			      <RETURN>)
		             (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<==? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	       <COND (<ZERO? <GET .TBL ,P-MATCHLEN>>
		      <COND (<VERB? EXAMINE CHASTISE LOOK-INSIDE FIND
				    FOLLOW LEAVE SEARCH SMELL ENTER WALK-TO
				    WAIT-FOR LOOK-ON>
			     <DO-SL ,ROOMS 1 1>)>)>)>>

<ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BITS) 
	;#DECL ((OBJ) OBJECT (BIT1 BIT2 BITS) FIX)
	<COND (<BTST ,P-SLOCBITS <+ .BIT1 .BIT2>>
	       <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCALL>)
	      (T
	       <COND (<BTST ,P-SLOCBITS .BIT1>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCTOP>)
		     (<BTST ,P-SLOCBITS .BIT2>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCBOT>)
		     (T <RTRUE>)>)>>  

<CONSTANT P-SRCBOT 2>    

<CONSTANT P-SRCTOP 0>    

<CONSTANT P-SRCALL 1>    

<ROUTINE SEARCH-LIST (OBJ TBL LVL)
 ;<COND (<EQUAL? .OBJ ,GLOBAL-OBJECTS> <SET GLOB T>) (T <SET GLOB <>>)>
 <COND (<SET OBJ <FIRST? .OBJ>>
	<REPEAT ()
		;<COND (<AND .GLOB ,DEBUG>
		       <TELL "[SRCLST: OBJ=" D .OBJ "]" CR>)>
		<COND (<AND <NOT <==? .LVL ,P-SRCBOT>>
			    <GETPT .OBJ ,P?SYNONYM>
			    <THIS-IT? .OBJ>>
		       <OBJ-FOUND .OBJ .TBL>)>
		<COND (<AND <OR <NOT <==? .LVL ,P-SRCTOP>>
			        <FSET? .OBJ ,SEARCHBIT>	;"Z0 deleted this"
				<FSET? .OBJ ,SURFACEBIT>>
			    <FIRST? .OBJ>
			    <SEE-INSIDE? .OBJ>
			  ; <OR <SEE-INSIDE? .OBJ>
			        <FSET? .OBJ ,SURFACEBIT> ; "ADDED 3/26/85"
			        <FSET? .OBJ ,OPENBIT>
			        <FSET? .OBJ ,TRANSBIT>
			        ,P-MOBY-FLAG ; "Needed only for ZIL"
			        <AND <FSET? .OBJ ,ACTORBIT>
				     <NOT <==? .OBJ ,PLAYER>>>>
			  ; <NOT <EQUAL? .OBJ ,PLAYER ,LOCAL-GLOBALS>>>
		       <SEARCH-LIST .OBJ .TBL
				    <COND (<FSET? .OBJ ,SURFACEBIT>
					   ,P-SRCALL)
					  (<FSET? .OBJ ,SEARCHBIT>
					   ,P-SRCALL)	;"Z0 deleted this"
					  (T
					   ,P-SRCTOP)>>)>
		<COND (<SET OBJ <NEXT? .OBJ>>) (T <RETURN>)>>)>>

<ROUTINE THIS-IT? (OBJ "AUX" SYNS) 
 <COND (<FSET? .OBJ ,INVISIBLE>
	<RFALSE>)
       (<AND ,P-NAM
	     <OR <NOT <SET SYNS <GETPT .OBJ ,P?SYNONYM>>>
		 <NOT <ZMEMQ ,P-NAM .SYNS <- </ <PTSIZE .SYNS> 2> 1>>>>>
	<RFALSE>)
       (<AND ,P-ADJ
	     <OR <NOT <SET SYNS <GETPT .OBJ ,P?ADJECTIVE>>>
		 <NOT <ZMEMQB ,P-ADJ .SYNS <- <PTSIZE .SYNS> 1>>>>>
	<RFALSE>)
       (<AND <NOT <ZERO? ,P-GWIMBIT>> <NOT <FSET? .OBJ ,P-GWIMBIT>>>
	<RFALSE>)>
 <RTRUE>>

<ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR) 
	;#DECL ((OBJ) OBJECT (TBL) TABLE (PTR) FIX)
	<SET PTR <GET .TBL ,P-MATCHLEN>>
	<PUT .TBL <+ .PTR 1> .OBJ>
	<PUT .TBL ,P-MATCHLEN <+ .PTR 1>>> 
 
<ROUTINE TAKE-CHECK () 
	<AND <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
	     <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>> 

<ROUTINE ITAKE-CHECK (TBL BITS "AUX" PTR OBJ TAKEN) 
	 ;"changed by MARC 11/17/83"
	 ;#DECL ((TBL) TABLE (BITS PTR) FIX (OBJ) OBJECT
		(TAKEN) <OR FALSE FIX ATOM>)
 <COND (<AND <SET PTR <GET .TBL ,P-MATCHLEN>>
	     <OR <BTST .BITS ,SHAVE>
		 <BTST .BITS ,STAKE>>>
	<REPEAT ()
	 <COND (<L? <SET PTR <- .PTR 1>> 0> <RETURN>)>
	 <SET OBJ <GET .TBL <+ .PTR 1>>>
	 <COND (<==? .OBJ ,IT>
		<COND (<OR <NOT ,P-IT-OBJECT>
			   <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
		       <REFERRING ;MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-IT-OBJECT>)>)
	       (<==? .OBJ ,HER>
		<COND (<OR <NOT ,P-HER-OBJECT>
			   <NOT <ACCESSIBLE? ,P-HER-OBJECT>>>
		       <REFERRING ;MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-HER-OBJECT>)>)
	       (<==? .OBJ ,HIM>
		<COND (<OR <NOT ,P-HIM-OBJECT>
			   <NOT <ACCESSIBLE? ,P-HIM-OBJECT>>>
		       <REFERRING ;MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-HIM-OBJECT>)>)
	       (<==? .OBJ ,THEM>
		<COND (<OR <NOT ,P-THEM-OBJECT>
			   <NOT <ACCESSIBLE? ,P-THEM-OBJECT>>>
		       <REFERRING ;MORE-SPECIFIC>
		       <RFALSE>)
		      (T
		       <SET OBJ ,P-THEM-OBJECT>)>)>
	 <COND (<AND <NOT <ULTIMATELY-IN? .OBJ>>
		     <NOT <EQUAL? .OBJ ,HANDS ,YOUR-FEET>>>
		<SETG PRSO .OBJ>
		<COND (<FSET? .OBJ ,TRYTAKEBIT>
		       <SET TAKEN T>)
		      (<AND <ULTIMATELY-IN? .OBJ ,BUCKET>
			    ,BUCKET-PEG>
		       <SET TAKEN T>) ;"you can't take from bucket on peg"
		      (<NOT <==? ,WINNER ,PLAYER>>
		       <SET TAKEN <>>)
		      (<AND <BTST .BITS ,STAKE>
			    <==? <ITAKE <>> T>>
		       <SET TAKEN <>>)
		      (<AND <VERB? PUT>
			    <EQUAL? .OBJ ,WATER>>
		       ;"else PUT WATER IN BUCKET says YOU'RE NOT HOLDING..."
		       <RTRUE>)
		      (T
		       <SET TAKEN T>)>
		<COND (<AND .TAKEN <BTST .BITS ,SHAVE>>
		       <TELL "[You don't seem to be holding">
		       <COND (<L? 1 <GET .TBL ,P-MATCHLEN>>
			      <TELL " all those things">)
			     (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
			      <TELL " that">)
			     (T
			      <THIS-IS-IT .OBJ>
			      <TELL T .OBJ>)>
		       <TELL "!]" CR>
		       <RFALSE>)
		      (<AND <NOT .TAKEN>
			    <==? ,WINNER ,PLAYER>>
		       <TELL "[taking" T ,PRSO>
		       <COND (,ITAKE-LOC
			      <TELL " from" T ,ITAKE-LOC>)>
		       <TELL " first]" CR>)>)>>)
       (T)>>  

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)
        <COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (.LOSS
	     ; <TELL "[" ,YOU-CANT "use more than one ">
	     ; <COND (<==? .LOSS 2>
		      <TELL "in">)>
	     ; <TELL "direct object with \"">
	       <TELL "[" ,YOU-CANT "use more than one object at a time with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP>
		      <TELL "tell">)
		     (<OR ,P-OFLAG ,P-MERGED>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL ".\"]" CR>
	       <RFALSE>)
	      (T
	       <RTRUE>)>>

<ROUTINE ZMEMQ (ITM TBL "OPTIONAL" (SIZE -1) "AUX" (CNT 1)) 
	<COND (<NOT .TBL> <RFALSE>)>
	<COND (<NOT <L? .SIZE 0>> <SET CNT 0>)
	      (ELSE <SET SIZE <GET .TBL 0>>)>
	<REPEAT ()
		<COND (<==? .ITM <GET .TBL .CNT>>
		       <RETURN <+ .CNT 1>>)
		      (<IGRTR? CNT .SIZE> <RFALSE>)>>>

; <ROUTINE ZMEMZ (ITM TBL "AUX" (CNT 0)) 
	<COND (<NOT .TBL> <RFALSE>)>
	<REPEAT ()
		<COND (<ZERO? <GET .TBL .CNT>>
		       <RFALSE>)
		      (<==? .ITM <GET .TBL .CNT>>
		       <COND (<ZERO? .CNT> <RTRUE>)
			     (T <RETURN .CNT>)>)
		      (T <INC CNT>)>>>

<ROUTINE ZMEMQB (ITM TBL SIZE "AUX" (CNT 0)) 
	;#DECL ((ITM) ANY (TBL) TABLE (SIZE CNT) FIX)
	<REPEAT ()
		<COND (<==? .ITM <GETB .TBL .CNT>>
		       <COND (<ZERO? .CNT> <RTRUE>)
			     (T <RETURN .CNT>)>)
		      (<IGRTR? CNT .SIZE> <RFALSE>)>>>

; <ROUTINE ZMEMQBIT (ITM TBL SIZE "AUX" (CNT 0) X)
	;#DECL ((ITM) ANY (TBL) TABLE (SIZE CNT) FIX)
	<REPEAT ()
		<COND (<FSET? <SET X <GETB .TBL .CNT>> .ITM> <RETURN .X>)
		      (<IGRTR? CNT .SIZE> <RFALSE>)>>>

<ROUTINE LIT? (RM "AUX" OHERE (LIT <>) (OGWIM <>))
	<SET OHERE ,HERE>
	<SETG HERE .RM>
	<COND (<FSET? .RM ,ONBIT>
	       <SET LIT T>)
	      (<AND <EQUAL? .RM ,ON-POOL-1>
		    <LIT? ,BOAT-DOCK>>
	       <SET LIT T>)
	      (<AND <EQUAL? .RM ,ON-POOL-2>
		    <LIT? ,LEDGE>>
	       <SET LIT T>)
	      (T
	       <SET OGWIM ,P-GWIMBIT>
	       <SETG P-GWIMBIT ,ONBIT>
	       <PUT ,P-MERGE ,P-MATCHLEN 0>
	       <SETG P-TABLE ,P-MERGE>
	       <SETG P-SLOCBITS -1>
	       <COND (<==? .OHERE .RM>
		      <DO-SL ,WINNER 1 1>
		      <COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
				  <IN? ,PLAYER .RM>>
			     <DO-SL ,PLAYER 1 1>)>)>
	       <DO-SL .RM 1 1>
	       <COND (<G? <GET ,P-TABLE ,P-MATCHLEN> 0>
		      <SET LIT T>)>)>
	<SETG HERE .OHERE>
	<SETG P-GWIMBIT .OGWIM>
	.LIT>

; <ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<ROUTINE PICK-ONE (FROB "OPTIONAL" (THIS <>) "AUX" L CNT RND MSG RFROB)
	 <SET L <GET .FROB 0>>
	 <SET CNT <GET .FROB 1>>
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <COND (<AND .THIS 
		     <ZERO? .CNT>>
		<SET RND .THIS>)
	       (T 
		<SET RND <RANDOM <- .L .CNT>>>)>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> 
		<SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<ROUTINE PICK-REMOVE (OBJ FROB "AUX" L CNT RND MSG RFROB ROBJ)
	 <SET L <GET .FROB 0>>
	 <SET CNT <GET .FROB 1>>
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* <+ .CNT 1> 2>>>
	 <COND (<SET RND <ZMEMQ .OBJ .RFROB <- .L .CNT>>>
		<SET RND <- .RND 1>>
		<SET MSG <GET .RFROB .RND>>
		<PUT .RFROB .RND <GET .RFROB 0>>
		<PUT .RFROB 0 .MSG>
		<SET CNT <+ .CNT 1>>
		<COND (<==? .CNT .L> 
		       <SET CNT 0>)>
		<PUT .FROB 0 .CNT>
		.MSG)>>

<ROUTINE DONT-HAVE? (OBJ "AUX" WHERE)
	 <SET WHERE <LOC .OBJ>>
	 <COND (<EQUAL? .WHERE ,PLAYER>
		<RFALSE>)
	       (<IN? .WHERE ,PLAYER>
		<TELL "You'll have to take" T .OBJ " ">
		<COND (<FSET? .WHERE ,CONTBIT>
		       <TELL "out">)
		      (T
		       <TELL "off">)>
		<TELL " of" T .WHERE " first." CR>)
	       (T
		<NOT-HOLDING .OBJ>
		<RTRUE>)>>

<ROUTINE NOT-HOLDING ("OPTIONAL" (OBJ <>))
	 <TELL "You're not holding">
	 <COND (.OBJ
		<TELL T .OBJ>)
	       (T
		<TELL " that">)>
	 <TELL "." CR>>

<ROUTINE ASKING? (ACTOR)
	 <COND (<AND <VERB? ASK-ABOUT ASK-FOR QUESTION>
		     <EQUAL? ,PRSO .ACTOR>>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TALKING-TO? (ACTOR)
	 <COND (<ASKING? .ACTOR>
		<RTRUE>)
	       (<AND <VERB? TELL HELLO WAVE-AT REPLY ALARM>
		     <EQUAL? ,PRSO .ACTOR>>
	        <RTRUE>) 
	       (T
		<RFALSE>)>>

<ROUTINE TOUCHING? (THING)
	 <COND (<OR <EQUAL? ,PRSA ,V?TAKE ,V?RUB ,V?SHAKE>
		    <EQUAL? ,PRSA ,V?SWING ;,V?PLAY ;,V?SPIN>
		    <EQUAL? ,PRSA ,V?CLEAN ,V?PUT ,V?PUT-ON>
		    <EQUAL? ,PRSA ,V?MOVE ,V?PULL ,V?PUSH>
		    <EQUAL? ,PRSA ,V?PUT-UNDER ,V?PUT-BEHIND ,V?SMELL>
		    <EQUAL? ,PRSA ,V?KISS ,V?BURN>
		    <HURT? .THING>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE HURT? (THING)
	 <COND (<AND <OR <EQUAL? ,PRSA ,V?MUNG ,V?KICK ,V?KILL>
			 <EQUAL? ,PRSA ,V?KNOCK ,V?SQUEEZE ,V?CUT>
			 <EQUAL? ,PRSA ,V?BITE ,V?RAPE ,V?SHAKE>>
		     <EQUAL? ,PRSO .THING>>
		<RTRUE>)
	       (<AND <VERB? THROW>
		     <EQUAL? ,PRSI .THING>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE ENTER-FROM? (ENTRY "OPTIONAL" (DEST <>) (PLACE <>))
	 <COND (<VERB? WALK-TO ENTER>
		<COND (<EQUAL? ,HERE .ENTRY>
		       <DO-WALK ,P?IN>)
		      (<AND .DEST .PLACE
		            <EQUAL? ,HERE .DEST>>
		       <ALREADY-IN .PLACE>)
		      (T
		       <HOW?>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE USE-DOOR? (OUTSIDE)
	 <COND (<VERB? WALK-TO ENTER USE>
		<COND (<EQUAL? ,HERE .OUTSIDE>
		       <DO-WALK ,P?IN>)
		      (T
		       <DO-WALK ,P?OUT>)>
		<RTRUE>)
	       (<VERB? EXIT>
		<COND (<EQUAL? ,HERE .OUTSIDE>
		       <V-WALK-AROUND>)
		      (T
		       <DO-WALK ,P?OUT>)>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ANYONE-HERE? ("AUX" OBJ)
	 <SET OBJ <FIRST? ,HERE>>
	 <REPEAT ()
	         <COND (<NOT .OBJ>
			<RETURN>)
		       (<AND <FSET? .OBJ ,ACTORBIT>
			     <NOT <EQUAL? .OBJ ,PLAYER>>>
		        <RETURN>)
		       (T
			<SET OBJ <NEXT? .OBJ>>)>>
	 <RETURN .OBJ>>

<ROUTINE GETTING-INTO? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?WALK-TO ,V?ENTER>
		    <EQUAL? ,PRSA ,V?SIT ,V?STAND-ON ,V?LIE-DOWN>
		    <EQUAL? ,PRSA ,V?CLIMB-UP ,V?CLIMB-ON ,V?LEAP>
		    <EQUAL? ,PRSA ,V?SWIM ,V?WEAR ,V?WALK-AROUND>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SAY-THE (THING)
	 <TELL "The " D .THING>>

<ROUTINE BUT-THE (THING)
	 <TELL "But" T .THING " ">>

<ROUTINE MOVING? (THING)
	 <COND (<AND <OR <EQUAL? ,PRSA ,V?MOVE ,V?PULL ,V?PUSH>
		         <EQUAL? ,PRSA ,V?TAKE ,V?TURN ,V?PUSH-TO>
		         <EQUAL? ,PRSA ,V?RAISE ;,V?SPIN ,V?SHAKE>>
		     <EQUAL? ,PRSO .THING>>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT NOT-HERE-OBJECT
	(DESC "that")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ ; (X <>))
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	       
	<COND (.PRSO?
		<COND (<OR <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?BUY>
			   <EQUAL? ,PRSA ,V?WAIT-FOR ,V?WALK-TO>
			   <AND <EQUAL? ,PRSA ,V?TAKE>
				<NOT <EQUAL? ,WINNER ,PLAYER>>>>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RFATAL>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<EQUAL? ,PRSA ,V?TELL ,V?ASK-ABOUT ,V?ASK-FOR>
		       <RFALSE>)>)>
	 
	 <TELL ,YOU-CANT "see">
	 <COND (<NOT <NAME? ,P-XNAM>>
		<TELL " any">)>
	 <NOT-HERE-PRINT .PRSO?>
	 <TELL " here!" CR>
	 <PCLEAR>
	 <RFATAL>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	<SET M-F <MOBY-FIND .TBL>>
	<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       <COND (,DEBUG <TELL "[Namely:" D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      ;(<EQUAL? ,PRSA ,V?TELL ,V?ASK-FOR ,V?ASK-ABOUT>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

; <ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ "AUX" TARGET)
	 <PCLEAR>
	 <COND (<EQUAL? .OBJ ,PRSO>
		<SET TARGET ,PRSO>)
	       (T
		<SET TARGET ,PRSI>)>
	 <YOU-CANT-SEE>
	 <COND (<NOT <FSET? .TARGET ,ACTORBIT>>
		<TELL "any ">)>
	 <TELL D .TARGET " here!" CR>>

<ROUTINE NOT-HERE-PRINT ("OPTIONAL" (PRSO? <>))
	 <COND (<OR ,P-OFLAG ,P-MERGED>
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
				       ',P-XADJ)
				      (T
				       ',P-XADJN)>>)>
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

;"MOVE-ALL ,FOO removes obj. MOVE-ALL ,FOO ,HERE moves obj to here."

<ROUTINE MOVE-ALL (FROM "OPTIONAL" (TO <>) "AUX" OBJ NXT)
	 ;"doesn't move fuse from cannon"
	 <SET OBJ <FIRST? .FROM>>
	 <REPEAT ()
		 <COND (.OBJ
		        <SET NXT <NEXT? .OBJ>>
		        <FCLEAR .OBJ ,WORNBIT>
			<COND (<NOT <EQUAL? .OBJ ,FUSE>>
			       <COND (.TO
			       	      <MOVE .OBJ .TO>)
				     (T
				      <REMOVE .OBJ>)>)>
			<SET OBJ .NXT>)
		       (T
			<RETURN>)>>>

;<ROUTINE MOVE-ALL (FROM TO "AUX" OBJ NXT)
	 <SET OBJ <FIRST? .FROM>>
	 <REPEAT ()
		 <COND (.OBJ
		        <SET NXT <NEXT? .OBJ>>
		        <FCLEAR .OBJ ,WORNBIT>
			<MOVE .OBJ .TO>
		        <SET OBJ .NXT>)
		       (T
		        <RTRUE>)>>>

;<ROUTINE REMOVE-ALL (THING "AUX" OBJ NXT)
	 <SET OBJ <FIRST? .THING>>
	 <REPEAT ()
		 <COND (<ZERO? .OBJ>
			<RTRUE>)>
		 <SET NXT <NEXT? .OBJ>>
		 <REMOVE .OBJ>
		 <SET OBJ .NXT>>
	 <RTRUE>>

<CONSTANT M-OBJDESC? 9>	;"modify if necessary for games with other M-..."

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TBL)
	 <COND (<SET TBL <GETPT .OBJ2 ,P?GLOBAL>>
		%<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
			'<ZMEMQ  .OBJ1 .TBL <RMGL-SIZE .TBL>>)
		       (T
			'<ZMEMQB .OBJ1 .TBL <RMGL-SIZE .TBL>>)>)>>

;<ROUTINE ARTICLE (OBJ "OPTIONAL" (THE <>))
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<RFALSE>)
	       (.THE
		<TELL "the ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL "an ">)
	       (T
		<TELL "a ">)>>

<GLOBAL YOU-SEE "You can see">

;<ROUTINE HELD? (OBJ)
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ ,PLAYER>
		<RTRUE>)
	       (<IN? .OBJ ,WINNER>
		<RTRUE>)
	       ;(<NOT <FSET? .OBJ ,TAKEBIT>>
		<RFALSE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<ULTIMATELY-IN? <LOC .OBJ>>)>>

<ROUTINE WHAT-A-CONCEPT ()
	 <TELL "What a concept!" CR>>

<ROUTINE YOU-DONT-NEED (THING "OPTIONAL" (STRING? <>))
	 <TELL "[You don't need to refer to">
	 <COND (.STRING?
		<TELL T .THING>)
	       (T
		<TELL T .THING>)>
	 <TELL " that way to finish this story.]" CR>>	 

<ROUTINE ITS-CLOSED (OBJ)
	 <THIS-IS-IT .OBJ>
	 <SAY-THE .OBJ>
	 <IS-CLOSED>
	 <CRLF>>

<ROUTINE IS-CLOSED ()
	 <TELL " is closed.">>

; <ROUTINE IF-YOU-TRIED ()
	 <TELL " if you tried that!" CR>>

; <ROUTINE OPEN-CLOSED (THING "OPTIONAL" (N? <>))
	 <COND (<FSET? .THING ,OPENBIT>
		<COND (.N?
		       <TELL "n">)>
		<TELL " open ">)
	       (T
		<TELL " closed ">)>>

; <CONSTANT P-PROMPT-START 9>
; <GLOBAL P-PROMPT 9>

; <ROUTINE I-PROMPT ("OPTIONAL" (GARG <>))
           <SETG P-PROMPT <- ,P-PROMPT 1>>
           <RFALSE>>

;<ROUTINE I-PROMPT-1 ()
	 <SETG P-PROMPT 1>
	 <RFALSE>>

;<ROUTINE I-PROMPT-2 ()
         <COND (,P-PROMPT
	        <SETG P-PROMPT <>>
	        <TELL CR
"(You won't see the \"What next?\" prompt any more.)">
	      ; <COND (<VERB? WAIT-FOR ;WAIT ;WAIT-UNTIL> 
	               <CRLF>)>
	        <DEQUEUE I-PROMPT-2>
	        <RFALSE>)>>