let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  name = "amy-kvantum-theme";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Amy-Plasma-Themes";
    rev = "main";
    sha256 = "0r7mpbj680c8z8h9zlzk8mxz2la2khnf72mdcr7hhic2q07c9fwp";
  };
  installPhase = ''
    mkdir -p $out/share/Kvantum
    cp -r "Amy Kvantum Themes/Amy-Light-Kvantum" $out/share/Kvantum/ || true
    cp -r "Amy Kvantum Themes/Amy-Dark-Kvantum" $out/share/Kvantum/ || true
  '';
}
