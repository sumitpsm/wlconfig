{ inputs, system, ... }:

# https://mozilla.github.io/policy-templates/
{
  environment.systemPackages = [
    (inputs.zen-browser.packages.${system}.beta.override {
      # preferences = {
      #   # "zen.urlbar.replace-newtab" = false;
      #   "browser.tabs.warnOnClose" = {
      #     "Value" = false;
      #     "Status" = "locked";
      #   };
      # };
      # zen-browser.policies = {
      #   AutofillAddressEnabled = false;
      #   AutofillCreditCardEnabled = false;
      #   DisableAppUpdate = true;
      #   DisableFeedbackCommands = true;
      #   DisableFirefoxStudies = true;
      #   DisablePocket = true;
      #   DisableTelemetry = true;
      #   DontCheckDefaultBrowser = true;
      #   EnableTrackingProtection = {
      #     Value = true;
      #     Locked = true;
      #     Cryptomining = true;
      #     Fingerprinting = true;
      #   };
      #   NoDefaultBookmarks = true;
      #   OfferToSaveLogins = false;
        # DNSOverHTTPS = {
        #   Enabled = false;
        #   Locked = true;
        # };
        # ExtensionSettings = {
        #   "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
        #     install_url = "https://addons.mozilla.org/firefox/downloads/file/4307738/bitwarden_password_manager-2024.6.3.xpi";
        #     installation_mode = "force_installed";
        #   };
        #   "extension@tabliss.io" = {
        #     install_url = "https://addons.mozilla.org/firefox/downloads/file/3940751/tabliss-2.6.0.xpi";
        #     installation_mode = "force_installed";
        #   };
        # };
      # };
    })
  ];
}
