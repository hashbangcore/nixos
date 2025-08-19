{ pkgs, unstable, ... }:

{
  environment = {
    variables = {
      GNUPGHOME = "/data/secrets/development/identities";
    };
    systemPackages = [ unstable.lock ];
  };
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
