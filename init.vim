" General
let mapleader=" "  "set Leader key to space

" cnoremap w!! w !sudo tee % >/dev/null " open a file with super user rights

set cursorline

set scrolloff=999  " keep cursur centered

set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

set textwidth=80
set shiftwidth=4
set softtabstop=4
set tabstop=4

set number "relativenumber "pendant: set number

set autochdir " Automatically change to current file dir
set termguicolors " dunno, nvim truecolor feature

set noswapfile " disable swap file

" folds
set foldlevelstart=1 " auto folds at level 1, "so i dunno forget that folds exist"


"" Keep the horizontal cursor position when moving vertically.
set nostartofline
set showmatch "" Show matching braces.
set nowrap "" Do not break long lines.

set title                " change the terminal's title
set wildignore=*.swp,*.bak,*.pyc,*.class
set history=1000         " remember more commands and search history
set undoreload=10000        " number of lines to save for undo
set undolevels=1000      " use many muchos levels of undo
set timeoutlen=500 " After this many msecs do not imap.
set showmode " Show the mode (insert,replace,etc.)
set gcr=a:blinkon0 " No blinking cursor please.
set wmh=0 " Do not show any line of minimized windows

" siehe für folgende, https://wiki.ubuntuusers.de/vim
set autoindent
set incsearch
set hlsearch
set smarttab
"" When inserting TABs replace them with the appropriate number of spaces
set expandtab
"" But TABs are needed in Makefiles
au BufNewFile,BufReadPost Makefile se noexpandtab

set splitbelow
set splitright

set smartcase 
set ignorecase
set gdefault " Make %s/A/B/g the default (g not needed anymore)
"Open new split panes to right and bottom, which feels more natural than Vim’s
"default: https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally

" Latex? (Hannah Bast)
let g:Imap_UsePlaceHolders = 0 "" no placeholders please
let g:Tex_SmartKeyQuote = 0 "" no " conversion please
let g:Tex_UseMakefile = 0 "" don't use Makefile if one is there

set mouse=a
" set drag and drop support (xterm -> xterm2)
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" nvim specific
if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
    runtime! plugin/python_setup.vim
else
    let s:editor_root=expand("~/.vim")
endif

" Code features:
" colorize the columns who exceed the length of 81
highlight colorcolumn ctermbg=magenta
call matchadd('Colorcolumn', '\%81v', 100)  " pattern match only the columns that exceed

" Buffers:
" http://stackoverflow.com/questions/26708822/why-do-vim-experts-prefer-buffers-over-tabs
" switch to other buffer without having to save it
" hide buffers when abandoned?
set hidden
" navigate between them
map <F2> :ls<CR>:b<Space>
" save them even after closing vim
:set viminfo^=%
"quit buffer easily, does not work :(
nnoremap <leader>q :bd
"cycle between buffers
nmap gb :bn<CR>
nmap gB :bprevious<CR>

" Appearance
set t_Co=256
"set background=light "dark
colorscheme Tomorrow
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
""colorscheme gruvbox not needed see gui_color_mod
""silent! source $HOME/.gui_color_mode "this also sets colorscheme
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=light " or dark
"colorscheme summerfruit256

" Font section
""set guifont=Liberation\ Mono\ for\ Powerline\ 10 "set guifont=Sauce\ Code\ Powerline\ 10
set guifont=Inconsolata\ for\ Powerline\ 10
"set linespace=12
set guioptions=r

" ______________________________________________________________________________ 
" Hit v to select one character
"Hit vagain to expand selection to word Hit v again to expand to paragraph
"Hit <C-v> go back to previous selection if I went too far
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" ______________________________________________________________________________ 
" vp (visual select and then paste) doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

