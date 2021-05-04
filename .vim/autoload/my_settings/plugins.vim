function! my_settings#plugins#syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \ 'add\|source\|post_source\|post_update\|done_update'.
  \ '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction

function! my_settings#plugins#lexima_rules() abort
  " 直後にアルファベットや数字がある場合は補完しない。VSCodeの挙動を参考にした。
  " Before        Input         After
  " ------------------------------------
  " |foo          "             "|foo
  " ------------------------------------
  " |foo          '             '|foo
  " ------------------------------------
  " |foo          (             (|foo
  " ------------------------------------
  " |foo          {             {|foo
  " ------------------------------------
  " |foo          [             [|foo
  " ------------------------------------
  " |foo          `             `|foo
  " ------------------------------------
  " (the cursor position is represented by |)
  call lexima#add_rule({'char': '"', 'at': '\%#\w'})
  call lexima#add_rule({'char': "'", 'at': '\%#\w'})
  call lexima#add_rule({'char': "(", 'at': '\%#\w'})
  call lexima#add_rule({'char': "{", 'at': '\%#\w'})
  call lexima#add_rule({'char': "[", 'at': '\%#\w'})
  call lexima#add_rule({'char': "`", 'at': '\%#\w'})

  " 直前にアルファベットや数字がある場合は補完しない。
  " Before        Input         After
  " ------------------------------------
  " foo|          "             foo"|
  " ------------------------------------
  " foo|          '             foo'|
  " ------------------------------------
  " foo|          `             foo`|
  call lexima#add_rule({'char': '"', 'at': '\w\%#'})
  " これがないと次のようになってくれない
  " Before        Input         After
  " ------------------------------------
  " "foo|"        "             "foo"|
  call lexima#add_rule({'char': '"', 'at': '\w\%#"', 'leave': 1})
  call lexima#add_rule({'char': "'", 'at': '\w\%#'})
  call lexima#add_rule({'char': "'", 'at': '\w\%#''', 'leave': 1})
  call lexima#add_rule({'char': "`", 'at': '\w\%#'})
  call lexima#add_rule({'char': "`", 'at': '\w\%#`', 'leave': 1})
endfunction
