{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.blacklistedKernelModules = [ "hid_appleir" ];
  boot.loader.grub.enable = false;
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_3_12;
  networking.hostName = "liquid";
  networking.enableB43Firmware = true;
  networking.wireless.enable = true;
  networking.wireless.interfaces = [ "wlan0" ];

  time.timeZone = "America/Los_Angeles";

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.openssh.enable = true;
  services.printing.enable = true;

  services.xserver.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  services.xserver.displayManager.slim.enable = true;
  services.xserver.layout = "us";
  services.xserver.multitouch = {
    enable = true;
    invertScroll = true;
    ignorePalm = true;
  };
  services.xserver.startOpenSSHAgent = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  users.extraUsers.mwhiteley = {
    description = "Matt Whiteley";
    group = "users";
    extraGroups = [ "wheel" ];
    home = "/home/mwhiteley";
    createHome = true;
    shell = pkgs.zsh + "/bin/zsh";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSFERgbdIFBFfWkYkxUgDoNbaBfwhyHY/kFnFgZdG8PamaKvYpvHCYHxXjVD2bp9oCr6VBu5mpTPi9pPbUJ5ZyymIm8xkCYGYTHaxxp/J3I642aRdHv6lXYQyVPS/mQjYOOVl9V4qzWgke001V3hbs3YDG0HJXU3RfOuiNRajzEzgTbJ6DFrpU8mdaCVe/gOj1lHlE38HuPxK8T5Kop0SpC78vu6gjWOtei2P+1M+qbaq/dYhNH/DDnqiA2AaDfNLUfSsJiqtjrhupEIAZpLdUL6VBtJXXSX1RJUUurlVZ9vQIci1PrlnVlZo27orwO6Jg09kJvTPP+LxSQv1F3JT9"
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      file
      git
      manpages
      tmux
      vim
      zsh
    ];
  };
}
