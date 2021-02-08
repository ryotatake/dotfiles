if [ -f ~/dotfiles-local/.config.fish ]
  source ~/dotfiles-local/.config.fish
end

source ~/.config/fish/aliases.fish

if status --is-interactive
  source ~/.config/fish/env.fish
end

if [ -f ~/.cargo/env ]
  source ~/.cargo/env
end
