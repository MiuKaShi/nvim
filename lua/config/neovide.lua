-- DOCS https://neovide.dev/configuration.html
if not vim.g.neovide then return end

-- REMOTE CONTROL
-- nvim server (RPC) to remote control neovide instances
-- https://neovim.io/doc/user/remote.html
vim.defer_fn(function() vim.fn.serverstart "/tmp/nvim_server.pipe" end, 400)
--------------------------------------------------------------------------------

-- SIZE & FONT
vim.opt.linespace = -2 -- less line height
vim.opt.guifont = "MonoLisa Nerd Font:h20"

vim.g.neovide_scale_factor = 1
vim.g.neovide_refresh_rate = 60

local function changeScaleFactor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  local icon = delta > 0 and "" or ""
  local opts = { id = "scale_factor", icon = icon, title = "Scale factor" }
  vim.notify(tostring(vim.g.neovide_scale_factor), nil, opts)
end

vim.keymap.set({ "n", "x", "i" }, "<A-j>", function() changeScaleFactor(-0.01) end, { desc = " Zoom" })
vim.keymap.set({ "n", "x", "i" }, "<A-k>", function() changeScaleFactor(0.01) end, { desc = " Zoom" })

--------------------------------------------------------------------------------

-- keymaps
vim.g.neovide_input_use_logo = true -- enable `cmd` key on macOS
vim.g.neovide_input_macos_option_key_is_meta = "none" -- disable, so `{@~` etc. can be used

-- Window Appearance
vim.g.neovide_theme = "auto"
vim.g.neovide_underline_stroke_scale = 2.0 -- slightly unstable according to docs
vim.g.neovide_remember_window_size = true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_scroll_animation_length = 1
vim.g.neovide_position_animation_length = 0.2

-- transparency formatting
-- local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
-- vim.g.neovide_transparency = 0.65
-- vim.g.transparency = 0.65
-- vim.g.neovide_background_color = "#0f1117" .. alpha()

---- The following should enable floating window transparency --------------------------------------
vim.g.neovide_floating_shadow = false
vim.g.neovide_window_floating_blur = 0.65
vim.g.neovide_window_floating_opacity = 0

--------------------------------------------------------------------------------
-- CURSOR
vim.opt.guicursor = {
  "i-ci-c:ver25",
  "n-sm:block",
  "r-cr-o-v:hor10",
  -- "a:blinkwait200-blinkoff350-blinkon550",
}

vim.g.neovide_cursor_animation_length = 0.01
vim.g.neovide_cursor_trail_size = 0.9
vim.g.neovide_cursor_unfocused_outline_width = 0.1
vim.g.neovide_cursor_vfx_mode = "railgun" -- railgun|torpedo|pixiedust|sonicboom|ripple|wireframe
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true

-- only railgun, torpedo, and pixiedust
vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
vim.g.neovide_cursor_vfx_particle_density = 20.0
vim.g.neovide_cursor_vfx_particle_speed = 40.0

-- only railgun
vim.g.neovide_cursor_vfx_particle_phase = 1.3
vim.g.neovide_cursor_vfx_particle_curl = 1.3
