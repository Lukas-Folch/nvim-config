require("nvchad.configs.lspconfig").defaults()

-- file type declarations
vim.filetype.add {
  extension = {
    hlsl = "hlsl",
    compute = "hlsl",
  },
}
-- custom hlsl_tools server (from vscode extension)
vim.lsp.config("hlsl_tools", {
  cmd = { "/Users/lukas/.vscode/extensions/timgjones.hlsltools-1.1.303/bin/osx-x64/ShaderTools.LanguageServer" },
  filetypes = { "hlsl" },
  root_markers = { ".git" },
})

-- omnisharp config
vim.lsp.config("omnisharp", {
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
})

-- clangd config, enabling clang-tidy (linter)
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
  init_options = {
    fallbackFlags = { "-std=c17" },
  },
})

-- list of servers
local servers =
  { "html", "cssls", "pyright", "rust_analyzer", "dockerls", "ts_ls", "omnisharp", "hlsl_tools", "clangd" }

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
