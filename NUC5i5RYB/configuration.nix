{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.cleanTmpDir = true;
  boot.kernelParams = [ "nomodeset" ];
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rime";
  networking.hostId = "3f5543de";

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    dmidecode
    file
    git
    gitAndTools.hub
    gnupg21
    htop
    jq
    manpages
    neovim
    openssl
    tmux
  ];

  fonts.enableCoreFonts = true;

  programs.bash.enableCompletion = true;
  programs.ssh.startAgent = true;

  security.pam.enableSSHAgentAuth = true;
  security.sudo.extraConfig = "\n# 5 minutes is too short.\nDefaults:mwhiteley timestamp_timeout=30";

  services.avahi.enable = true;
  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    xkbOptions = "ctrl:nocaps";
  };

  time.timeZone = "America/Los_Angeles";

  users.extraUsers.mwhiteley = {
    description = "Matt Whiteley";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh + "/bin/zsh";
    uid = 1000;
  };
}
