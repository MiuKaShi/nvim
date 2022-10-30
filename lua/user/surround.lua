local status_ok, surround = pcall(require, 'nvim-surround')
if not status_ok then
    return
end

surround.setup {
    move_cursor = false,
    keymaps = {
        insert = '<C-g>s',
        visual = 's',
    },
    aliases = { -- aliases should match the bindings further above
        ['b'] = ')',
        ['c'] = '}',
        ['r'] = ']',
        ['q'] = '"',
        ['z'] = "'",
    },
}
