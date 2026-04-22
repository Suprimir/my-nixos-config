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
    ./modules/programs/kitty/kitty.nix
    ./modules/programs/fastfetch/fastfetch.nix
    ./modules/programs/fish/fish.nix
    ./modules/programs/git/git.nix
    ./modules/programs/spicetify/spicetify.nix
    ./modules/programs/starship/starship.nix
    ./modules/programs/code/code.nix

    ./modules/desktop/plasma/plasma.nix

    ./modules/games/games.nix
  ];

  home.username = "luis";
  home.homeDirectory = "/home/luis";

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.nixfmt
    pkgs.arduino-ide
    pkgs.nerd-fonts._0xproto
    pkgs.obsidian
    (pkgs.vesktop.override {
      electron = pkgs.electron.override {
        commandLineArgs = [
          "--disable-gpu"
          "--no-sandbox"
        ];
      };
    })
    pkgs.flatpak
    pkgs.kicad
    pkgs.rar
  ];

  programs.direnv.enable = true;
  programs.home-manager.enable = true;
}
