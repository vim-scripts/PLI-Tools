*** Features ***
Syntax-highlighting and indenting for IBM's PLI on mainframes (MVS; LE/390; z/OS etc.) when using the PLIOPT-Compiler.
Does recognize embedded SQL and CICS.
Smart uppercasing (only source, no strings and/or comments)


*** Installation ***
1) copy the 3 pli.vim-files in the correct directories:
ftplugin\pli.vim
syntax\pli.vim
indent\pli.vim


2) add into your runtime\filetype.vim this lines:
---BEG
" PLI
au BufNewFile,BufRead *.PLI		setf pli
---END

3) add into your runtime\synmenu.vim this lines (maybe you have to change the position-numbers):
---BEG
an 50.80.235 &Syntax.PQ.PLI :cal SetSyn("pli")<CR>
---END

4) Be sure you use a color-schema which defines these highlights (or modify your schema or syntax\pli.vim).
Items marked by '*****' are very usually not in your environment!

---BEG
Builtin   *****     
CICS_Statement   *****
Comment
Error
Identifier
IncludeFile   *****
Label
Number
Operator
PreProc   *****
SQL_Statement   *****
Statement
String
Todo
Type
---END
