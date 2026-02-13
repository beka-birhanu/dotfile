# Neovim config

Neovim config under `nvim/`. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) with last minute loading (plugins load on `cmd`/`keys`/`ft`/`event` when needed).

## Structure

- **Entry**: `init.lua` sets `Vim = vim`, then requires (in order):
  - `romareo.plugins.utils.launch` — defines `LAZY_PLUGIN_SPEC` and `Spec(item)` (appends `{ import = item }` to the spec).
  - `romareo.core.options` — global `vim.opt`.
  - `romareo.core.keymaps` — leader, window nav, resize, save/quit, etc.
  - `romareo.plugins.autohelpers.autocmds` — BufWinEnter, VimResized, FileType (spell/wrap for gitcommit/markdown), CursorHold (luasnip), Go keymaps.
- **Plugin registration**: `init.lua` calls `Spec("romareo.plugins....")` for each plugin. No plugin code runs yet; only spec paths are collected.
- **Bootstrap**: `require("romareo.plugins.utils.lazy")` ensures lazy.nvim is on `rtp`, then `require("lazy").setup({ spec = LAZY_PLUGIN_SPEC, ... })`. Lazy loads each module via `import`; each returns a spec table (`event`/`cmd`/`keys`/`ft`) and optional `config()`.

**Directory layout:**

- `lua/romareo/core/` — options.lua, keymaps.lua
- `lua/romareo/plugins/utils/` — launch.lua (Spec + LAZY_PLUGIN_SPEC), lazy.lua (lazy.nvim setup)
- `lua/romareo/plugins/ui/` — colorscheme, devicons, lualine, navic, dashboard, markdown, csv, breadcrumbs, illuminate; icons.lua (shared icon table, no spec)
- `lua/romareo/plugins/autohelpers/` — treesitter, lspconfig, cmp, mason, autoclose, comment, oil, ufo, lint, conform, luasnip, dap; lspsettings, autocmds
- `lua/romareo/plugins/movement/` — which-key, nvimtree, fterm, telescope, harpoon
- `lua/romareo/plugins/cph/`, `git/`, `ai/` — cph (competitest), gitsigns, fugitive, lazygit, supermaven

## Keybindings

**Leader / general**

| Key         | Action                   |
| ----------- | ------------------------ |
| `<Space>`   | Leader                   |
| `<leader>q` | Quit (confirm)           |
| `<leader>v` | Vertical split           |
| `<leader>b` | Horizontal split         |
| `<leader>f` | Maximize/equalize window |
| `<leader>w` | Save                     |
| `<leader>u` | Redo                     |

**Core (no plugin)**

| Key                                        | Action                    |
| ------------------------------------------ | ------------------------- |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>`            | Window left/down/up/right |
| `<C-Up>` `<C-Down>` `<C-Left>` `<C-Right>` | Resize window             |
| `<s-h>` `<s-l>`                            | Line start / line end     |
| `<C-a>`                                    | Select all                |
| `<M-d>` `<BS>` (n/v)                       | Delete without yank       |
| `jk` (insert)                              | Exit insert               |
| `<` `>` (visual)                           | Indent left/right         |
| `p` (visual)                               | Paste without yank        |
| `J` `K` (visual block)                     | Move block down/up        |

**Explorer / files**

| Key         | Action                 |
| ----------- | ---------------------- |
| `<leader>e` | NvimTree toggle        |
| `-`         | Oil (parent directory) |

**Telescope**

| Key          | Action       |
| ------------ | ------------ |
| `<leader>bb` | Buffers      |
| `<leader>tb` | Git branches |
| `<leader>tc` | Colorscheme  |
| `<leader>tf` | Find files   |
| `<leader>th` | Help tags    |
| `<leader>tp` | Projects     |
| `<leader>tt` | Live grep    |

**Harpoon / terminal**

| Key         | Action              |
| ----------- | ------------------- |
| `<leader>m` | Mark file (Harpoon) |
| `<Tab>`     | Harpoon quick menu  |
| `<A-f>`     | FTerm toggle (n/t)  |

**Comment**

| Key         | Action               |
| ----------- | -------------------- |
| `<leader>/` | Toggle comment (n/v) |

**LSP (buffer, on attach)**

| Key        | Action                                   |
| ---------- | ---------------------------------------- |
| `gD`       | Declaration                              |
| `gd`       | Definition                               |
| `gsd`      | Definition (vsplit)                      |
| `K`        | Hover                                    |
| `gi` `gsi` | Implementation / implementation (vsplit) |
| `gr`       | References                               |
| `gl`       | Diagnostic float                         |

**LSP (leader)**

| Key                       | Action               |
| ------------------------- | -------------------- |
| `<leader>la`              | Code action          |
| `<leader>li`              | LspInfo              |
| `<leader>lj` `<leader>lk` | Next/prev diagnostic |
| `<leader>lr`              | Rename               |

**Folds (UFO)**

| Key       | Action                         |
| --------- | ------------------------------ |
| `zR` `zM` | Open/close all folds           |
| `zr` `zm` | Open/close folds by level      |
| `K`       | Peek folded lines or LSP hover |

**Git**

| Key           | Action                |
| ------------- | --------------------- |
| `<leader>ghs` | Stage hunk (Gitsigns) |
| `<leader>ghp` | Preview hunk          |
| `<leader>gl`  | LazyGit               |

**DAP**

| Key          | Action                    |
| ------------ | ------------------------- |
| `<Leader>dc` | Continue                  |
| `<Leader>do` | Step over                 |
| `<Leader>di` | Step into                 |
| `<Leader>da` | Step out                  |
| `<Leader>db` | Toggle breakpoint         |
| `<Leader>dp` | Log point / preview (n/v) |
| `<Leader>dr` | REPL                      |
| `<Leader>dl` | Run last                  |
| `<Leader>dh` | Hover (n/v)               |
| `<Leader>df` | Frames                    |
| `<Leader>ds` | Scopes                    |

**CPH (competitest)**

| Key          | Action          |
| ------------ | --------------- |
| `<leader>cc` | Receive contest |
| `<leader>cp` | Receive problem |
| `<leader>cr` | Run             |
