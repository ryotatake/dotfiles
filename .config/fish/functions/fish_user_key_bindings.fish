function fish_user_key_bindings
  fzf_key_bindings

  # jkでノーマルモードへ
  bind -M insert -m default jk force-repaint
end
