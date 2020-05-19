function fish_user_key_bindings
  fzf_key_bindings

  # Ctrl-Kでノーマルモードへ
  bind -M insert -m default \ck force-repaint
end
