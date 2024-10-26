function align
  sed "s/$argv[1]/:$argv[1]/g" |
  column -t -s: |
  sed "s/ $argv[1]/$argv[1]/g" |
  bat -S --file-name a.csv
end
