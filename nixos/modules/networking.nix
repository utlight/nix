{
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  services.resolved.enable = true;
  services.softether.vpnclient.enable = true;
}
