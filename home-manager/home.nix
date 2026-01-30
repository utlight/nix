{ home_state_version, ... }:
{
  imports = [
    ./modules/modules.nix
    ./dotfiles/dotfiles.nix
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  xdg.desktopEntries = {
    teams-for-linux = {
      name = "Teams";
      exec = "teams-for-linux --enable-features=UseOzonePlatform --ozone-platform-hint=auto";
      icon = "teams-for-linux";
      categories = [ "Network" ];
    };
    discord = {
      name = "Discord";
      exec = "discord --enable-features=UseOzonePlatform --ozone-platform-hint=auto";
      icon = "discord";
      categories = [ "Network" ];
    };
    steam = {
      name = "Steam";
      exec = "steam --enable-features=UseOzonePlatform --ozone-platform-hint=auto";
      icon = "steam";
      categories = [ "Game" ];
    };
  };

  home = {
    username = "utlight";
    homeDirectory = "/home/utlight";
    stateVersion = home_state_version;
  };
}
