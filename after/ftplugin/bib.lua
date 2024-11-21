-- `%` not actually a comment character, just convention of some programs
-- https://tex.stackexchange.com/questions/261261/are-comments-discouraged-in-a-bibtex-file
vim.bo.commentstring = "% %s"
vim.opt_local.formatoptions:append { r = true }

--------------------------------------------------------------------------------
