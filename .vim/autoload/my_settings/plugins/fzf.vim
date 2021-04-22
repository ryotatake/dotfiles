" ------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------
function! s:format_function(line) abort
  return substitute(a:line, '^function \(.\{-1,}\)\( abort\)\?$', '\1', '')
endfunction

function! s:sink_function(function) abort
  execute feedkeys(":call ".a:function)
endfunction

function! my_settings#plugins#fzf#functions(bang=0)
  redir => cout
  silent function
  redir END
  let list = split(cout, "\n")
  return fzf#run(fzf#wrap({
  \ 'source': list->map('s:format_function(v:val)'),
  \ 'sink': function('s:sink_function'),
  \ 'options': '--prompt Functions\>\ '
  \}, a:bang))
endfunction
