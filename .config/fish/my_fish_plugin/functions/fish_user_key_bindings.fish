function fish_user_key_bindings
  fish_vi_key_bindings --no-erase

  # dfでノーマルモードへ
  bind -M insert -m default df force-repaint
end