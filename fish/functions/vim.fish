set pipepath "$HOME/nvim.pipe"

function vim
    if test -e $pipepath
        nvim --server $pipepath --remote-tab $argv
    else
        nvim --listen $pipepath
    end
end
