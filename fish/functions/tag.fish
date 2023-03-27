function tag
    ctags -R $(git ls-files)
end
