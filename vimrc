
if 1
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/configs/basic.vim'
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/configs/plugins.vim'
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/configs/extended.vim'
try
    execute 'source' fnamemodify(expand('<sfile>'), ':h').'/local.vim'
catch
endtry
endif
