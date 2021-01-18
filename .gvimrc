" ウィンドウの縦幅
set lines=55
" ウィンドウの横幅
set columns=180
set guifont=HackGenNerdConsole-Regular:h14

augroup vimrc-colorscheme
  autocmd!
  autocmd ColorScheme * highlight String guifg=LightMagenta
  autocmd ColorScheme * highlight Comment guifg=gray
  autocmd ColorScheme * highlight Visual guifg=gray  " 選択モードで選択された部分の背景色を指定
augroup END

colorscheme iceberg
