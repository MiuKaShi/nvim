local status_ok, aerial = pcall(require, 'aerial')
if not status_ok then
    return
end

aerial.setup {
    min_width = 30,
    -- backends = {"lsp", "treesitter", "markdown"}
    backends = { 'treesitter', 'markdown' },
    filter_kind = false,
    nerd_font = 'auto',
    update_events = 'TextChanged,InsertLeave',
    on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>o', function()
            require('aerial').toggle()
        end, { buffer = bufnr, desc = 'Toggle aerial window' })
    end,
    show_guides = true,
}
