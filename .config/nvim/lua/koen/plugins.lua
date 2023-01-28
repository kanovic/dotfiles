-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- installs/updates/removes plugins when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, 'packer')
if not status then
  return
end

return packer.startup(function(use)
  use('wbthomason/packer.nvim')

  -- My plugins here
  use('nvim-lua/plenary.nvim')
  use('szw/vim-maximizer')
  use('preservim/nerdtree')
  use('tpope/vim-surround')
  use('tpope/vim-repeat')
  use('numToStr/Comment.nvim')

  -- Telescope
  use({ 'nvim-telescope/telescope.nvim', tag = '0.1.1' })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  })
  
  -- Auto closing
  use('windwp/nvim-autopairs')
  use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

