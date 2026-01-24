{pkgs, ...}: {
  programs.neovide.enable = true;
  programs.nvf = {
    enable = true;
    settings.vim = {
      luaConfigRC.config = ''require("config")'';
      # luaConfigRC.keymaps = ''require("config.keymaps")'';
      # luaConfigRC.plugins = ''require("config.plugins.telescope")'';

      theme.enable = true;
      theme.name = "rose-pine";
      theme.style = "moon";

      visuals.nvim-web-devicons.enable = true;
      statusline.lualine.enable = true;

      startPlugins = with pkgs.vimPlugins; [
        #treesitter
        nvim-treesitter
        nvim-treesitter-parsers.lua
        nvim-treesitter-parsers.nix

        #telescope
        plenary-nvim
        telescope-nvim
        telescope-ui-select-nvim
        telescope-fzf-native-nvim

        #development
        nvim-lspconfig
        lazydev-nvim
        luvit-meta
        blink-cmp
        conform-nvim
        luasnip
        friendly-snippets

        #mini
        mini-pairs
        # mini-ai
        # mini-surround
        mini-splitjoin

        tiny-inline-diagnostic-nvim
        # nvim-scrollbar
        # substitute-nvim
        # satellite-nvim

        #help
        guess-indent-nvim
        which-key-nvim
      ];

      extraPackages = with pkgs; [
        ripgrep
        lua-language-server
        stylua
        nixd
        alejandra
      ];
    };
  };
}
