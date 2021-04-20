" ------------------------------------------------------------------
" Menu
" ------------------------------------------------------------------
let s:marker = nr2char(0x2007)

if exists("g:fzf_menu_list")
else
  let g:fzf_menu_list = []
endif

let s:header = ["Description", "Command"]
let s:fzf_menu_list_with_header = extend([s:header], g:fzf_menu_list)

function! s:description_max_length() abort
  let l:max_length = 0

  for [description, _] in s:fzf_menu_list_with_header
    let l:max_length = max([l:max_length, len(description)])
  endfor

  return l:max_length
endfunction

let s:max_len = s:description_max_length()

function! s:menu_format(idx, list) abort
  return printf("%-*s %s", s:max_len, a:list[0], s:marker.a:list[1].s:marker)
endfunction

function! s:menu_source() abort
  return s:fzf_menu_list_with_header->copy()->map(function('s:menu_format'))
endfunction

function! s:menu_sink(menu) abort
  let cmd = matchstr(a:menu, s:marker.'.*'.s:marker)->substitute(s:marker, '', 'g')
  execute cmd
endfunction

function! my_settings#plugins#fzf#menu(bang=0)
  return fzf#run(fzf#wrap({
  \ 'source': s:menu_source(),
  \ 'sink': function('s:menu_sink'),
  \ 'options': '--prompt Menu\>\  --header-lines=1'
  \}, a:bang))
endfunction

" ------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------
function! s:format_function(line) abort
  return substitute(a:line, '^function \([^ ]*\).*$', '\1', '')
endfunction

function! s:sink_function(function) abort
  echo a:function
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
