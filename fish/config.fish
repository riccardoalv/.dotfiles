if status is-interactive
	starship init fish | source
	zoxide init fish | source
end

fish_add_path $HOME/.local/bin
