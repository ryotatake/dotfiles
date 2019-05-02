""""""""""""""""""""""""""""""
" テンプレート
""""""""""""""""""""""""""""""
function! CppTemplate()
  return setline('.', ['#include <bits/stdc++.h>', '', 'using namespace std;', '', 'int main() {', '', '  return 0;', '}'])
endfunction
command! CppTemplate :call CppTemplate()

function! CppTemplateHeader()
  let filename = expand("%:r")
  let filenameConst = '_' . toupper(filename) . '_H_'
  return setline('.', ['#ifndef '. filenameConst, '#define ' . filenameConst, '', '#endif //' . filenameConst])
endfunction
command! CppTemplateHeader :call CppTemplateHeader()

""""""""""""""""""""""""""""""
" ファイル
""""""""""""""""""""""""""""""
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile

""""""""""""""""""""""""""""""
" カーソル変更
""""""""""""""""""""""""""""""

if has('vim_starting')
  if exists('$TMUX')
    " tmux使用時は追加のエスケープが必要
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    let &t_SR .= "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
  else
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
  endif
endif

""""""""""""""""""""""""""""""
" カラースキーマ
""""""""""""""""""""""""""""""
"colorscheme desert
colorscheme molokai
"FIXME:
"本来は$TERMに256色設定をすべき。https://codeyarns.com/2015/03/18/how-to-set-term-to-xterm-256color/"
set t_Co=256
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
"Leader系
""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
nnoremap <Leader>w :<C-u>w<CR>    " leader + w で保存
nnoremap <Leader>v <C-w>v         " leader + v,s でwindow分割
nnoremap <Leader>s <C-w>s
nnoremap <Leader>h <C-w>h         " leader + h,j,k,lでwindowの移動
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>H <C-w>H         " leader + H,J,K,Lでwindowの位置を変える
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

""""""""""""""""""""""""""""""
" 改行系
""""""""""""""""""""""""""""""
set whichwrap=b,s,h,l,<,>,[,],~   " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set nu                            " 行数を表示
set cursorline                    " カーソル行下線 色設定は「hi CursolLine 〜」部で行ってる。
set cursorcolumn                  " カーソル列を強調表示
hi NonText guibg=NONE guifg=DarkGreen    "改行記号
set notextmode                    " 改行コードを LF (UNIX 風)にする

""set matchpairs=(:),{:},[:],<:>

""""""""""""""""""""""""""""""
" normal mode
""""""""""""""""""""""""""""""
nnoremap mm :<C-u>set nonumber<CR>
nnoremap MM :<C-u>set number<CR>
nnoremap gV `[v`]
" move line
nnoremap <C-a> 0
nnoremap <C-e> $
" increment & decrement number
nnoremap + <C-a>
nnoremap - <C-x>

""""""""""""""""""""""""""""""
" insert mode
""""""""""""""""""""""""""""""
inoremap kj <Esc>
inoremap jk <Esc>
" 移動
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
" move line
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" :terminalモードでnormalモードへ
tnoremap <Esc> <C-w><S-n>

""""""""""""""""""""""""""""""
" 検索
""""""""""""""""""""""""""""""
set hlsearch                      " 検索語をハイライト
set ignorecase                    " 検索時に大/小文字を区別しない
set smartcase                     " 検索パターンに大文字を含んでいたら大/小を区別

set wildmenu                      " コマンド補完を強化
set incsearch                     " インクリメンタルサーチ

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

""""""""""""""""""""""""""""""
" スペース系
""""""""""""""""""""""""""""""
set tabstop=2     " <Tab> での空白数
set shiftwidth=2  " 自動インデントでの空白数
set expandtab     " タブをスペースに
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set backspace=1   " 改行後に BS を押すと上の行末に移動する
set backspace=start,eol,indent

""""""""""""""""""""""""""""""
" タブ文字、行末スペースの可視化
""""""""""""""""""""""""""""""
set list
set listchars=tab:>\ ,eol:\ ,trail:_

""""""""""""""""""""""""""""""
" その他見た目
""""""""""""""""""""""""""""""
syntax enable                  " 強調表示オン
set showmatch                  " 括弧の対応の表示
set showmode                   " モードを表示
set showcmd                    " 打ったキーを表示
set title                      " タイトルをウィンドウ枠に表示
highlight Visual ctermbg=gray  " 選択モードで選択された部分の背景色を指定
hi Comment ctermfg=darkcyan    " コメントになっている部分の色を指定。
                               " :so $VIMRUNTIME/syntax/colortest.vim で色のリストを確認できる。

autocmd BufRead,BufNewFile *.erb set filetype=eruby.html


""""""""""""""""""""""""""""""
" クリップボード
""""""""""""""""""""""""""""""
"https://pocke.hatenablog.com/entry/2014/10/26/145646
set clipboard&
"Linux以外
set clipboard+=unnamed
"Linux用
set clipboard^=unnamedplus


""""""""""""""""""""""""""""""
" tagsの作成
""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.rb set tags+=$HOME/apps/lrms/current/tags

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

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
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" :pumvisible() ?  "\<C-n>" : "\<TAB>"

let g:rails_level = 4

""""""""""""""""""""""""""""""
" RSpec.vim mappings
""""""""""""""""""""""""""""""
map <Leader>t :call RunCurrentSpecFile()<CR>

""""""""""""""""""""""""""""""
" Vundleによるプラグイン管理
""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-rails'
Plugin 'Keithbsmiley/rspec.vim'  "rspec用シンタックスハイライト
Plugin 'soramugi/auto-ctags.vim'
Plugin 'thoughtbot/vim-rspec'    "テストの実行を楽に
Plugin 'itchyny/lightline.vim'   "vimにpowerlineを表示
Plugin 'joker1007/vim-ruby-heredoc-syntax'
Plugin 'othree/yajs.vim'
Plugin 'vim-jp/vim-cpp'
" leader + sh で上にterminalを開く
Plugin 'Shougo/deol.nvim'
nnoremap <Leader>sh :<C-u>Deol -split="horizontal"<CR>

"for lightline.vim
set laststatus=2
set noshowmode
Plugin 'yegappan/mru'            "ファイル編集履歴リスト
"for mru
nnoremap <space><space> :<C-u>MRU<CR>
Plugin 'slim-template/vim-slim'
" 古いバージョンのRSpecを動かすためのコマンド
let g:rspec_command = ":terminal spec {spec}"

if has('lua') " lua機能が有効になっている場合・・・・・・①
    " コードの自動補完
    Plugin 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    Plugin 'Shougo/neosnippet'
    " スニペット集
    Plugin 'Shougo/neosnippet-snippets'
endif

"----------------------------------------------------------
" neocomplete・neosnippetの設定 (luaが有効で無いと使えません)
"----------------------------------------------------------
if has('lua')
  " Vim起動時にneocompleteを有効にする
  let g:neocomplete#enable_at_startup = 1
  " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
  let g:neocomplete#enable_smart_case = 1
  " 3文字以上の単語に対して補完を有効にする
  let g:neocomplete#min_keyword_length = 3
  " 区切り文字まで補完する
  let g:neocomplete#enable_auto_delimiter = 1
  " 1文字目の入力から補完のポップアップを表示
  let g:neocomplete#auto_completion_start_length = 1
  " バックスペースで補完のポップアップを閉じる
  inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

  " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
  imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
  " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
  imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on
