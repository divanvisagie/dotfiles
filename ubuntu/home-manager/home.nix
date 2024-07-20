{ config, pkgs, ... }:

{
  home.username = "divan";
  home.homeDirectory = "/home/divan";

  home.stateVersion = "24.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.autoconf
    pkgs.autogen
    pkgs.bat # rust replacement for less
    pkgs.bash-completion
    pkgs.bottom # rust replacement for top
    pkgs.bun
    pkgs.cmake
    pkgs.cowsay
    pkgs.ddgr
    pkgs.direnv
    pkgs.dust
    pkgs.eza
    pkgs.fastfetch
    pkgs.fd # rust replacement for find
    pkgs.fortune
    pkgs.gh
    pkgs.gitui
    pkgs.gnome-extensions-cli
    pkgs.go
    pkgs.gum
    pkgs.hurl
    pkgs.hyperfine # benchmarking tool
    pkgs.lldb
    pkgs.lolcat
    pkgs.meslo-lgs-nf
    pkgs.neovim
    pkgs.nix-search-cli
    pkgs.nodejs_20
    pkgs.nyancat
    pkgs.procs # better version of ps
    pkgs.protonvpn-gui
    pkgs.protonmail-bridge
    pkgs.protonmail-bridge-gui
    pkgs.qemu
    pkgs.ripgrep
    pkgs.rustup
    pkgs.starship # The starship prompt
    pkgs.tldr # simplified man pages
    pkgs.tmux
    pkgs.tokei # find out what programming languages are in use in this directory
    pkgs.tree
    pkgs.vim
    pkgs.volta
    pkgs.yazi # rust terminal file browser
    pkgs.zig
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable Bash completion
  programs.bash.enableCompletion = true;

  # Enable Starship prompt
  programs.starship = {
    enable = true;
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
 
}
