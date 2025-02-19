{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs;
    [
      git
      ydotool
      gobject-introspection
      gcc
      cairo
      pkg-config
      python3
      gtk3
      opencv
      python3Packages.pyscreenshot
      python312Packages.pygobject3
      python3Packages.pillow
      python312Packages.opencv4
      (python3Packages.buildPythonPackage rec {
        pname = "hints";
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "AlfredoSequeida";
          repo = "hints";
          rev = "config/manual-window-system"; # You can specify a specific commit or tag if needed
          sha256 = "sha256-pWP8XVrFpzZ3xhLvsrerOyBMX0qx6v4DWahXTahqUZY="; # Replace with actual hash
        };
        nativeBuildInputs = with pkgs; [python3Packages.setuptools];
      })
    ]
    ++ (
      if pkgs.stdenv.isLinux && builtins.getEnv "XDG_SESSION_TYPE" == "wayland"
      then [
        gtk-layer-shell
        grim
      ]
      else []
    );
}
