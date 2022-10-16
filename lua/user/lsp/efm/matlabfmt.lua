return {
    lintCommand = '/usr/bin/mlint -severity',
    lintStdin = false,
    lintStderr = true,
    lintIgnoreExitCode = true,
    lintFormats = { 'L %l (C %c): ML%t: %m', 'L %l (C %c-%*[0-9]): ML%t: %m' },
    lintCategoryMap = { -- Severities
        ['0'] = 'I',
        ['1'] = 'W',
        ['2'] = 'W',
        ['3'] = 'E',
    },
}
