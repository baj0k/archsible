" Remap mod key
    let mapleader = " "

" Source vim configuration files
    so $XDG_CONFIG_HOME/nvim/netrw.vim
    so $XDG_CONFIG_HOME/nvim/vimplug.vim
    so $XDG_CONFIG_HOME/nvim/tabline.vim

" Basic configuration
	set encoding=utf-8
	set number relativenumber
	set viminfo="NONE"
	syntax on

" Whitespace options
    set tabstop=4      
    set softtabstop=4 
    set shiftwidth=4 
    set expandtab   
    set autoindent
    set copyindent 

" Autocompletion
	set wildmode=longest,list,full

" Window split & navigation
	set splitbelow splitright
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Tab navigation
    map <Tab> gt
    map <S-Tab> gT

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
