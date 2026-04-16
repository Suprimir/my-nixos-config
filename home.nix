{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.spotify
    pkgs.nixfmt
  ];

  home.file = {
    ".config/fastfetch/hanni.jpg" = {
      source = ./hanni.jpg;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.direnv.enable = true;
  programs.vscode.enable = true;
  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      shell = "fish";
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";

      confirm_os_window_close = 0;
      enable_audio_bell = false;
      copy_on_select = "yes";

      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "~/.config/fastfetch/hanni.jpg";
        type = "kitty";
        height = 14;
        padding = {
          top = 2;
          left = 2;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        "break"
        "break"
        {
          type = "title";
          keyWidth = 10;
        }
        "break"
        {
          type = "os";
          key = " ";
          keyColor = "34";
        }
        {
          type = "kernel";
          key = " ";
          keyColor = "34";
        }
        {
          type = "packages";
          format = "{} (nix)";
          key = " ";
          keyColor = "34";
        }
        {
          type = "shell";
          key = " ";
          keyColor = "34";
        }
        {
          type = "terminal";
          key = " ";
          keyColor = "34";
        }
        {
          type = "wm";
          key = " ";
          keyColor = "34";
        }
        {
          type = "cursor";
          key = " ";
          keyColor = "34";
        }
        {
          type = "terminalfont";
          key = " ";
          keyColor = "34";
        }
        {
          type = "uptime";
          key = " ";
          keyColor = "34";
        }
        {
          type = "datetime";
          format = "{1}-{3}-{11}";
          key = " ";
          keyColor = "34";
        }
        {
          type = "media";
          key = "󰝚 ";
          keyColor = "34";
        }
        {
          type = "player";
          key = " ";
          keyColor = "34";
        }
        "break"
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Luis Mario";
      user.email = "luismarioparrap@gmail.com";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting 
      fastfetch
    '';

    shellAliases = {
      rb = "sudo nixos-rebuild switch";
      hms = "home-manager switch";

      ls = "ls --color=auto";
      ll = "ls -l";
      ".." = "cd ..";

      nix-clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
  };
}
