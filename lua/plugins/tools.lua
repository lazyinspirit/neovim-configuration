-- ~/.config/nvim/lua/plugins/tools.lua
return {
  -- Installer for LSPs, DAPs, and Formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "c", "python", "html", "css", "javascript", "latex", "lua" },
      highlight = { enable = true, disable = { "latex" }, },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        c = { "clang-format" },
        javascript = { "prettier" },
      },
    },
  },
}
