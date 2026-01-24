{
  description = "SoftEther build environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.softether = pkgs.mkShell {
        name = "softether-shell";

        buildInputs = [
          pkgs.gnumake
          pkgs.gcc
          pkgs.cmake
          pkgs.pkg-config
          pkgs.libsodium
          pkgs.ncurses
          pkgs.openssl
          pkgs.zlib
          pkgs.readline
        ];

        shellHook = ''
          export PS1='[\u@nix:softether \w]\$ '
          export READLINE_INCLUDE=${pkgs.readline.dev}/include
          export READLINE_LIB=${pkgs.readline.dev}/lib/libreadline.so
          export CURSES_INCLUDE=${pkgs.ncurses.dev}/include
          export CURSES_LIBRARY=${pkgs.ncurses.dev}/lib/libncurses.so
        '';
      };
    };
}
