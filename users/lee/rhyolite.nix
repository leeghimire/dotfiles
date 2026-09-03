{ pkgs, zen-browser, ... }: {
  imports = [ zen-browser.homeModules.beta ];

  programs.zen-browser.enable = true;

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    btop
    wl-clipboard
    xclip

    blender
    discord
    distrobox
    foliate
    ghostty
    krita
    mpv
    obsidian
    podman-desktop
    prismlauncher
  ];
}
