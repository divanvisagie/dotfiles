{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-environment";
  paths = [
    pkgs.odin
    pkgs.go
    pkgs.clang
    pkgs.tmux
    pkgs.neovim
    pkgs.zig
    pkgs.vim
    pkgs.bun
    pkgs.valgrind
  ];
}
