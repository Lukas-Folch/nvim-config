local jdtls = require "jdtls"
local nv = require "nvchad.configs.lspconfig"

local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" })
if not root then
  return
end

local ws = vim.fn.stdpath "cache" .. "/jdtls/" .. vim.fn.fnamemodify(root, ":t")

jdtls.start_or_attach {
  cmd = { vim.fn.stdpath "data" .. "/mason/bin/jdtls", "-data", ws },
  root_dir = root,
  capabilities = nv.capabilities,
  on_attach = function(client, bufnr)
    nv.on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>oi", jdtls.organize_imports, { buffer = bufnr, desc = "Organize imports" })
  end,
  settings = {
    java = {
      format = { enabled = true }, -- no "settings" block, so the built-in Eclipse profile is used
    },
  },
}
