{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = "josephtong";
  home.homeDirectory = "/Users/josephtong";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep        # fast search
    fd             # fast find
    fzf            # fuzzy finder
    jq             # json on the command line
    lazygit
    neovim
    tree-sitter    # builds parsers for nvim-treesitter
    gh             # GitHub CLI - PRs, issues, CI from the terminal
    heroku         # Heroku CLI - deploys, stack management, logs
    # the fond everything renders in
    nerd-fonts.hack
  ];
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home";
    ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
  };
  home.sessionPath = [
    "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin"
    "${config.home.homeDirectory}/Library/Android/sdk/emulator"
    "${config.home.homeDirectory}/Library/Android/sdk/platform-tools"
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;             # ghost text from history
    syntaxHighlighting.enable = true;         # commands turn green when valid
    initContent = ''
      bindkey '^f' autosuggest-accept

      # nvm's node keeps losing to Homebrew's in PATH: nix-darwin's system
      # /etc/zshrc re-runs `brew shellenv` after ~/.zprofile already put nvm
      # first, and the `typeset -U path` above locks that order in place for
      # the rest of the session (so even `nvm use` can't fix it afterward).
      # Re-assert nvm's bin at the front here: filter it out of the unique
      # array and re-add it, since a plain re-prepend of an already-present
      # entry is silently dropped.
      if [[ -n "''${NVM_BIN:-}" ]]; then
        path=("$NVM_BIN" ''${path:#$NVM_BIN})
      fi
    '';
    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      status = "git status";
      cc = "claude"; 
      co = "codex";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
	      success_symbol = "[>](purple)";
        error_symbol = "[>](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file.".claude/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.claude/settings.json";

  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".codex/AGENTS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
  home.file.".config/opencode/AGNETS.md".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/AGENTS.md";
}
