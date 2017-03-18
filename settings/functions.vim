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
 
