local M = {}

function M.setup()
    local status_ok, aerial = pcall(require, 'aerial')
    if status_ok then
        aerial.setup {
            backends = { 'lsp', 'treesitter', 'markdown', 'man' },
            filter_kind = {
                'Array',
                'Boolean',
                'Class',
                'Constant',
                'Constructor',
                'Enum',
                'EnumMember',
                'Event',
                'Field',
                'File',
                'Function',
                'Interface',
                'Key',
                'Method',
                'Module',
                'Namespace',
                'Null',
                'Number',
                'Object',
                'Operator',
                'Package',
                'Property',
                'String',
                'Struct',
                'TypeParameter',
                'Variable',
            },
            icons = {
                Array = ' ',
                Boolean = ' ',
                Class = ' ',
                Collapsed = ' ',
                Constant = ' ',
                Constructor = ' ',
                Enum = ' ',
                EnumMember = ' ',
                Event = ' ',
                Field = ' ',
                File = ' ',
                Function = ' ',
                Interface = ' ',
                Key = ' ',
                Method = ' ',
                Module = ' ',
                Namespace = ' ',
                Null = '  ',
                Number = ' ',
                Object = ' ',
                Operator = ' ',
                Package = '  ',
                Property = ' ',
                String = ' ',
                Struct = ' ',
                TypeParameter = ' ',
                Variable = ' ',
            },
            show_guides = true,
            layout = {
                min_width = 30,
            },
        }
    end
end

return M
