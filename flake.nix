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
        src = ./.;
        configurePhase = ''
          runHook preConfigure
          cmake .
          runHook postConfigure
        '';
        buildPhase = ''
          runHook preBuild
          cmake --build .
          runHook postBuild
        '';
        installPhase = ''
          runHook preInstall
          mkdir -p $out/lib/ $out/include/
          cp ./fmtlog.h $out/include/
          cp ./fmtlog-inl.h $out/include/
          cp ./libfmtlog-shared.so $out/lib/
          cp ./libfmtlog-static.a $out/lib/
          runHook postInstall
        '';
      };
    };
}
