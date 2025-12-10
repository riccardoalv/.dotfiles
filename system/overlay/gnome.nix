self: super: {

  gnome = super.gnome.overrideScope (_: g: {
    mutter = g.mutter.overrideAttrs (old: {
      mesonBuildType = "release";

      mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Db_lto=true" ];

      NIX_CFLAGS_COMPILE = toString (old.NIX_CFLAGS_COMPILE or "")
        + " -O3 -march=native -mtune=native -fno-plt -fomit-frame-pointer";
    });
  });

  gnome-shell = super."gnome-shell".overrideAttrs (old: {
    mesonBuildType = "release";

    mesonFlags = old.mesonFlags or [ ];

    NIX_CFLAGS_COMPILE = toString (old.NIX_CFLAGS_COMPILE or "")
      + " -O3 -march=native -mtune=native";

    NIX_LDFLAGS = old.NIX_LDFLAGS or "";
  });

}
