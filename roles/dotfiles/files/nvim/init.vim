let mapleader = " "

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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

" Basic configuration
	set encoding=utf-8
	set number relativenumber
	set viminfo="NONE"
	syntax on

" Spaces & Tabs
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

"" Custom shortcuts:
" Clear search highlight
    noremap <leader>/ :let @/ = ""<CR>

" Open multiple files in new tabs
    command! -nargs=+ -complete=dir Tabnew argadd <args> | tab all

" Shellcheck - use capital S to specify a shell
    nnoremap <leader>s :!shellcheck -a --enable=all %:p -C'never' <CR>

    function AskForInput(x)
        redraw
        execute ":!clear && shellcheck -a --enable=all -s "a:x "-C'never' %"
    endfunction

    noremap <leader>S :call AskForInput(input(""))<CR>

" Execute currently opened file
    nnoremap <leader>./ :!"%:p" <CR>

" Spell-Checking
    map <leader>l :setlocal spell!<CR>

" Netrw shortcuts
    nnoremap <leader>e :Lexplore %:p:h<CR>
    nnoremap <leader>E :Lexplore<CR>
    
" Netrw custom keymappings wrapper
    function! NetrwMapping()
    endfunction

    augroup netrw_mapping
      autocmd!
      autocmd filetype netrw call NetrwMapping()
    augroup END

    function! NetrwMapping()
      nmap <buffer> h -^
      nmap <buffer> l <CR>
      nmap <buffer> . gh
      nmap <buffer> P <C-w>z
      nmap <buffer> <leader>e :quit<CR>
      nmap <buffer> <Tab> mf
      nmap <buffer> <C-n> %:w<CR>:buffer #<CR>
      nmap <buffer> a R
      nmap <buffer> pp mtmc
      nmap <buffer> dpp mtmm
    endfunction

" Netrw (file manager) options
    let g:netrw_keepdir = 0
    let g:netrw_hide = 1
    let g:netrw_winsize = 20
    let g:netrw_banner = 0
    let g:netrw_localcopydircmd = '/usr/bin/cp -r'
    let g:netrw_browse_split = 3

" Snippets plugin keybindings
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-l>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" Disable conceal features
    let g:tex_conceal = ""
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_math = 1

" Support front matter of various format
    let g:vim_markdown_frontmatter = 1  " for YAML format
    let g:vim_markdown_toml_frontmatter = 1  " for TOML format
    let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Run xrdb after .Xresources are updated
    autocmd BufWritePost *Xresources !xrdb %
