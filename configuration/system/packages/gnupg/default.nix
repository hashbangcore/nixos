{ pkgs, ... }:

{
  environment = {
    variables = {
      GNUPGHOME = "/data/secrets/development/identities";
    };
    systemPackages = [ pkgs.lock ];
  };
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
