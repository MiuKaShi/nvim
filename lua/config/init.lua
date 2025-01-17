local M = {}

local colors = {
  darkgray = "#282828",
  gray = "#a89984",
  innerbg = nil,
  outerbg = "#282828",
  normal = "#458588",
  insert = "#689d6a",
  visual = "#d79921",
  replace = "#cc241d",
  command = "#ebdbb2",
}

local options = {
  -- icons used by other plugins
  icons = {
    kinds = {
      File = "󰈙",
      Module = "󰏗", -- " "
      Namespace = "󰌗",
      Snippet = "",
      Package = "󰆦",
      Class = "", -- 󰌗 󰠱
      Method = "󰆧",
      Property = "󰜢", --  
      Keyword = "󰌋",
      Field = "", --󰜢" 
      Constructor = "",
      Enum = "󰕘", -- ""
      Interface = "", --  󰕘
      Function = "󰊕",
      Variable = "󰀫",
      Constant = "󰏿",
      String = "󰉾",
      Number = "󰎠",
      Boolean = "",
      Array = "",
      Object = "󰅩",
      Key = "󰌋",
      Null = "󰟢", -- 󰢤
      EnumMember = "",
      Struct = "󰙅", -- "󰌗 "
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰊄",
      Text = "󰉿",
      Unit = "󰑭",
      Value = "󰎠",
      Color = "󰏘",
      Reference = "󰈇",
      Folder = "󰉋",
      MarkdownH1 = "󰉫",
      MarkdownH2 = "󰉬",
      MarkdownH3 = "󰉭",
      MarkdownH4 = "󰉮",
      MarkdownH5 = "󰉯",
      MarkdownH6 = "󰉰",
      Call = "󰃷",
      BreakStatement = "󰙧",
      CaseStatement = "󱃙",
      ContinueStatement = "→",
      Copilot = "",
      Declaration = "󰙠",
      Delete = "󰩺",
      DoStatement = "󰑖",
      ForStatement = "󰑖",
      Identifier = "󰀫",
      IfStatement = "󰇉",
      List = "󰅪",
      Log = "󰦪",
      Lsp = "",
      Macro = "󰁌",
      Regex = "",
      Repeat = "󰑖",
      Scope = "󰅩",
      Specifier = "󰦪",
      Statement = "󰅩",
      SwitchStatement = "󰺟",
      Terminal = "",
      Type = "",
      WhileStatement = "󰑖",
    },
    diagnostics = {
      BoldError = "",
      Error = "",
      BoldWarning = "",
      Warning = "",
      BoldInformation = "",
      Information = "",
      BoldQuestion = "",
      Question = "",
      BoldHint = "󰛨",
      Hint = "󰛩",
      Debug = "",
      Trace = "✎",
    },
    git = {
      branch = " ",
      added = " ",
      modified = " ",
      removed = " ",
    },
  },
  -- exclude from indent lines
  ft_exclude = {
    "aerial",
    "chatgpt",
    "checkhealth",
    "conf",
    "crunner",
    "dashboard",
    "dap-repl",
    "help",
    "lazy",
    "lspinfo",
    "man",
    "markdown",
    "mason",
    "neo-tree",
    "norg",
    "notify",
    "qf",
    "query",
  },
  themes = {
    lualine = {
      inactive = {
        a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      visual = {
        a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      replace = {
        a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      normal = {
        a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      insert = {
        a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
      command = {
        a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
        b = { fg = colors.gray, bg = colors.outerbg },
        c = { fg = colors.gray, bg = colors.innerbg },
      },
    },
  },
}

setmetatable(M, {
  __index = function(_, key) return options[key] end,
})

return M
