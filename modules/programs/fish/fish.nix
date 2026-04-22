{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting 
      starship init fish | source
      fastfetch
    '';

    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake";
      hms = "home-manager switch";

      ls = "ls --color=auto";
      ll = "ls -l";
      ".." = "cd ..";

      nix-clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
  };
}
