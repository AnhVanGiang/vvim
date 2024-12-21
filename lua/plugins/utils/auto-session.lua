return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'info', -- Set logging level
      auto_session_suppress_dirs = { '~/', '~/Projects' }, -- Directories to ignore
    }
  end,
}
