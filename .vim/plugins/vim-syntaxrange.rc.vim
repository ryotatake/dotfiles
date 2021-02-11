" https://teratail.com/questions/151066
" toml内には複数列リテラルの仕様上上手く書けなかったのでファイルを分ける

" ref. https://qiita.com/tmsanrinsha/items/9670628aef3144c7919b
augroup vimrc-syntax-range
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter dein*.toml call s:syntax_range_dein()
augroup END

function! s:syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \ 'add\|source\|post_source\|post_update\|done_update'.
  \ '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction
