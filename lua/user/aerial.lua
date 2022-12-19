local status_ok, aerial = pcall(require, 'aerial')
if not status_ok then
    return
end

aerial.setup {
    backends = { 'lsp', 'markdown' },
    nerd_font = 'auto',
    filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
    },
    update_events = 'TextChanged,InsertLeave',
    show_guides = true,
    layout = {
        min_width = 30,
    },
}
