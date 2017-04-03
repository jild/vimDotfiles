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
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

Plugin 'tpope/vim-fugitive' " git functionality
Plugin 'vim-scripts/SearchComplete.git' " autocomplete search / ? with tab
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
" Plugin 'easymotion/vim-easymotion'  " new motion with <leader><leader>w
Plugin 'vimwiki/vimwiki.git' " default wiki page with <leader><leader>w
Plugin 'rafaqz/citation.vim.git'
let g:citation_vim_mode="zotero"
let g:citation_vim_zotero_path="/home/mm/.mozilla/firefox/manjaro.default/zotero"
"~/.zotero/zotero/jvkcoyob.default/zotero
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
Plugin 'ervandew/supertab' "needed?

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<ctrl-space>" " ctrl-space seems to workt too! way cooler
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

Plugin 'freitass/todo.txt-vim.git'
" fzf (fuzzy)
" Plugin 'junegunn/fzf'

" mksession on steroids
Plugin 'xolox/vim-session.git'
Plugin 'xolox/vim-misc.git' "needed for above
:let g:session_autoload = 'no'
:let g:session_autosave = 'no'

" use DeleteSession to delete your session
" RestartSession may come in handy too

Plugin 'scrooloose/syntastic.git' " syntax checking hacks, don't see a big difference to
Plugin 'https://github.com/neomake/neomake.git' " linter
autocmd! BufWritePost * Neomake " execute linter on every write

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



