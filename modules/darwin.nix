{ username, ... }:

# System config shared by every machine. Host-specific bits live in hosts/<name>/darwin.nix.
{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = username;
  users.users.${username} = {
    home = "/Users/${username}";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;            # fast key repeat
      InitialKeyRepeat = 15;    # short delay before repeat
      _HIHideMenuBar = false;   # always show the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";   # list view by default
    finder.CreateDesktop = false;           # clean desktop
    trackpad.Clicking = true;               # tap to click
  };
  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };
  # Lists here merge with each host's; onActivation.cleanup is set per host.
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];

    brews = [
      "herdr"
      "nvm"
    ];

    casks = [
      "wezterm"
      "claude-code"
      "opensuperwhisper"
    ];
  };
}
