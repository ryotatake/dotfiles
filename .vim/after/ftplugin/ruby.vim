" ruby.snip以外のsnippetファイル読み込み
let snippets_dir = expand('~/.vim/snippets/')

if CurrentFileName() =~# '_spec\.rb$'
  execute "NeoSnippetSource " . snippets_dir . "rspec.snip"
end
