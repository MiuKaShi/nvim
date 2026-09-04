-- Installation:
-- https://github.com/josephsdavid/juliacli
return {
  cmd = { "juliacli", "server" },
  settings = {
    julia = {
      usePlotPane = false,
      symbolCacheDownload = false,
      runtimeCompletions = true,
      singleFileSupport = true,
      useRevise = true,
      lint = {
        NumThreads = 6,
        missingrefs = "all",
        iter = true,
        lazy = true,
        modname = true,
      },
    },
  },
}
