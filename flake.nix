{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      lix-module,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      unstable = import nixpkgs-unstable { inherit system; };
      colorscheme = import ./configuration/colorscheme.nix;
    in
    {
      nixosConfigurations.master = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit unstable colorscheme;
        };
        modules = [
          ./configuration/system
          lix-module.nixosModules.default
        ];
      };
    };
}
