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
  au BufRead,BufNewFile *.rasi set filetype=css
	au BufRead,BufNewFile *.log set filetype=log
	au BufRead,BufNewFile *_log set filetype=log
	au BufRead,BufNewFile *.LOG set filetype=log
	au BufRead,BufNewFile *_LOG set filetype=log
	au BufRead,BufNewFile *.org set filetype=org
	au BufNewFile,BufRead *.el set filetype=elisp
	au BufNewFile,BufRead *.geo set filetype=glsl
	au BufNewFile,BufRead *.frag set filetype=glsl
	au BufNewFile,BufRead *.vert set filetype=glsl
	au BufNewFile,BufRead *.step set filetype=ruby
	au BufNewFile,BufRead *.stl set filetype=stl
augroup END
