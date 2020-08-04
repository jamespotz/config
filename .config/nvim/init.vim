" =======================================================================
"                                                                       "
"   _   _                 _              ____             __ _	       	"
"  | \ | | ___  _____   _(_)_ __ ___    / ___|___  _ __  / _(_) __ _   	"
"  |  \| |/ _ \/ _ \ \ / / | '_ ` _ \  | |   / _ \| '_ \| |_| |/ _` |	  "
"  | |\  |  __/ (_) \ V /| | | | | | | | |__| (_) | | | |  _| | (_| |	  "
"  |_| \_|\___|\___/ \_/ |_|_| |_| |_|  \____\___/|_| |_|_| |_|\__, |	  "
"                                                              |___/ 	  "
"                                                                       "   
" =======================================================================

" ## Plugins
source $HOME/.config/nvim/config/vim-plug.vim

" ## General Settings
source $HOME/.config/nvim/config/general.vim

" ## Mappings
source $HOME/.config/nvim/config/mappings.vim

" ## Plugins Config
source $HOME/.config/nvim/config/plugin-config.vim

" ## Functions
source $HOME/.config/nvim/config/functions.vim

" ## Colorizer
luafile $HOME/.config/nvim/config/colorizer.lua


" ## Themes
syntax on
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
colorscheme gruvbox
"hi Comment gui=italic cterm=italic term=italic


" ## auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC nested source %
