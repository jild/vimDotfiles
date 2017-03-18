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
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
nnoremap <leader>v :sp $HOME/.config/nvim/init.vim 
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
nnoremap <C-c> <S-v>"+y
" copy/paste to *system clipboard* in visual mode
" vnoremap <C-c> "+y
" vnoremap <C-S-v> "+p
"paste from clipboard in command mode
" nnoremap <leader>p o<C-r>+<esc>
" yank a line to clipboard when not selecting anything

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

nnoremap <C-n> :bprev<cr>
nnoremap <C-m> :bnext<cr>


"inotify test

