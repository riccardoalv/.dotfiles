if status is-interactive
	starship init fish | source
	zoxide init fish | source

  atuin init fish --disable-up-arrow | source

  alias zz='cd $(find . -type d -print | fzf)'
  alias vi='nvim -u $HOME/.dotfiles/nvim/cpp.lua '
  alias cat='bat '
  alias ls='eza --icons=always '
  alias find='fd '
  alias cd='z '
  alias diff='difft '
end

fish_add_path $HOME/.local/bin
