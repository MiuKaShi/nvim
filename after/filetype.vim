augroup filetypedetect
  au BufRead,BufNewFile *.tp set filetype=type
  au BufRead,BufNewFile *.m set filetype=matlab
  au BufRead,BufNewFile *.md set filetype=markdown.pandoc
  au BufRead,BufNewFile lfrc set filetype=lf
  au BufRead,BufNewFile *.sage set filetype=sage
  au BufRead,BufNewFile sxhkdrc,*.sxhkdrc set filetype=sxhkdrc
  au BufRead,BufNewFile *tridactylrc set filetype=tridactyl
  au BufRead,BufNewFile *.pyx set filetype=cython
  au BufRead,BufNewFile *.pxd set filetype=cython
  au BufRead,BufNewFile *.pxi set filetype=cython
  au BufRead,BufNewFile *.snippets set filetype=snippets
  au BufRead,BufNewFile *.isy set filetype=xml
  au BufRead,BufNewFile *.zsh set filetype=sh
augroup END
