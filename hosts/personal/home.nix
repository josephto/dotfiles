{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    heroku         # Heroku CLI - deploys, stack management, logs
  ];
  home.sessionVariables = {
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home";
    ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
  };
  home.sessionPath = [
    "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin"
    "${config.home.homeDirectory}/Library/Android/sdk/emulator"
    "${config.home.homeDirectory}/Library/Android/sdk/platform-tools"
  ];
}
