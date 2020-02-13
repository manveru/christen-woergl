let
  pkgs = import ./nix { };

  euphenix = pkgs.euphenix.extend (self: super: {
    parseMarkdown =
      super.parseMarkdown.override { flags = { prismjs = true; }; };
  });

  inherit (euphenix.lib) take optionalString hasPrefix;
  inherit (euphenix) build mkPostCSS cssTag;

  mkRoute = template: title: {
    template = [ ./templates/layout.html template ];
    variables = rec {
      inherit title;
      active = route: prefix: optionalString (hasPrefix prefix route) "active";
      liveJS = optionalString (__getEnv "LIVEJS" != "")
        ''<script src="/js/live.js"></script>'';
      css = cssTag (mkPostCSS ./css);
      email = "kontakt@christen-wörgl.at";
      googleMap = ''
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d690165.1185484787!2d11.502663834237135!3d47.49074140812301!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x477632533027bf63%3A0xbe6f8ef93fee8fec!2sPeter-Anich-Stra%C3%9Fe+6%2C+6300+W%C3%B6rgl%2C+Austria!5e0!3m2!1sen!2sde!4v1565723700063!5m2!1sen!2sde" width="100%" frameborder="0" style="border:0" allowfullscreen class="map"></iframe>
      '';
      background = class: ''<div class="background ${class}"></div>'';
    };
  };

in build {
  src = ./.;
  name = "christen-woergl";

  routes = {
    "/de/about/index.html" = mkRoute ./templates/about.html "Über uns";
    "/de/contact/index.html" = mkRoute ./templates/contact_de.html "Kontakt";
    "/de/impressum/index.html" = mkRoute ./templates/impressum.html "Impressum";
    "/de/activities/index.html" =
      mkRoute ./templates/activities.html "Aktivitäten";
    "/en/contact/index.html" = mkRoute ./templates/contact_en.html "Contact";
    "/en/index.html" = mkRoute ./templates/home_en.html "Home";
    "/index.html" = mkRoute ./templates/home_de.html "Home";
  };

  extraParts = [
    (euphenix.copyImagesMogrify ./static/img "/img" 2000)
    (euphenix.copyFile ./static/download/flyer_irland.pdf
      "/download/flyer_irland.pdf")
    (euphenix.copyFile ./static/download/flyer_irland2.pdf
      "/download/flyer_irland2.pdf")
    (euphenix.copyFile ./static/download/flyer_irland3.pdf
      "/download/flyer_irland3.pdf")
  ];
}
