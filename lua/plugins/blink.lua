return {

  -- auto completion
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "*",
    dependencies = {
      {
        "saghen/blink.compat",
        version = "*",
        opts = {},
      },
      "jc-doyle/cmp-pandoc-references",
      "Kaiser-Yang/blink-cmp-dictionary",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        version = "v2.*",
        opts = function()
          local types = require "luasnip.util.types"
          require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/LuaSnip" }
          return {
            updateevents = "TextChanged,TextChangedI",
            history = true,
            delete_check_events = "TextChanged",
            enable_autosnippets = true,
            store_selection_keys = "`",
            ext_opts = {
              [types.insertNode] = { active = { virt_text = { { "●", "Boolean" } } } },
              [types.choiceNode] = { active = { virt_text = { { "↺", "markdownBold" } } } },
            },
          }
        end,
        keys = {
          { "<C-l>", function() require("luasnip").jump(1) end, mode = { "i", "s" } },
          { "<C-h>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
      },
    },
    config = function()
      local has_punctuation_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%p" ~= nil
      end
      -- if last char is number, and the only completion item is provided by rime-ls, accept it
      require("blink.cmp.completion.list").show_emitter:on(function(event)
        if #event.items ~= 1 then return end
        local col = vim.fn.col "." - 1
        if event.context.line:sub(1, col):match "^.*%a+%d+$" == nil then return end
        local client = vim.lsp.get_client_by_id(event.items[1].client_id)
        if (not client) or client.name ~= "rime_ls" then return end
        require("blink.cmp").accept { index = 1 }
      end)
      -- link BlinkCmpKind to CmpItemKind since nvchad/base46 does not support it
      local set_hl = function(hl_group, opts)
        opts.default = true -- Prevents overriding existing definitions
        vim.api.nvim_set_hl(0, hl_group, opts)
      end
      for _, kind in ipairs(require("blink.cmp.types").CompletionItemKind) do
        set_hl("BlinkCmpKind" .. kind, { link = "CmpItemKind" .. kind or "BlinkCmpKind" })
      end

      require("blink.cmp").setup {
        completion = {
          list = {
            selection = { preselect = false, auto_insert = true },
            cycle = { from_top = false }, -- cycle at bottom, but not at the top
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
            window = {
              border = "single",
              max_width = 50,
              max_height = 20,
            },
          },
          menu = {
            border = "single",
            draw = {
              align_to = "none", -- keep in place
              treesitter = { "lsp" },
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "source_name" },
              },
              components = {
                kind_icon = {
                  text = function(ctx)
                    -- detect emmet-ls
                    local source = ctx.item.source_id
                    -- use source-specific icons, and `kind_icon` only for items from LSPs
                    local sourceIcons = {
                      cmdline = "󰘳",
                      buffer = "󰦨",
                      supermaven = "",
                    }
                    return sourceIcons[source] or ctx.kind_icon
                  end,
                },
                label_description = { width = { max = 20 } },
                source_name = {
                  text = function(ctx) return "[" .. ctx.source_name .. "]" end,
                },
              },
            },
          },
        },
        snippets = {
          preset = "luasnip",
        },
        signature = {
          enabled = true,
          window = { border = "single" },
        },
        keymap = {
          preset = "none",
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-u>"] = { "scroll_documentation_down", "fallback" },
          ["<C-f>"] = { "scroll_documentation_up", "fallback" },
          ["<C-c>"] = { "cancel", "fallback" },
          ["<C-x>"] = { "hide" }, -- `hide` keeps `auto_insert`, `cancel` does not
          ["<C-y>"] = { "select_and_accept" },
          ["<space>"] = {
            function(cmp)
              if not vim.g.rime_enabled then return false end
              if has_punctuation_before() then return false end
              local rime_item_index = require("util").get_n_rime_item_index(1)
              if #rime_item_index ~= 1 then return false end
              return cmp.accept { index = rime_item_index[1] }
            end,
            "fallback",
          },
          ["<Tab>"] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return cmp.select_and_accept()
              end
            end,
            "snippet_forward",
            "fallback",
          },
          ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
        },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "normal",
          kind_icons = require("config").icons.kinds,
        },
        sources = {
          default = { "lsp", "snippets", "buffer", "path" },
          per_filetype = {
            ["markdown.pandoc"] = function(ctx)
              local markdown = require "snippets.markdown"
              if markdown.in_mathzone() then
                return { "buffer", "snippets" }
              else
                return { "lsp", "buffer", "dictionary" }
              end
            end,
            ["markdown"] = function(ctx)
              local markdown = require "snippets.markdown"
              if markdown.in_mathzone() then
                return { "buffer", "snippets" }
              else
                return { "lsp", "buffer", "dictionary" }
              end
            end,
            tex = {
              "lsp",
              "path",
              "snippets",
              "buffer",
              "pandoc_references",
              "dictionary",
            },
            lua = {
              "lsp",
              "path",
              "snippets",
              "buffer",
              "supermaven",
            },
            gitcommit = {},
          },
          providers = {
            lsp = {
              fallbacks = {}, -- do not use `buffer` as fallback
              score_offset = 20, -- the higher the number, the higher the priority
              transform_items = function(_, items)
                for _, item in ipairs(items) do
                  if item.kind == require("blink.cmp.types").CompletionItemKind.Snippet then
                    item.score_offset = item.score_offset - 3
                  end
                end
                return items
              end,
            },
            snippets = {
              min_keyword_length = 1,
              score_offset = -1,
            },
            path = {
              opts = { get_cwd = vim.uv.cwd },
            },
            buffer = {
              max_items = 4,
              min_keyword_length = 4,
              score_offset = -7,
              opts = {
                -- show completions from all buffers used within the last x minutes
                get_bufnrs = function()
                  local mins = 15
                  local allOpenBuffers = vim.fn.getbufinfo { buflisted = 1, bufloaded = 1 }
                  local recentBufs = vim
                    .iter(allOpenBuffers)
                    :filter(function(buf)
                      local recentlyUsed = os.time() - buf.lastused < (60 * mins)
                      local nonSpecial = vim.bo[buf.bufnr].buftype == ""
                      return recentlyUsed and nonSpecial
                    end)
                    :map(function(buf) return buf.bufnr end)
                    :totable()
                  return recentBufs
                end,
              },
            },
            dictionary = {
              module = "blink-cmp-dictionary",
              name = "Dict",
              score_offset = 30, -- the higher the number, the higher the priority
              -- enabled = false,
              max_items = 8,
              min_keyword_length = 3,
              opts = {
                get_command = "rg",
                get_command_args = function(prefix)
                  return {
                    "--color=never",
                    "--no-line-number",
                    "--no-messages",
                    "--no-filename",
                    "--ignore-case",
                    "--",
                    prefix,
                  }
                end,
                dictionary_files = { vim.fn.expand "~/.config/nvim/mydict/words.txt" },
                -- To disable the definitions comment this
                separate_output = function(output)
                  local items = {}
                  for line in output:gmatch "[^\r\n]+" do
                    table.insert(items, {
                      label = line,
                      insert_text = line,
                      documentation = nil,
                    })
                  end
                  return items
                end,
              },
            },
            pandoc_references = {
              name = "pandoc_references",
              module = "blink.compat.source",
              score_offset = -1,
            },
            supermaven = {
              name = "supermaven",
              module = "blink.compat.source",
              score_offset = 100,
              async = true,
            },
          },
        },
      }
    end,
  },
}
