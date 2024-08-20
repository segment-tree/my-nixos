{ config, pkgs, pkgs-stable, lib, ... }:

{
    # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    # need to configue GnomeSettings-Keyboard-Input to activate ibus
    # fcitx5.addons = with pkgs; [ fcitx5-chinese-addons fcitx5-gtk ];#  libsForQt5.fcitx5-qt 
    # fcitx5-configtool
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
  # sound.enable = true;
  hardware.pulseaudio.enable = lib.mkDefault true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  
  services.keyd = {
    enable = true;
    keyboards = {
      # The name is just the name of the configuration file, it does not really matter
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
        # Everything but the ID section:
        settings = {
          # The main layer, if you choose to declare it in Nix
          main = {};
          otherlayer = {};
        };
        extraConfig = ''
          [main]
          capslock=layer(mylayer)
          [mylayer]
          h=left
          j=down
          k=up
          l=right
          space=M-S-space
        '';
      };
    };
  };
  
}
