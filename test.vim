let s:marker = nr2char(0x2007)

let g:fzf_menu_list = [
\  ["Description",                               "Command"],
\  ["[fzf] Find by Filename under cursor",       "call FindByCursorFilename()"],
\  ["[option] Toggle Paste",                     "set invpaste"],
\  ['[substitute] Delete Blank Lines',           'v/./d'],
\  ['[substitute] snake_case to camelCase',      's#_\(\l\)#\u\1#g'],
\  ['[substitute] snake_case to UpperCamelCase', 's#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g'],
\  ["[repl] Toggle REPL",                        "REPLToggle"],
\]

function! s:description_max_length() abort
  let l:max_length = 0

  for [description, _] in g:fzf_menu_list
    let l:max_length = max([l:max_length, len(description)])
  endfor

  return l:max_length
endfunction

let s:max_len = s:description_max_length()

function! s:menu_format(idx, list) abort
  return printf("%-*s %s", s:max_len, a:list[0], s:marker.a:list[1].s:marker)
endfunction

function! s:menu_source() abort
  return g:fzf_menu_list->map(function('s:menu_format'))
endfunction

function! s:menu_sink(menu) abort
  let cmd = matchstr(a:menu, s:marker.'.*'.s:marker)->substitute(s:marker, '', 'g')
  execute cmd
endfunction

function! Menu()
  return fzf#run(fzf#wrap({
  \ 'source': s:menu_source(),
  \ 'sink': function('s:menu_sink'),
  \ 'options': '--prompt Menu\>\  --header-lines=1'
  \}))
endfunction

call Menu()
