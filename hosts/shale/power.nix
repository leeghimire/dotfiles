{ ... }: {
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = false;
}
