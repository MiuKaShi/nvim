local g = vim.g

-- REMOTE CONTROL
-- nvim server (RPC) to remote control neovide instances
-- https://neovim.io/doc/user/remote.html
vim.defer_fn(function() vim.fn.serverstart "/tmp/nvim_server.pipe" end, 400)
--------------------------------------------------------------------------------

-- SIZE & FONT
vim.opt.guifont = "monospace:h20"

g.neovide_scale_factor = 1
g.neovide_refresh_rate = 60
local function setNeovideScaleFactor(delta) g.neovide_scale_factor = g.neovide_scale_factor + delta end

vim.keymap.set({ "n", "x", "i" }, "<A-j>", function() setNeovideScaleFactor(-0.01) end)
vim.keymap.set({ "n", "x", "i" }, "<A-k>", function() setNeovideScaleFactor(0.01) end)

--------------------------------------------------------------------------------

-- window size
g.neovide_remember_window_size = true

-- keymaps
g.neovide_input_use_logo = true -- enable `cmd` key on macOS
g.neovide_input_macos_alt_is_meta = false -- false, so {@~ etc can be used
g.neovide_hide_mouse_when_typing = true

-- Window Appearance
g.neovide_underline_automatic_scaling = true -- slightly unstable according to docs
g.neovide_scroll_animation_length = 1

-- Helper function for transparency formatting
local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end
g.neovide_transparency = 0.65
g.transparency = 0.65
g.neovide_background_color = "#0f1117" .. alpha()

---- The following should enable floating window transparency --------------------------------------
g.neovide_window_floating_blur = 0.65
g.neovide_window_floating_opacity = 0
g.neovide_floating_blur = 0.65

--------------------------------------------------------------------------------
-- CURSOR
vim.opt.guicursor = {
  "i-ci-c:ver25", -- INFO with noice.nvim, the guicursor cannot be styled in the cmdline https://github.com/folke/noice.nvim/issues/552
  "n-sm:block",
  "r-cr-o-v:hor10",
  -- "a:blinkwait200-blinkoff350-blinkon550",
}

g.neovide_cursor_animation_length = 0.01
g.neovide_cursor_trail_size = 0.9
g.neovide_cursor_unfocused_outline_width = 0.1
g.neovide_cursor_vfx_mode = "railgun" -- railgun|torpedo|pixiedust|sonicboom|ripple|wireframe

-- only railgun, torpedo, and pixiedust
g.neovide_cursor_vfx_particle_lifetime = 0.5
g.neovide_cursor_vfx_particle_density = 20.0
g.neovide_cursor_vfx_particle_speed = 40.0

-- only railgun
g.neovide_cursor_vfx_particle_phase = 1.3
g.neovide_cursor_vfx_particle_curl = 1.3
