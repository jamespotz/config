autoload -Uz compinit
compinit -i
source ~/.zplug/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/git-extras",   from:oh-my-zsh
zplug "plugins/zoxide",   from:oh-my-zsh
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/colored-man-pages",   from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "wfxr/forgit"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load #--verbose

# Keychain
if command -v /usr/bin/keychain &> /dev/null; then
  /usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519
  source $HOME/.keychain/$HOST-sh
fi

#History setup
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST="$HISTSIZE"
setopt hist_ignore_space # ignore space
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

# McFly
eval "$(mcfly init zsh)"

LS_COLORS="dircolors"

# wfxr/forgit ctrl-d to drop the selected stash but do not quit fzf (gss specific).
FORGIT_STASH_FZF_OPTS='
--bind="ctrl-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"
'

# Increase node js memory
export NODE_OPTIONS="--max-old-space-size=8192"

# Alias
alias mkdir="mkdir -p"
alias weather='curl -s https://wttr.in/Asingan, Philippines'

if command -v lsd &> /dev/null; then
  alias ls="lsd"
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

if command -v neovide &>/dev/null; then
  alias nv="neovide"
fi

if command -v lazydocker &>/dev/null; then
  alias lzd="lazydocker"
fi

alias myip="curl http://ipecho.net/plain; echo"
alias config="nvim $HOME/.zshrc"
alias reload="source $HOME/.zshrc"
alias his_fix="fix_zsh_history"
alias gbda='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

# Starship.rs
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/jamespotz/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#
alias test_user_offer="docker compose build && COLLECTION=user docker compose -f docker-compose-test.yml -p goose_api_postman_runner up --abort-on-container-exit --remove-orphans && COLLECTION=offer-engine docker compose -f docker-compose-test.yml -p goose_api_postman_runner up --abort-on-container-exit --remove-orphans"

# fnm
FNM_PATH="/home/jamespotz/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/jamespotz/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Auto-Warpify
printf 'P$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "Linux" }}�' 
