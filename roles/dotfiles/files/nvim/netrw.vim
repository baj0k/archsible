" Netrw options
let g:netrw_keepdir = 0
let g:netrw_hide = 1
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_localcopydircmd = '/usr/bin/cp -r'
let g:netrw_browse_split = 3

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
  nmap <buffer> <C-n> %:w<CR>:buffer #<CR>
  nmap <buffer> a R
  nmap <buffer> pp mtmc
  nmap <buffer> dpp mtmm
endfunction
