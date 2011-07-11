"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
set t_Co=256

" Vim syntax file for scss (Sassy CSS) 
au BufRead,BufNewFile *.scss set filetype=scss

" pathogen.vim : Easy manipulation of 'runtimepath', 'path', 'tags', etc 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Coffee script
let coffee_folding = 1

" The % key will switch between opening and closing brackets
runtime macros/matchit.vim

"cursor line
:set cursorline
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>


"" Highlights
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%79v.*/

"-------------------------------------------------------------- statusline setup
"Syntax check
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

if has('statusline')
  set statusline=   " clear the statusline, allow for rearranging parts
  set statusline+=%f                "Path to the file, as typed or relative to current dir
  set statusline+=%#errormsg#        "change color
  set statusline+=%{&ff!='unix'?'['.&ff.']':''}   "display a warning if fileformat isnt unix
  set statusline+=%*                "reset color to normal statusline color
  set statusline+=%#errormsg#       "change color
  set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}   "display a warning if file encoding isnt utf-8
  set statusline+=%*                "reset color to normal statusline color
  set statusline+=\ %y              "filetype
  set statusline+=%([%R%M]%)        "read-only (RO), modified (+) and unmodifiable (-) flags between braces
  set statusline+=%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%* "shows '!' if file format is not platform default
  set statusline+=%{'~'[&pm=='']}   "shows a '~' if in patchmode
  set statusline+=\ %{fugitive#statusline()}  "show Git info, via fugitive.git
  "set statusline+=\ (%{synIDattr(synID(line('.'),col('.'),0),'name')}) "DEBUG : display the current syntax item name
  set statusline+=%#error#          "change color
  set statusline+=%{&paste?'[paste]':''}    "display a warning if &paste is set
  set statusline+=%*                "reset color to normal statusline color
  set statusline+=%=                "right-align following items
  set statusline+=#%n               "buffer number
  set statusline+=\ %l/%L,          "current line number/total number of lines,
  set statusline+=%c                "Column number
  set statusline+=%V                " -{Virtual column number} (Not displayed if equal to 'c')
  set statusline+=\ %p%%            "percentage of lines through the file%
  set statusline+=\                 "trailing space
  if has('title')
    set titlestring=%t%(\ [%R%M]%)
  endif
endif
"-----------------------------------------------------------end statusline setup

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible
set hidden



set modeline
set encoding=utf-8
set fileencoding=utf8
set scrolloff=3
set autoindent
set showmode
set cursorline
set ttyfast
set ruler
set relativenumber
set undofile
set wildchar=9 " tab as completion character




set linebreak
set virtualedit=block
set clipboard+=unnamed " Yanks go on clipboard instead.
set nowrap        " don't wrap lines
set tabstop=2     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  " case-sensitive otherwise
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class

set title                " change the terminal's title
"set visualbell           " don't beep
set noerrorbells         " don't beep
autocmd VimEnter * set vb t_vb= 

set showtabline=2 " show always for console version
set tabline=%!MyTabLine()

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

autocmd filetype python set expandtab
set list
set gdefault
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
syntax match Tab /\t/
hi Tab gui=underline guifg=blue ctermbg=blue
set listchars=tab:>.,trail:.,extends:#,nbsp:.
cmap w!! w !sudo tee % >/dev/null

" The next section makes Vim handle long lines correctly
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

au FocusLost * :wa

" copy paste
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" ack  It’s far, far better than grep.
nnoremap <leader>a :Ack

"to do something in the new split
nnoremap <leader>w <C-w>v<C-w>l

" CSS properties sorted
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

"I use ,W to mean “strip all trailing whitespace in the current file” so I can clean things " up quickly:
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!

set softtabstop=2

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Ruby staff

compiler ruby


autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" For HTML
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" Ctags
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F12> :TlistToggle<cr>
map <F11> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a
behave xterm
set selectmode=mouse

" Got backspace?
set backspace=2

"Directories
set backupdir=~/.vimbackup          " Set backup location.
set backup                          " Enable backups.
set directory=~/.vimbackup/swap     " Set swap directory.

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase


set clipboard=unnamed

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>


nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'
" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel


"
" appearance options
"
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
let g:molokai_original = 0
set t_Co=256
colorscheme molokai

if has("gui_running")
" set default size: 90x35
   set columns=90
   set lines=35
" No menus and no toolbar
   set guioptions-=m
   set guioptions-=T
   let g:obviousModeInsertHi = "guibg=Black guifg=White"
   set guifont=Droid\ sans\ mono\ 10
else
   let g:obviousModeInsertHi = "ctermfg=253 ctermbg=16"
   colorscheme wombat256i
endif



"Status line gnarliness
set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]



