{
  pkgs,
  unstable_pkgs,
  zen_browser,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;

  programs.steam.enable = true;

  environment.systemPackages =
    (with pkgs; [
      #development
      dotnetCorePackages.dotnet_8.sdk

      #others
      spice-vdagent
      home-manager
    ])
    ++ (with unstable_pkgs; [
      #development
      jetbrains-toolbox
      azure-functions-core-tools
      azurite
      zed-editor
      nil
      nixd

      #web
      zen_browser.packages.x86_64-linux.default
    ]);
}
