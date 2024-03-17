alias cb='git branch --show-current'
alias uuid="uuidgen | tr 'A-F' 'a-f'"
alias sf="source ~/.zshrc"
alias ls="exa"
alias flushdns='sudo killall -HUP mDNSResponder'
alias mac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//'"

function strp() {
 awk '
    /```/ { p=!p; next }
    p     { print }
  '
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
