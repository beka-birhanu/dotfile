# Neovim Key Mappings Documentation

# CORE maps
## General Mappings

- `<Space>`: Set as leader key (disabled as normal key)
- `<leader>e`: Open file explorer (`:Lex 20`)
- `<leader>u`: Redo (`<C-r>`)
- `<leader>w`: Save (`:w`)
- `<leader>q`: Quit (`:q`)
- `<C-a>`: Select all (`ggVG`)
- `<leader>d`: Delete without copying (`"_d`)

## Navigation

### Window Navigation
- `<C-h>`: Move to left window
- `<C-j>`: Move to bottom window
- `<C-k>`: Move to top window
- `<C-l>`: Move to right window

### Cursor Movement
- `<s-h>`: Move to beginning of line
- `<s-l>`: Move to end of line

## Window Resizing
- `<C-Up>`: Increase window height
- `<C-Down>`: Decrease window height
- `<C-Left>`: Decrease window width
- `<C-Right>`: Increase window width

## Insert Mode
- `jk`: Exit insert mode quickly

## Visual Mode
- `< <gv>`: Indent left
- `> >gv>`: Indent right
- `p`: Paste without yanking

## Visual Block Mode
- `J`: Move block down
- `K`: Move block up


# PLUGIN maps
## **General Mappings**
| Key | Action |
|------|--------|
| `<leader>/` | Toggle comment (normal & visual mode) |
| `<leader>e` | Open NvimTree Explorer |
| `<leader>m` | Mark file for Harpoon |
| `<TAB>` | Toggle Harpoon quick menu |
| `<A-f>` | Open/Close Floating Terminal |

---

## **LSP Key Mappings**
| Key | Action |
|------|--------|
| `<leader>la` | Code Action |
| `<leader>lh` | Toggle LSP Inlay Hints |
| `<leader>li` | LSP Info |
| `<leader>lj` | Go to next diagnostic |
| `<leader>lk` | Go to previous diagnostic |
| `<leader>ll` | Run CodeLens Action |
| `<leader>lq` | Set diagnostics to loclist |
| `<leader>lr` | Rename Symbol |

#### **LSP Buffer Mappings (Set on Attach)**
| Key | Action |
|------|--------|
| `gD` | Go to declaration |
| `gd` | Go to definition (split view) |
| `K` | Hover Documentation |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `gl` | Show diagnostics float |
| `gpd` | Preview definition |
| `gpr` | Preview references |
| `gpi` | Preview implementation |
| `gpc` | Close all preview windows |

---

## **Formatting & Navigation**
| Key | Action |
|------|--------|
| `<leader>lf` | Format file/range |
| `-` | Open parent directory (Oil plugin) |
| `zR` | Open all folds (UFO plugin) |
| `zM` | Close all folds |
| `zr` | Open folds except kinds |
| `zm` | Close folds with level |

---

## **Neoscroll Key Mappings**
| Key | Action |
|------|--------|
| `<C-u>` | Scroll up (slow) |
| `<C-d>` | Scroll down (slow) |
| `<C-k>` | Scroll up a page |
| `<C-j>` | Scroll down a page |
| `<C-y>` | Scroll slightly up |
| `<C-e>` | Scroll slightly down |

---

## **Telescope Key Mappings**
| Key | Action |
|------|--------|
| `<leader>fb` | Checkout Git branches |
| `<leader>fc` | Change colorscheme |
| `<leader>ff` | Find files |
| `<leader>fh` | Find help tags |
| `<leader>fl` | Resume last search |
| `<leader>fp` | Open projects |
| `<leader>ft` | Live grep search |

---

## **Surround Plugin Mappings**
| Action | Command |
|------|--------|
| Surround words | `ysiw)` → `(surround_words)` |
| Make strings | `ys$"` → `"make strings"` |
| Delete surrounding | `ds]` → `delete around me!` |
| Remove HTML tags | `dst` → `remove HTML tags` |
| Change quotes | `cs'"` → `"change quotes"` |
| Delete function calls | `dsf` → `function calls` |
