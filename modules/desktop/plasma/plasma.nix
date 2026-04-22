{ pkgs, ... }:

{
  home.file = {
    "Pictures/wallpapers/wallpaper.png" = {
      source = ./wallpaper.png;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Amy-Dark-Kvantum
  '';

  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    (pkgs.stdenv.mkDerivation {
      name = "amy-kvantum-theme";
      src = pkgs.fetchFromGitHub {
        owner = "L4ki";
        repo = "Amy-Plasma-Themes";
        rev = "main";
        sha256 = "0r7mpbj680c8z8h9zlzk8mxz2la2khnf72mdcr7hhic2q07c9fwp";
      };
      installPhase = ''
        mkdir -p $out/share/Kvantum
        cp -r "Amy Kvantum Themes/Amy-Dark-Kvantum" $out/share/Kvantum/
      '';
    })
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
  ];

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

    kscreenlocker = {
      autoLock = false;
    };

    powerdevil.AC = {
      autoSuspend.action = "nothing";
      dimDisplay.enable = false;
      turnOffDisplay.idleTimeout = "never";
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        lengthMode = "fill";
        opacity = "translucent";
        floating = true;
        height = 44;

        widgets = [
          {
            plasmusicToolbar = {
              background = "transparentShadow";
              panelIcon = {
                albumCover = {
                  fallbackToIcon = true;
                  useAsIcon = true;
                };
              };
              songText = {
                maximumWidth = 100;
              };
            };
          }

          "org.kde.plasma.panelspacer"

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
    ];
  };
}
