function! my_settings#utils#get_current_file_name() abort
  return expand('%:t')
endfunction

function! my_settings#utils#get_current_relative_path() abort
  return expand('%:~:.')
endfunction

function! my_settings#utils#get_current_absolute_path() abort
  return expand('%:~')
endfunction

function! my_settings#utils#selected_words() abort
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  return selected
endfunction
