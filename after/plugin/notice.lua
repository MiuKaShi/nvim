require("noice").setup {
  cmdline = {
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
    icons = {
      [":"] = { icon = "|> ", hl_group = "red", firstc = false },
    },
  },
  routes = {
    {
      view = "split",
      filter = { event = "msg_show", min_height = 20 },
    },
    {
      filter = { event = "msg_show", find = "level" },
      opts = { skip = true },
    },
    {
      filter = { event = 'msg_show', kind = 'search_count' },
      opts = { skip = true },
    },
    -- FIX: wierd message
    {
      filter = { event = "msg_show", find = "<$" },
      opts = { skip = true },
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 13,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
}
