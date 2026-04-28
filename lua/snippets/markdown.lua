--https://www.reddit.com/r/neovim/comments/10s3nmn/math_zone_detection_for_luasnip/

local has_treesitter, ts = pcall(require, "vim.treesitter")
local _, query = pcall(require, "vim.treesitter")

local M = {}

local MATH_NODES = {
  displayed_equation = true,
  inline_formula = true,
}

local function get_node_at_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col - 1
  local parser = ts.get_parser(buf, "markdown")
  if not parser then return end
  local root_tree = parser:parse()[1]
  local root = root_tree and root_tree:root()
  if not root then return end
  return root:named_descendant_for_range(row, col, row, col)
end

local function is_active(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(buf) then return false end
  local ok = pcall(ts.get_parser, buf, vim.bo[buf].ft)
  return ok and true or false
end

local function in_tsnode(ntype, pos, buf, mode)
  pos = pos or vim.api.nvim_win_get_cursor(0)
  buf = buf or vim.api.nvim_get_current_buf()
  mode = mode or vim.api.nvim_get_mode().mode
  if not is_active(buf) then return false end
  local node = ts.get_node {
    bufnr = buf,
    pos = {
      pos[1] - 1,
      pos[2] - (pos[2] >= 1 and mode:match "^i" and 1 or 0),
    },
  }
  if not node then return false end
  if type(ntype) == "string" then return node:type():match(ntype) ~= nil end
  return ntype(node:type())
end

function M.in_mathzone()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1] -- 1-indexed
  local col = cursor[2]
  local total_lines = vim.api.nvim_buf_line_count(0)

  local lines = vim.api.nvim_buf_get_lines(0, 0, total_lines, false)
  local cur = lines[current_line] -- current line (1-indexed into lua table)

  -- 1. Fast inline check on current line
  local before = cur:sub(1, col)
  local after = cur:sub(col + 1)
  if before:find "%$%$[^$]*$" and after:find "^[^$]*%$%$" then return true end

  -- 2. Multiline $$ block check
  local function is_delimiter(l) return l:match "^%s*%$%$%s*$" ~= nil end

  -- Search upward for opening $$
  local open_found = false
  for i = current_line - 1, 1, -1 do
    local l = lines[i]
    if is_delimiter(l) then
      open_found = true
      break
    end
    if l:find("%$%$", 1, true) then break end -- plain search, no pattern overhead
  end

  if not open_found then return false end

  -- Search downward for closing $$
  for i = current_line + 1, total_lines do
    local l = lines[i]
    if is_delimiter(l) then return true end
    if l:find("%$%$", 1, true) then break end
  end

  return false
end

---Check if the current line is a markdown code block, using regex
---to check each line
function M.in_codeblock_regex(lnum, buf)
  buf = buf or 0
  lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(buf, 0, lnum - 1, false)
  local result = false
  for _, line in ipairs(lines) do
    if line:match "^```" then result = not result end
  end
  return result
end

---Check if the current line is a markdown code block
function M.in_codeblock(lnum, buf)
  buf = buf or 0
  lnum = lnum or vim.api.nvim_win_get_cursor(0)[1]
  if is_active(buf) then
    return in_tsnode(
      function(ntype) return ntype:match "fence" and ntype:match "code" and true or false end,
      { lnum, 0 },
      buf
    )
  end
  return M.in_codeblock_regex(lnum, buf)
end

function M.in_text(check_parent)
  local node = get_node_at_cursor()
  while node do
    if node:type() == "text_mode" then
      if check_parent then
        -- For \text{}
        local parent = node:parent()
        if parent and MATH_NODES[parent:type()] then return false end
      end

      return true
    elseif MATH_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return true
end

-- function M.in_comment()
-- 	return vim.fn["vimtex#syntax#in_comment"]() == 1
-- end
--
-- function M.in_mathzone()
-- 	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
-- end

return M
