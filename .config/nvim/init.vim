"
" ▄▄▄██▀▀▀ ▄▄▄       ███▄ ▄███▓▓█████   ██████  ██▓███   ▒█████  ▄▄▄█████▓▒███████▒
"   ▒██   ▒████▄    ▓██▒▀█▀ ██▒▓█   ▀ ▒██    ▒ ▓██░  ██▒▒██▒  ██▒▓  ██▒ ▓▒▒ ▒ ▒ ▄▀░
"   ░██   ▒██  ▀█▄  ▓██    ▓██░▒███   ░ ▓██▄   ▓██░ ██▓▒▒██░  ██▒▒ ▓██░ ▒░░ ▒ ▄▀▒░ 
"▓██▄██▓  ░██▄▄▄▄██ ▒██    ▒██ ▒▓█  ▄   ▒   ██▒▒██▄█▓▒ ▒▒██   ██░░ ▓██▓ ░   ▄▀▒   ░
" ▓███▒    ▓█   ▓██▒▒██▒   ░██▒░▒████▒▒██████▒▒▒██▒ ░  ░░ ████▓▒░  ▒██▒ ░ ▒███████▒
" ▒▓▒▒░    ▒▒   ▓▒█░░ ▒░   ░  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░▒▓▒░ ░  ░░ ▒░▒░▒░   ▒ ░░   ░▒▒ ▓░▒░▒
" ▒ ░▒░     ▒   ▒▒ ░░  ░      ░ ░ ░  ░░ ░▒  ░ ░░▒ ░       ░ ▒ ▒░     ░    ░░▒ ▒ ░ ▒
" ░ ░ ░     ░   ▒   ░      ░      ░   ░  ░  ░  ░░       ░ ░ ░ ▒    ░      ░ ░ ░ ░ ░
" ░   ░         ░  ░       ░      ░  ░      ░               ░ ░             ░ ░    
"                                                                         ░        

" ## General Settings
runtime config/general.vim

" ## Plugins
runtime config/vim-plug.vim

" ## Mappings
runtime config/mappings.vim

" ## Custom Functions
runtime config/functions.vim

" ## Colorizer
luafile $HOME/.config/nvim/config/colorizer.lua

" ## Theme Config
runtime config/gruvbox.vim

" ## Themes
colorscheme gruvbox


" ## auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC nested source %
