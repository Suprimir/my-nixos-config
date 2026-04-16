{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "laptop";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.networkmanager.enable = true;

  time.timeZone = "America/Mazatlan";

  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.cpu.amd.updateMicrocode = true;

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

  services.xserver.xkb.layout = "us";
  services.libinput.enable = true;

  users.users.luis = {
    isNormalUser = true;
    description = "Luis Mario";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "render"
      "dialout"
    ];
    packages = with pkgs; [ tree ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fastfetch
    firefox
    brightnessctl
    powertop
    acpi
  ];

  system.stateVersion = "25.11";
}
