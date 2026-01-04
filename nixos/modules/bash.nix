{
  programs.bash = {
    enable = true;
    completion.enable = true;
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/.config/nix && home-manager switch --flake ~/.config/nix/#utlight";
      boot = "sudo nixos-rebuild boot --flake ~/.config/nix && home-manager switch --flake ~/.config/nix/#utlight";

      vpnclient-up = ''sudo ~/.softehter/vpnclient/vpnclient start && printf "AccountConnect tpdev\n" | ~/.softehter/vpnclient/vpncmd localhost /CLIENT'';
      vpnclient-down = ''printf "AccountDisconnect tpdev\n" | ~/.softehter/vpnclient/vpncmd localhost /CLIENT && sudo ~/.softehter/vpnclient/vpnclient stop'';
    };
  };
}
