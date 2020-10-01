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
runtime config/nord.vim

" ## Themes
colorscheme nord


" ## auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC nested source %
