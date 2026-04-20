{ ... }: {
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
    HandleSuspendKeyLongPress = "ignore";
    HandleHibernateKeyLongPress = "ignore";
  };

  powerManagement.enable = false;
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];
}
