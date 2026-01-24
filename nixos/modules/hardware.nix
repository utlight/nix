{ config, pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  hardware.nvidia = {
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = [ "utlight" ];
  users.users.utlight.extraGroups = [ "libvirtd" ];

  virtualisation.vmware.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = false;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
