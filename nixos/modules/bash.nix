{
  programs.bash = {
    enable = true;
    completion.enable = true;
    shellAliases = {
      #nixos
      rebuild-switch = "sudo nixos-rebuild switch --flake ~/.config/nix";
      rebuild-boot = "sudo nixos-rebuild boot --flake ~/.config/nix";
      flake-update = "sudo nix flake update --flake ~/.config/nix";
      home-switch = "home-manager switch --flake ~/.config/nix/#utlight -b backup";

      #softether
      vpnclient-up = ''sudo ~/.softether/build/vpnclient start && printf "AccountConnect tpdev\n" | ~/.softether/build/vpncmd localhost /CLIENT'';
      vpnclient-down = ''printf "AccountDisconnect tpdev\n" | ~/.softether/build/vpncmd localhost /CLIENT && sudo ~/.softether/build/vpnclient stop'';
    };
  };
}
