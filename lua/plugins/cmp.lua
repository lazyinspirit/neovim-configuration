-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "enter" }, -- 'enter' to accept completion
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
}
