if [ -f ~/.config/fish/config.fish.local ]
  source ~/.config/fish/config.fish.local
end

source ~/.config/fish/aliases.fish

if status --is-interactive
  source ~/.config/fish/env.fish
end
