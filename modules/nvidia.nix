{ config, ... }: {
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" "nova_core" ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics.enable = true;

  # Keep the RTX 2060 (0000:04:00.0) out of the NVIDIA graphics stack.
  # Remove these two settings and reboot when the card is needed for AI work.
  boot.initrd.kernelModules = [ "vfio_pci" ];
  boot.kernelParams = [ "vfio-pci.ids=10de:1f08" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };
}
