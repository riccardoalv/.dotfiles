if status is-interactive
	starship init fish | source
  any-nix-shell fish --info-right | source
	zoxide init fish | source
end

fish_add_path $HOME/.local/bin
