if [ -f ~/dotfiles-local/.config.fish ]
  source ~/dotfiles-local/.config.fish
end

source ~/.config/fish/aliases.fish

if status --is-interactive
  source ~/.config/fish/env.fish
  source ~/.config/fish/abbr.fish
end
