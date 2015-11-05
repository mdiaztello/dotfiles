
" VUNDLE INITIALIZATION STARTS HERE *********************************

" The following was taken from the Vundle installation instructions at
" https://github.com/VundleVim/Vundle.vim
set nocompatible              "leave vi mode to use vim extensions
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'     "Vim wrapper/interface to git
Plugin 'kien/ctrlp.vim'         "fuzzy matching file finder
Plugin 'scrooloose/nerdtree'    "file navigator using a tree structure
Plugin 'rking/ag.vim'           "Ag (silver searcher) frontend for vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" VUNDLE INITIALIZATION ENDS HERE ***********************************

set cb=unnamed "use system clipboard for copy/paste

set cindent

"TABS/SPACES SETTINGS
set tabstop=4       "a tab character inserted from the tab key will be 4 spaces wide
set softtabstop=4   "erasing tabs that have been expanded to spaces will erase 4 spaces at a time
set shiftwidth=4    "shift commands in normal mode indent by 4 spaces
set expandtab       "expands tab characters into space characters of equivalent width

"set guioptions-=m "remove menubar from gvim
set guioptions-=T       "remove buttons bar from gvim
set foldmethod=syntax   "folds will occur around curly braces in C
set background=dark
set number              "enable numbered lines in left margin
set tabpagemax=100      "allow up to 100 tabs at a time
colorscheme torte       "change syntax highlighting and background colors

"change 'jump to previous tag' binding so that we don't clobber it
"note that we are clobbering the 'scroll screen without moving cursor'
"binding, but I never used it so that's ok
map <C-y> :pop<enter>
"firefox-like tab bindings
map <C-t> :tabnew<space>
map <C-l> <Esc>gt
map <C-h> <Esc>gT

"automatically applies changes after writing the vimrc to disk
autocmd bufwritepost $MYVIMRC source $MYVIMRC

source $VIMRUNTIME/vimrc_example.vim

set nobackup "stop generating the ~ backup files (e.g. myfile.txt~)
set nowritebackup "stop generating the ~ backup files (e.g. myfile.txt~)

"This allows me to quickly #if 0-style comment something out; just highlight
"the block you want to comment out and type ,i0
noremap ,i0 dO#endif<Esc>PO#if 0<Esc>
"This removes the #if 0-style comment just position over the #if 0 and type
",r0
noremap ,r0 kmmj%''dd''dd'm

"This allows me to press 'jj' as a substitute for <Esc> when in insert mode
"The 'h' at the end allows the escape to occur without moving forward by one
"char as it does without the h
inoremap jj <ESC>

"filetype plugin on

syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip

let g:CommentDefines = ""

hi link MyCommentOut2 MyCommentOut
hi link MySkip MyCommentOut
hi link MyCommentOut Comment

map <silent> ,a :call AddCommentDefine()<CR>
map <silent> ,x :call ClearCommentDefine()<CR>

function! AddCommentDefine()
  let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
  syn clear MyCommentOut
  syn clear MyCommentOut2
  exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$" contains=MyCommentOut2'
  exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '" end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
endfunction

function! ClearCommentDefine()
  let g:ClearCommentDefine = ""
  syn clear MyCommentOut
  syn clear MyCommentOut2
endfunction

