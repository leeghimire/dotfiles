{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    arandr
    bitwarden
    brightnessctl
    cargo
    clang
    dmenu
    eza
    feh
    ffmpeg
    fishPlugins.hydro
    fishPlugins.z
    flameshot
    gcc
    git
    gnumake
    go
    mpv
    neovim
    networkmanagerapplet
    nodejs
    ntfs3g
    python3
    qutebrowser
    ripgrep
    rustc
    tmux
    ungoogled-chromium
    unzip
    xclip
    xfce.thunar
    zathura
    zip

    (st.overrideAttrs (oldAttrs: rec {
      patches = [
        (pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/leeghimire/dotfiles/main/patches/st.diff";
          sha256 = "sha256-g4rS8DD6ln7RJD1scVCweWmjTVNyU7gGgiI1e8Xg694=";
        })
      ];
    }))

  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];
}
