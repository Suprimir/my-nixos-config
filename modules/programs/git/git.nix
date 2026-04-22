{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Luis Mario";
      user.email = "luismarioparrap@gmail.com";
    };
  };
}
