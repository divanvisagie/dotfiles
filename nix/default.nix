{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-environment";
  paths = [
    pkgs.autoconf
    pkgs.autogen
    pkgs.bat # rust replacement for less
    pkgs.bottom # rust replacement for top
    pkgs.bun
    pkgs.clang
    pkgs.cmake
    pkgs.cowsay
    pkgs.dust
    pkgs.eza
    pkgs.fastfetch
    pkgs.fd # rust replacement for find
    pkgs.fortune
    pkgs.gh
    pkgs.gitui
    pkgs.go
    pkgs.hurl
    pkgs.hyperfine # benchmarking tool
    pkgs.lldb
    pkgs.lolcat
    pkgs.neovim
    pkgs.nix-search-cli
    pkgs.nyancat
    pkgs.ocaml
    pkgs.odin
    pkgs.opam
    pkgs.scala
    pkgs.procs # better version of ps
    pkgs.tokei # find out what programming languages are in use in this directory
    pkgs.ripgrep
    pkgs.tldr # simplified man pages
    pkgs.tmux
    pkgs.vim
    pkgs.volta
    pkgs.yazi # rust terminal file browser
    pkgs.zig
    pkgs.zoxide
  ];
}
