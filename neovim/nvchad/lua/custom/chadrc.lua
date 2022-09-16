local M = {}

M.ui = {
  theme = "gruvbox"
}

M.plugins = {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    -- config = function()
    --   require("custom.plugins.null-ls").setup()
    -- end,
    config = function()
      require("null-ls").setup({
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.clang_format,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.rustfmt,
        require("null-ls").builtins.formatting.prettierd.with {
          filetypes = { "html", "json", "markdown", "scss", "css", "typescript" },
        },
        require("null-ls").builtins.diagnostics.eslint.with {
          command = "eslint_d",
        },
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  },
  ["windwp/nvim-ts-autotag"] = {
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  ["folke/trouble.nvim"] = {
    cmd = "TroubleToggle",
  },
  ["karb94/neoscroll.nvim"] = {
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,        -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,              -- Function to run after the scrolling animation ends
      })
    end
  },
  ["rcarriga/nvim-notify"] = {},
  ["oberblastmeister/neuron.nvim"] = {},
  ["tpope/vim-repeat"] = {},
  ["tpope/vim-surround"] = {

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, 
    -- see https://github.com/tpope/vim-surround/issues/117
    --
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  ["itchyny/vim-cursorword"] = {
    event = {"BufEnter", "BufNewFile"},
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },


}
return M
