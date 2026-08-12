local opt = vim.o
local g = vim.g

--- Generic
opt.autochdir = true
opt.clipboard = 'unnamed'
opt.colorcolumn = '80'

--- Line numbers
opt.number = true
opt.relativenumber = true 

--- Tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

--- Backup / Swap file
opt.swapfile = false
opt.backup = false

--- Undodir
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

--- Search
opt.hlsearch = false
opt.incsearch = true

--- number of lines always visible
opt.scrolloff = 8

--- Sets signcolumn visibility.
opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

--- Sets buffer update time.
opt.updatetime = 50

---- Global variables
g.undotree_WindowLayout = 4
g.netrw_sort_by = 'exten'

--- Filetype behaivor
vim.filetype.add({
    extension = {
        tex = 'tex'
    }
})
