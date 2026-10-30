-- The plugin's bundled highlight/fold/indent queries live under its own
-- `runtime/` subdir (new in the main-branch rewrite) rather than the plugin
-- root, so they aren't found via runtimepath by default; without this,
-- `queries/<lang>/highlights.scm` resolves to Neovim's own bundled query,
-- which targets an older grammar than the parsers this plugin installs and
-- silently produces zero highlight matches.
local config_path = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/config.lua', false)[1]
if config_path then
  local plugin_root = vim.fn.fnamemodify(config_path, ':h:h:h')
  vim.opt.runtimepath:prepend(plugin_root .. '/runtime')
end

require('nvim-treesitter').setup()

-- `nvim-treesitter.configs`/`highlight.enable` was removed in the main-branch
-- rewrite; highlighting is now enabled per-buffer via `vim.treesitter.start()`.
-- pcall so filetypes without an installed parser don't error.
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
