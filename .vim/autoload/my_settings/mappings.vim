function my_settings#mappings#define_cr_for_insert_mode() abort
  imap <silent><expr> <CR> <SID>cr_expr_for_insert_mode()
endfunction

function my_settings#mappings#define_tab_for_insert_mode() abort
  imap <silent><expr> <TAB> <SID>tab_expr_for_insert_mode()
endfunction

function s:cr_expr_for_insert_mode() abort
  " <C-g>u: Break undo sequence when a new line is inserted
  return "\<C-g>u" .. lexima#expand("<CR>", "i")
endfunction

function s:tab_expr_for_insert_mode() abort
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  elseif pumvisible()
    return "\<C-y>"
  else
    return "\<TAB>"
  endif
endfunction
