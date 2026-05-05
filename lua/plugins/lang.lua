-- ~/.config/nvim/lua/plugins/lang.lua
return {
  -- LaTeX Setup
  {
    "lervag/vimtex",
    lazy = false, -- Load immediately for .tex files
    config = function()
      vim.g.vimtex_view_method = "skim" -- Change to 'zathura' or your preferred viewer
      vim.g.vimtex_compiler_latexmk = { options = { "-shell-escape" } }
    end,
  },

  -- LSP Configuration
{
    "neovim/nvim-lspconfig",
    lazy = true, -- Load lazily, we enable servers manually in ftplugin
    config = function()
      -- No setup call needed here.
      -- The plugin makes server configs available to vim.lsp.config
    end,
},

  -- Formatting (Optional but recommended)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        c = { "clang-format" },
        javascript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },
}
