" Vim syntax file
" Language:	pli 
" Maintainer:	Ing. Michael Fitz
" Last change:	2014-01-25_19:14:57
" Version: 2.0 (some new items merged in from Ricky Wu's z/OS #2685)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


set isk+=#

" PLI is a case insensitive language
syn case ignore


syn keyword pliTodo contained	TODO FIXME XXX


" String
syn region  pliString		start=+'+  end=+'[bx]\=+ contains=pliLine73Error

syn match   pliOperator		"[=!\+\-\*\/\<\>\^|&]"


syn match   pliIdentifier	"\<[a-zA-Z_#][a-zA-Z0-9_#]*\>"

syn match   pliDelimiter	"[();,]"

syn region  pliPreProc		start="%" end=";" contains=pliComment,pliString

syn match   pliNumber 		"[+-]\=\<\d\+\(\(\.\d\+\)\=\(E[+-]\=\d\+\)\=\)\="

" If you don't like tabs
"syn match pliShowTab "\t"
"syn match pliShowTabc "\t"

"when wanted, highlight trailing white space
if exists("c_space_errors")
  syn match	pliSpaceError	"\s*$"
  syn match	pliSpaceError	" \+\t"me=e-1
endif

"
syn match       pliCommentStarter "/\*" contained 
syn region      pliComment	start="/\*" end="\*/" contains=pliLine73Error


syntax match pliLabel "\<[a-zA-Z_#][a-zA-Z0-9_#]*\>:" 
syntax region pliIncludeFile start="%\s*include" end=";"
" syn match   IncludeFile    '^-inc\s\+\S*'


syntax match    pliCommentError	"\*/"
syntax region   pliLine73Error start='\%>72c\S\+' end='$'
"syntax match    pliLine73Error '\%>72c$'

syn region pliSQL_Statement start="EXEC\_s\+SQL" end=";" contains=pliComment,pliString,pliNumber
" TQL ist ein SQL-Dialekt
syn region pliSQL_Statement start="EXEC\_s\+TQL" end=";" contains=pliComment,pliString,pliNumber 
syn region pliCICS_Statement start="EXEC\_s\+CICS" end=";" contains=pliComment,pliString,pliNumber

syn keyword pliType     BIN[ARY] DEC[IMAL] FIXED CHAR VAR[YING] STATIC AUTO BIT UNAL PIC[TURE] BASED 
syn keyword pliType     PTR FLOAT ENTRY POINTER EXTERNAL INIT[IAL] UNAL[IGNED] 

syn keyword pliFlowChange CALL GOTO LEAVE ITERATE RETURN SIGNAL

" Vers 2: added for z/OS Enterprise
syn keyword pliReserved ALLOC[ATE] BEGIN BLKSIZE BUILTIN BY CLOSE CONTROLLED CTL
syn keyword pliReserved DATA DCL DECLARE DEF[INED] DEFAULT DELAY DFT DO
syn keyword pliReserved EDIT ELSE END ENV ERROR EXTERNAL
syn keyword pliReserved FETCH FILE FREE IF INPUT LIKE LIST LOOP MAIN
syn keyword pliReserved ON OPEN OPTIONS ORDER OTHER[WISE] OUTPUT PRINT
syn keyword pliReserved PROC[EDURE] PUT REENTRANT REFER REORDER REPEAT RETURNS
syn keyword pliReserved SELECT SKIP SNAP STREAM SYSTEM THEN
syn keyword pliReserved TO UNTIL WHEN WHILE

