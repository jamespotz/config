eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#History setup
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST="$HISTSIZE"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell
setopt auto_cd # cd by typing directory name if it's not a command
setopt correct_all # autocorrect commands
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate #enable approximate matches for completion

# Git Completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

function set_win_title(){
    echo -ne "\033]0; 🚀 $USER:$PWD \007"
}
precmd_functions+=(set_win_title)


# Autojump
eval "$(zoxide init zsh)"

export PS1="%B%~ %b$ "

export PATH="$HOME/.cargo/bin:$PATH"

LS_COLORS="dircolors"

# Increase node js memory
# export NODE_OPTIONS="--max-old-space-size=4096"

# Add Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

# ZSH history corruption fix
function fix_zsh_history() {
  echo "Fixing corrupt .zsh_history file..."
  mv ~/.zsh_history ~/.zsh_history_bad
  strings ~/.zsh_history_bad > ~/.zsh_history
  fc -R ~/.zsh_history
  rm ~/.zsh_history_bad
  echo "Done 🚀"
}

# fnm
export PATH=/home/jamespotz/.fnm:$PATH
eval "`fnm env`"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

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
alias his_fix="fix_zsh_history"

# Starship.rs 
eval "$(starship init zsh)"
