function fish_user_key_bindings
  fzf_key_bindings
  fish_vi_key_bindings --no-erase

  # jkでノーマルモードへ
  bind -M insert -m default jk force-repaint
end
