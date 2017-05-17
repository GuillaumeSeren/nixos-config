# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
    ranger
    ncdu
    # Gui
    pcmanfm
    darktable
    gimp
    libreoffice
    pavucontrol
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
    wineStaging
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

    # Enable CUPS to print documents.
    printing.enable = true;

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
      latitude = "48";
      longitude = "11";
      temperature = {
        day = 3500;
        night = 3500;
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
