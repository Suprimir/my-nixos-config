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

  networking.hostName = "desktop";
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
    priority = 10;
    memoryPercent = 50;
  };

  services.power-profiles-daemon.enable = true;

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
    packages = with pkgs; [
      tree
    ];
  };

  # Paquetes de sistema
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fastfetch
    firefox
    pciutils
    clinfo
  ];

  system.stateVersion = "25.11";
}
