alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"
alias sf="source ~/.zshrc"
alias ls="exa"
alias flushdns='sudo killall -HUP mDNSResponder'
alias mac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(git history zsh-autosuggestions)

export EDITOR='nvim'

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

export TERM=xterm-256color
