if [ -f ~/dotfiles-local/.config.fish ]
  source ~/dotfiles-local/.config.fish
end

if status --is-interactive
  source ~/.config/fish/env.fish
  source ~/.config/fish/abbr.fish
end
