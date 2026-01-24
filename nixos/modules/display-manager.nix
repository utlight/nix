{
  services.xserver.enable = true;

  programs.niri.enable = true;
  programs.niri.useNautilus = true;
  programs.dms-shell.enable = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    compositor.customConfig = ''
      input {
        mouse {
            accel-profile "flat"
        }
      }
      cursor {
          xcursor-theme "Afterglow-Recolored-Dracula-Cyan"
      }
      hotkey-overlay {
          skip-at-startup
      }
    '';
  };
}
