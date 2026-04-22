{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/kernel.nix
    ../../modules/core/common.nix
  ];

  networking.hostName = "laptop";

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 60;
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MAX_PERF_ON_BAT = 60;

      USB_AUTOSUSPEND = 1;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
    acpi
  ];
}
