" Q for quitting help buffer
nnoremap <buffer> q :q <CR>

" Help is a vertical buffer
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END
