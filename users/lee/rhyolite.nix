{ pkgs, zen-browser, ... }: {
  imports = [ zen-browser.homeModules.beta ];

  programs.zen-browser.enable = true;

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    btop
    cloc
    wl-clipboard
    xclip

    blender
    codex
    distrobox
    ghostty
    krita
    mpv
    obsidian
    podman-desktop

    nodejs
    (python3.withPackages (ps: [ ps.huggingface-hub ps.hf-xet ]))
  ];
}