""""
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/<Paste>
" ______________________________________________________________________________ 
" turn off vims 'horrible' regex search and use normal regexes instead
nnoremap / /\v
vnoremap / /\v
nnoremap <leader>c :noh<cr> " clears the highlighting of search!!!

"" Toggle between .h and .cpp with F4.
function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "hh"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "hh"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"Java compile and debug
autocmd Filetype java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
map <F9> :make<Return>:copen<Return>
map <F10> :cprevious<Return>
map <F11> :cnext<Return>

" Functions
" Underline func (example :Underline +=+)
inoremap <F5> :Underline =<CR>
nnoremap <F5> :Underline =<CR>
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
 
" Playground
au FocusLost * :wa "save everything on focus lost

" make vim create undo files which make it possible to undo actions even after
" closing the file
"set undofile

" ______________________________________________________________________________ 
"auto save with esc
"map <Esc><Esc> :w<CR>
"save with ctrl -s
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" ______________________________________________________________________________ 
"Type 12<Enter> to go to line 12 (12G breaks my wrist)
"Hit Enter to go to end of file.
"Hit Backspace to go to beginning of file.
"nnoremap <CR> G
"nnoremap <BS> gg

" ______________________________________________________________________________ 
" funzt nicht: mapping of special chars
" http://stackoverflow.com/questions/14122573/how-to-map-ctrl-combination-in-vim 

" ______________________________________________________________________________ 
" Paste in new line
":nmap p :pu<CR>  " makes vim paste in new line http://stackoverflow.com/questions/1346737/how-to-paste-in-a-new-line-with-vim

" may want to disable again, show textmate like characters for whitspace
"set list
"set listchars=tab:▸\ ,eol:¬


" ______________________________________________________________________________ 
" Try to open things that do not belong in vim with their respective system
" program
augroup nonvim
   au!
   au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft
   au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!/usr/local/bin/any2pdf " . shellescape(expand("%:p"))
   au BufRead *.ppt*,*.doc*,*.rtf sil exe "!xdg-open " . g:output_pdf | bd | let &ft=&ft
augroup end

" Reload all files from disk:
" http://stackoverflow.com/questions/1272007/refresh-all-files-in-buffer-from-disk-in-vim
"fun! PullAndRefresh()
  "set noconfirm
  ""!git pull deactivated it because i dunno what it does
  "bufdo e!
  "set confirm
"endfun

"nmap <leader>gr call PullAndRefresh()


" Open pdf function
function! OpenPDF(file,page)
  exec 'silent ! okular --page ' . a:page . ' --unique ' . a:file . ' > /dev/null 2>&1 &'
endfunction

"These are to cancel the default behavior of d, D, c, C
"  to put the text they delete in the default register.
"  Note that this means e.g. "ad won't copy the text into
"  register a anymore.  You have to explicitly yank it.
"nnoremap d "_d
"vnoremap d "_d
"nnoremap D "_D
"vnoremap D "_D
"nnoremap c "_c
"vnoremap c "_c
"nnoremap C "_C
"vnoremap C "_C<Paste>

" vim: set fdm=marker: " Treat comments as folds

" Key bindings for split-view navigation (not needed with Tmux navigate plugin)
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
" Wiki
" Things to remember - new new verision, old down here and in vim wiki
" ====================================================================
" zM/zm: fold More/less zr/R: reduce fold
" Things to remember - old new verision in vimwiki directory 
" ==========================================================
" use gf to follow a file path like in my init.vim
" use verbose map <keybinding> to show where it was assigned
" use '. to jump to the last changed line
" use tmux-prefix + z to maximize / restore previous state
" use //e to put curor to end of a search match, or use /regex/e to do so in the
" first place
" t/T is the pendant to f/F, but befor the character
" make folds with zf
" subistiute command %s can be repeated with &
" [{ or ]} jump to the outer brackets
" use jump lists
" show them with :jumps, use ctrl-O to jump back and ctrl-I to jump forth
" use Jump commands:
" " returns to before last jump command
" HML Top, Middle, Bottom of Screen
" use cgn for replace search patterns several times
" http://vimcasts.org/episodes/operating-on-search-matches-using-gn/
" use ab, aB, ib, iB in visual mode to select blocks
" use :verbose map and :redir to see which keybindings are bound
" use q: (or q/) for vim command line window
" use ZZ to save and close
" use f in combination with v, d etc. AND use / for the same over multiple lines
" combine f with ; and , which repeats the search back and forth
" use E, ge/E to go forward/backward to the _End_ of the word
" use SaveSession Plugin
" use surround Plugin:
"   ysiwx:  you surround it with x
"   ds:     delete surroundings
"   csxy:   clear x surroundings (with) y
"   yssx:   surround whole line with x
"   Shift-S: surround in visual mode
" use vip to select an visual inner paragraph
"Make things happen in insert mode
"   CTRL-W    delete word to the left of cursor
"   CTRL-O D  delete everything to the right of cursor
"   CTRL-U    delete everything to the left of cursor
"   CTRL-H    backspace/delete
"   CTRL-J    insert newline (easier than reaching for the return key)
"   CTRL-T    indent current line
"   CTRL-D    un-indent current line
"   for more: :help ex-edit-index
"How to use registers: macros: http://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers
"   :reg to see all registers
"   @m start makro m
"   0 register is last yanked line
"   1 register is last deleted line
"   qaq clear register a
"   c-R * paste register * ??
" Use my shortcuts:
"   alt+jklh in insert mode to move
" Tabularize Plugin: Use Select Test + :Tabularize (or Tab) /PATTERN to tabularize e.g. equoations by
" setting PATTERN to =
" ______________________________________________________________________________ 
" use jj to go pack to normal mode
" ______________________________________________________________________________ 
" Easy Motion short cuts:
    "Default Mapping      | Details
    "---------------------|----------------------------------------------
    "<Leader>f{char}      | Find {char} to the right. See |f|.
    "<Leader>F{char}      | Find {char} to the left. See |F|.
    "<Leader>t{char}      | Till before the {char} to the right. See |t|.
    "<Leader>T{char}      | Till after the {char} to the left. See |T|.
    "<Leader>w            | Beginning of word forward. See |w|.
    "<Leader>W            | Beginning of WORD forward. See |W|.
    "<Leader>b            | Beginning of word backward. See |b|.
    "<Leader>B            | Beginning of WORD backward. See |B|.
    "<Leader>e            | End of word forward. See |e|.
    "<Leader>E            | End of WORD forward. See |E|.
    "<Leader>ge           | End of word backward. See |ge|.
    "<Leader>gE           | End of WORD backward. See |gE|.
    "<Leader>j            | Line downward. See |j|.
    "<Leader>k            | Line upward. See |k|.
    "<Leader>n            | Jump to latest "/" or "?" forward. See |n|.
    "<Leader>N            | Jump to latest "/" or "?" backward. See |N|.
    "<Leader>s            | Find(Search) {char} forward and backward.
                         "| See |f| and |F|.
                         "
 " :?foo?t.                        
" What :m, :t and :d do is explained in their relative :help :command parts.
" :M and :T are certainly custom commands which probably massage the manipulated lines in some way.
" '' is the "last position before last jump" mark.
" Because forward search and backward search are jumps, '' can be used as address for the Ex commands above:
" place cursor on some line, we will call it "origin",
" search for foo, a few lines below,
" hit <CR> when you have found your target,
" '' now corresponds to that "origin" line from before,
" we copy the current line to just below the "origin" line with :t''
" The command-line mode mappings I suggested to jollybobbyroger turn this two steps action into a single step action.
 
" Vundle
set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
" do git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim to install
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'   " Plugin manager
" Plugin 'terryma/vim-multiple-cursors' "multiple line insert/yank
Plugin 'tpope/vim-sleuth' " set shiftwidth and expandtab automatically
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'Valloric/YouCompleteMe' " autocompletition

Plugin 'vim-scripts/restore_view.vim'
Plugin 'terryma/vim-expand-region' " use for a keybinding see above
let g:ycm_confirm_extra_conf = 0
Plugin 'Shougo/neocomplete.vim'  " autocomplete
"source $HOME/.vim/config_neocomplete.vim
Plugin 'scrooloose/nerdtree.git' " file browser
Plugin 'ctrlpvim/ctrlp.vim'         " search files, tags
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'      " without the mixed you start in files mode
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
"if executable('ag')
"""" Use Ag over Grep
"""set grepprg=ag\ --nogroup\ --nocolor

"""" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"""let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif
"Plugin 'zefei/vim-wintabs'
"map <C-n> <Plug>(wintabs_previous)
"map <C-m> <Plug>(wintabs_next)
"map <C-T>c <Plug>(wintabs_close)
"map <C-T>o <Plug>(wintabs_only)
"map <C-W>c <Plug>(wintabs_close_window)
"map <C-W>o <Plug>(wintabs_only_window)
"command! Tabc WintabsCloseVimtab
"command! Tabo WintabsOnlyVimtab
" Plugin 'easymotion/vim-easymotion'  " new motion with <leader><leader>w
Plugin 'vimwiki/vimwiki.git' " default wiki page with <leader><leader>w
Plugin 'rafaqz/citation.vim.git'
let g:citation_vim_mode="zotero"
let g:citation_vim_zotero_path="~/.zotero/zotero/jvkcoyob.default/zotero"
let g:citation_vim_cache_path='~/.config/nvim/cache/citation_vim'
let g:citation_vim_outer_prefix="["
let g:citation_vim_inner_prefix="@"
let g:citation_vim_suffix="]"
let g:citation_vim_et_al_limit=2

