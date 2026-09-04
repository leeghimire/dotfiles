{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # PipeWire uses RTKit for real-time scheduling.
  security.rtkit.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    discord
    foliate
    ghostty
    mpv
    obsidian
    ungoogled-chromium
    wl-clipboard
  ];

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
}
