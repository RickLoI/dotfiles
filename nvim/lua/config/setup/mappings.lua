local function map(modes, keys, cmd, opts)
    opts = opts or { remap = false, silent = true }
    vim.keymap.set(modes, keys, cmd, opts)
end

map('n', '<leader><leader>', vim.cmd.Ex)
map('v', 'J', [[:m '>+1<CR>gv=gv]])
map('v', 'K', [[:m '<-2<CR>gv=gv]])
map('v', '<leader>y', [["+y]])
map('v', '<leader>Y', [["+Y]])
map({ 'n', 'v' }, '<leader>d', [["_d]])

--- Plugins
-- Trouble
map('n', '<leader>tt', ':Trouble diagnostics toggle<CR>')
map('n', '<leader>[t', ':Trouble diagnostics next<CR>')
map('n', '<leader>]t', ':Trouble diagnostics prev<CR>')

-- Undotree
map({ 'n', 'v' }, '<leader>u', vim.cmd.UndotreeToggle)

-- Telescope
map('n', '<leader>lg', function()
    require('telescope.builtin').live_grep({})
end)


map('n', '<leader>ff', function()
    local builtin = require('telescope.builtin')
    builtin.find_files({ hidden = true })
end)

-- LSPs
map('n', '<leader>s',[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {})
