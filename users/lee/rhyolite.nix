{ pkgs, zen-browser, ... }: {
  imports = [ zen-browser.homeModules.beta ];

  programs.zen-browser.enable = true;

  home.packages = with pkgs; [
    btop
    claude-code

    blender
    discord
    distrobox
    krita
    obsidian
    podman-desktop
    prismlauncher
  ];
}
