local UtsuroNoArashis = vim.api.nvim_create_augroup('UtsuroNoArashi', {})
local autocmd = vim.api.nvim_create_autocmd

local map = vim.keymap.set

--- Add mappings for LSP provided commands
autocmd('LspAttach', {
    group = UtsuroNoArashis,
    callback = function(e)
        local opts = { buffer = e.buf }
        map('n', 'gd', function()
            vim.lsp.buf.definition()
        end, opts)

        map('n', 'K', function()
            vim.lsp.buf.hover()
        end, opts)

        map('n', '<leader>vrr', function()
            vim.lsp.buf.references()
        end, opts)

        map({ 'n', 'v' }, '<leader>f', function()
            vim.lsp.buf.format()
        end, opts)
    end
})

--- For a CSV file: check the number of lines and if under a trashold enable the Csv View
autocmd('FileType', {
    group = UtsuroNoArashis,
    pattern = 'csv',
    callback = function(args)
        --- Enable CSV view
        local lines = vim.api.nvim_buf_line_count(args.buf)
        local delay = lines <= 75000 and 2500 or 7500

        if lines > 300000 then
            vim.notify(
                'Disabling CSV view. File too large.',
                vim.log.levels.INFO
            )
            return
        end

        vim.defer_fn(function()
            vim.cmd('CsvViewEnable')
        end, delay)
    end
})

--- On colorscheme change: update highlighting groups
autocmd({ 'ColorScheme', 'BufEnter' }, {
    group = UtsuroNoArashis,
    callback = function()
        if vim.g.colors_name ~= 'haligan' then
            vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
            vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')
            vim.cmd('hi EndOfBuffer guibg=NONE ctermbg=NONE')
        end
    end
})

--- NOTE: most likely will remove
--- Filter colorscheme per filetype
-- autocmd('BufEnter', {
--     group = UtsuroNoArashis,
--     callback = function(e)
--         local buff = e.buf
--         local ft = vim.bo[buff].filetype
--         local colorscheme_set = 'haligan'
--
--         --- Update when some are found
--         local lookup = {
--             ['catppuccin']       = {},
--             ['rose-pine-moon']   = {},
--             ['tokyonight-storm'] = {}
--         }
--
--
--         for colorscheme, langs in pairs(lookup) do
--             if vim.tbl_contains(langs, ft) then
--                 colorscheme_set = colorscheme
--             end
--         end
--
--         vim.cmd.colorscheme(colorscheme_set)
--         require('lualine').setup({})
--     end
-- })

--- When in a (La)TeX file:
--- 1. Enable a couple of mappings (compilation and docs)
--- 2. Change a few options
autocmd('FileType', {
    group = UtsuroNoArashis,
    pattern = { 'latex', 'tex' },
    callback = function(e)
        local opts = { buffer = e.buf }

        map({ 'n', 'v' }, '<leader>lc', function()
            vim.cmd('LspTexlabBuild')
        end, opts)

        map('n', '<leader>ld', function()
            vim.ui.input({ prompt = 'What package are you looking for?' }, function(input)
                if input == nil then
                    return
                end

                local ok = pcall(vim.fn.system, 'command -v latex')
                if ok then
                    vim.fn.system('texdoc ' .. input)
                end
            end)
        end, opts)

        vim.cmd(':set colorcolumn=100')
        vim.cmd(':set conceallevel=2')
    end
})


--- Once a (La)TeX project is built: run TexlabClean.
autocmd('LspRequest', {
    group = UtsuroNoArashis,
    pattern = { '*.tex', '*.latex' },
    callback = function(args)
        local buf = args.buf
        local request = args.data.request

        if not request or request.method ~= 'textDocument/build' then
            return
        end

        if request.type == 'complete' then
            vim.api.nvim_buf_call(buf, function()
                vim.cmd('LspTexlabCleanAuxiliary')
            end)
        end
    end
})

--- Treesitter functionalities
autocmd('FileType', {
    pattern = '<filetype>',
    callback = function()
        vim.treesitter.start()
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})
