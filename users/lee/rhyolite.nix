{ pkgs, ... }: {
  home.packages = with pkgs; [
    claude-code

    blender
    krita
    obsidian
    prismlauncher
  ];
}
