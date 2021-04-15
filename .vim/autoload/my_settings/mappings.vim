function my_settings#mappings#define_cr_for_insert_mode() abort
  imap <silent><expr> <CR> <SID>cr_expr_for_insert_mode()
endfunction

function s:cr_expr_for_insert_mode() abort
  if neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  elseif pumvisible()
    return "\<C-y>"
  else
    " <C-g>u: Break undo sequence when a new line is inserted
    return "\<C-g>u" .. lexima#expand("<CR>", "i")
  endif
endfunction
