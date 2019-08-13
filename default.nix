let
  euphenix = import ../euphenix {};
in euphenix.build {
  name = "christen-woergl";
  rootDir = ./.;
  layout = ./templates/layout.tmpl;
  favicon = ./static/img/favicon.svg;
  extraParts = [(euphenix.copyImagesMogrify ./static/img "/img" 2000)];
  variables = {
    liveJS = false;
    email = "kontakt@christen-wörgl.at";
  };
}
