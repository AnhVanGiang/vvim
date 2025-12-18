return {
  'nvim-java/nvim-java',
  config = function()
    -- Ensure Java 21+ is in PATH for Spring Boot Tools
    local java_home = '/opt/homebrew/opt/openjdk@21'
    vim.env.JAVA_HOME = java_home
    vim.env.PATH = java_home .. '/bin:' .. vim.env.PATH

    require('java').setup({
      jdk = {
        -- Let nvim-java manage JDK installation (downloads JDK 25 for JDTLS 1.54.0)
        auto_install = true,
      },
      spring_boot_tools = {
        enable = false,
      },
    })
    vim.lsp.enable('jdtls')

    -- Set up LSP keymaps for Java files
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('JavaLspConfig', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= 'jdtls' then
          return
        end

        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = 'Go to references' }))
        vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Go to type definition' }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover documentation' }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
      end,
    })
  end,
}
