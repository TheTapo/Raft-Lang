{
  description = "Raft-Lang: A simple LLVM based programming language";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "raft-lang";
      version = "dev";

      # Pointing to the local repository
      src = ./.;

      # Tools needed to build the project
      nativeBuildInputs = with pkgs; [
        cmake
      ];

      # Libraries needed by the project
      buildInputs = with pkgs; [
        llvm 
      ];
      
      # CMake automatically handles the configure, build, and install phases in Nix!
    };
  };
}