Plugin 'Shougo/unite.vim.git'  " https://github.com/Shougo/unite.vim
nnoremap <c-l> :Unite<CR>
Plugin 'rodjek/vim-puppet.git' " Puppet Syntax
" Plugin 'vim-airline/vim-airline'      " new statusbar
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme = "hybrid"
let g:airline#extensions#tabline#enabled = 1 " enable buffer tab-like view
let g:airline#extensions#tabline#fnamemod = ':t' " show filename instead of full path

Plugin 'ap/vim-buftabline'
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdcommenter'
let NERDSpaceDelims=1
Plugin 'christoomey/vim-tmux-navigator' " vim navigation in tmux
Plugin 'vimoutliner/vimoutliner' " simple, fast authoring
Plugin 'tpope/vim-surround.git'
Plugin 'jiangmiao/auto-pairs.git' "auto brackets?
" may be cpu intensive?
"Plugin 'Raimondi/delimitMate.git' " auto brackets? but not in comments etc?
Plugin 'flazz/vim-colorschemes' "color schemes
Plugin 'chriskempson/tomorrow-theme.git' "nice light color scheme
"Plugin 'adragomir/javacomplete' " java code completition
"alternative: AutoComplPop or Vim JDE

"snipmate and all the packages that belong to it:
"Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets' "optional

