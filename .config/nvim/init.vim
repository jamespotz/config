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


" ## Themes
colorscheme gruvbox


" ## auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC nested source %
