" Install vim-plug if not found
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Install missing plugins on startup
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins
call plug#begin()
Plug 'ncm2/ncm2'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'jiangmiao/auto-pairs'
Plug 'alec-gibson/nvim-tetris'
Plug 'ThePrimeagen/vim-be-good'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'elzr/vim-json'
call plug#end()
