let
  euphenix = import (fetchTarball {
    url = "https://github.com/manveru/euphenix/archive/35af750a24bd16b72085efff772f86754c928b6b.tar.gz";
    sha256 = "sha256:08drqgianwhj45d5syn97r3dr5q3y3xczwy6qv33mdyldq9r3cr1";
  }) { };
in euphenix.build {
  name = "christen-woergl";
  rootDir = ./.;
  layout = ./templates/layout.tmpl;
  favicon = ./static/img/favicon.svg;
  variables = {
    liveJS = false;
    email = "kontakt@christen-wörgl.at";
  };
}
