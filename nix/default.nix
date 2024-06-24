{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-environment";
  paths = [
    pkgs.autoconf
    pkgs.autogen
    pkgs.bun
    pkgs.clang
    pkgs.cmake
    pkgs.cowsay
    pkgs.fastfetch
    pkgs.fortune
    pkgs.gh
    pkgs.go
    pkgs.lolcat
    pkgs.neovim
    pkgs.nix-search-cli
    pkgs.nyancat
    pkgs.ocaml
    pkgs.odin
    pkgs.tmux
    pkgs.vim
    pkgs.zig
  ];
}
