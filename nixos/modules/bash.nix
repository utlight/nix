{
  programs.bash = {
    enable = true;
    completion.enable = true;
    shellAliases = {
      switch = "sudo nixos-rebuild switch --flake ~/.config/nix && home-manager switch --flake ~/.config/nix/#utlight";
    };
  };
}
