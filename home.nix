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
    pkgs.vesktop
    pkgs.flatpak
    pkgs.kicad
  ];

  programs.direnv.enable = true;
  programs.home-manager.enable = true;
}
