{ config
, pkgs
, ...
}:


# XXX: Make sure to enable toolkit.legacyUserProfileCustomizations.stylesheets in about:config.
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
    profiles = {
      icy = {
        isDefault = true;
        path = "34x366wc.default";
        userChrome = ''
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
            display: none;
          }

          #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
            opacity: 0;
            pointer-events: none;
          }
          #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
              visibility: collapse !important;
          }
        '';
      };
    };
  };
}
