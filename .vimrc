""""""""""""""""""""""""""""""
" カラースキーマ
""""""""""""""""""""""""""""""
"colorscheme desert
colorscheme molokai

""""""""""""""""""""""""""""""
" カレントウィンドウ以外の罫線非表示
""""""""""""""""""""""""""""""
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline nocursorcolumn
  autocmd WinEnter,BufRead * set cursorline cursorcolumn
augroup END

highlight CursorLine ctermbg=white guibg=white
""""""""""""""""""""""""""""""
" 改行系
""""""""""""""""""""""""""""""
set whichwrap=b,s,h,l,>,[,]       " 行移動がスムーズになる
set ai                            " 改行後の自動インデント
set nu                            " 行数を表示
set cursorline                    " カーソル行下線 色設定は「hi CursolLine 〜」部で行ってる。
set cursorcolumn                  " カーソル列を強調表示
hi NonText guibg=NONE guifg=DarkGreen    "改行記号
set notextmode                    " 改行コードを LF (UNIX 風)にする
""set matchpairs=(:),{:},[:],<:>

""""""""""""""""""""""""""""""
" insert mode
""""""""""""""""""""""""""""""
""imap <C-j> <Down>
""imap <C-k> <Up>
""imap <C-h> <Left>
""imap <C-l> <Right>
""imap <C-x> <Delete>

""""""""""""""""""""""""""""""
" 検索
""""""""""""""""""""""""""""""
set hlsearch                      " 検索語をハイライト
set ignorecase                    " 大/小を区別しない
set smartcase                     " 大文字を含んでいたら大/小を区別

set wildmenu                      " コマンド補完を強化
set incsearch                     " インクリメンタルサーチ

""""""""""""""""""""""""""""""
" スペース系
""""""""""""""""""""""""""""""
set tabstop=2     " <Tab> での空白数
set shiftwidth=2  " 自動インデントでの空白数
set expandtab     " タブをスペースに
set autoindent    " オートインデント
set smartindent   " 賢いオートインデント
set backspace=1   " 改行後に BS を押すと上の行末に移動する
"autocmd BufWritePre * :%s/\s\+$//ge    " 保存時に行末の空白を除去する
set backspace=start,eol,indent

""""""""""""""""""""""""""""""
" タブ文字、行末スペースの可視化
""""""""""""""""""""""""""""""
set list
set listchars=tab:>\ ,eol:\ ,trail:_

""""""""""""""""""""""""""""""
" その他見た目
""""""""""""""""""""""""""""""
syntax on                      " 強調表示オン
set showmatch                  " 括弧の対応の表示
set showmode                   " モードを表示
set showcmd                    " 打ったキーを表示
set title                      " タイトルをウィンドウ枠に表示
set ruler                      " ルーラーを表示
highlight Visual ctermbg=gray  " 選択モードで選択された部分の背景色を指定

autocmd BufRead,BufNewFile *.erb set filetype=eruby.html

""""""""""""""""""""""""""""""
" 空白ハイライト
""""""""""""""""""""""""""""""
""highlight WhitespaceEOL ctermfg=BLUE ctermbg=BLUE guibg=BLUE
""au BufWinEnter,VimEnter,WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\s\+$')
""
""highlight WhitespaceBOL ctermfg=BLUE ctermbg=BLUE guibg=BLUE
""au BufWinEnter,VimEnter,WinEnter * let w:m2 = matchadd("WhitespaceBOL", '^\s\+')
""
""highlight ZenkakuSpace ctermfg=BLUE ctermbg=BLUE guibg=BLUE
""au BufWinEnter,VimEnter,WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=skelton guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


""""""""""""""""""""""""""""""
" クリップボード
""""""""""""""""""""""""""""""
set clipboard&
set clipboard^=unnamedplus


""""""""""""""""""""""""""""""
" svn diffを出力
""""""""""""""""""""""""""""""
nmap ,d :call SVNDiff()<CR>
function! SVNDiff()
  edit diff
  silent! setlocal ft=diff nobackup noswf buftype=nofile
  execute "normal :r!LANG=ja_JP.UTF8 svn diff\n"
  goto 1
endfunction


""""""""""""""""""""""""""""""
" ,rで.vimrcを再読み込み
""""""""""""""""""""""""""""""
nnoremap ,r :source ~/.vimrc<CR>


""""""""""""""""""""""""""""""
" 新しいアプリケーションで使うデータベース
""""""""""""""""""""""""""""""
let g:rails_default_database="mysql"

""""""""""""""""""""""""""""""
" neocomplcache
""""""""""""""""""""""""""""""
""let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
""imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" :pumvisible() ?  "\<C-n>" : "\<TAB>"

""let g:rails_level = 4


