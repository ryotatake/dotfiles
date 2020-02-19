" https://github.com/kg8m/.vim/blob/0b60b62817fabb2dd8a451b5a40b1770c0c78089/ftplugin/gitcommit.vim
function! OpenGitDiffWindows() abort
  if exists("w:git_diff_opened") && w:git_diff_opened
    return
  endif

  let w:git_diff_opened = 1

  set nosplitright

  vnew
  silent! setlocal ft=git bufhidden=delete nobackup noswf nobuflisted wrap buftype=nofile
  execute ":0r !git log --max-count=100\n"
  setlocal nomodifiable
  goto 1
  redraw!
  wincmd R
  wincmd p
  goto 1
  redraw!
endfunction

set nowarn

call OpenGitDiffWindows()
set nowritebackup
