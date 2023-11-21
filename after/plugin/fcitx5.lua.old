local api = vim.api
local fn = vim.fn

if fn.executable "fcitx5-remote" ~= 1 then return end

--- switch fcitx5 to English input
local function fcitx5_en()
  local input_status = tonumber(fn.system "fcitx5-remote")
  if input_status == 2 then fn.system("fcitx5-remote" .. " -c") end
end

function is_surrounded_by_not_english()
  local row, col = unpack(api.nvim_win_get_cursor(0))
  local line = api.nvim_buf_get_lines(0, row - 1, row, false)[1]
  local prev_char, next_char
  prev_char = line:sub(col, col)
  next_char = line:sub(col + 1, col + 1)
  if col == 0 then prev_char = " " end
  if col >= #line then next_char = " " end
  if prev_char:match "[%w%p%s%#%%]" and next_char:match "[%w%p%s%#%%]" then
    return false
  else
    return true
  end
end

-- local function code_comment()
--   local cursor = api.nvim_win_get_cursor(0)
--   local parser = require("nvim-treesitter.parsers").get_parser()
--   if parser == nil then return false end
--   local tree = parser:parse()[1]:root()
--   local node = tree:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
--   local type = node:type()
--   return type == "comment" or type == "line_comment" or type == "block_comment"
-- end

--- switch fcitx5 to Non-Latin input
local function fcitx5_smart()
  local surrounded_by_not_english = is_surrounded_by_not_english()
  -- local in_comment = code_comment()
  -- If in_comment and surrounded_by_not_english then fn.system("fcitx5-remote" .. " -o") end

  if not vim.g.rime_enabled and surrounded_by_not_english then fn.system("fcitx5-remote" .. " -o") end
end

local fcitx5 = api.nvim_create_augroup("fcitx5", { clear = true })

api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = fcitx5,
  callback = function()
    if fn.reg_executing() == "" then fcitx5_smart() end
  end,
})
api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  group = fcitx5,
  callback = function()
    if fn.reg_executing() == "" then fcitx5_en() end
  end,
})
