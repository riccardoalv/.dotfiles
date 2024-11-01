if status is-interactive
	starship init fish | source
	zoxide init fish | source

  atuin init fish --disable-up-arrow | source
end

fish_add_path $HOME/.local/bin
