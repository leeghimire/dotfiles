{ lib, pkgs, options, ... }:
let
  has = lib.hasAttrByPath;

  # Keep one package list, then drop missing or unavailable packages.
  requestedPackageNames = [
    "git"
    "go"
    "gopls"
    "jq"
    "lua"
    "lua-language-server"
    "neovim"
    "pyright"
    "python3"
    "ripgrep"
    "stow"
    "tmux"
    "vtsls"
    "zig"
    "zls"
  ];

  requestedPackages = builtins.concatMap
    (name: lib.optional (builtins.hasAttr name pkgs) (builtins.getAttr name pkgs))
    requestedPackageNames;

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
