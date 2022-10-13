" BEVA's vimrc file

source $VIMRUNTIME/mswin.vim

" Get out of VI's compatible mode..
set nocompatible

" Sets how many lines of history VIM has to remember
set history=400

" Enable filetype plugin
filetype plugin on
filetype indent on

" Have the mouse enabled all the time
set mouse=a

" Set mapleader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" Enable Remote Editing
let g:netrw_cygwin = 0
let g:netrw_scp_cmd = "pscp.exe"

" Set column marker
set colorcolumn=120

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

" Enable syntax highlighting.
syntax on

" Highlight current line
set cursorline

if has("gui_running")
  " Size of GVim window
  set lines=45 columns=150
  hi CursorLine guibg=#333333
  hi CursorColumn guibg=#333333
  set mousehide
  if has("gui_gtk3") || has("gui_gtk2")
      set guifont=Source\ Code\ Pro\ 11
      "Switch fonts/sizes
      map <F9> <ESC>:set guifont=Source\ Code \ Pro\ 11<CR>
      map <F10> <ESC>:set guifont=Source\ Code \ Pro\ 13<CR>
      map <F11> <ESC>:set guifont=Source\ Code \ Pro\ 14<CR>
      map <F12> <ESC>:set guifont=Source\ Code \ Pro\ 16<CR>
  elseif has("gui_win32")
      set guifont=Consolas:h11:cANSI
      "Switch fonts/sizes
      map <F9> <ESC>:set guifont=Consolas:h11:cANSI<CR>
      map <F10> <ESC>:set guifont=Consolas:h13:cANSI<CR>
      map <F11> <ESC>:set guifont=Consolas:h14:cANSI<CR>
      map <F12> <ESC>:set guifont=Consolas:h16:cANSI<CR>
  endif
endif

" Automatically indent when adding a curly bracket, etc.
set smartindent

" Auto Indent
set autoindent

" C-sytle indenting
set cindent

" Wrap lines
set wrap

" Tabs should be converted to a group of 4 spaces.
" This is the official Python convention
" (http://www.python.org/dev/peps/pep-0008/)
" I didn't find a good reason to not use it everywhere.
" This can be overridden on a per language basis by placing
"   the settings in ~/.vim/ftplugin/LANGUAGE.vim (e.g. ruby.vim)
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" Set my colorscheme
" colorscheme darkblue
" colorscheme morning
colorscheme elflord

" Status line
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%10{strlen(&ff)?&ff:'undef'}
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

" Show line number, cursor position.
set ruler

" Display incomplete commands.
set showcmd

" Set selection to inclusive
set selection=inclusive

" To insert timestamp, press F3.
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" To save, press ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <ESC>:w<CR>a

" Search as you type.
set incsearch

" Ignore case when searching.
set ignorecase

" Show autocomplete menus.
set wildmenu

" Show editing mode
set showmode

" Set backspace
set backspace=eol,start,indent

" Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

" show matching bracets
set showmatch

" Highlight search things
set hlsearch

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tl :tabprev<cr>
map <leader>tr :tabnext<cr>
try
  set switchbuf=usetab
  set stal=2
catch
endtry

" Allow select word within visual and quick search with //
vnoremap // y/<C-R>"<CR>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
" )
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
imap <d-l> <esc>:exec "normal f" . leavechar<cr>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Brant Evans

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding, I find it very useful
set fen
set fdl=0

" Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

" Turn on line numbering
set number
set numberwidth=5

" Turn on relative line numbering
" set relativenumber

" scroll offset, keeps 2 lines above the cursor
set scrolloff=2

let Tlist_Ctags_Cmd = 'c:\ctags\ctags.exe'

let BASH_AuthorName = "Brant Evans"
let BASH_AuthorRef  = "bevans"
let BASH_Email      = "bevans@redhat.com"
let BASH_Company    = "Red Hat, Inc."

" map control-backspace to delete the previous word
:imap <C-BS> <C-W>

function ShowSpaces(...)
  let @/="\\v(\\s+$)|( +\\ze\\t)"
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <C-F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

" toggle paste in cmd only
nnoremap <Leader>p :set invpaste<CR>

" json beautifier (requires jq to be installed)
nnoremap <Leader>z :%!jq '.'<CR>
