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

      src = ./.;

      nativeBuildInputs = with pkgs; [
        cmake
      ];

      buildInputs = with pkgs; [
        llvm 
      ];
      
      # We override the default install phase to handle it ourselves
      installPhase = ''
        # Create the bin directory in the output path
        mkdir -p $out/bin
        
        # Copy the compiled executable to the bin directory
        # (Assuming it outputs to bin/raft based on your log)
        cp ../bin/raft $out/bin/
      '';
      
      # Optional: explicitly tell Nix what the main executable is called
      meta.mainProgram = "raft";
    };
  };
}