" }}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction

"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#molokai#inkpot#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}

"{{{ Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc
"}}}

"{{{ Todo List Mode

function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction

"}}}

"}}}

"{{{ Mappings

" Open Url on this line with the browser \w
map <Leader>w :call Browser ()<CR>

" Open the Project Plugin <F2>
nnoremap <silent> <F2> :Project<CR>

" Open the Project Plugin
nnoremap <silent> <Leader>pal  :Project .vimproject<CR>

" TODO Mode
nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" CommandT
nnoremap <silent> <C-f> :CommandT<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Paste Mode!  Dang! <F4>
nnoremap <silent> <F4> :call Paste_on_off()<CR>
set pastetoggle=<F4>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Edit gvimrc \gv
nnoremap <silent> <Leader>gv :tabnew<CR>:e ~/.gvimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

set completeopt=longest,menuone,preview

inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Swap ; and :  Convenient.
" nnoremap ; :
" nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"ly$O#{{{ "lpjjj_%A#}}}jjzajj

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

let g:rct_completion_use_fri = 1
"let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "kpdf"

filetype plugin indent on
syntax on

" Gundo
nnoremap <F6> :GundoToggle<CR>


"buffer prompt
:nnoremap <F5> :buffers<CR>:buffer<Space>

"buffer selection
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")



"Preview output from interpreter in new window
function! Ruby_eval_vsplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! ruby " . src . " > " . dst . " 2>&1 "
  execute ":pedit! " . dst
endfunction

vmap <silent> <F7> :call Ruby_eval_vsplit()<CR>
nmap <silent> <F7> mzggVG<F7>`z
imap <silent> <F7> <Esc><F7>a
map <silent> <S-F7> <C-W>l:bw<CR>
imap <silent> <S-F7> <Esc><S-F7>a


" tab navigation like firefox
nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>
" map \tx for the console version as well
if !has("gui_running")
   nmap <Leader>tn :tabnext<cr>
   nmap <Leader>tp :tabprevious<cr>
   nmap <Leader><F4> :tabclose<cr>
end


" Map Ctrl-E Ctrl-W to toggle linewrap option like in VS
noremap <C-E><C-W> :set wrap!<CR>
" Map Ctrl-M Ctrl-L to expand all folds like in VS
noremap <C-M><C-L> :%foldopen!<CR>
" Remap omni-complete to avoid having to type so fast
inoremap <C-Space> <C-X><C-O>

" SuperTab Options
" let g:SuperTabDefaultCompletionType="<C-x><C-o>"
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<C-X><C-O>"

" Close tags
imap ,/ </<C-X><C-O>


" Make sure taglist doesn't change the window size
let g:Tlist_Inc_Winwidth = 0
"nnoremap <silent> <F8> :TlistToggle<CR>


" set custom file types I've configured
au BufNewFile,BufRead *.ps1 setf ps1
au BufNewFile,BufRead *.boo setf boo
au BufNewFile,BufRead *.config setf xml
au BufNewFile,BufRead *.xaml setf xml
au BufNewFile,BufRead *.xoml setf xml
au BufNewFile,BufRead *.blogTemplate setf xhtml
au BufNewFile,BufRead *.brail setf xhtml
au BufNewFile,BufRead *.rst setf xml
au BufNewFile,BufRead *.rsb setf xml
au BufNewFile,BufRead *.io setf io
au BufNewFile,BufRead *.notes setf notes
au BufNewFile,BufRead *.mg setf mg

nmap <leader>R :RainbowParenthesesToggle<CR>
" these are supposed to be done on syntax files, but
" they fit pretty much everything I work on.
"au BufNewFile,BufRead *.* call rainbow_parentheses#LoadRound()
"au BufNewFile,BufRead *.* call rainbow_parentheses#LoadSquare()
"au BufNewFile,BufRead *.* call rainbow_parentheses#LoadBraces()



"
" Configure tabs for the console version
"
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
" select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

" set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

" the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

" after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

" right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction


"Rainbow
if exists("g:btm_rainbow_color") && g:btm_rainbow_color
  call rainbow_parenthsis#LoadSquare ()
  call rainbow_parenthsis#LoadRound ()
  call rainbow_parenthsis#Activate ()
endif






