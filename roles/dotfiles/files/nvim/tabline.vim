" Load custom tabline
set tabline=%!MyTabLine()

" Define tab labels
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    
    " Select highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " Set tab name using MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    " Set modified buffer indicator
    let m = 0
    let buflist = tabpagebuflist(i + 1)
    for b in buflist
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    if m > 0
      let s .= '+ '
    endif
  endfor

  " Fill tabline
  let s .= '%#TabLineFill#%'
  return s
endfunction

" Choose tab name
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1]) 
  return fnamemodify(label, ":t") 
endfunction