" Vers 2: added for z/OS Enterprise
syn keyword pliBuiltin ABS ACOS ACOSF ADD ADDR ADDRDATA ALL ALLOCATE ALLOCATION ALLOCSIZE ANY
syn keyword pliBuiltin ASIN ASINF ATAN ATAND ATANF ATANH AUTOMATIC AVAILABLEAREA BINARYVALUE BINVALUE BITLOCATION
syn keyword pliBuiltin BOOL BYTE CDS CEIL CENT CENTERLEFT CENTERRIGHT CENTRELEFT CENTRERIGHT CHARACTER CHARGRAPHIC
syn keyword pliBuiltin CHARVAL CHECKSTG CHKEOM CHKMNT2 CHKMNTH CHKNUM CHKSIGN COLLATE COMPARE COMPLEX CONJG
syn keyword pliBuiltin COPY COS COSD COSF COSH COUNT CS CSTG CURRENTSIZE CURRENTSTORAGE DATAFIELD
syn keyword pliBuiltin DATE DATETIME DAYS DAYSTODATE DAYSTOSECS DIM[ENSION] DIVIDE DTFORMAT DUMP EMPTY ENDFILE
syn keyword pliBuiltin ENTRYADDR EPSILON ERF ERFC EXP EXPF EXPONENT FILEDDINT FILEDDTEST FILEDDWORD FILEID
syn keyword pliBuiltin FILEOPEN FILEREAD FILESEEK FILETELL FILEWRITE FLOOR GAMMA GETENV GRAPHIC GREGJUL HANDLE HBOUND
syn keyword pliBuiltin HEX HEXIMAGE HIGH HUGE IAND IEOR IMAG INDEX INIT[IAL] INOT IOR
syn keyword pliBuiltin ISIGNED ISLL ISMAIN ISRL IUNSIGNED LBOUND LEFT LENGTH LINENO LOCATION LOG LOG10
syn keyword pliBuiltin LOG10F LOG2 LOGF LOGGAMMA LOW LOWER2 LOWERCASE MAX MAXEXP MAXLENGTH MIN
syn keyword pliBuiltin MINEXP MOD MPSTR MULTIPLY NOFOFL NULL OFFSET OFFSETADD OFFSETDIFF OFFSETSUBTRACT OFFSETVALUE
syn keyword pliBuiltin OMITTED ONCHAR ONCODE ONCONDCOND ONCONDID ONCOUNT ONFILE ONGSOURCE ONKEY ONLOC ONSOURCE
syn keyword pliBuiltin ONSUBCODE ONWCHAR ONWSOURCE ORDINALNAME ORDINALPRED ORDINALSUCC PACKAGENAME PAGENO PICSPEC PLACES PLIASCII
syn keyword pliBuiltin PLICANC PLICKPT PLIDELETE PLIDUMP PLIEBCDIC PLIFILL PLIFREE PLIMOVE PLIOVER PLIREST PLIRETC
syn keyword pliBuiltin PLIRETV PLISAXA PLISAXB PLISRTA PLISRTB PLISRTC PLISRTD POINTER POINTERADD POINTERDIFF POINTERSUBTRACT
syn keyword pliBuiltin POINTERVALUE POLY PRECISION PRED PRESENT PROCEDURENAME PROD PTRADD PTRVALUE PUTENV RADIX
syn keyword pliBuiltin RAISE2 RANDOM RANK REAL REM REPATTERN REPEAT REVERSE RIGHT ROUND RUCHKNUM
syn keyword pliBuiltin SAMEKEY SCALE SEARCH SEARCHR SECS SECSTODATE SECSTODAYS SIGN SIGNED SIN SIND
syn keyword pliBuiltin SINF SINH SIZE SOURCEFILE SOURCELINE SQRT SQRTF STG STORAGE STRING SUBSTR
syn keyword pliBuiltin SUBTRACT SUCC SUM SYSNULL SYSPRINT SYSTEM TALLY TAN TAND TANF TANH
syn keyword pliBuiltin THREADID TIME TIMEDIFF TINY TRANSLATE TRIM TRUNC TYPE UNALLOCATED UNSIGNED UNSPEC
syn keyword pliBuiltin UPPERCASE VALID VALIDDATE VALUE VARGLIST VARGSIZE VERIFY VERIFYR WCHARVAL WEEKDAY WHIGH
syn keyword pliBuiltin WIDECHAR WLOW Y4DATE Y4JULIAN Y4YEAR

" Vers 2: "GO TO" is valid GOTO too 
syn match   pliFlowChange "\<GO\>\s*\<TO\>"

" Folgende BUILTINS sind auch TYPES: FIXED FLOAT EDIT BINARY DECIMAL BIT POINTER 

syn sync lines=50

runtime! syntax/StandardSyntax.VIM

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pli_syntax_inits")
  if version < 508
    let did_pli_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

 " The default methods for highlighting.  Can be overridden later
  HiLink pliLabel			Label
"  HiLink pliConditional		Conditional
"  HiLink pliRepeat			Repeat
  HiLink pliTodo			Todo
  HiLink pliNumber			Number
  HiLink pliOperator			Operator
  HiLink pliDelimiter			Operator
  "HiLink pliShowTab			Error
  "HiLink pliShowTabc			Error
  HiLink pliIdentifier			Identifier
  HiLink pliBuiltIn			Builtin
  HiLink pliReserved			Statement
  HiLink pliFlowChange			FlowChange
  HiLink pliPreProc			PreProc
  HiLink pliCommentError		Error
  HiLink pliLine73Error	                Error
  "HiLink pliCommentString		pliString
  "HiLink pliComment2String		pliString
  "HiLink pliCommentSkip			pliComment
  HiLink pliString			String
  HiLink pliComment			Comment
  HiLink pliType                        Type
  HiLink pliIncludeFile                 IncludeFile
  HiLink pliSQL_Statement               SQL_Statement
  HiLink pliCICS_Statement              CICS_Statement

  delcommand HiLink
endif

let b:current_syntax = "pli"
" vim: ts=8 sw=2

