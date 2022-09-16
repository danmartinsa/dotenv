local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  if vim.g.vim_version > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    -- stable
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.rust_analyzer.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities

}

lspconfig.tailwindcss.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.taplo.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.emmet_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.gopls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.rome.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.astro.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.prismals.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}

lspconfig.svelte.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities
}
return M
