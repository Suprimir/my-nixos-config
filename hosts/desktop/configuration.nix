{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/kernel.nix
    ../../modules/core/common.nix
  ];

  networking.hostName = "desktop";

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  zramSwap = {
    enable = true;
    priority = 10;
    memoryPercent = 50;
  };

  services.power-profiles-daemon.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pciutils
    clinfo
    system-config-printer
    htop
  ];

  programs.steam.enable = true;
}
