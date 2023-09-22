if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

fish_add_path $HOME/.local/bin

zoxide init fish | source

any-nix-shell fish --info-right | source
