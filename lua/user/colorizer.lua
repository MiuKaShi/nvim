local cmp_status_ok, color = pcall(require, 'colorizer')
if not cmp_status_ok then
    return
end

color.setup()
