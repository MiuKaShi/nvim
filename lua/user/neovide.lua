vim.g.gui_font_default_size = 16
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = 'MonoLisa Custom'
vim.g.neovide_font_subpixel_antialiasing = 1
vim.g.neovide_remember_window_size = true

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_position_animation_length = 0.15
vim.g.neovide_transparency = 0.65
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_no_idle = true
vim.g.neovide_confirm_quit = false
vim.g.neovide_background_color = '#16161e' .. math.floor(255 * vim.g.neovide_transparency)
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = false
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_scroll_animation_length = 0.3

vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_trail_size = 0.2
vim.g.neovide_cursor_vfx_mode = 'ripple'
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 8.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5
vim.g.neovide_cursor_animation_length = 0.03
vim.opt.winblend = 10
vim.opt.pumblend = 10

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
vim.keymap.set({ 'n', 'i' }, '<M-v>', 'p') --alt+v paste
vim.keymap.set({ 'n', 'i' }, '<M-c>', 'y') --alt+c copy