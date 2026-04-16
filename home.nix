{
  config,
  pkgs,
  imports,
  spicetify-nix,
  ...
}:

{
  imports = [
    spicetify-nix.homeManagerModules.spicetify
  ];

  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.stateVersion = "25.11";

  home.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "layan-aurorae-theme";
      src = pkgs.fetchFromGitHub {
        owner = "vinceliuice";
        repo = "Layan-kde";
        rev = "master";
        hash = "sha256-gy3sHVoCo4q7ihFuLvQEil7t4GdrbcfatOulAy2MZ9U=";
      };
      installPhase = ''
        mkdir -p $out/share/aurorae/themes
        cp -r aurorae/themes/* $out/share/aurorae/themes/
      '';
    })
    (pkgs.stdenv.mkDerivation {
      name = "mcsur-kde-theme";
      src = pkgs.fetchFromGitHub {
        owner = "yeyushengfan258";
        repo = "McSur-kde";
        rev = "master";
        hash = "sha256:1v1bzbkmhwpp0wd41kw71d4arqwf9iixkvqnv0ggglgg3pa0wm36";
      };
      installPhase = ''
        mkdir -p $out/share/plasma/desktoptheme
        cp -r plasma/desktoptheme/* $out/share/plasma/desktoptheme/ || true

        mkdir -p $out/share/color-schemes
        cp -r color-schemes/*.colors $out/share/color-schemes/ || true
      '';
    })
    pkgs.papirus-icon-theme
    pkgs.nixfmt
    pkgs.arduino-ide
  ];

  home.file = {
    ".config/fastfetch/hanni.jpg" = {
      source = ./assets/hanni.jpg;
    };
    "Pictures/wallpapers/wallpaper.png" = {
      source = ./assets/wallpaper.png;
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

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    workspace = {
      clickItemTo = "select";
      theme = "McSur-dark";
      colorScheme = "McSur-dark";
      iconTheme = "Papirus-Dark";
      windowDecorations = {
        library = "org.kde.kwin.aurorae";
        theme = "__aurorae__svg__Layan";
      };
      wallpaper = "/home/luis/Pictures/wallpapers/wallpaper.png";
    };

    panels = [
      {
        location = "top";
        height = 20;

        widgets = [
          "org.kde.plasma.panelspacer"

          {
            name = "org.kde.plasma.systemtray";
            config = {
              General.extraItems = [
                "org.kde.plasma.battery"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
            };
          }

          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Appearance = {
                showSeconds = "true";
                format = "24h";
              };
            };
          }
        ];
      }
      {
        location = "bottom";
        alignment = "center";
        floating = true;
        hiding = "dodgewindows";
        lengthMode = "fit";
        height = 44;

        widgets = [
          "org.kde.plasma.kickoff"

          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:kitty.desktop"
                "applications:spotify.desktop"
                "applications:code.desktop"
              ];
            };
          }
          {
            plasmusicToolbar = {
              background = "transparentShadow";
              panelIcon = {
                albumCover = {
                  fallbackToIcon = true;
                  useAsIcon = true;
                };
              };
            };
          }
        ];
      }
    ];
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      hidePodcasts
      shuffle
    ];
    theme = spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
    colorScheme = "mocha";
  };
}
