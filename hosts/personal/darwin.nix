{ ... }:

{
  homebrew = {
    onActivation.cleanup = "zap";  # remove anything not listed here

    taps = [
      { name = "mongodb/brew"; trusted = true; }
      { name = "facebook/fb"; trusted = true; }
    ];

    brews = [
      "mongodb-community"
      "redis"
      "cliclick"       # macOS mouse/keyboard automation - simulator UI testing
      "idb-companion"  # iOS Simulator control (tap/swipe) - facebook/fb tap
    ];

    casks = [
      "android-studio"
      "another-redis-desktop-manager"
      "temurin@17"
    ];
  };
}
