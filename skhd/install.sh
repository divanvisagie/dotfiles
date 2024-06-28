
mkdir -p ~/.config/skhd

# create link if it does not exist
[ -f ~/.skhdrc ] || ln -s ~/.dotfiles/skhd/.skhdrc ~/.skhdrc
