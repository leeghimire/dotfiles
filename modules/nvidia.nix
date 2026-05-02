{ config, ... }: {
  boot.kernelParams = [ "nvidia.NVreg_EnableGpuFirmware=0" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" "nova_core" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    forceFullCompositionPipeline = true;
    gsp.enable = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}
