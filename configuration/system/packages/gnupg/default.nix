{ pkgs, ... }:

{
  environment = {
    variables = {
      GNUPGHOME = "/home/hash/secrets/development/identities";
    };
  };
  programs.gnupg = {
    agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
  };
}
