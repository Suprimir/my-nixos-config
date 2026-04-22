{ pkgs, spicetify-nix, ... }:

{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
      hidePodcasts
      shuffle
    ];
    theme = spicetify-nix.legacyPackages.${pkgs.stdenv.system}.themes.catppuccin;
    colorScheme = "mocha";
  };
}
