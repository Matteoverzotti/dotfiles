return {
  {
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
  },
  {
    'SirVer/ultisnips',
    event = "InsertEnter",
    ft = { 'tex', 'plaintex', 'snippets' },
    cmd = { 'UltiSnipsEdit' },
    init = function()
      -- Leave Tab and Ctrl-j/k/l/h to Blink completion.
      vim.g.UltiSnipsExpandTrigger = '<Tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
      vim.g.UltiSnipsEditSplit = 'vertical'
      vim.g.UltiSnipsSnippetDirectories = { 'UltiSnips' }
      vim.g.UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = vim.fn.stdpath('config') .. '/UltiSnips'
    end,
  },
}
