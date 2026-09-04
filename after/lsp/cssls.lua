return {
  cmd = { "vscode-css-language-server", "--stdio" },
  flags = { debounce_text_changes = 150 },
  settings = {
    css = {
      colorDecorators = { enable = true }, -- color inlay hints
      lint = {
        compatibleVendorPrefixes = "ignore",
        vendorPrefix = "ignore",
        unknownVendorSpecificProperties = "ignore",
        unknownProperties = "ignore", -- duplicate with stylelint
        duplicateProperties = "warning",
        emptyRules = "warning",
        importStatement = "warning",
        zeroUnits = "warning",
        fontFaceProperties = "warning",
        hexColorLength = "warning",
        argumentsInColorFunction = "warning",
        unknownAtRules = "warning",
        ieHack = "warning",
        propertyIgnoredDueToDisplay = "warning",
      },
    },
  },
}
