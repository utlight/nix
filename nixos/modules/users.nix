{pkgs, ...}: {
  users.users.utlight = {
    isNormalUser = true;
    description = "Utlight";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
    ];
  };
}
