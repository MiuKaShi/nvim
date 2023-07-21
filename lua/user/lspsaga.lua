local M = {}

function M.setup()
    require('lspsaga').setup {
        symbol_in_winbar = {
            enable = false,
        },
        lightbulb = {
            enable = false,
        },
        ui = {
            theme = 'round',
            winblend = 0,
            title = false,
            border = 'single',
            expand = '',
            collapse = '',
            colors = {
                normal_bg = 'none',
                title_bg = 'none',
                red = '#ea6962',
                magenta = '#98869a',
                orange = '#e78a4e',
                yellow = '#d8a657',
                green = '#a9b665',
                cyan = '#89b482',
                blue = '#7daea3',
                purple = '#d3869b',
                white = '#d1d4cf',
                black = '#1e2030',
            },
        },
        scroll_preview = {
            scroll_down = '<C-9>',
            scroll_up = '<C-0>',
        },
    }
end

return M
