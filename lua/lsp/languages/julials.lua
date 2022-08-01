-- Installation:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/63?u=mroavi
--  $ julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- Instant startup with PackageCompiler:
--  https://discourse.julialang.org/t/neovim-languageserver-jl/37286/72?u=mroavi
-- Makes use of the julia bin generated using PackageCompiler to remove startup time
local M = {}

M.setup = function(on_attach, capabilities)
    require('lspconfig').julials.setup {
        on_new_config = function(new_config, _)
            local julia = vim.fn.expand '~/.julia/environments/nvim-lspconfig/bin/julia'
            if require('lspconfig').util.path.is_file(julia) then
                new_config.cmd[1] = julia
            end
        end,
        -- This just adds dirname(fname) as a fallback (see nvim-lspconfig#1768).
        root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern 'Project.toml'(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
        end,
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- M.setup = function(on_attach, capabilities)
--     require('lspconfig').julials.setup {
--         cmd = {
--             'julia',
--             '--project=@nvim-lspconfig',
--             '-J' .. vim.fn.getenv 'HOME' .. '/.julia/environments/nvim-lspconfig/languageserver.so',
--             '--sysimage-native-code=yes',
--             '--startup-file=no',
--             '--history-file=no',
-- 			"-e",
-- 			[[
-- 		# just in case
-- 		import Pkg;
-- 		using LanguageServer
-- 		function recurse_project_paths(path::AbstractString)
-- 			isnothing(Base.current_project(path)) && return
-- 			tmp = path
-- 			CUSTOM_LOAD_PATH = []
-- 			while !isnothing(Base.current_project(tmp))
-- 					pushfirst!(CUSTOM_LOAD_PATH, tmp)
-- 					tmp = dirname(tmp)
-- 			end
-- 			# push all to LOAD_PATHs
-- 			pushfirst!(Base.LOAD_PATH, CUSTOM_LOAD_PATH...)
-- 			return joinpath(CUSTOM_LOAD_PATH[1], "Project.toml")
--     end
-- 		buffer_file_path = "]] .. vim.fn.expand("%:p:h") .. '";' .. [[
--     project_path = let 
-- 			dirname(something(
-- 				# 1. Check if there is an explicitly set project
-- 				# 2. Check for Project.toml in current working directory
-- 				# 3. Check for Project.toml from buffer's full file path exluding the file name
-- 				# 4. Fallback to global environment
-- 				Base.load_path_expand((
--                 p = get(ENV, "JULIA_PROJECT", nothing);
--                 p === nothing ? nothing : isempty(p) ? nothing : p
--         )),
-- 				Base.current_project(strip(buffer_file_path)),
-- 				Base.current_project(pwd()),
-- 				Pkg.Types.Context().env.project_file,
-- 				Base.active_project()
-- 			))
-- 		end
--     # Some projects require Pkg to activate and instantiate it
--     # Activate the project 
--     import Pkg;
-- 		# Pkg.activate(project_path);
--     # Instantiate project
--     # Pkg.instantiate();
-- 		# @info "Active project: $(Base.active_project())"
--     ls_install_path = joinpath(get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments", "nvim-lspconfig");
--     pushfirst!(LOAD_PATH, ls_install_path);
--     using LanguageServer;
--     popfirst!(LOAD_PATH);
-- 		@info "LOAD_PATHS: $(Base.load_path())"
--     depot_path = get(ENV, "JULIA_DEPOT_PATH", "");
--     symbol_server_path = joinpath(homedir(), ".cache", "nvim", "julia_lsp_symbol_store")
--     mkpath(symbol_server_path)
-- 		@info "LanguageServer has started with buffer $project_path or $(pwd())"
--     server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path, nothing, symbol_server_path, true);
--     server.runlinter = true;
--     run(server);
-- 		]],
--         },
--         settings = {
--             julia = {
--                 symbolCacheDownload = true,
--                 lint = {
--                     missingrefs = 'all',
--                     iter = true,
--                     lazy = true,
--                     modname = true,
--                 },
--             },
--         },
--         -- This just adds dirname(fname) as a fallback (see nvim-lspconfig#1768).
--         root_dir = function(fname)
--             local util = require 'lspconfig.util'
--             return util.root_pattern 'Project.toml'(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
--         end,
--         on_attach = on_attach,
--         capabilities = capabilities,
--     }
-- end
--
return M
