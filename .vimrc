let mapleader = "\<Space>"

" https://secret-garden.hatenablog.com/entry/2017/12/03/000628
augroup my_vimrc
  autocmd!
augroup END
command! -nargs=* MyAutocmd autocmd my_vimrc <args>

"----------------------------------------------------------
" Pluginの準備
"----------------------------------------------------------
" https://qiita.com/delphinus/items/00ff2c0ba972c6e41542
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimがなければgithubから取ってくる。
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim/rc')
  " 起動時に読み込みさせたいプラグイン
  let s:toml   = g:rc_dir . '/dein.toml'
  " 遅延読み込みさせたいプラグイン
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOMLを読み込み、キャッシュさせる
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" 未インストールのものがあればインストール
if dein#check_install()
  call dein#install()
endif

" https://github.com/Shougo/dein.vim/blob/772ae08cef5e712b2b31b4aaee908fc853accd94/doc/dein.txt#L907-L911
autocmd VimEnter * call dein#call_hook('post_source')

"----------------------------------------------------------
" ファイル
"----------------------------------------------------------
set encoding=utf-8
set nobackup   " バックアップファイルを作らない
set noswapfile " スワップファイルを作らない


"----------------------------------------------------------
" カーソル変更
"----------------------------------------------------------

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

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
" https://qiita.com/sff1019/items/3f73856b78d7fa2731c7
" :so $VIMRUNTIME/syntax/colortest.vim で色のリストを確認できる。
command! Colorlist :source $VIMRUNTIME/syntax/colortest.vim

augroup vimrc-colorscheme
  autocmd!
  autocmd ColorScheme * highlight String ctermfg=175
  autocmd ColorScheme * highlight Comment ctermfg=gray
  autocmd ColorScheme * highlight Visual ctermbg=gray  " 選択モードで選択された部分の背景色を指定
  autocmd ColorScheme * highlight CursorLineNr ctermfg=lightred
  " ターミナルの背景色に合わせるための設定
  autocmd ColorScheme * highlight Normal ctermbg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none
  autocmd ColorScheme * highlight SignColumn ctermbg=none
  autocmd ColorScheme * highlight EndOfBuffer ctermbg=none
augroup END

"colorscheme molokai
colorscheme iceberg
"FIXME:
"本来は$TERMに256色設定をすべき。https://codeyarns.com/2015/03/18/how-to-set-term-to-xterm-256color/"
set t_Co=256


"----------------------------------------------------------
" キーマッピング
"----------------------------------------------------------
" leader + w で保存
nnoremap <Leader>w :<C-u>w<CR>
" leader + q でファイルを閉じる
nnoremap <Leader>q :<C-u>q<CR>
" leader + v,s でwindow分割
nnoremap <Leader>v <C-w>v
nnoremap <Leader>s <C-w>s
" leader + h,j,k,lでwindowの移動
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
" leader + H,J,K,Lでwindowの位置を変える
nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

" Tab/Shift+Tabでインデントさせる
" in insert mode, use <C-t>/<C-d>
nnoremap <Tab> >>
vnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <S-Tab> <<

" Ctrl+j,kでポップアップメニューから選択
imap <expr><C-j> pumvisible() ? "<C-n>" : "<C-j>"
imap <expr><C-k> pumvisible() ? "<C-p>" : "<C-k>"

" 直前に選択していた範囲を選択
nnoremap gV `[v`]
nnoremap q: :<C-u>q<CR>
" increment & decrement number
nnoremap + <C-a>
nnoremap - <C-x>
" ,rで.vimrcを再読み込み
nnoremap ,r :source $MYVIMRC<CR>
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>
" カーソル下のファイルをウィンドウを分割して開く
nnoremap Gf <C-w><C-f>
nnoremap cie ciw

