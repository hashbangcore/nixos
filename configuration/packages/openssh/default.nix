{ pkgs, ... }:

{
  services.sshd = {
    enable = false;
  };
  environment = {
    systemPackages = [ pkgs.openssh ];
  };
}
