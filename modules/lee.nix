{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.lee = {
    isNormalUser = true;
    description = "Lee Ghimire";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # English with ISO 8601 dates, 24-hour time, metric units, and A4 paper.
  i18n.extraLocaleSettings = {
    LC_TIME = "en_DK.UTF-8";
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
  };
}
