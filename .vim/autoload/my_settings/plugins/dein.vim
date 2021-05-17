let s:update_log_file = expand("~/vim_plugin_updates.log")

function! my_settings#plugins#dein#output_update_logs() abort
  execute ":redir >> " . s:update_log_file
  silent! echo strftime("========== Update time: %Y-%m-%d %H:%M:%S ==========")
  silent! echo dein#get_updates_log()
  redir END
endfunction

function! my_settings#plugins#dein#open_log_file() abort
  execute ":e" . s:update_log_file
endfunction
