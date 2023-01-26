local M = {}

function M.setup()
    local cmp_status_ok, cmp = pcall(require, 'cmp')
    local snip_status_ok, luasnip = pcall(require, 'luasnip')
    if cmp_status_ok and snip_status_ok then
        require('copilot_cmp').setup {}
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').lazy_load { paths = { '~/.config/nvim/my_snippets' } }
        require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/my_snippets/lua/' }

        local check_backspace = function()
            local col = vim.fn.col '.' - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
        end
        local cmp_kinds = {
            Text = '',
            Method = 'm',
            Function = '',
            Constructor = '',
            Field = '',
            Variable = '',
            Class = '',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '',
            Enum = '',
            Keyword = '',
            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            EnumMember = '',
            Constant = '',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = '',
        }
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = {
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm { select = true },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand {}
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.kind = cmp_kinds[vim_item.kind]
                    vim_item.menu = ({
                        buffer = '[Buf]',
                        copilot = '[Cop]',
                        nvim_lsp = '[LSP]',
                        path = '[Path]',
                        cmdline = '[Cmd]',
                        luasnip = '[Snip]',
                        -- neorg    = '[Norg]',
                        cmp_matlab = '[MATLAB]',
                        rg = '[RG]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
            window = {
                documentation = { border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' } },
                completion = {
                    col_offset = -2,
                    side_padding = 1,
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                },
            },
            matching = { disallow_prefix_unmatching = true },
            sources = {
                { name = 'nvim_lsp', priority = 80 },
                { name = 'luasnip', priority = 80, option = { show_autosnippets = true } },
                { name = 'copilot', priority = 80, max_item_count = 3 },
                { name = 'path', priority = 40, max_item_count = 4 },
                -- { name = 'neorg' },
                {
                    name = 'buffer',
                    priority = 5,
                    keyword_length = 3,
                    max_item_count = 5,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                { name = 'rg', keyword_length = 4, max_item_count = 10, priority = 1 },
                { name = 'cmp_matlab' },
                -- { name = 'cmp_tabnine' },
                -- {name = 'cmp_octave'}
            },
        }
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'path' }, { name = 'cmdline' } },
        })
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } },
        })
    end
end

return M
