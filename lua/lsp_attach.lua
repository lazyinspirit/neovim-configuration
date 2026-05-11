-- ~/.config/nvim/lua/lsp_attach.lua
-- Defines an LspAttach autocmd that binds buffer-local LSP keymaps when an
-- LSP server attaches. Loaded from init.lua.

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition,      "LSP: go to definition")
    map("n", "gD", vim.lsp.buf.declaration,     "LSP: go to declaration")
    map("n", "gr", vim.lsp.buf.references,      "LSP: list references")
    map("n", "gi", vim.lsp.buf.implementation,  "LSP: go to implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "LSP: go to type definition")

    -- Information
    map("n", "K",         vim.lsp.buf.hover,          "LSP: hover docs")
    map("i", "<C-k>",     vim.lsp.buf.signature_help, "LSP: signature help")

    -- Edits
    map("n",        "<leader>rn", vim.lsp.buf.rename,      "LSP: rename")
    map({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")

    -- Diagnostics
    map("n", "[d",         vim.diagnostic.goto_prev,  "Diagnostic: previous")
    map("n", "]d",         vim.diagnostic.goto_next,  "Diagnostic: next")
    map("n", "<leader>e",  vim.diagnostic.open_float, "Diagnostic: line float")
    map("n", "<leader>dq", vim.diagnostic.setloclist, "Diagnostic: to loclist")

    -- Format (uses conform.nvim if loaded, otherwise LSP)
    map({"n", "v"}, "<leader>f", function()
      local ok, conform = pcall(require, "conform")
      if ok then
        conform.format({ async = true, lsp_fallback = true, bufnr = bufnr })
      else
        vim.lsp.buf.format({ async = true, bufnr = bufnr })
      end
    end, "Format buffer")
  end,
})
