local set = vim.opt
set.tags = { '.tags', '.git/tags', '.gemtags' }
-- Spelling because I can't learn to spell
vim.cmd('iab thier their')
vim.cmd('iab recieve receive')
vim.cmd('iab reciept receipt')
vim.cmd('abbr jursidiction jurisdiction')
set.showmatch = true
set.ignorecase = true
set.smartcase = true
set.cursorline = true
set.cmdheight = 2
set.switchbuf="useopen"
set.numberwidth=5
set.showtabline=2
set.winwidth=79
set.scrolloff=3
set.backup=true
local backupdirs = {
	vim.fn.expand('~/.vim-tmp'),
	vim.fn.expand('~/.tmp'),
	vim.fn.expand('~/tmp'),
	vim.fn.expand('/var/tmp'),
	vim.fn.expand('/tmp')
}
set.backupdir=backupdirs
set.directory=backupdirs
set.wildmode={'longest', 'list'}
set.undodir={ vim.fn.expand('~/.vim/undo') }
set.ttimeoutlen=100
set.modeline=true
set.modelines=3
set.wildignore={ 'tmp/*' }
set.splitbelow=true
set.splitright=true
vim.cmd([[
  let g:rails_projections = {
    \   "app/views/**/*.json.jbuilder": { "test": "spec/views/{}/{}.json.jbuilder_spec.rb" },
    \   "app/views/**/*.erb": { "test": "spec/views/{}/{}.erb_spec.rb" },
    \   "app/**/*.rb": { "test": "spec/{}/{}_spec.rb" }
    \ }
]])
vim.keymap.set('n','<leader>.', ':A<cr>', { desc = 'Alternate File'})
vim.keymap.set('n','<leader><leader>', '<c-^>', { desc = 'Alternate File'})
vim.keymap.set('c','%%', '<C-R>=expand(%:h).\'/\'<cr>', { desc = 'Current Directory'})
vim.keymap.set('n','<leader>e', ':edit %%', { desc = 'Current Directory'})
vim.keymap.set('n','<leader>v', ':view %%', { desc = 'Current Directory'})
vim.keymap.set('n', '<cr>', ':nohlsearch<cr>', { desc = 'Kill current Highlights' })
vim.keymap.set('n', '<leader>t', ':Rails<cr>', { desc = 'Run current [t]est file' })
vim.keymap.set('n', '<leader>T', ':.Rails<cr>', { desc = 'Run current [T]est file at line #' })
vim.keymap.set('n', '<leader>gc', ":lua require('telescope.builtin').find_files({ cwd='app/controllers' })<cr>", { desc = '[G]oto [C]ontrollers' })
vim.keymap.set('n', '<leader>gf', ":lua require('telescope.builtin').find_files({ cwd='spec/factories' })<cr>", { desc = '[G]oto [F]actories' })
vim.keymap.set('n', '<leader>gh', ":lua require('telescope.builtin').find_files({ cwd='app/helpers' })<cr>", { desc = '[G]oto [H]helpers' })
vim.keymap.set('n', '<leader>gl', ":lua require('telescope.builtin').find_files({ cwd='lib' })<cr>", { desc = '[G]oto [L]ib' })
vim.keymap.set('n', '<leader>gm', ":lua require('telescope.builtin').find_files({ cwd='app/models' })<cr>", { desc = '[G]oto [M]odels' })
vim.keymap.set('n', '<leader>gs', ":lua require('telescope.builtin').find_files({ cwd='app/services' })<cr>", { desc = '[G]oto [S]ervice' })
vim.keymap.set('n', '<leader>gv', ":lua require('telescope.builtin').find_files({ cwd='app/views' })<cr>", { desc = '[G]oto [V]iews' })
vim.keymap.set('v', '<leader>u', 'c<C-R>=trim(system(\'ruby -e "require \\"securerandom\\"; puts SecureRandom.uuid"\'))<cr><esc>', { desc = '[U]uid' })
vim.keymap.set('v', '<leader>U', 'c<C-R>=trim(system(\'ruby -e "require \\"securerandom\\"; puts SecureRandom.uuid.tr(\\"-\\", \\"\\")"\'))<cr><esc>', { desc = '[U]uid' })
-- when opening a file, go to the last cursor line
vim.opt.grepprg=[[git grep -n $*]]
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'x', false)
        end
      end,
    })
  end,
})
vim.api.nvim_create_user_command('Test', function()
  package.loaded.Refactor = nil
  require('Refactor').promote_to_let()
end, {})
return {
  'tpope/vim-bundler',
  'tpope/vim-fugitive',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-abolish',
  'tpope/vim-dispatch',
  'vim-ruby/vim-ruby',
  'carakan/new-railscasts-theme',
  'jpo/vim-railscasts-theme',
  {
    'tpope/vim-projectionist',
    config = function()
      local config = {
        ["app/views/**/*.json.jbuilder"] = { alternate = "spec/views/{}/{}.json.jbuilder_spec.rb" },
        ["spec/views/**/*.json.jbuilder_spec.rb"] = { alternate = "app/views/{}/{}.json.jbuilder", dispatch = "rspec {file}" },
        ["app/views/**/*.erb"] = { alternate = "spec/views/{}/{}.erb_spec.rb" },
        ["spec/views/**/*.erb_spec.rb"] = { alternate = "app/views/{}/{}.erb", dispatch = "rspec {file}" },
        ["app/**/*.rb"] = { alternate = "spec/{}/{}_spec.rb" },
        ["spec/**/*_spec.rb"] = { alternate = "app/{}/{}.rb", dispatch = "rspec {file}" },
      }
      if vim.g.projectionist_heuristics then
        vim.tbl_extend("force", vim.g.projectionist_heuristics, config)
      else
        vim.g.projectionist_heuristics = config
      end
    end
  },
  -- {
  --   'RRethy/nvim-treesitter-endwise',
  --   config = function()
  --     require('nvim-treesitter.configs').setup {
  --       endwise = {
  --         enable = true,
  --       },
  --     }
  --   end
  -- },
  {
    "klen/nvim-test",
    config = function()
      require('nvim-test').setup {}
    end
  },
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
        enabled = true,
        input = {
          relative = 'win'
        }
      }
    end
  },
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'deep',
        transparent = true,
        term_colors = true,
        toggle_style_key = '<leader>ts',
      }
      require('onedark').load()
      vim.cmd("hi DashboardHeader guifg=#41a7fc")
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup{}
    end
  },
  {
    dir = "~/.config/nvim/lua/custom/cmp_jira",
    name = "cmp_jira",
    dependencies = {
        'hrsh7th/nvim-cmp',
    }
  },
}
--    autocmd BufRead * autocmd FileType <buffer> ++once
--      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
