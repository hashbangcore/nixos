{ pkgs, ... }:

{
  environment = {
    variables = {
      GNUPGHOME = "/data/secrets/development/identities";
    };
  };
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
