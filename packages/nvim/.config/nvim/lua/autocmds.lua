if vim.env.TMUX then
  vim.api.nvim_create_autocmd({ 'VimEnter', 'VimResume' }, {
    callback = function() vim.fn.system('tmux set status off') end,
  })
  vim.api.nvim_create_autocmd({ 'VimLeave', 'VimSuspend' }, {
    callback = function() vim.fn.system('tmux set status on') end,
  })
end

vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require('oil').open()
      end)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
