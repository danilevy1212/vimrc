"" Python
setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 fileformat=unix expandtab autoindent

"" Jedi
" Disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled=0

" show call signature
let g:jedi#show_call_signatures=1

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers="right"
