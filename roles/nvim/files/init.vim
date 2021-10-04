" Neovim conf file

let mapleader = " "

" Install missing plugins on startup
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Plugins
    call plug#begin()
    Plug 'ncm2/ncm2'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'jiangmiao/auto-pairs'
    Plug 'alec-gibson/nvim-tetris'
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    "
    Plug 'godlygeek/tabular'
    Plug 'elzr/vim-json'
    Plug 'plasticboy/vim-markdown'
    call plug#end()

" Basic configuration
	set encoding=utf-8
	set number relativenumber
	set viminfo="NONE"
	syntax on

" Spaces & Tabs {{{
    set tabstop=4      
    set softtabstop=4 
    set shiftwidth=4 
    set expandtab   
    set autoindent
    set copyindent 

" Autocompletion
	set wildmode=longest,list,full

" Window split
	set splitbelow splitright
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Shellcheck
    function AskForInput(x)
        redraw
        execute ":!clear && shellcheck -a --enable=all -s "a:x "-C'never' %"
    endfunction

    noremap <leader>s :call AskForInput(input(""))<cr>

" Spell-Checking
    map <leader>l :setlocal spell!<CR>

" Snippets plugin keybindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Run xrdb after .Xresources are updated
autocmd BufWritePost *Xresources !xrdb %
