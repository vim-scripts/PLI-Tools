"  pli.vim: (filetype plugin) for IBM-PLI-language
"  Last Change: 2004-06-17_16:52:10
"  Maintainer:  Michael Fitz
"  Version:     1.0, for Vim 6.3
"  URL:		http://www.vim.org/script.php?script_id=39

" Documentation:
" This maps <leader>U to UPPERCASE only the Source, but no strings and/or comments
" Furthermore it sets the b:match_words for the matchit.vim-script

" allow user to prevent loading
" and prevent duplicate loading
if exists("b:did_ftplugin")
  finish
endif

:function! <SID>PLI_Upcase(What)
let Neu=''
let Alt=a:What
" echo 'Alt:("' . Alt . ')"'
let qOpen=1
let qS="\'"
while(Alt!='')
  let i1=stridx(Alt,"\'")
  let i2=stridx(Alt,"\/*")
  if (i1<0 && i2<0)
    let Neu=Neu.toupper(Alt)
    break
  endif
  let i=0
  let j=0
  if(i1>=0)
    let i=i1+1
    let qS="\'"
    let j=1
  endif
  if (i2>=0 && (i2+2<i || i==0))
    let i=i2+2
    let qS="\*\/"
    let j=2
  endif
" echo 'qS="' . qS . '", i=' . i . ', j=' . j  
  let Neu=Neu.toupper(strpart(Alt,0,i))
" echo 'Alt1:("' . Alt . ')"'
  let Alt=strpart(Alt,i)
" echo 'Alt2:("' . Alt . ')"'
  let i=stridx(Alt,qS)
  if(i>=0)
    let i=i+j
    let Neu=Neu.strpart(Alt,0,i)
    let Alt=strpart(Alt,i)
" echo 'Alt3:("' . Alt . ')"'
  else
    let Neu=Neu.Alt
    break
  endif
endwhile
" redraw
" echo 'Altx("' . Alt . ')"'
" echo 'Neu:("' . Neu . ')"'
return (Neu)
:endfun

setlocal textwidth=72  "This is standard for /370-sources
setlocal ignorecase
set iskeyword=a-z,A-Z,#,$,@-@,_,48-57

" Don't catch SELECT within SQL-Statements
" (any of the following chooses will work, but none in any case...)

" The select has '\_s*[(;]' appended to avoid a 'EXEC SQL ... SELECT ...' matched.
" Please note, that a 'EXEC SQL ... SELECT (' will match!
let s:SQLnoselect='\<select\>\_s*[;(]'

" The following would be correct, but unfortunately '\@<!' searches only one line upwards...
" let s:SQLnoselect='\(\<exec\>\(\_[^;]\)*\)\@<!\<select\>'

" Another way: catch any SQL-keyword possible before a SELECT - good chance in same or preceding line
" let s:SQLnoselect='\(\(<\sql\>\|<\for\>\|<\in\>\|(\)\_s*\)\@<!\<select\>'

let b:match_words = '%do\>\|%proc\(edure\)\=\>:%end\>,' .
      \'[%]\@<!\<do\>\|\<begin\>\|[%]\@<!\<proc\(edure\)\=\>\|'.s:SQLnoselect.':\<when\>\|\<other\>\|\<otherwise\>:[%]\@<!\<end\>'

" You must have VARTABS.VIM installed to use this - or comment this line out
" You get it by http://www.vim.org/scripts/script.php?script_id=785
call VarTab_SetStops("4,6,8,10,12,14,16,18,20,73")

:vmap <buffer> <Leader>U x"=<SID>PLI_Upcase(@")<CR>P
