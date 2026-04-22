{
  config,
  lib,
  pkgs,
  inputs,
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
    ryubing
  ];

  virtualisation.waydroid.enable = true;

  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = [
    inputs.apple-fonts.packages.${pkgs.system}.sf-pro
    inputs.apple-fonts.packages.${pkgs.system}.sf-compact
    inputs.apple-fonts.packages.${pkgs.system}.sf-mono
    inputs.apple-fonts.packages.${pkgs.system}.sf-arabic
    inputs.apple-fonts.packages.${pkgs.system}.ny
  ];

  fonts.fontconfig = {
    defaultFonts = {
      sansSerif = [
        "SF Pro Display"
        "SF Pro Text"
      ];
      serif = [ "New York" ];
      monospace = [ "SF Mono" ];
    };
  };

  system.stateVersion = "25.11";
}
