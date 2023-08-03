{
  description = "fmtlog";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
  };

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
        name = "fmtlog";
        buildInputs = with pkgs; [
          fmt
          cmake
        ];
        src = self;
        buildPhase = ''
          cmake .
          cmake --build .
        '';
        installPhase = ''
          mkdir -p $out/lib/
          cp ./libfmtlog-shared.so $out/lib/libfmtlog-shared.so
          cp ./libfmtlog-static.a $out/lib/libfmtlog-shared.a
        '';
      };
    };
}
