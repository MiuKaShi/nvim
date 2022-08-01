require('aerial').setup {
    default_direction = 'right',
    filter_kind = {
        'Class', 'Constant', 'Constructor', 'Enum',
        'EnumMember', 'Function', 'Interface', 'Method',
        'Module', 'Object', 'Struct', 'Variable',
    },
    highlight_on_hover = true,
    highlight_on_jump = 150,
    min_width = 25,
    nerd_font = true,
    show_guides = true,
    float = { relative = 'editor' },
}
