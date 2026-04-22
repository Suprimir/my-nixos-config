{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    gamemode
    protonup-qt
    gamescope
    mangohud
    wine
  ];
}
