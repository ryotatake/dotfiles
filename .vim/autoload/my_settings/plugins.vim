function! my_settings#plugins#syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \ 'add\|source\|post_source\|post_update\|done_update'.
  \ '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction
