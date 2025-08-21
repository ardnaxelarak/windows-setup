" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set encoding=utf-8
scriptencoding utf-8

set dir=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//

set nu
set ts=2
set shiftwidth=2
set et
set ai
set showtabline=2
set fdm=syntax
set linebreak
let javaScript_fold=1

set autoread
au FocusGained * :checktime

if has("gui_running")
  set guifont=Consolas:h12
  set lines=34
  set columns=86
endif

inoremap <C-V> <C-R>+

hi SpecialKey guifg=#d8d898
set list listchars=tab:ᴛᴀʙ,trail:▸

au BufNewFile,BufRead *.asm set filetype=snes noet ts=4 shiftwidth=4 | hi Constant guifg=#74beff | hi Number guifg=DarkOrange | hi SpecialKey guifg=#d8d898

command Latex ! pdflatex -halt-on-error %
command Xetex ! xelatex -halt-on-error %

command Stream set lines=23 columns=75
