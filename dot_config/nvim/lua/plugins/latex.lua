return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load vimtex
  -- tag = "v2.15", -- uncomment to pin a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
    vim.g.vimtex_quickfix_mode = 0
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('vimtex-conceal', { clear = true }),
      pattern = 'tex',
      callback = function()
        vim.wo.conceallevel = 2
      end,
    })
  end
}
