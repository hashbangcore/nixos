{ pkgs, ... }:

{
  environment = {
    variables = {
      PASSWORD_STORE_DIR = "/home/hash/secrets/development/store";
    };
    systemPackages = [ pkgs.pass ];
  };

}
