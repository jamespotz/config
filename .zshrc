autoload -Uz compinit

source ~/.zsh_plugins.sh

# Keychain 
/usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519
source $HOME/.keychain/$HOST-sh

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

function set_win_title(){
    echo -ne "\033]0; 🚀 $USER:$PWD \007"
}
precmd_functions+=(set_win_title)

# ZSH history corruption fix
function fix_zsh_history() {
  echo "Fixing corrupt .zsh_history file..."
  mv ~/.zsh_history ~/.zsh_history_bad
  strings ~/.zsh_history_bad > ~/.zsh_history
  fc -R ~/.zsh_history
  rm ~/.zsh_history_bad
  echo "Done 🚀"
}

# Autojump
eval "$(zoxide init zsh)"

LS_COLORS="dircolors"

# wfxr/forgit ctrl-d to drop the selected stash but do not quit fzf (gss specific).
FORGIT_STASH_FZF_OPTS='
--bind="ctrl-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"
'

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

if command -v lazygit &> /dev/null; then
  alias lg="lazygit"
fi

if command -v gitui &> /dev/null; then
  alias gu="gitui"
fi


if command -v fdfind &>/dev/null; then
  alias fd="fdfind"
fi

alias myip="curl http://ipecho.net/plain; echo"
alias config="nvim $HOME/.zshrc"
alias reload="source $HOME/.zshrc"
alias his_fix="fix_zsh_history"
# alias neovide="neovide.exe --wsl --multigrid --nofork &"
alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

# Starship.rs 
eval "$(starship init zsh)"

# fnm
eval "$(fnm env --use-on-cd)"
