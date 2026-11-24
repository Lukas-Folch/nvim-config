local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    rust = { "rustfmt" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    cs = { "csharpier" },
    hlsl = { "shader_formatter" },
    compute = { "shader_formatter" },
    cginc = { "shader_formatter" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
  formatters = {
    csharpier = {
      command = "csharpier",
      args = { "format" },
      stdin = true,
    },
    shader_formatter = {
      command = "shader-formatter",
      args = { "$FILENAME" },
      stdin = false,
    },
  },
  format_on_save = {
    timeout_ms = 5000,
    lsp_fallback = true,
  },
}

return options
