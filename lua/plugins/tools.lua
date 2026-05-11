-- ~/.config/nvim/lua/plugins/tools.lua
-- Tooling: LSP installer, formatters.
return {
  -- Installer for LSPs, DAPs, and Formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Formatting (conform.nvim). Runs on save unless `:FormatDisable` was used.
  -- `:FormatDisable` toggles buffer-local opt-out; `:FormatEnable` re-enables.
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- 5000ms because `black` cold-start on macOS can take 5+ seconds
        -- (Python interpreter + code-signing checks). prettier/stylua are
        -- much faster and won't approach this.
        return { timeout_ms = 5000, lsp_format = "fallback", quiet = true }
      end,
    },
    init = function()
      -- Buffer-local toggle commands. Global toggle: `:FormatDisable!`.
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.g.disable_autoformat = true
        else
          vim.b.disable_autoformat = true
        end
      end, { desc = "Disable autoformat (! for global)", bang = true })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat" })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope: grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope: buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope: help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",   desc = "Telescope: recent files" },
    },
    opts = {},
  },
}
