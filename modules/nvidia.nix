{ config, ... }: {
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" "nova_core" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}
