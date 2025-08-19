{ pkgs, ... }:

{
  environment = {
    variables = {
      PASSWORD_STORE_DIR = "/data/secrets/development/store";
    };
    systemPackages = [ pkgs.pass ];
  };

}
