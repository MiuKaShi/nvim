local M = {}

function M.setup_rime()
  vim.g.rime_enabled = false
  local configs = require "lspconfig.configs"
  if not configs.rime_ls then
    configs.rime_ls = {
      default_config = {
        name = "rime_ls",
        cmd = { "rime_ls" },
        -- cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
        root_dir = function() return vim.fn.expand "~/.local/share/rime-ls" end,
        filetypes = { "*" },
        single_file_support = true,
      },
      settings = {},
      docs = {
        description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
      },
    }
  end

  local rime_on_attach = function(client, _)
    local toggle_rime = function()
      client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
        if ctx.client_id == client.id then vim.g.rime_enabled = result end
      end)
    end
    -- keymaps for executing command
    vim.keymap.set("n", "<leader><space>", function() toggle_rime() end)
    vim.keymap.set("n", "<leader>rs", function() vim.lsp.buf.execute_command { command = "rime-ls.sync-user-data" } end)
  end

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
  -- capabilities.general.positionEncodings = { "utf-8" }

  -- 检查log目录
  local rime_log_dir = vim.fn.expand "~/.local/share/rime-ls/log"
  if vim.fn.isdirectory(rime_log_dir) == 0 then vim.fn.mkdir(rime_log_dir, "p") end

  require("lspconfig").rime_ls.setup {
    name = "rime_ls",
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
    filetypes = { "markdown.pandoc", "tex", "matlab", "glsl", "c", "python", "lua" },
    init_options = {
      enabled = vim.g.rime_enabled,
      shared_data_dir = vim.fn.expand "/usr/share/rime-data", -- rime 公共目录
      user_data_dir = vim.fn.expand "~/.local/share/rime-ls", -- 指定用户目录, 最好新建一个
      log_dir = rime_log_dir, -- 日志目录,必须存在文件
      max_candidates = 9,
      paging_characters = { ",", "." },
      trigger_characters = {},
      schema_trigger_character = "&",
      max_tokens = 0,
      always_incomplete = false,
      preselect_first = false,
      show_filter_text_in_label = false,
      long_filter_text = true,
    },
    on_attach = rime_on_attach,
    capabilities = capabilities,
  }
end

return M
