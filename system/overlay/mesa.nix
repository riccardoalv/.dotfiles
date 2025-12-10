self: super: {
  mesa = super.mesa.overrideAttrs (old: {
    mesonFlags = (old.mesonFlags or [ ]) ++ [ "-Db_lto=false" ];

    NIX_CFLAGS_COMPILE = toString (old.NIX_CFLAGS_COMPILE or "")
      + " -O3 -mtune=native -fno-plt -fomit-frame-pointer";
  });
}
