{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "eastwood";
    ohMyZsh.plugins = [
      "sudo"
    ];
    promptInit = ''
      bindkey '^Y' autosuggest-accept
    '';
    interactiveShellInit = ''
      vpnclient() {
        if pgrep -x vpnclient > /dev/null; then
          echo "Disconnecting from VPN..."
          printf "AccountDisconnect tpdev\n" | ~/.softether/build/vpncmd localhost /CLIENT && \
          sudo ~/.softether/build/vpnclient stop
        else
          echo "Connecting to VPN..."
          sudo ~/.softether/build/vpnclient start && \
          printf "AccountConnect tpdev\n" | ~/.softether/build/vpncmd localhost /CLIENT
        fi
      }
    '';
  };
}
