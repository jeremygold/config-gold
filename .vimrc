" Suggestions from http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
set t_Co=256
syntax on
set background=dark

" Setup for Vundle
" Ref https://github.com/gmarik/Vundle.vim#quick-start
"
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

" Bundle 'jelera/vim-javascript-syntax'
" Bundle 'pangloss/vim-javascript'
" Bundle 'nathanaelkane/vim-indent-guides'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'marijnh/tern_for_vim'

" call vundle#end()            " required
" filetype plugin indent on    " required

" Automatically start maximised
" au GUIEnter * simalt ~x

" Ignore case for searches
:set ic

" Turn line numbering on
:set nu

" Set up tabstops and shift width to 4
:set ts=4
:set sw=4
:set expandtab

" do incremental searches
:set incsearch
:set hlsearch
:map <F7> :wa<CR> :make<CR>
:map <F5> :make run<CR>

" Use F2 to disable auto indenting for pasted code. ref
" http://vim.wikia.com/wiki/VimTip906
:set pastetoggle=<F2>

" Set up F4 to toggle between .h and .cpp file of the same name. ref
" http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
" map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Use ndk-build for compilation by default
" :set makeprg=ndk-build
" :set makeprg=make

" Set up a nicer status bar
" From http://www.linux.com/archive/feature/120126
" :set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
" :set laststatus=2
filetype plugin indent on
syntax on

" My colour scheme.
colorscheme slate
" colorscheme desert256
" colorscheme distinguished

" Octave Syntax
augroup filetypedetect
   au! BufRead,BufNewFile *.m,*.oct setfiletype octave
   au! BufRead,BufNewFile *.ino,*.pde setfiletype c
augroup END 

" Need this on for snipMate plugin to work
" :filetype plugin on

" Use F3 to toggle NERDTree
map <F3> :NERDTreeToggle<CR>

" Tips from http://nvie.com/posts/how-i-boosted-my-vim/

" Remap command leader from : to ; (to avoid having to press shift)
" Note - this was a bit more trouble than it was worth - I like ; for go to
" next match
" nnoremap ; :

" change the mapleader from \ to ,
" let mapleader=","

" Quickly edit/reload the vimrc file - type ,ev to edit .vimrc, ,sv to source
" latest .vimrc
" nmap <silent> <leader>ev :e $MYVIMRC<CR>
" nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Hide, rather than close buffers, so you don't have to save changes before
" switching
set hidden

" Auto formatting for XML files:
" Ref http://vim.wikia.com/wiki/Format_your_xml_document_using_xmllint
" au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Quick yanking to the end of the line - Not sure if I like this?
" nmap Y y$

" Yank/paste to the OS clipboard with ,y and ,p
" nmap <leader>y "+y
" nmap <leader>Y "+yy
" nmap <leader>p "+p
" nmap <leader>P "+P
" nmap <leader>r :registers<CR>

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear current search highlight - This seems to cuase gremlins during vim
" startup???
" nnoremap <esc> :noh<return><esc>

" Map ,b to LustyJuggler
" nmap <silent> <leader>b :LustyJuggler<CR>

" Automatically cd into directory of current buffer
" autocmd BufEnter * lcd %:p:h

" Automatically enable xml folding - Ref http://vim.wikia.com/wiki/Vim_as_XML_Editor
" let g:xml_syntax_folding=1
" au FileType xml setlocal foldmethod=syntax

" For jave development:
" set sm
" set ai
" set cinoptions+=j1
" let java_highlight_all=1
" let java_highlight_functions="style"
" let java_allow_cpp_keywords=1
" let java_comment_strings=1
" let java_highlight_java_lang_ids=1
" let java_mark_braces_in_parens_as_errors=1
" let java_highlight_all=1
" let java_highlight_debug=1
" let java_ignore_javadoc=1
" let java_highlight_java_lang_ids=1
" let java_highlight_functions="style"
" let java_minlines = 150

" For gvim (disable menu and toolbar) - Also helps for eclim
" set guioptions-=m " turn off menu bar
" set guioptions-=T " turn off toolbar

" From http://djcraven5.blogspot.co.nz/2006/10/mastering-vim-help-system.html
" autocmd BufWrite mytips.txt             :helptags ~/.vim/doc/
" autocmd BufRead  mytips.txt             set filetype=help
" autocmd BufRead  mytips.txt             set noreadonly
" autocmd BufRead  mytips.txt             set modifiable

" nmap <leader>h :e ~/.vim/doc/mytips.txt<CR>

" For openSCAD syntax coloring
au! BufRead,BufNewFile *.scad set filetype=openscad 

" Improved cursor shapes in vim - Ref http://tangosource.com/blog/a-tmux-crash-course-tips-and-tweaks/
if exists('$ITERM_PROFILE')
  if exists('$TMUX') 
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

" For Pathogen.vim. Ref https://github.com/tpope/vim-pathogen
" execute pathogen#infect()
