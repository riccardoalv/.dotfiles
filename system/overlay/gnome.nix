self: super: {
  gnome = super.gnome.overrideScope' (
    _: g: {
      mutter = g.mutter.override { enablePerformancePatches = true; };
    }
  );
}