Plugin 'blueyed/vim-diminactive.git' " dim inactive splits

" Plugin 'KevinGoodsell/vim-csexact.git'
" needed to combine ycm and ultisnips
Plugin 'ervandew/supertab'

" " make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" " better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
 
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>" " ctrl-space seems to workt too! way cooler
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

Plugin 'freitass/todo.txt-vim.git'
" fzf (fuzzy)
Plugin 'junegunn/fzf'

"Plugin 'https://bitbucket.org/ns9tks/vim-autocomplpop/'

" mksession on steroids
Plugin 'xolox/vim-session.git'
Plugin 'xolox/vim-misc.git' "needed for above
:let g:session_autoload = 'no'
" use DeleteSession to delete your session
" RestartSession may come in handy too

Plugin 'scrooloose/syntastic.git' " syntax checking hacks, don't see a big difference to

Plugin 'godlygeek/tabular.git' " make things line up

Plugin 'majutsushi/tagbar.git'
nmap <F8> :TagbarToggle<CR>

"Plugin 'vim-scripts/YankRing.vim.git' " use ctrl-p to cycle between pasted, and makes a shared yank history for all open instances
"let g:yankring_replace_n_pkey = '<alt>-m'
"let g:yankring_replace_n_nkey = '<alt>-n'

"Plugin 'maxbrunsfeld/vim-yankstack.git' " lightweight alternative to yankring
" standard: use <meta>-p and <meta>-<shift>-p to cycle forth and back, remap:
"nmap <leader>p <Plug>yankstack_substitute_older_paste
"nmap <leader>P <Plug>yankstack_substitute_newer_paste

Plugin 'mileszs/ack.vim.git' " 'far better than grep, optimized for programmers'
" see https://github.com/mileszs/ack.vim

