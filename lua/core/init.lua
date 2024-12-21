-- Include available lua files in `lua/core` directory
require("core.settings")
require("core.keymaps")
require("core.auto_commands")
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
