-- ~/.config/nvim/lsp/texlab.lua
return {
  name = "texlab",
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".git", ".latexmkrc", ".texlabrc", "texlab.toml" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdf", "-synctex=1", "-interaction=nonstopmode", "-file-line-error", "%f" },
        onSave = false,  -- Let VimTeX handle compilation
        forwardSearchAfter = false,
      },
      -- Forward search via Skim's displayline script
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = { "-revert", "%l", "%p", "%f" },
      },
      -- Disable texlab's chktex if you want (optional)
      chktex = {
        onOpenAndSave = false,
      },
    },
  },
}
