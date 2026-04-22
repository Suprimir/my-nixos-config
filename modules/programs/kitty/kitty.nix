{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    settings = {
      shell = "fish";
      background_opacity = "0.85";
      dynamic_background_opacity = "yes";

      confirm_os_window_close = 0;
      enable_audio_bell = false;
      copy_on_select = "yes";

      cursor_shape = "beam";
      cursor_blink_interval = "0.5";
    };
  };
}
