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
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
#     initrd.luks.devices = [{
#     	name = "crypto_root";
# 	device = "/dev/disk/by-uuid/899a6b0b-db4a-4715-b9e9-f14e1dce9b20";
#     	allowDiscards = true;
# 	}];
   };

  networking.hostName = "josekit470"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

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
    # Editor
    vim
    neovim
    emacs
    # Dev
    git
    gitAndTools.git-extras
    tig
    # Mail
    notmuch
    alot
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
  };

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;
  };

  hardware.pulseaudio.enable = true;
  # per user is broken (for me?)
  hardware.pulseaudio.systemWide = true;

  # nix.extraOptions = ''
  #   auto-optimise-store = true
  #   env-keep-derivations = true
  #   gc-keep-outputs = true
  #   gc-keep-derivations = true
  # '';
  # nix.useChroot = true;

  # powerManagement.cpuFreqGovernor = "ondemand";
  # powerManagement.enable = true;
  #powerManagement.aggressive = true;

  # # Virtualisation
  # virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;

  # List services that you want to enable:

  # ctrl+alt+F8 open manual in a term
  services.nixosManual.showManual = true;

  # @TODO:
  # services.thinkfan.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e, caps:escape";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.gseren = {
    description = "Guillaume Seren";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "vboxuser" "docker" "audio" ];
  };
  
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
