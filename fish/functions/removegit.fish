function removegit
    find . -iname '.git' -exec rm -rf {} \;; find . -iname '.gitignore' -exec rm -rf {} \;; find . -iname '.github' -exec rm -rf {} \;
end
