" Searching
nnoremap / /\v
vnoremap / /\v
nnoremap <silent> <leader>n :noh<cr>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $
vnoremap B ^
vnoremap E $

" faster, swap : to ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Move selected lines up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" jj as ESC key
inoremap jj <Esc>


" go to different screen with ctrl JKLH
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Tab close
noremap <C-w> <Esc>:tabclose<CR>

" Quickly open/reload vim
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Delete buffer completely without messing up window layout
nnoremap <leader>q :bwipeout<CR>

" Switching tabs quickly
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <leader>w :tabclose<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Lazygit
nnoremap <silent> <leader>lg :call ToggleLazyGit()<CR>

" Lazydocker
nnoremap <silent> <leader>ld :call ToggleLazyDocker()<CR>

" Paste from system clipboard
nnoremap <leader>v "*dP

" Copy/Paste
noremap YY "+y<CR>
noremap PP "+gP<CR>
noremap XX "+x<CR>

" Open terminal
nnoremap <silent> <leader>T :call ToggleScratchTerm()<CR>

" Open YTop
nnoremap <silent> <leader>Y :call ToggleYTop()<CR>

" Alias replace all
nnoremap <leader>sr :%s//gI<Left><Left><Left>

" ConcealToggle
nnoremap <leader>cl :ConcealToggle<CR>

" Correcting bad indent while pasting
nnoremap <leader>V p=`]

" Better indenting with `<` `>`;w
vnoremap < <gv
vnoremap > >gv

" Select All
map <leader>sa ggVG$

" Visually select the characters that are wanted in the search, 
" then type // to search for the next occurrence of the selected text.
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" When you press <leader>sr you can search and replace the selected text
vnoremap <leader>sr "hy:%s/<C-r>h//gc<left><left><left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> r* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> r* "sy:let @/=@s<CR>cgn

" Clear search highlights.
nnoremap <silent> <leader><leader> :let @/=""<CR>

" Paste
inoremap <C-v> <F3><C-r>+<F3>
