{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Mazatlan";

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "us";
  services.libinput.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.cpu.amd.updateMicrocode = true;

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
  ];

  system.stateVersion = "25.11";
}
