{ config, pkgs, pkgs-stable, ... }:

{
    # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    # need to configue GnomeSettings-Keyboard-Input to activate ibus
  };
  fonts = {
        enableDefaultPackages = true;
        fontconfig.enable = true;
        fontDir.enable = true;
        enableGhostscriptFonts = true;
        # default font name : monospace
        packages = with pkgs; [
            noto-fonts
            source-han-sans
            noto-fonts-cjk
            noto-fonts-emoji
            sarasa-gothic
            wqy_microhei
            wqy_zenhei
        ];
  };
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
   };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

}
