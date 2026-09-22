{ ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = "josephtong";
  users.users.josephtong = {
    home = "/Users/josephtong";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;            # fast key repeat
      InitialKeyRepeat = 15;    # short delay before repeat
      _HIHideMenuBar = true;    # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";   # list view by default
    finder.CreateDesktop = false;           # clean desktop
    trackpad.Clicking = true;               # tap to click
  };
  nix-homebrew = {
    enable = true;
    user = "josephtong";
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];

    taps = [
      { name = "mongodb/brew"; trusted = true; }
      { name = "facebook/fb"; trusted = true; }
    ];

    brews = [
      "herdr"
      "mongodb-community"
      "nvm"
      "redis"
      "cliclick"       # macOS mouse/keyboard automation - simulator UI testing
      "idb-companion"  # iOS Simulator control (tap/swipe) - facebook/fb tap
    ];

    casks = [
      "wezterm"
      "android-studio"
      "another-redis-desktop-manager"
      "temurin@17"
      "claude-code"
      "opensuperwhisper"
    ];
  };
}
