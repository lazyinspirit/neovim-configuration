# nvim

Personal Neovim configuration for Python, Lua, C/C++, HTML/CSS/JS/TS,
Bash/Zsh, JSON, and LaTeX. Built on Neovim's native LSP client (no
`nvim-lspconfig`), `lazy.nvim` for plugin management, and Treesitter for
syntax highlighting.

**Requires Neovim 0.12+ on macOS** (Apple Silicon Homebrew at `/opt/homebrew`).

---

## Language support

| Language | Treesitter | LSP server | Linter / formatter |
|---|---|---|---|
| Python | ✓ | pyright (types) · ruff (lint) | ruff\_format |
| C / C++ | ✓ | clangd | clang-format |
| JavaScript | ✓ | ts\_ls | prettier |
| TypeScript | ✓ | ts\_ls | prettier |
| HTML | ✓ | html | prettier |
| CSS | ✓ | cssls | prettier |
| Lua | ✓ | lua\_ls | stylua |
| Bash / sh | ✓ | bashls + shellcheck | — |
| Zsh | ✓ (bash parser) | bashls (completion/hover only¹) | — |
| JSON / JSONC | ✓ | jsonls | — |
| LaTeX | VimTeX | texlab | — |
| Markdown | ✓ | — | — |

> ¹ shellcheck does not support zsh syntax; diagnostics are unavailable for
> `.zsh` files. Completion, hover, and go-to-definition still work.

---

## Features

- **Native LSP** — configured via `lsp/*.lua` + `ftplugin/*.lua` using
  `vim.lsp.config` / `vim.lsp.enable` (Neovim 0.11+ API, no wrapper plugin).
- **Treesitter** — `nvim-treesitter` main branch. Parsers install automatically
  on first launch. Zsh reuses the bash parser via a language alias.
- **Format on save** — `conform.nvim` with per-language formatters and
  buffer/global toggle commands.
- **Autocompletion** — `blink.cmp` with LSP, buffer, path, and snippet sources.
  VimTeX omnifunc wired in for LaTeX.
- **LaTeX workflow** — VimTeX + Skim with SyncTeX forward/inverse search.
- **Fuzzy finding** — Telescope for files, live grep, buffers, help, and recent
  files.
- **Git integration** — Gitsigns for hunk navigation and inline blame.

---

## Setup

### 1. Clone

```bash
git clone <repo-url> ~/.config/nvim
```

On first launch `nvim` bootstraps `lazy.nvim`, installs all plugins, and
downloads the required Treesitter parsers (allow ~30 s).

### 2. Install external tools

LSP servers and formatters are **not** auto-installed — they live outside the
config directory. Install everything below before opening files.

```bash
# Python
brew install pyright ruff

# Lua
brew install lua-language-server stylua

# C / C++ (clangd ships with Xcode Command Line Tools)
brew install clang-format

# Bash / Zsh (shellcheck provides diagnostics for .sh/.bash files)
brew install bash-language-server shellcheck

# JS / TS / HTML / CSS / JSON (requires Node)
brew install node
npm install -g typescript typescript-language-server \
               vscode-langservers-extracted \
               prettier
```

Confirm attachment with `:LspInfo` after opening a file of the relevant type.

### 3. LaTeX + Skim (optional)

1. Install MacTeX and Skim:
   ```bash
   brew install --cask mactex skim
   ```
2. Open **Skim → Settings → Sync**. Enable *Check for file changes* and
   *Reload automatically*. Set Preset to **Custom**:
   - Command: `/usr/local/bin/skim-nvr.sh`
   - Arguments: `%line "%file"`
3. Create the inverse-search helper and make it executable:
   ```bash
   sudo tee /usr/local/bin/skim-nvr.sh << 'EOF'
   #!/bin/bash
   SERVER=$(cat /tmp/vimtexserver.txt)
   /opt/homebrew/bin/nvim --server "$SERVER" --remote "$2"
   sleep 0.1
   /opt/homebrew/bin/nvim --server "$SERVER" --remote-send "${1}G"
   EOF
   sudo chmod +x /usr/local/bin/skim-nvr.sh
   ```
4. Open a `.tex` file in Neovim and compile once (`<Space>ll`) to register
   the server address.

---

## Keymaps

Leader key: `<Space>`

### LSP (active when a server is attached)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | List references |
| `gi` | Go to implementation |
| `gy` | Go to type definition |
| `K` | Hover documentation |
| `<C-k>` (insert) | Signature help |
| `<Leader>rn` | Rename symbol |
| `<Leader>ca` | Code action |
| `<Leader>f` | Format buffer |

### Diagnostics

| Key | Action |
|---|---|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<Leader>e` | Show diagnostic float |
| `<Leader>dq` | Send diagnostics to loclist |

### Telescope

| Key | Action |
|---|---|
| `<Leader>ff` | Find files |
| `<Leader>fg` | Live grep |
| `<Leader>fb` | Buffers |
| `<Leader>fh` | Help tags |
| `<Leader>fr` | Recent files |

### Git (Gitsigns)

| Key | Action |
|---|---|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<Leader>gp` | Preview hunk |
| `<Leader>gb` | Blame line |

### File tree (nvim-tree)

| Key | Action |
|---|---|
| `<Leader>tt` | Toggle tree |
| `<Leader>tf` | Reveal current file |

### LaTeX (VimTeX — `.tex` files only)

| Key | Action |
|---|---|
| `<Space>ll` | Start / stop compiler |
| `<Space>lv` | Forward search (Skim) |
| `<Space>lk` | Stop compiler |
| `<Space>le` | Open error list |

### Format toggle

| Command | Effect |
|---|---|
| `:FormatDisable` | Disable format-on-save for this buffer |
| `:FormatDisable!` | Disable format-on-save globally |
| `:FormatEnable` | Re-enable format-on-save |

---

## Plugin inventory

| Plugin | Role |
|---|---|
| `folke/lazy.nvim` | Plugin manager |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting + indentation |
| `navarasu/onedark.nvim` | Colorscheme (pure-black variant) |
| `nvim-lualine/lualine.nvim` | Status line |
| `nvim-tree/nvim-tree.lua` | File explorer |
| `nvim-telescope/telescope.nvim` | Fuzzy finder |
| `lewis6991/gitsigns.nvim` | Git hunk signs + blame |
| `saghen/blink.cmp` | Autocompletion |
| `stevearc/conform.nvim` | Format on save |
| `williamboman/mason.nvim` | LSP / tool installer UI |
| `lervag/vimtex` | LaTeX editing, compilation, SyncTeX |
