{ pkgs, zen_browser, ... }:
{
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  programs.steam.enable = true;

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  environment.unixODBCDrivers = with pkgs.unixODBCDrivers; [
    msodbcsql18
  ];

  environment.systemPackages = with pkgs; [
    #development
    jetbrains-toolbox
    bruno
    azure-functions-core-tools
    azure-cli
    azurite
    gh
    dotnetCorePackages.dotnet_8.sdk

    #gaming
    discord
    protonup-qt
    mangohud

    #desktop
    xwayland-satellite
    xdg-desktop-portal
    wl-clipboard
    alacritty
    ghostty
    fuzzel
    afterglow-cursors-recolored
    fastfetch
    mako
    loupe
    nautilus

    #other
    teams-for-linux
    gnome-boxes
    zen_browser.packages.x86_64-linux.default
    home-manager
  ];
}
