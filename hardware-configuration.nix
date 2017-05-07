# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/899a6b0b-db4a-4715-b9e9-f14e1dce9b20";
      fsType = "btrfs";
      options = [ "subvol=__active/root" "autodefrag" "compress=lzo" "noatime" "nodiratime" "discard" ];
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/a4471078-f37e-4193-be8a-bd25bf83347d";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/899a6b0b-db4a-4715-b9e9-f14e1dce9b20";
      fsType = "btrfs";
      options = [ "subvol=__active/home" "autodefrag" "compress=lzo" "noatime" "nodiratime" "discard" ];
    };

  # boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/a4471078-f37e-4193-be8a-bd25bf83347d";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D5C8-E94B";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/822b76a1-60b3-4495-ac50-87a03a5d5a1c"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "powersave";
}
