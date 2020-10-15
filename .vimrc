let mapleader = "\<Space>"

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
    execute 'git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
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
augroup END

"colorscheme molokai
colorscheme iceberg
"FIXME:
"本来は$TERMに256色設定をすべき。https://codeyarns.com/2015/03/18/how-to-set-term-to-xterm-256color/"
set t_Co=256


"----------------------------------------------------------
" Leader系
"----------------------------------------------------------
nnoremap <Leader>w :<C-u>w<CR>    " leader + w で保存
nnoremap <Leader>q :<C-u>q<CR>    " leader + q でファイルを閉じる
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
nnoremap <Leader>mm :<C-u>set nonumber<CR>
nnoremap <Leader>MM :<C-u>set number<CR>
nnoremap <Leader>pp :<C-u>set paste<CR>
nnoremap <Leader>PP :<C-u>set nopaste<CR>

" fzf.vim mappings
nnoremap <silent> <Leader>f :<C-u>Files<CR>
nnoremap <silent> <Leader>b :<C-u>Buffers<CR>
nnoremap <silent> <Leader>* :<C-u>Ag <C-r>=expand("<cword>")<CR><CR>
vnoremap <silent> <Leader>* :<C-u>Ag <C-r>=SelectedWords()->escape('()')<CR><CR>
nnoremap <silent> <Leader>d :<C-u>Files ~/dotfiles<CR>
nnoremap <silent> <Leader><Leader>m :<C-u>Files ~/.config/memo/_posts<CR>

"----------------------------------------------------------
" 改行系
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~   " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set nu                            " 行数を表示
hi NonText guibg=NONE guifg=DarkGreen    "改行記号
set notextmode                    " 改行コードを LF (UNIX 風)にする

""set matchpairs=(:),{:},[:],<:>

"----------------------------------------------------------
" normal mode
"----------------------------------------------------------
" 直前に選択していた範囲を選択
nnoremap gV `[v`]
nnoremap q: :<C-u>q<CR>
nnoremap + <C-a>                                      " increment & decrement number
nnoremap - <C-x>
nnoremap ,r :source $MYVIMRC<CR>                      " ,rで.vimrcを再読み込み
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> " ESCキー2度押しでハイライトの切り替え
nnoremap <C-]> g<C-]>                                 " tagsジャンプの時に複数ある時は一覧表示
nnoremap Gf <C-w><C-f>                                " カーソル下のファイルをウィンドウを分割して開く
nnoremap cie ciw


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
" visual mode
"----------------------------------------------------------
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"----------------------------------------------------------
" 検索
"----------------------------------------------------------
set hlsearch                      " 検索語をハイライト
set ignorecase                    " 検索時に大/小文字を区別しない
set smartcase                     " 検索パターンに大文字を含んでいたら大/小を区別

set wildmenu                      " コマンド補完を強化
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
  autocmd BufRead,BufNewFile *.txt set filetype=markdown
augroup END

augroup vimrc-tag
  autocmd!
  au BufNewFile,BufRead *.rb set tags+=$HOME/apps/lrms/current/tags
augroup END

augroup vimrc-auto-save
  autocmd!
  au InsertLeave,TextChanged * call s:auto_save()
augroup END

" ref. https://github.com/907th/vim-auto-save/blob/master/plugin/AutoSave.vim#L72-L80
" Preserve marks that are used to remember start and
" end position of the last changed or yanked text (`:h '[`).
function! s:auto_save() abort
  let first_char_pos = getpos("'[")
  let last_char_pos = getpos("']")

  try
    write
  catch
    echo "not saved"
  endtry

  call setpos("'[", first_char_pos)
  call setpos("']", last_char_pos)
endfunction

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

"for lightline.vim
set laststatus=2
set noshowmode

" https://itchyny.hatenablog.com/entry/20130828/1377653592
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
        \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" for previm
if has('mac')
  let g:previm_open_cmd = 'open -a Google\ Chrome'
elseif system("uname -r") =~# 'Microsoft' " WSLを使っている場合
  let g:previm_open_cmd = '/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'
  let g:previm_wsl_mode = 1
endif

" for fzf
" C-a: select-all, C-q: open files in quickfix
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border --inline-info --preview 'head -100 {}' --bind ctrl-a:select-all"

" Ag with preview
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)
" Files with preview
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! SelectedWords() abort
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  return selected
endfunction

" for help Open vim help by K command
if &filetype ==# "vim"
  setlocal keywordprg=:help
endif
