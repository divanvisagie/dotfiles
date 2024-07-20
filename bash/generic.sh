#!/bin/bash
export EDITOR='nvim'
export TERM=xterm-256color

# if on ubuntu
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias wezterm='flatpak run org.wezfurlong.wezterm'
    alias marktext='flatpak run com.github.marktext.marktext'
fi

# Aliases
alias cb='git branch --show-current'
alias dfu='~/.dotfiles/install.sh' # Update dotfiles
alias ed='$EDITOR'
alias fd='fd --color never'
alias flushdns='sudo killall -HUP mDNSResponder'
alias glo='git lg'
alias gpr='git pull --rebase'
alias gtop='git log -1 --format="%H" | cat | xargs echo -n | pbcopy'
alias ls="eza --group-directories-first"
alias ne='$EDITOR ~/.dotfiles/nix/default.nix' # Edit nix environment
alias ni='nix-env -i'
alias ns='nix-search'
alias nu='~/.dotfiles/nix/install.sh' # Update nix environment
alias nv='nvim'
alias rsync='rsync --partial --info=progress2'
alias sf="source ~/.bashrc"
alias uuid="uuidgen | tr 'A-F' 'a-f'"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # if wayland
    if [ -n "$WAYLAND_DISPLAY" ]; then
        export GDK_BACKEND=wayland
        alias pbcopy='wl-copy'
    else
        alias pbcopy='xclip -selection c'
    fi
fi
####################
# Custom functions
####################
function strp() {
 awk '
    /```/ { p=!p; next }
    p     { print }
  '
}

# A shutdown system 
function down() {
   # Get the name of the primary network interface
   local interface=$(ip route | grep '^default' | awk '{print $5}')
   
   # Check if an interface is found
   if [ -z "$interface" ]; then
       echo "No network interface found. Ensure you are connected to a network."
       return 1
   fi

   # Apply the Wake-on-LAN setting
   sudo ethtool -s "$interface" wol g
   if [[ $? -ne 0 ]]; then
       echo "Failed to set Wake-on-LAN for $interface"
       return 1
   fi

   # Shutdown the system
   echo "Shutting down..."
   sudo shutdown -h now
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

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function httpserver () {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# Enable bash vi mode
set -o vi
shopt -s autocd

export CGIP_SESSION_NAME=$(date -I)
eval "$(starship init bash)"
eval "$(direnv hook bash)"
