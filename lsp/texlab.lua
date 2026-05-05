-- ~/.config/nvim/lsp/texlab.lua
return {
  name = "texlab",
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".git", ".latexmkrc", ".texlabrc", "texlab.toml" },
  settings = {
    texlab = {
      build = { executable = "latexmk" },
      forwardSearch = {
        executable = "skim", -- Or "zathura", "okular", etc.
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
    },
  },
}
