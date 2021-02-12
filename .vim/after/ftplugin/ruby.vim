" ruby.snip以外のsnippetファイル読み込み
let snippets_dir = expand('~/.vim/snippets/')

if my_settings#utils#get_current_file_name() =~# '_spec\.rb$'
  execute "NeoSnippetSource " . snippets_dir . "rspec.snip"
end
