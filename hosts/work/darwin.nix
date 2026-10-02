{ ... }:

{
  homebrew = {
    # IT installs things outside this config, so don't zap unlisted apps.
    onActivation.cleanup = "none";

    brews = [
    ];

    casks = [
    ];
  };
}
