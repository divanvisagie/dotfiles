# ZSH setup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::yarn
zinit snippet OMZP::rust
# if on ubuntu
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    zinit snippet OMZP::ubuntu
fi
# if on mac
if [[ "$OSTYPE" == "darwin"* ]]; then
    zinit snippet OMZP::brew
fi

autoload -U compinit && compinit

ZSH_THEME="powerlevel10k/powerlevel10k"
export TERM=xterm-256color
export EDITOR='nvim'

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt sharehistory

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion colors

# Aliases
alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"
alias sf="source ~/.zshrc"
alias ls="eza --group-directories-first"
alias flushdns='sudo killall -HUP mDNSResponder'
alias mac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'"
alias gtop='git log -1 --format="%H" | cat | xargs echo -n | pbcopy'

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # if wayland
    if [ -n "$WAYLAND_DISPLAY" ]; then
        export GDK_BACKEND=wayland
        alias pbcopy='wl-copy'
    else
        alias pbcopy='xclip -selection c'
    fi
fi

# Custom functions
function strp() {
 awk '
    /```/ { p=!p; next }
    p     { print }
  '
}

function nocol() {
    sed "s,\x1B\[[0-9;]*[a-zA-Z],,g"
}

function kb() {
    for job in $(jobs -p); do kill -9 $job; done
}

function today() {
    local filename=$(date "+%Y-%m-%d").md

    if [[ -f "$filename" ]]; then
        echo "Opening existing file: $filename"
        nvim "$filename"
    else
        touch "$filename"
        echo "New markdown file created: $filename"
        nvim "$filename"
    fi
}

# Shell integrations
eval "$(direnv hook zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
