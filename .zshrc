source ~/.zsh_plugins.sh

function set_win_title(){
    echo -ne "\033]0; 🚀 $USER:$PWD \007"
}
precmd_functions+=(set_win_title)

# Autojump
eval "$(zoxide init zsh)"

LS_COLORS="dircolors"

# Increase node js memory
# export NODE_OPTIONS="--max-old-space-size=4096"

# Alias
alias mkdir="mkdir -p"

if command -v exa &> /dev/null; then
  alias ls="exa"
fi

if command -v bat &> /dev/null; then
  alias cat="bat"
fi

if command -v fdfind &>/dev/null; then
  alias fd="fdfind"
fi

alias myip="curl http://ipecho.net/plain; echo"
alias config="nvim $HOME/.zshrc"
alias reload="source $HOME/.zshrc"

# fnm
eval "$(fnm env --use-on-cd)"

# Starship.rs 
eval "$(starship init zsh)"
