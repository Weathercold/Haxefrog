{
  description = "Haxefrog development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    android = {
      url = "github:tadfisher/android-nixpkgs/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, android }:
    with nixpkgs.legacyPackages.x86_64-linux;
    with haxePackages;
    let
      android-sdk = android.sdk.x86_64-linux (sdkPkgs: with sdkPkgs; [
        cmdline-tools-latest
        build-tools-33-0-1
        emulator
        platform-tools
        platforms-android-33
      ]);
    in
    {
      formatter.x86_64-linux = nixpkgs-fmt;
      devShells.x86_64-linux.default = mkShell {
        buildInputs = [
          temurin-bin-17
          android-sdk
          haxe
          hxjava
        ];
        shellHook = ''
          export JAVA_HOME=${temurin-bin-17} \
                 ANDROID_SDK_ROOT=${android-sdk}/share/android-sdk \
                 PATH=$JAVA_HOME/bin:$ANDROID_SDK_ROOT/build-tools/33.0.1:$PATH
          mkdir ~/Android 2>/dev/null
          ln -snf $JAVA_HOME ~/jdk
          ln -snf $ANDROID_SDK_ROOT ~/Android/Sdk
        '';
      };
    };
}
