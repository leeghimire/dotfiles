{ lib, pkgs, options, ... }:
let
  has = lib.hasAttrByPath;

  # Keep one package list, then drop packages unavailable on the current platform.
  requestedPackages = with pkgs; [
    git
    go
    gopls
    jq
    lua
    lua-language-server
    neovim
    pyright
    python3
    ripgrep
    telegram-desktop
    tmux
    vtsls
    zig
    zls
  ];

  availablePackages = builtins.filter
    (pkg: lib.meta.availableOn pkgs.stdenv.hostPlatform pkg)
    requestedPackages;
in {
  config = lib.mkIf (has [ "environment" "systemPackages" ] options) {
    environment.systemPackages =
      availablePackages
      ++ [
        (pkgs.runCommand "vim-shadow" { } ''
          mkdir -p $out/bin
          ln -s ${pkgs.neovim}/bin/nvim $out/bin/vim
        '')
      ];
  };
}
