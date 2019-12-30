
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No blinking in gui
set gcr=a:blinkon0
" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

set guioptions-=m
set guioptions-=T

" Colorscheme
set background=dark
try
    "colorscheme peaksea
    colorscheme molokai
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of local vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
    map <F10> :e! ~/.vim/local.vim<cr>
    autocmd! bufwritepost ~/.vim/local.vim source ~/.vim/local.vim
else
    map <F10> :e! ~/.config/nvim/local.vim<cr>
    autocmd! bufwritepost ~/.config/nvim/local.vim source ~/.config/nvim/local.vim
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    if has('nvim')
        set undodir=~/.config/nvim/cache/undodir
    else
        set undodir=~/.vim/cache/undodir
    endif
    set undofile
catch
endtry


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" $q is super useful when browsing on the command line
" it deletes everything until the last slash 
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Map ½ to something useful
map ½ $
cmap ½ $
imap ½ $


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $< <esc>`>a><esc>`<i<<esc>
vnoremap $( <esc>`>a)<esc>`<i(<esc>
vnoremap $[ <esc>`>a]<esc>`<i[<esc>
vnoremap ${ <esc>`>a}<esc>`<i{<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the ripgrep firstly if possible (faster than ag)
" Use the the_silver_searcher if possible (much faster than Ack)
if executable('rg')
    let g:ackprg = 'rg --vimgrep --smart-case'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.[ch] set noexpandtab tabstop=8 shiftwidth=8 textwidth=79
autocmd BufNewFile,BufRead *.cc,*.cpp,*.hpp set noexpandtab tabstop=8 shiftwidth=8 textwidth=79
autocmd BufNewFile,BufRead *.md set tabstop=2 shiftwidth=2
autocmd FileType python setlocal textwidth=79
try
autocmd BufNewFile *.sh,*.py,*.[ch],*.cc,*.cpp,*.hpp exec ":call SetTitle('Jason Wang')"
autocmd BufReadPost *.[ch],*.cc,*.cpp,*.hpp exec ":call SubCR(2)"
catch
endtry

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

func! SubCR(lineno)
    let l:curdate = strftime('%Y')
    let l:crline = getline(a:lineno)
    let l:olddate_h = matchstr(l:crline, ' [0-9]\{4}', 3)
    let l:olddate_t = matchstr(l:crline, '-[0-9]\{4}', 3)
    let l:newdate_h = ' ' . l:curdate
    let l:newdate_t = '-' . l:curdate
    if l:olddate_t != '' && l:olddate_t < l:newdate_t
        let l:new_data_str = l:newdate_t
        call setline(a:lineno, substitute(l:crline, l:olddate_t, l:new_data_str, ''))
    elseif l:olddate_h != '' && l:olddate_h < l:newdate_h
        if match(l:crline, '[0-9]\{4}-') < 0
            let l:new_data_str = l:olddate_h . l:newdate_t
            call setline(a:lineno, substitute(l:crline, l:olddate_h, l:new_data_str, ''))
        endif
    endif
endfunc
