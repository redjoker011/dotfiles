function rtfm
  help $argv || man $argv || $BROWSER "https://www.google.com/search?q=$argv"
end
