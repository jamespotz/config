inoremap <C-c> <esc>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>b :Vex<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" move at the very end of line
nnoremap $ $l

" Indent Lines wihtout going back to Normal Mode
vnoremap < <gv
vnoremap > >gv

" Helpful delete/change into blackhole buffer
nmap <leader>d "_d
nmap <leader>c "_c
nmap <space>d "_d
nmap <space>c "_c

" Find and Replace
nnoremap R :%s/\<<C-r><C-w>\>//gc<Left><Left><Left><C-r><C-w>

" Remove highlight
nnoremap <leader>, :nohlsearch<CR><CR>
