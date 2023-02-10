require('gruvbox').setup {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = 'hard', -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
}
vim.cmd [[colorscheme gruvbox]]
vim.cmd [[
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi MsgArea ctermbg=NONE guibg=NONE
hi Pmenu guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi NormalFloat guibg=NONE ctermbg=NONE
]]

if vim.g.neovide then
    vim.g.gui_font_default_size = 18
    vim.g.gui_font_size = vim.g.gui_font_default_size
    vim.g.gui_font_face = 'JetBrainsMono Nerd Font'
    vim.g.neovide_transparency = 0.75
    vim.g.neovide_background_color = '#16161e' .. math.floor(255 * vim.g.neovide_transparency)
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_scroll_animation_length = 1
    vim.g.neovide_cursor_vfx_mode = 'ripple'
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_density = 8.0
    vim.g.neovide_cursor_vfx_particle_phase = 1.5
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_hide_mouse_when_typing = false

    RefreshGuiFont = function()
        vim.opt.guifont = string.format('%s:h%s', vim.g.gui_font_face, vim.g.gui_font_size)
    end

    ResizeGuiFont = function(delta)
        vim.g.gui_font_size = vim.g.gui_font_size + delta
        RefreshGuiFont()
    end

    ResetGuiFont = function()
        vim.g.gui_font_size = vim.g.gui_font_default_size
        RefreshGuiFont()
    end

    -- Call function on startup to set default font size
    ResetGuiFont()

    -- Resize font
    local opts = { noremap = true, silent = true }
    vim.keymap.set({ 'n', 'i' }, '<M-k>', function()
        ResizeGuiFont(1)
    end, opts)
    vim.keymap.set({ 'n', 'i' }, '<M-j>', function()
        ResizeGuiFont(-1)
    end, opts)
end
