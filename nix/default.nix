{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-environment";
  paths = [
    pkgs.autoconf
    pkgs.autogen
    pkgs.bat
    pkgs.bottom
    pkgs.bun
    pkgs.clang
    pkgs.cmake
    pkgs.cowsay
    pkgs.dust
    pkgs.eza
    pkgs.fastfetch
    pkgs.fortune
    pkgs.hyperfine
    pkgs.gh
    pkgs.gitui
    pkgs.go
    pkgs.hurl
    pkgs.lldb
    pkgs.lolcat
    pkgs.neovim
    pkgs.nix-search-cli
    pkgs.nyancat
    pkgs.ocaml
    pkgs.odin
    pkgs.opam
    pkgs.ripgrep
    pkgs.tmux
    pkgs.vim
    pkgs.volta
    pkgs.yazi
    pkgs.zig
    pkgs.zoxide
  ];
}