" increment numbers with ctrl-v ctrl-a
Plugin 'triglav/vim-visual-increment.git'

" Latex live preview, to start execute :LLPStartPreview
Plugin 'xuhdev/vim-latex-live-preview'
let g:livepreview_previewer = 'okular'
" another latex plugin also with live preview
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Track the engine. ULTISNIPS
Plugin 'SirVer/ultisnips'
" Use c-tab to see the list of snippets
" " Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'        " I used this but all snippets were
"duplicated forcing the options dialog to show
" " Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=["UltiSnips"] "~/.vim/bundle/vim-snippets/UltiSnips/] search for snippets in dirs, disable to use third-party...
" make ycm compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<c-Space>"
" let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" " If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"according ycm config for ultisnip integration: http://stackoverflow.com/questions/27390285/vim-ultisnips-not-working-with-ycm
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
"tmux navigator settings
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
"nnoremap <silent> <C-P> :TmuxNavigatePrevious<cr>
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"Plugin highlight f/F movement
" Plugin 'unblevable/quick-scope'


" All of your Plugins must be added before the following line
call vundle#end()            " required

syntax on " needs to be after vundle and before filetype

" Vundle needs filetype detection off, so enable it again after vundle finished
filetype off " only this makes next line work?
filetype on
filetype plugin indent on   " automatic file type detection for ultisnip?


" Bindings
" alt m to go to normal mode
inoremap <a-m> <Esc>

nnor <leader>cf :let @+=expand("%:p")<CR>    " Mnemonic: Copy File path
nnor <leader>yf :let @+=expand("%:p")<CR>    " Mnemonic: Yank File path
nnor <leader>fn :let @+=expand("%")<CR>      " Mnemonic: yank File Name

"imap ö [
"imap S-ö ]

