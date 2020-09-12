" # Plug management

" ------------------------ Plugins definition ---------------------- "

" setup plug.vim
set nocompatible
call plug#begin()

" ## Color schemes
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ## Useful tools for vim
" Git integrated
Plug 'airblade/vim-gitgutter'
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" auto pairs like '"({
"Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'neui/cmakecache-syntax.vim'
"Plug 'vim-scripts/bash-support.vim'
if filereadable('/usr/bin/fzf')
    Plug '/usr/bin/fzf'
elseif filereadable(expand('~/.zsh/external/fzf/bin/fzf'))
    set rtp+=~/.zsh/external/fzf
elseif filereadable(expand('~/.fzf/bin/fzf'))
    set rtp+=~/.fzf
endif
Plug 'junegunn/fzf.vim'
"Plug 'tmux-plugins/vim-tmux-focus-events'
" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'
" zenroom2
Plug 'amix/vim-zenroom2'
Plug 'vim-scripts/YankRing.vim'
"True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
" provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'raimondi/delimitmate'
Plug 'mileszs/ack.vim'
Plug 'gcmt/wildfire.vim'
" cheat.sh
if !has('nvim')
    Plug 'dbeniamine/cheat.sh-vim'
endif

" ## Developping support
Plug 'scrooloose/syntastic'

" ### Completion
" Next generation completion framework
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if !has('nvim')
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'rip-rip/clang_complete'
" Coc is an intellisense engine for vim8 & neovim.
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" ### Syntax check
Plug 'w0rp/ale'
Plug 'cquery-project/cquery'
Plug 'kergoth/aftersyntaxc.vim'
if has('ctags')
    " Ctags bar
    Plug 'vim-scripts/indexer.tar.gz'
    Plug 'majutsushi/tagbar'
endif
if has('cscope')
    Plug 'brookhong/cscope.vim'
endif

" ### Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" Vim plug for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Display thin vertical lines at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'

" ### Navigation
" FSwitch is designed to allow you to switch between companion files of source
" code (e.g. "cpp" files and their corresponding "h" files).
Plug 'derekwyatt/vim-fswitch'
" vim-signature is a plugin to place, toggle and display marks.
Plug 'kshenoy/vim-signature'
" Just a library for some scripts.
Plug 'vim-scripts/DfrankUtil'
" Plug for managing options for different projects
Plug 'vim-scripts/vimprj'
" Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'Lokaltog/vim-easymotion'

" ### Debug
if has('nvim')
    Plug 'huawenyu/new.vim'
    Plug 'huawenyu/new-gdb.vim'
endif
Plug 'neomake/neomake'

" ### Languages support
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
"Plug 'lervag/vimtex'
" verilog
Plug 'vhda/verilog_systemverilog.vim'

call plug#end()


" ------------------------ Plugins configuration ---------------------- "

" => Airline
" Use powerline fonts by default
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

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

" => cscope
if has('cscope')
    set csto=0
    set cst
    " add any database in current directory
    if filereadable('cscope.out')
        silent cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ''
        if filereadable($CSCOPE_DB)
            silent cs add $CSCOPE_DB
        endif
    endif

    nnoremap <leader>f :call CscopeFindInteractive(expand('<cword>'))<CR>
    nnoremap <leader>t :call ToggleLocationList()<CR>
    let g:cscope_silent = 1
endif

" => switch between *.c and *.h
nmap <leader>ch :FSHere<cr>

" => ultisnips
" Use honza's snippets
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

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
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" run vim with a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"map <leader>tr :NERDTreeToggle<CR>
" Close vim when the nerdtree is the last buffer
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" => syntastic
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
if isdirectory(expand('~/.vim/plugged/python-mode')) || isdirectory(expand('~/.config/nvim/plugged/python-mode'))
    " use python 3 syntax checking
    let g:pymode_python = 'python3'

    let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
endif

if filereadable('/usr/lib/libclang.so')
    " ultra-useful for completion C code
    let g:clang_library_path='/usr/lib/libclang.so'
elseif filereadable(expand('~/.local/lib/libclang.so'))
    let g:clang_library_path=expand('~/.local/lib/libclang.so')
else
    echo 'Please install clang and make a symbolic link of libclang.so.* in /usr/lib/libclang.so or ~/.local/lib/libclang.so'
endif
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
