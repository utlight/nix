{
  pkgs,
  unstable_pkgs,
  zen_browser,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    #vm
    spice-vdagent

    home-manager

    zen_browser.packages.x86_64-linux.default

    #development
    jetbrains-toolbox
    azure-functions-core-tools
    dotnetCorePackages.dotnet_8.sdk
    azurite
    zed-editor
    nil
    nixd
  ];
}
