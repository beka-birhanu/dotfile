Vim.opt.backup = false -- creates a backup file
Vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
Vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
Vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
Vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
-- vim.opt.fileencoding = "utf-8"        -- the encoding written to a file
Vim.opt.hlsearch = true -- highlight all matches on previous search pattern
Vim.opt.ignorecase = true -- ignore case in search patterns
Vim.opt.mouse = "a" -- allow the mouse to be used in neovim
Vim.opt.pumheight = 10 -- pop up menu height
Vim.opt.pumblend = 10
Vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
Vim.opt.showtabline = 1 -- always show tabs
Vim.opt.smartcase = true -- smart case
Vim.opt.smartindent = true -- make indenting smarter again
Vim.opt.splitbelow = true -- force all horizontal splits to go below current window
Vim.opt.splitright = true -- force all vertical splits to go to the right of current window
Vim.opt.swapfile = false -- creates a swapfile
Vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
Vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
Vim.opt.undofile = true -- enable persistent undo
Vim.opt.updatetime = 100 -- faster completion (4000ms default)
Vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
Vim.opt.expandtab = true -- convert tabs to spaces
Vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
Vim.opt.tabstop = 2 -- insert 2 spaces for a tab
Vim.opt.cursorline = true -- highlight the current line
Vim.opt.number = true -- set numbered lines
Vim.opt.laststatus = 3 -- set the value of the last window's status line
Vim.opt.showcmd = false -- don't show command in the last line of the screen
Vim.opt.ruler = false -- disable the ruler in the last line of the screen
Vim.opt.relativenumber = true -- set relative numbered lines
Vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
Vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
Vim.opt.wrap = false -- display lines as one long line
Vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
Vim.opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor
Vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
Vim.opt.title = false -- disable title
-- colorcolumn = "80",
-- colorcolumn = "120",
Vim.opt.fillchars = Vim.opt.fillchars + "eob: " -- configure fill characters for different parts of UI
Vim.opt.fillchars:append({
	stl = " ", -- character to use at the start of a status line
})

Vim.opt.shortmess:append("c") -- append "c" to 'shortmess' option

Vim.cmd("set whichwrap+=<,>,[,],h,l") -- set characters that allow moving to the previous/next line in the specified direction
Vim.cmd([[set iskeyword+=-]]) -- add '-' to 'iskeyword' option

Vim.g.netrw_banner = 0 -- disable netrw banner
Vim.g.netrw_mouse = 2 -- enable netrw mouse
Vim.opt.conceallevel = 2 -- enable conceal
