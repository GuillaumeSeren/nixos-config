# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
    # "vm.dirty_writeback_centisecs" = 1500;
    # "vm.drop_caches" = 3;
      "vm.laptop_mode" = 5;
      "vm.swappiness" = 1;
    };

    # extraModprobeConfig = ''
    #   options thinkpad_acpi fan_control=1
    # '';
  };

  networking = {
    hostName = "josekit470"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # Font
    nerdfonts
    # term
    neofetch
    cowsay
    ponysay
    colordiff
    rxvt_unicode
    xclip
    weechat
    xdotool
    xorg.xkbcomp
    xorg.xinput
    ranger
    ncdu
    # Search
    ag
    ripgrep
    # Terminal Multiplexer
    tmux
    screen
    # Network
    wget
    curl
    nmap
    wgetpaste
    netcat
    rtorrent
    # shell
    zsh
    # Linter
    shellcheck
    # Editor
    vim
    neovim
    emacs
    # Dev
    git
    gitAndTools.git-extras
    tig
    subversion
    pijul
    # Mail
    notmuch
    alot
    offlineimap
    python35Packages.afew
    astroid
    # Music
    mpd
    ncmpcpp
    # Top
    iftop
    iotop
    htop
    powertop
    nethogs
    # Browser
    firefox
    chromium
    w3m
    pcmanfm
    # Gui
    pavucontrol
    # Office
    libreoffice
    # Images
    darktable
    gimp
    blender
    gimp
    # Video
    vlc
    mpv
    # WM
    dmenu
    slock
    redshift
    # Games
    cockatrice
    steam
    # Virtualisation
    virtualbox
    qemu
    docker
    rkt
    packer
    # wineStaging
    wine
    winetricks
    # System
    sshfs-fuse
    acpitool
    cpufrequtils
    cryptsetup
    hdparm
    parted
    lm_sensors
    tlp
      ];

  # Configure package options
  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };

    vim = {
      python = true;
      netbeans = false;
      ftNixSupport = true;
    };

    # Whitelisting
    permittedInsecurePackages = [
      "webkitgtk-2.4.11"
    ];

    wine = {
      release = "staging"; # "stable", "unstable", "staging"
        build = "wineWow"; # "wine32", "wine64", "wineWow"
        pulseaudioSupport = true;
      override = {
        wineBuild = "wineWow";
        wineRelease = "staging";
      };
    };

    # packageOverrides = pkgs: {
    #   wine = pkgs.stdenv.lib.overrideDerivation pkgs.wine (oldAttrs : {
    #     wineBuild = "wineWow";
    #     wineRelease = "unstable";
    #     pulseaudioSupport=true;
    #     configureFlags = [ "--enable-win64" "--with-alsa" "--with-pulse" ];
    #   });
    # };
  };

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };

    virtualbox.host.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      # per user is broken (for me?)
      systemWide = true;
    };
    trackpoint = {
      enable = true;
      sensitivity = 255;
    };
  };

  # List services that you want to enable:
  services = {
    # ctrl+alt+F8 open manual in a term
    nixosManual.showManual = true;

    # thinkfan.enable = true;
    tlp = {
      enable = true;
      extraConfig = ''
        START_CHARGE_THRESH_BAT0=75
        STOP_CHARGE_THRESH_BAT0=90
        START_CHARGE_THRESH_BAT1=75
        STOP_CHARGE_THRESH_BAT1=90
        '';
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      xkbOptions = "eurosign:e, caps:escape";

      # Enable the KDE Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;

      # Touchpad
      synaptics = {
        enable = true;
        tapButtons = false;
        twoFingerScroll = true;
      };
    };

    redshift = {
      enable = true;
      latitude = "47.08";
      longitude = "2.39";
      temperature = {
        day = 3700;
        night = 3600;
      };
    };

    upower.enable = true;
    urxvtd.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.gseren = {
    description = "Guillaume Seren";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxuser" "docker" "audio" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
