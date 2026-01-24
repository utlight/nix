{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "kdl"
      "sql"
    ];
    extraPackages = with pkgs; [
      nixd
      nil
    ];
    userSettings = {
      base_keymap = "JetBrains";
      theme = {
        mode = "system";
      };
    };
  };
}
