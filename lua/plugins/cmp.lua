return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    config = function()
      local ls = require 'luasnip'
      local types = require 'luasnip.util.types'
      ls.setup {
        updateevents = 'TextChanged,TextChangedI',
        history = true,
        delete_check_events = 'TextChanged',
        enable_autosnippets = true,
        store_selection_keys = '`',
        ext_opts = {
          [types.choiceNode] = { active = { virt_text = { { '↺', 'markdownBold' } } } },
        },
      }
      -- snippets
      require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/LuaSnip' }

      vim.keymap.set({ 'i', 's' }, '<C-j>', function()
        if ls.locally_jumpable(1) then
          ls.jump(1)
        end
      end, { desc = 'LuaSnip Forward Jump' })

      vim.keymap.set({ 'i', 's' }, '<C-k>', function()
        if ls.locally_jumpable(-1) then
          ls.jump(-1)
        end
      end, { desc = 'LuaSnip Backward Jump' })

      vim.keymap.set('i', '<C-e>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { desc = 'LuaSnip Next Choice' })
    end,
  },

  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'mstanciu552/cmp-matlab',
      -- 'lukas-reineke/cmp-rg',
    },
    opts = function()
      local cmp = require 'cmp'
      local cmp = require 'cmp'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'path' }, { name = 'cmdline' } },
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } },
      })
      cmp.setup.filetype({ 'markdown.pandoc', 'tex' }, {
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'buffer', keyword_length = 3, priority = 900 },
          { name = 'luasnip', priority = 800, option = { show_autosnippets = true } },
        },
      })

      cmp.setup.filetype({ 'julia', 'matlab', 'python' }, {
        sources = cmp.config.sources {
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
          { name = 'copilot', priority = 800, max_item_count = 3 },
          { name = 'buffer', keyword_length = 3, priority = 700 },
          { name = 'path', priority = 600, max_item_count = 4 },
        },
      })
      -- copilot
      require('copilot_cmp').setup {}
      local compare = require 'cmp.config.compare'
      local cmp_kinds = require('config').icons.cmp_kinds
      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end
      local border_thin = {
        { '╭', 'CmpBorder' },
        { '─', 'CmpBorder' },
        { '╮', 'CmpBorder' },
        { '│', 'CmpBorder' },
        { '╯', 'CmpBorder' },
        { '─', 'CmpBorder' },
        { '╰', 'CmpBorder' },
        { '│', 'CmpBorder' },
      }
      return {
        completion = { completeopt = 'menu,menuone,noinsert' },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<CR>'] = cmp.config.disable,
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping {
            i = function(fallback)
              if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                  cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                  if has_words_before() then
                    cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                  else
                    cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }
                  end
                end
              else
                fallback()
              end
            end,
          },
          ['<S-Tab>'] = cmp.config.disable,
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = cmp_kinds[vim_item.kind]
            vim_item.menu = ({
              buffer = '[Text]',
              copilot = '[Cop]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
              cmdline = '[Cmd]',
              luasnip = '[Snip]',
              cmp_matlab = '[MATLAB]',
              -- rg = '[RG]',
              -- neorg    = '[Norg]',
            })[entry.source.name]
            return vim_item
          end,
        },
        sorting = {
          comparators = {
            compare.sort_text,
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.length,
            compare.order,
          },
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        window = {
          completion = {
            side_padding = 1,
            scrollbar = false,
            border = border_thin,
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
          },
          documentation = {
            border = border_thin,
          },
        },
        matching = { disallow_prefix_unmatching = true },
        sources = {
          { name = 'luasnip', priority = 900, option = { show_autosnippets = true } },
          {
            name = 'buffer',
            priority = 800,
            keyword_length = 3,
            max_item_count = 5,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = 'path', priority = 700, max_item_count = 4 },
          -- { name = 'neorg' },
          -- { name = 'cmp_tabnine' },
          -- {name = 'cmp_octave'}
        },
      }
    end,
    event = { 'CmdlineEnter', 'InsertEnter' },
  },
}