" 行頭や行末への移動を簡単にする
nnoremap <C-l> $
vnoremap <C-l> $
nnoremap <C-h> ^
vnoremap <C-h> ^

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" fzf.vim mappings
" http://deris.hatenablog.jp/entry/2013/05/02/192415
nnoremap [fzf] <Nop>
vnoremap [fzf] <Nop>
nmap     <Leader>f [fzf]
vmap     <Leader>f [fzf]
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]a :<C-u>Ag<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]* :<C-u>Ag <C-r>=expand("<cword>")<CR><CR>
vnoremap <silent> [fzf]* :<C-u>Ag <C-r>=my_settings#utils#selected_words()->escape('()')<CR><CR>
nnoremap <silent> [fzf]d :<C-u>Files ~/dotfiles<CR>
nnoremap <silent> [fzf]m :<C-u>Files ~/.config/memo/_posts<CR>
nnoremap <silent> [fzf]l :call FindByCursorFilename()<CR>

" ack.vim mappings
" カーソル下の単語をAckで検索する
nnoremap <silent> <Leader>A :<C-u>Ack "\b<C-r>=expand("<cword>")<CR>\b"<CR>

" カーソル下の単語を簡単に一括置換できるようにする
nnoremap <Leader>R :<C-u>%s/\v<(<C-r>=expand("<cword>")<CR>)>/
vnoremap <Leader>R :<C-u>%s/\v(<C-r>=my_settings#utils#selected_words()->fnameescape()<CR>)/

" fern.vim mappings
let g:notebooks_dir = expand("~/notebooks")
nnoremap <silent> <Leader>N :<C-u>Fern <C-r>=g:notebooks_dir<CR> -drawer<CR>
nnoremap <silent> <Leader>F :<C-u>Fern . -drawer<CR>

"----------------------------------------------------------
" 改行系
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~   " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set nu                            " 行数を表示
hi NonText guibg=NONE guifg=DarkGreen    "改行記号
set notextmode                    " 改行コードを LF (UNIX 風)にする

"----------------------------------------------------------
" その他
"----------------------------------------------------------
set belloff=all


"----------------------------------------------------------
" insert mode
"----------------------------------------------------------
" dfでEscした時とノーマルモードでEscした時に英数モードにする
" https://rcmdnk.com/blog/2017/03/10/computer-mac-vim/
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    inoremap <silent> df <Esc>:call system(g:imeoff)<CR>
  augroup END
  noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
else
  inoremap <silent> df <Esc>
endif


"----------------------------------------------------------
" 検索
"----------------------------------------------------------
set hlsearch                      " 検索語をハイライト
set ignorecase                    " 検索時に大/小文字を区別しない
set smartcase                     " 検索パターンに大文字を含んでいたら大/小を区別

set wildmenu                      " コマンド補完を強化
set wildmode=list:longest         " 補完候補を全て表示する & 補完候補の全てに共通する部分だけ自動で補完される
set incsearch                     " インクリメンタルサーチ


"----------------------------------------------------------
" スペース系
"----------------------------------------------------------
set tabstop=8     " <Tab> での空白数
set shiftwidth=2  " 自動インデントでの空白数
set expandtab     " タブをスペースに
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set backspace=1   " 改行後に BS を押すと上の行末に移動する
set backspace=start,eol,indent


"----------------------------------------------------------
" タブ文字、行末スペースの可視化
"----------------------------------------------------------
set list
set listchars=tab:>-,trail:_


"----------------------------------------------------------
" その他見た目
"----------------------------------------------------------
syntax enable                  " 強調表示オン
set showmatch                  " 括弧の対応の表示
set showmode                   " モードを表示
set showcmd                    " 打ったキーを表示
set title                      " タイトルをウィンドウ枠に表示
set scrolloff=2
set cursorline
set signcolumn=yes             " aleやvim-signify用に常にsignカラムを表示する
set shortmess=atTI


"----------------------------------------------------------
" クリップボード
"----------------------------------------------------------
"https://pocke.hatenablog.com/entry/2014/10/26/145646
set clipboard&
"Linux以外
set clipboard+=unnamed
"Linux用
set clipboard^=unnamedplus

" https://github.com/kg8m/dotfiles/blob/7148aa65b0a892a98c3776c10fd0a22bb3e38e18/.vimrc#L288
function! RemoteCopy(text) abort
  let text = a:text
  let text = substitute(text, '\n$', "", "")
  let text = substitute(text, '%', "%%", "g")
  let text = shellescape(escape(text, '\'))

  " ~/.ssh/config でmainという名前でsshできるように設定しておく。
  let executed = system("printf " . text . " | ssh main -t 'pbcopy'")

  if v:shell_error != 0
    echomsg "Not Copied: Because " . executed
  else
    echomsg "Copied"
  endif
endfunction

" 無名レジスタ \"にコピーした上で、@"で取り出す。
vnoremap <silent> <Leader>y "yy:call RemoteCopy(@")<Cr>

"----------------------------------------------------------
" 新しいアプリケーションで使うデータベース
"----------------------------------------------------------
let g:rails_default_database="mysql"

let g:rails_level = 4


"----------------------------------------------------------
" auto commands
"----------------------------------------------------------
augroup vimrc-number
  autocmd!
  autocmd WinLeave,BufLeave * set nonumber
  autocmd WinEnter,BufEnter * set number
augroup END

augroup vimrc-filetype
  autocmd!
  autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
augroup END

augroup vimrc-html-auto-close
  autocmd!
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END


"----------------------------------------------------------
" Utility Functions
"----------------------------------------------------------
" ウィンドウの最大化・元に戻す
let g:toggle_window_size = 0
function! ToggleWindowSize() abort
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    resize
    vertical resize
    let g:toggle_window_size = 1
  endif
endfunction
nnoremap <silent> <Leader>z :call ToggleWindowSize()<CR>

"----------------------------------------------------------
" Pluginのための設定
"----------------------------------------------------------
filetype plugin indent on "ファイル形式別のプラグインのロードを有効化

" for help Open vim help by K command
if &filetype ==# "vim"
  setlocal keywordprg=:help
endif

" ref. https://github.com/plasticboy/vim-markdown/blob/8e5d86f7b85234d3d1b4207dceebc43a768ed5d4/ftplugin/markdown.vim#L537-L555
function! s:TracTableFormat() abort
  let l:pos = getpos('.')
  normal! {
  " Search instead of `normal! j` because of the table at beginning of file edge case.
  call search('||')
  " gdefaultが1の場合は、flagにgを指定すると1番目だけが置換される。常に行全体を置換するためにこの判定を行う。
  let l:flags = (&gdefault ? '' : 'g')
  " Tabularize /||によって、||の前後に2スペース挿入される。
  " それによってTracTableFormatを呼び出す度にテーブルが横に伸びてしまうので、連続するスペースを事前に削除しておく。
  execute 's/ \+/ /e' . l:flags
  Tabularize /||
  " 見出しにつける=の位置を調整する。
  execute 's/||\( \+\)=/||=\1/e' . l:flags
  execute 's/=\( \+\)||/\1=||/e' . l:flags
  call setpos('.', l:pos)
endfunction
command! TracTableFormat call s:TracTableFormat()

"----------------------------------------------------------
" settings for notebooks
"----------------------------------------------------------

let s:journals_dir = expand("~/notebooks/journals")
let s:journal_filename = strftime("%Y-%m-%d") . ".md"
let s:new_journal_title = "# " . strftime("%Y-%m-%d")
let s:new_journal_template_path = expand("~/notebooks/journals/template.md")

function! s:journal_path() abort
  return s:journals_dir . "/" . s:journal_filename
endfunction

function! s:new_or_edit_journal() abort
  execute "edit " . s:journal_path()

  if s:is_blank_file()
    call s:add_journal_title()
    call s:add_blank_line()
    call s:add_from_journal_template()
  endif
endfunction
command! Journal call s:new_or_edit_journal()

function! s:add_journal_title() abort
  execute "normal i" . s:new_journal_title
endfunction

function! s:add_blank_line() abort
  " ref. https://vim-jp.org/vim-users-jp/2009/08/15/Hack-57.html
  call append(expand('.'), '')
  normal j
endfunction

function! s:add_from_journal_template() abort
  execute "silent read " . fnameescape(s:new_journal_template_path)
endfunction

function! s:is_blank_file() abort
  return line('$') == 1 && getline(1) == ''
endfunction

"----------------------------------------------------------
" .vimrc以外の読み込み
"----------------------------------------------------------
call localrc#load(g:localrc_filename)

let s:local_vimrc_path = expand("~/dotfiles-local/.vimrc")
if filereadable(s:local_vimrc_path)
  execute "source " . s:local_vimrc_path
endif
