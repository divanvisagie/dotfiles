#!/bin/bash
set -e
# Alert user if they are running in sh, since the script only 
# is compatible with bash/zsh arrays

if [ -z "$BASH_VERSION" ] && [ -z "$ZSH_VERSION" ]; then
	echo "Please run this script in bash or zsh, you can do this by simply running ./install.sh"
	exit 1
fi

clear
# generated with toilet -f future "dotfiles"
cat << 'EOF'

╺┳┓┏━┓╺┳╸┏━╸╻╻  ┏━╸┏━┓
 ┃┃┃ ┃ ┃ ┣╸ ┃┃  ┣╸ ┗━┓
╺┻┛┗━┛ ╹ ╹  ╹┗━╸┗━╸┗━┛

-----------------------------------------
Installer for Divan's development system
-----------------------------------------

EOF

if ! [ -x "$(command -v node)" ]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	nvm install --lts
	nvm use --lts
fi

# Perform OS specific installs
OS=$(uname)
if [[ "$OS" == "Linux" ]]; then
	echo "Linux detected..."
	./ubuntu/install.sh
else
	./macos/install.sh
fi

sh ~/.dotfiles/zsh/install.sh

# Install rust if not present 
if ! [ -x "$(command -v rustc)" ]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Define the list of tools to install
tools=(
	"exa"
	"bat"
	"du-dust"
	"ripgrep"
	"cgip"
	"hurl"
	"cargo-watch"
	"gitui --locked"
	"zoxide"
	"yazi-fm --locked"
	"yazi-cli --locked"
)

# Iterate over the tools and install them if they are not already available
for tool in "${tools[@]}"; do
	if ! command -v ${tool%% *} &> /dev/null; then
		echo "${tool%% *} could not be found, installing..."
		cargo install $tool
	else
		echo "${tool%% *} is already installed."
	fi
done

# Set up working directories if they do not exist
if [ ! -d ~/Projects ]; then
	mkdir ~/Projects
fi
if [ ! -d ~/Projects/com.github ]; then
	mkdir ~/Projects/com.github
fi

# Install configs
~/.dotfiles/tmux/install.sh
~/.dotfiles/git/install.sh
~/.dotfiles/wezterm/install.sh
~/.dotfiles/vim/install.sh
~/.dotfiles/nvim/install.sh

# Install custom tools
echo "Installing dark mode switcher..."
cd ~/.dotfiles/scripts/dm
cargo install --path .
cd ~/.dotfiles

cat << 'EOF'

Installation complete!
EOF
