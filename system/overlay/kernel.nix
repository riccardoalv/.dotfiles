final: prev:

{
  linux_zen = prev.linux_zen.overrideAttrs (old: {
    NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "")
      + " -O3 -march=native -mtune=native -fomit-frame-pointer";

    NIX_LDFLAGS = (old.NIX_LDFLAGS or "");

    structuredExtraConfig = with final.lib.kernel; {
      DEBUG_KERNEL = no;
      DEBUG_INFO = no;
      DEBUG_MISC = no;
      KALLSYMS = no;

      PREEMPT_DYNAMIC = yes;
      PREEMPT = yes;

      HZ = freeform "1000";
      NO_HZ_FULL = yes;

      TRANSPARENT_HUGEPAGE = yes;
    };
    ignoreConfigErrors = true;
  });
}
