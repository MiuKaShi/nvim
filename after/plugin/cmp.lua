local cmp_kinds = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

local source_names = {
    buffer     = { '[Buf]', 'String' },
    nvim_lsp   = { '[LSP]', 'Question' },
    path       = { '[Path]', 'WarningMsg' },
    cmdline    = { '[Cmd]', 'CmpItemMenu' },
    luasnip    = { '[Snip]', 'CmpItemMenu' },
    -- neorg    = { '[Org]', 'CmpItemMenu' },
    cmp_matlab = { '[MATLAB]', 'CmpItemMenu' },
    rg         = { '[RG]', 'CmpItemMenu' },
}

local cmp = require 'cmp'

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local tab_complete = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local s_tab_complete = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif has_words_before() then
        cmp.complete()
    else
        fallback()
    end
end

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-d>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<C-y>']     = cmp.mapping.confirm { select = true },
    }),
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind]

            local nm = source_names[entry.source.name]
            if nm then
                vim_item.menu = nm[1]
                vim_item.menu_hl_group = nm[2]
                vim_item.kind_hl_group = nm[2]
            else
                vim_item.menu = entry.source.name
            end

            local maxwidth = 50
            if #vim_item.abbr > maxwidth then
                vim_item.abbr = vim_item.abbr:sub(1, maxwidth) .. '...'
            end
            return vim_item
        end
    },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
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
        { name = 'luasnip', priority = 80 },
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
        { name = 'rg', keyword_length = 3, max_item_count = 10, priority = 1 },
        { name = 'cmp_matlab' },
        -- { name = 'cmp_tabnine' },
        -- {name = 'cmp_octave'}
    },
}

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})
-- End of setup for nvim-cmp.
