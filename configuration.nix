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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
   };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     firefox
     git
     weechat
     stack
     dmenu
     gnumake
     gcc
     python
     python3
     binutils-unwrapped
     tldr
   ];
  #environment.variables = 
 # environment.shells = with pkgs; [zsh];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.ohMyZsh.enable = true;
  
  programs.zsh.interactiveShellInit=''
  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
    # Customize your oh-my-zsh options here
      ZSH_THEME="lambda"
      plugins=(git)

      source $ZSH/oh-my-zsh.sh
     '';
  programs.zsh.promptInit="";
 # user settings
 
 # allow proprietary packages
  
    nixpkgs.config = {
    allowUnfree = true;
    };
  
  # users.defaultUserShell = pkgs.zsh;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.windowManager.xmonad.enable = true;
  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  #services.upower.enable = true;
  #systemd.services.upower.enable = true;
  
  # use xmonad 
  services.xserver = {
	enable = true;
	displayManager.lightdm={enable = true;};
	windowManager.xmonad= {
		enable = true;
		enableContribAndExtras = true;
		extraPackages = haskellPackages: [
		haskellPackages.xmonad-contrib
		haskellPackages.xmonad-extras
		haskellPackages.xmonad
		];
		};

	windowManager.default = "xmonad";
	};
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.extraUsers.andrewdo = {
     isNormalUser = true;
     uid = 1000;
     home = "/home/andrewdo";
     extraGroups = ["wheel" "networkmanager"];
     shell = pkgs.zsh;
   };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