"" Alt-ö and ä inserts braces
imap <a-char-246> {
"imap <a-char-214> }
imap <a-char-228> [
"imap <a-char-196> ]

"exe "imap <Char-196> }" | " LATIN CAPITAL A WITH DIAERESIS
"exe "imap <Char-214> {" | " LATIN CAPITAL O WITH DIAERESIS
"exe "imap <Char-228> ]" | " LATIN SMALL A WITH DIAERESIS
"exe "imap <Char-246> [" | " LATIN SMALL O WITH DIAERESIS 

inoremap jj <Esc>
"vmap jk <Esc>

" make text move around in normal, visual mode
" left/right
nnoremap <Left> <<
nnoremap <Right> >>
vnoremap <Left> <gv " gv selects last selection or sth.
vnoremap <Right> >gv
" inoremap <Left> <Esc><<i
" inoremap <Right> <Esc>>>i
" " up/down - doesnt work
" nnoremap <Up> [e
" nnoremap <Down> ]e
" vnoremap <Up> [egv
" vnoremap <Down> ]egv
" " up/down alternative
" nnoremap <Down> :m .+1<CR>==
" nnoremap <Up> :m .-2<CR>==
" inoremap <Down> <Esc>:m .+1<CR>==gi
" inoremap <Up> <Esc>:m .-2<CR>==gi
" vnoremap <Down> :m '>+1<CR>gv=gv
" vnoremap <Up> :m '<-2<CR>gv=gv

"nnoremap <s-enter> :echo 'senter'<cr>
"nnoremap <enter> :echo 'enter'<cr>
"nnoremap <c-s-enter> :echo 'csenter'<cr>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader><leader>q :qa<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>u :Unite<CR>

" accumulate selections: 
"   V '"'a then y, then '"'A for appending, pa for paste from a
nnoremap <Leader>j \"Jyy      "append to register j
"
" ______________________________________________________________________________ 
" make a new vsp and switch to it
nnoremap <leader><leader>s <C-w>v<C-w>l " s means split
"make separation lines, should invoke my ultisnippet
nnoremap <leader>- 0i-- <esc>:call UltiSnips#ExpandSnippet()<cr><esc>
nnoremap <leader>" 0i"" <esc>:call UltiSnips#ExpandSnippet()<cr><esc>

" Strip all trailing whitespaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" re-hardwrap two soft wrapped lines
nnoremap <leader><leader>q gqip
" select text just pasted
"nnoremap <leader>v V`]`

"" Make it easy to update/reload _vimrc.
nnoremap <leader>s :source $HOME/.config/nvim/init.vim
nnoremap <leader>v :vsp $HOME/.config/nvim/init.vim 
"nmap ,u :vsp $HOME/.vimrc/Bundle/vim-snippets/UltiSnips/java.snippets

"Eclim shortcuts
nnoremap <Leader><Leader>cr :JavaCorrect
nnoremap <Leader><Leader>cn :JavaCorrect

" ______________________________________________________________________________ 
" PASTING AND YANKING
" use <C-R> + <Register> (e.g. " or *) to print that register:
" http://stackoverflow.com/questions/2861627/paste-in-insert-mode
" paste from *vim reg* in insert mode
inoremap <C-v> <C-r>0
" equivalent in visual mode: paste from non-delete buffer
vnoremap <C-v> "0p
"paste from clipboard in command mode
  " nnoremap <leader>p o<C-r>+<esc>
" yank a line to clipboard when not selecting anything
nnoremap <C-c> <S-v>"+y
" copy/paste to *system clipboard* in visual mode
  " vnoremap <C-c> "+y
  " vnoremap <C-S-v> "+p

" want to sync vim with system clipboard
" this makes every yank appear in system clipboard
set clipboard=unnamedplus " for windows it is unamed

"_____________________________________________________________________________
" compatibility with normal programs
nnoremap <c-a> ggvG

" make my short cuts 
" make newline easily: conflicts with vim command history
nnoremap <CR> o<Esc>
" maybe this resolves the conflict: nmap <S-Enter> <CR> doesnt work in vim, as enter is ^I
" this should fix the problem
:autocmd CmdwinEnter * nnoremap <CR> <CR>
:autocmd BufReadPost quickfix nnoremap <CR> <CR>

" map Backspace in normalmode to delete and go into insert
nnoremap <BS> xa

" Map Ctrl-Backspace to delete the previous word in insert mode, does not work?
inoremap <C-BS> <C-W>

" ______________________________________________________________________________ 
" Cucumber Tables
" Tabularize Plugin + Cucumber Tables with this script
" Cucumber tables are tables seperated by |
" see ~/jakobwild@gmail.com/Optimierung/vimrcs/cucumberTablesWithTabularPluginAutomation.vim
" and nvim plugin directory .config/nvim/plugins/ where files get automatically
" sourced

" ______________________________________________________________________________ 
" Change of Vim basics
" move by line on screen, not by line of file
" http://stackoverflow.com/questions/9713967/how-can-i-intuitively-move-cursor-in-vimnot-by-line
:map j gj
:map k gk

" provide hjkl movements in Insert mode and Command-line mode via the <Alt> modifier key
noremap! <A-h> <Left>
noremap! <A-j> <Down>
noremap! <A-k> <Up>
noremap! <A-l> <Right>

" get rid of help key that you might accidentally hit while trying to reach ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


"nmap <C-M> :tabnext<CR>
"nmap <C-N> :tabprev<CR>

"" Next / previous error with Tab / Shift+Tab.
"map <silent> <Tab> :cn<CR>
"map <silent> <S+Tab> :cp<CR>
"map <silent> <BS><Tab> :cp<CR>

"" Umlaut mappings for US keyboard.
imap "a ä
imap "o ö
imap "u ü
imap "s ß
imap "A Ä
imap "O Ö
imap "U Ü


" Old init.vim
" set runtimepath+=~/.config/nvim/settings

" runtime general.vim " ~/.config/nvim/settings/general.vim
" runtime functions.vim  " ~/.config/nvim/settings/functions.vim
" runtime playground.vim " ~/.config/nvim/settings/playground.vim
" runtime vundle.vim " ~/.config/nvim/settings/vundle.vim
" runtime bindings.vim " ~/.config/nvim/settings/bindings.vim




nnoremap <C-n> :bprev<cr>
nnoremap <C-m> :bnext<cr>



