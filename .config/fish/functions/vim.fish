# Map vim and vi command to nvim because nvim is cool
# vim: Defaults to Neovim if exists
function vim
  if command -v nvim 2>&1 >/dev/null
    alias vim='nvim'
  end
end

vim
