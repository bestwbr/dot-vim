" Plug management

" ------------------------- Plugins ------------------------- "

set nocompatible
call plug#begin()

" ## Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ## Git integrated
Plug 'airblade/vim-gitgutter'
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" auto pairs like '"({
"Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'neui/cmakecache-syntax.vim'
"Plug 'vim-scripts/bash-support.vim'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'tmux-plugins/vim-tmux-focus-events'
" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'
" zenroom2
Plug 'amix/vim-zenroom2'
Plug 'vim-scripts/YankRing.vim'
"True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
" cheat.sh
if !has('nvim')
    Plug 'dbeniamine/cheat.sh-vim'
endif
"Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'
" Ctags bar
Plug 'majutsushi/tagbar'

" ## Developping support
Plug 'scrooloose/syntastic'
" ## Complete
Plug 'Valloric/YouCompleteMe'
" Next generation completion framework
"Plug 'shougo/neocomplete.vim'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-dictionary'
Plug 'rip-rip/clang_complete'
" Coc is an intellisense engine for vim8 & neovim.
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" ## Syntax check
Plug 'w0rp/ale'
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cquery-project/cquery'
Plug 'kergoth/aftersyntaxc.vim'
"provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'
Plug 'vim-scripts/indexer.tar.gz'
Plug 'brookhong/cscope.vim'
" A c/c++ client/server indexer for c/c++/objc[++] with integration based on clang.
"Plug 'andersbakken/rtags'
"Plug 'lyuts/vim-rtags'

" ## Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdtree'

" ## Comment
" Vim plug for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
Plug 'gcmt/wildfire.vim'
" Display thin vertical lines at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'
"Plug 'nathanaelkane/vim-indent-guides'

" ## Navigation
" FSwitch is designed to allow you to switch between companion files of source
" code (e.g. "cpp" files and their corresponding "h" files).
Plug 'derekwyatt/vim-fswitch'
" vim-signature is a plugin to place, toggle and display marks.
Plug 'kshenoy/vim-signature'
"Just a library for some scripts.
Plug 'vim-scripts/DfrankUtil'
"Plug for managing options for different projects
Plug 'vim-scripts/vimprj'
" Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
"Plug 'vim-scripts/DrawIt'
Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim'

" ## Debug
"Plug 'Conque-GDB'
Plug 'huawenyu/neogdb.vim'
Plug 'neomake/neomake'

" Python
Plug 'klen/python-mode'

" Rust
Plug 'rust-lang/rust.vim'

" Scala
Plug 'derekwyatt/vim-scala'

" Markdown
" depend on xdg-utils curl nodejs, check the installation firstly.
Plug 'suan/vim-instant-markdown'

" latex
Plug 'lervag/vimtex'

" verilog
Plug 'vhda/verilog_systemverilog.vim'

call plug#end()


" ------------------------ Plug configuration ---------------------- "

" => YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" => deocomplete
" Enable deoplete when InsertEnter.
let g:deoplete#enable_at_startup = 1
" Set a single option
call deoplete#custom#option('auto_complete_delay', 100)
" Pass a dictionary to set multiple options
call deoplete#custom#option({
			\ 'auto_complete_delay': 100,
			\ 'smart_case': v:true,
			\ })
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String']
            \ )
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

set hidden
let g:LanguageClient_rootMarkers = {
            \ 'cpp': ['compile_commands.json', 'build'],
            \ 'c': ['compile_commands.json', 'build']
            \ }
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
            \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
            \ }

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.vim/cquery_setting.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

setlocal dictionary+=/usr/share/dict/words
" Remove this if you'd like to use fuzzy search
"call deoplete#custom#source(
"            \ 'dictionary', 'matchers', ['matcher_head'])
" If dictionary is already sorted, no need to sort it again.
call deoplete#custom#source(
            \ 'dictionary', 'sorters', [])
" Do not complete too short words
call deoplete#custom#source(
            \ 'dictionary', 'min_pattern_length', 4)

" => cscope
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>t :call ToggleLocationList()<CR>
let g:cscope_silent = 1

" => switch between *.c and *.h
nmap <leader>ch :FSHere<cr>

" => ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Use honza's snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'

" => YankRing
if has('nvim')
    let g:yankring_history_dir = '~/.config/nvim/cache'
else
    let g:yankring_history_dir = '~/.vim/cache'
endif
"fix for yankring and neovim
let g:yankring_clipboard_monitor=0

" => NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" run vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" run vim with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"map <leader>tr :NERDTreeToggle<CR>
" Close vim when the nerdtree is the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" => Airline
let g:airline#extensions#tabline#enabled = 1

" => cheat.sh
if !has('nvim')
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_shell_checkers = ['shellcheck']
endif

" => vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" => Multi_cursor
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" => Vimroom
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" => autopair
"let g:AutoPairsFlyMode = 1

" => nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" => undotree
nnoremap <F5> :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle=1

" => delimitmate
let delimitMate_jump_expansion = 1
au FileType c let delimitMate_expand_cr = 1
au FileType sh let delimitMate_expand_space = 1

" PyMode
if isdirectory(expand("~/.vim/plugged/python-mode"))
    let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
endif
