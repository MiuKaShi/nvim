local M = {}

function M.setup()
    local cmp_status_ok, cmp = pcall(require, 'cmp')
    local snip_status_ok, luasnip = pcall(require, 'luasnip')
    if cmp_status_ok and snip_status_ok then
        -- copilot
        require('copilot_cmp').setup {}
        -- snippets
        require('luasnip.loaders.from_snipmate').lazy_load() --Snipmate like snippets

        local compare = require 'cmp.config.compare'

        local check_backspace = function()
            local col = vim.fn.col '.' - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
        end
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
        end
        local cmp_kinds = {
            Array = '󰅪',
            Boolean = '',
            Class = '󰌗',
            Color = '',
            Constant = '',
            Constructor = '',
            Enum = '',
            EnumMember = '',
            Event = '',
            Field = '',
            File = '󰈙',
            Folder = '',
            Function = '',
            Interface = '',
            Key = '󰌆',
            Keyword = '',
            Method = '',
            Module = '',
            Namespace = '󰅪',
            Null = '󰟢',
            Number = '',
            Object = '󰀚',
            Operator = '',
            Package = '󰏗',
            Property = '',
            Reference = '',
            Snippet = '',
            String = '󰀬',
            Struct = '',
            Text = '',
            TypeParameter = '󰊄',
            Unit = '',
            Value = '',
            Variable = '',
        }
        local border_thin = {
            { '╭', 'CmpBorder' },
            { '─', 'CmpBorder' },
            { '╮', 'CmpBorder' },
            { '│', 'CmpBorder' },
            { '╯', 'CmpBorder' },
            { '─', 'CmpBorder' },
            { '╰', 'CmpBorder' },
            { '│', 'CmpBorder' },
        }
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            mapping = {
                ['<CR>'] = cmp.config.disable,
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
                ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                        else
                            if has_words_before() then
                                cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                            else
                                cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }
                            end
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.config.disable,
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
                        cmp_matlab = '[MATLAB]',
                        -- neorg    = '[Norg]',
                        -- rg = '[RG]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sorting = {
                comparators = {
                    compare.sort_text,
                    compare.offset,
                    compare.exact,
                    compare.score,
                    compare.recently_used,
                    compare.kind,
                    compare.length,
                    compare.order,
                },
            },
            window = {
                documentation = {
                    border = border_thin,
                },
                completion = {
                    col_offset = -2,
                    side_padding = 1,
                    border = border_thin,
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                },
            },
            matching = { disallow_prefix_unmatching = true },
            sources = {
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
                { name = 'path', priority = 700, max_item_count = 4 },
                {
                    name = 'buffer',
                    priority = 800,
                    keyword_length = 3,
                    max_item_count = 5,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                -- { name = 'neorg' },
                -- { name = 'cmp_tabnine' },
                -- {name = 'cmp_octave'}
            },
        }
        cmp.setup.filetype({ 'markdown.pandoc', 'tex' }, {
            sources = cmp.config.sources {
                { name = 'nvim_lsp', keyword_length = 2, priority = 600 },
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
                { name = 'buffer', keyword_length = 3, priority = 1000 },
            },
        })

        cmp.setup.filetype({ 'julia', 'matlab', 'sh', 'python' }, {
            sources = cmp.config.sources {
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
                { name = 'path', priority = 700, max_item_count = 4 },
                { name = 'copilot', priority = 800, max_item_count = 3 },
                { name = 'buffer', keyword_length = 3, priority = 600 },
            },
        })

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
