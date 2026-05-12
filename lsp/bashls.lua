-- bash-language-server: covers sh, bash, and zsh (no dedicated zsh parser exists).
-- Install: brew install bash-language-server
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
  root_markers = { ".git" },
  settings = {
    bashIde = { globPattern = "*@(.sh|.inc|.bash|.command|.zsh)" },
  },
}
