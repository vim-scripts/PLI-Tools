" PLI indent file
" Language:	IBM-PLI (z/OS, OS/370)
" Maintainer:	Ing.Michael Fitz
" Last Change:	2004-06-17_17:14:23

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1
let b:NextIndent=-1  "For indenting next coming line

" Some preliminary setting
setlocal indentkeys=!,o,O,0=~dcl,0=~declare,:
setlocal indentexpr=Get_PL1_Indent(v:lnum)

" Only define the function once.
if exists("*Get_PL1_Indent")
  finish
endif

let s:NonDos='then\|else\|when\|other\(wise\)\='
let s:Dos='do\|begin\|select'

function s:CheckMatch(ZeileN,Zeile,Pattern)
  let Col=match(a:Zeile,a:Pattern)
  if(Col<0)
    return(0)
  endif
  let Sid=synIDattr(synID(a:ZeileN,Col+1, 1), "name")
let qMatched=!(Sid=='pliComment' || Sid=='pliSQL_Statement' || Sid=='pliCICS_Statement' || Sid=='pliString')
"  call confirm("CheckMatch2(".a:ZeileN.','.Col.')=<'.Sid.">\r---<".a:Zeile.">--- qMatched=".qMatched)
return(qMatched)
endfun

function Get_PL1_Indent(lnum)
let xS='LV='.v:lnum.',LA='.a:lnum
  " Search backwards for the first non-empty line.
  let plnum =  prevnonblank(a:lnum-1)

  if plnum == 0
    " This is the first non-empty line, use zero indent.
    return 1
  endif

  let curind = indent(plnum)
  let curind0=curind
  let xS=xS.',LP='.plnum.',Calt='.curind
  if(b:NextIndent>=0)
    let xS=xS.';NI='.b:NextIndent
    let curind=b:NextIndent
    let b:NextIndent=-1
  endif

  let aZeile=getline(a:lnum) "Current line
  let pZeile=getline(plnum) "Vorgänger

  let qNeu=0
  " call confirm(xS . "\nPZ=".pZeile."\nAZ=".aZeile)
  if s:CheckMatch(plnum,pZeile,'\<\(' . s:NonDos .'\|'. s:Dos. '\)\>')
  "if pZeile =~ '\<\(' . s:NonDos .'\|'. s:Dos. '\)\>'
    " Rightindent one tab
    let curind=curind+&sw
    let qNeu=1
    " call confirm(xS.' *DO+')
  elseif s:CheckMatch(plnum,pZeile,'\<end\>')
  "elseif pZeile =~ '\<end\>'
    let curind=curind-&sw
    " call confirm(xS.' *END')
  elseif s:CheckMatch(a:lnum,aZeile,'^\s\+\(\<\(dcl\|declare\)\>\|\K\k*\:\)')
  "elseif aZeile =~ '^\s\+\(\<\(dcl\|declare\)\>\|\K\k*\:\)'
    let b:NextIndent=curind
    " call confirm(xS.' *DCL')
    return(1)
  endif

  " Check for an single-line 'else'&Co
  if qNeu && !s:CheckMatch(plnum,pZeile,'\<\('.s:Dos.'\)\>') 
"  if qNeu && pZeile !~ '\<\('.s:Dos.'\)\>' 
    if (stridx(pZeile,';')==-1) "incomplete
    " call confirm('AA')
      let b:NextIndent=curind-&sw
    else
    " call confirm('BB')
      let curind=curind0
    endif
  endif
  let xS=xS.',Cneu='.curind
 " call confirm(xS)
  return curind
endfunction

" vim:sw=2
