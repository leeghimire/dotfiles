{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm_vdo" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0489d877-e7cf-436c-87fc-d7ec28087ece";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd:3" "noatime" "discard=async" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5A85-4F3B";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
