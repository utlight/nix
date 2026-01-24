{
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  networking.firewall.enable = false;

  services.resolved.enable = true;

  networking.useNetworkd = true;
  systemd.network.networks."50-softether" = {
    matchConfig.Name = "vpn_vpn";
    networkConfig.DHCP = "ipv4";
    routes = [
      {
        Destination = "20.0.0.0/8";
        Gateway = "192.168.30.1";
      }
      {
        Destination = "13.0.0.0/8";
        Gateway = "192.168.30.1";
      }
    ];
  };
}
