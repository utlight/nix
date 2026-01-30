{pkgs, ...}: {
  programs.neovide.enable = true;
  programs.nvf = {
    enable = true;
    settings.vim = {
      luaConfigRC.config = ''require("config")'';
      # luaConfigRC.dbui-preview = ''require("config.lua.dbui-preview").setup {}'';
      # luaConfigRC.dadbod-ui = ''require("config.lua.dadbod-ui").setup {}'';

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
        nvim-treesitter-parsers.bash
        nvim-treesitter-parsers.c_sharp
        nvim-treesitter-parsers.sql

        #telescope
        plenary-nvim
        project-nvim
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

        roslyn-nvim
        gitsigns-nvim
        diffview-nvim

        #mini
        mini-pairs
        mini-splitjoin

        tiny-inline-diagnostic-nvim
        toggleterm-nvim
        dashboard-nvim
        better-escape-nvim
        # substitute-nvim

        #help
        guess-indent-nvim
        which-key-nvim
        yazi-nvim
      ];

      extraPackages = with pkgs; [
        ripgrep
        lua-language-server
        roslyn-ls
        stylua
        nixd
        alejandra

        sqlcmd
      ];
    };
  };
}
