local M = {}

function M.setup()
    local status_ok, cmp = pcall(require, 'cmp')
    if status_ok then
        -- copilot
        require('copilot_cmp').setup {}

        local check_backspace = function()
            local col = vim.fn.col '.' - 1
            return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
        end
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
        end
        local cmp_kinds = {
            Array = ' ',
            Boolean = ' ',
            Class = ' ',
            Color = ' ',
            Constant = ' ',
            Constructor = ' ',
            Copilot = ' ',
            Enum = ' ',
            EnumMember = ' ',
            Event = ' ',
            Field = ' ',
            File = ' ',
            Folder = ' ',
            Function = ' ',
            Interface = ' ',
            Key = ' ',
            Keyword = ' ',
            Method = ' ',
            Module = ' ',
            Namespace = ' ',
            Null = ' ',
            Number = ' ',
            Object = ' ',
            Operator = ' ',
            Package = ' ',
            Property = ' ',
            Reference = ' ',
            Snippet = ' ',
            String = ' ',
            Struct = ' ',
            Text = '',
            TypeParameter = ' ',
            Unit = ' ',
            Value = ' ',
            Variable = ' ',
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
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            mapping = {
                ['<CR>'] = cmp.config.disable,
                ['<C-y>'] = cmp.mapping.confirm { select = true },
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete {}, { 'i', 'c' }),
                ['<C-e>'] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
                ['<C-h>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        for i = 1, 10 do
                            cmp.mapping.select_prev_item()(nil)
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-l>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        for i = 1, 10 do
                            cmp.mapping.select_next_item()(nil)
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
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
                        buffer = '[Text]',
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
            -- don't sort double underscore things first
            sorting = {
                comparators = {
                    cmp.config.compare.sort_text,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            duplicates = {
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            },
            window = {
                completion = {
                    side_padding = 1,
                    scrollbar = false,
                    border = border_thin,
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                },
                documentation = {
                    border = border_thin,
                },
            },
            matching = { disallow_prefix_unmatching = true },
            sources = {
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
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
                { name = 'path', priority = 700, max_item_count = 4 },
                -- { name = 'neorg' },
                -- { name = 'cmp_tabnine' },
                -- {name = 'cmp_octave'}
            },
        }
        cmp.setup.filetype({ 'markdown.pandoc', 'tex' }, {
            sources = cmp.config.sources {
                { name = 'buffer', keyword_length = 3, priority = 1000 },
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
            },
        })

        cmp.setup.filetype({ 'julia', 'matlab', 'python' }, {
            sources = cmp.config.sources {
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
                { name = 'copilot', priority = 800, max_item_count = 3 },
                { name = 'buffer', keyword_length = 3, priority = 700 },
                { name = 'path', priority = 600, max_item_count = 4 },
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
