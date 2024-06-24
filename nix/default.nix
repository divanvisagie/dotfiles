{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-environment";
  paths = [
    pkgs.bun
    pkgs.clang
    pkgs.autogen
    pkgs.autoconf
    pkgs.cmake
    pkgs.go
    pkgs.neovim
    pkgs.ocaml
    pkgs.odin
    pkgs.tmux
    pkgs.vim
    pkgs.zig
  ];
}
