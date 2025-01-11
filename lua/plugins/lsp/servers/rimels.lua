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
  -- local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  -- if cmp_ok then capabilities = cmp_nvim_lsp.default_capabilities(capabilities) end
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- 检查log目录
  local rime_log_dir = vim.fn.expand "~/.local/share/rime-ls/log"
  if vim.fn.isdirectory(rime_log_dir) == 0 then vim.fn.mkdir(rime_log_dir, "p") end

  require("lspconfig").rime_ls.setup {
    name = "rime_ls",
    -- cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
    filetypes = { "markdown.pandoc", "tex", "matlab", "glsl", "c", "python" },
    init_options = {
      enabled = vim.g.rime_enabled,
      shared_data_dir = vim.fn.expand "/usr/share/rime-data", -- rime 公共目录
      user_data_dir = vim.fn.expand "~/.local/share/rime-ls", -- 指定用户目录, 最好新建一个
      log_dir = rime_log_dir, -- 日志目录,必须存在文件
      trigger_characters = {}, -- 为空表示全局开启
      override_server_capabilities = { trigger_characters = {} },
      always_incomplete = false, -- [since v0.2.3] true 强制补全永远刷新整个列表，而不是使用过滤
      max_tokens = 0, -- [since v0.2.3] 大于 0 表示会在删除到这个字符个数的时候，重建所有候选词，而不使用删除字符操作
      preselect_first = true, --是否默认第一个候选项是选中状态，default false
      show_order_in_label = true, --[since v0.4.0] 在候选项的 label 中显示数字
      schema_trigger_character = "&", -- 当输入此字符串时请求补全会触发 “方案选单”
    },
    on_attach = rime_on_attach,
    capabilities = capabilities,
  }
end
return M
