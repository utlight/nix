vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
-- vim.o.inccommand = 'split'
vim.o.scrolloff = 10
vim.o.cursorline = true
vim.o.confirm = true

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'i', 'c' }, 'jk', '<Esc>')
vim.keymap.set({ 'i', 'c' }, 'kj', '<Esc>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- vim.keymap.set('n', 's', require('substitute').operator)
-- vim.keymap.set('n', 'ss', require('substitute').line)
-- vim.keymap.set('x', 's', require('substitute').visual)

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

require('guess-indent').setup {}
require('which-key').setup {
  spec = {
    { '<leader>s', group = '[S]earch' },
  },
}

require('mini.pairs').setup {}
-- require('mini.ai').setup {}
require('mini.splitjoin').setup {}

-- require('substitute').setup {}
-- require('mini.surround').setup {}
require('tiny-inline-diagnostic').setup {}

do
  local telescope = require 'telescope'
  local builtin = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  local actions = require 'telescope.actions'

  telescope.setup {
    extension = {
      ['ui-select'] = themes.get_dropdown(),
    },
    defaults = {
      mappings = {
        i = {
          ['jj'] = actions.close,
        },
      },
    },
    pickers = {
      marks = {
        attach_mappings = function(_, map)
          map('n', 'dd', actions.delete_mark)
          return true
        end,
      },
    },
  }
  telescope.load_extension 'fzf'
  telescope.load_extension 'ui-select'

  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = '~/.config/nix' }
  end, { desc = '[S]earch [N]ix files' })
end

do
  local conform = require 'conform'
  conform.setup {
    notify_on_error = true,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'alejandra' },
    },
  }

  vim.keymap.set('n', '<leader>f', function()
    conform.format {
      async = true,
      lsp_format = 'fallback',
    }
  end, { desc = '[F]ormat buffer' })
end

do
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
      local builtin = require 'telescope.builtin'
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('grd', builtin.lsp_definitions, '[G]oto [D]efinition')
      map('grr', builtin.lsp_references, '[G]oto [R]eferences')
      map('gri', builtin.lsp_implementations, '[G]oto [I]mplementation')
      map('grs', builtin.lsp_document_symbols, '[G]oto Document [S]ymbols')
      map('grS', builtin.lsp_dynamic_workspace_symbols, '[G]oto Workspace [S]ymbols')
      map('grt', builtin.lsp_type_definitions, '[G]oto [T]ype')

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end,
  })

  require('luasnip.loaders.from_vscode').lazy_load()
  require('lazydev').setup {
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    },
  }

  require('blink.cmp').setup {
    keymap = { preset = 'default' },
    appearance = { nerd_font_variant = 'mono' },
    snippets = { preset = 'luasnip' },
    signatures = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  }

  vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
        runtime = { version = 'LuaJIT' },
        workspace = { library = { vim.env.VIMRUNTIME } },
      },
    },
  })

  vim.lsp.enable 'lua_ls'
  vim.lsp.enable 'nixd'

  vim.diagnostic.config {
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = {
      text = vim.tbl_map(function()
        return ''
      end, vim.diagnostic.severity),
    },
    virtual_text = false,
  }
end
