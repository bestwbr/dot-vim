
if 1
     execute 'source' fnamemodify(expand('<sfile>'), ':h').'/basic.vim'
     execute 'source' fnamemodify(expand('<sfile>'), ':h').'/filetypes.vim'
     execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugins.vim'
     execute 'source' fnamemodify(expand('<sfile>'), ':h').'/extended.vim'
try
     execute 'source' fnamemodify(expand('<sfile>'), ':h').'/local.vim'
catch
endtry
endif
