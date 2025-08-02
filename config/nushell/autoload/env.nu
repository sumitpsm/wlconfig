# re-renders all environment variables set by nixos-configuration

# let $vars = [
#   EDITOR
#   VISUAL
#   SUDO_EDITOR
#   PKG_CONFIG_PATH
#   RUST_SRC_PATH
#   RUST_BACKTRACE
# ];

# env | parse '{key}={value}' | where key in $vars | each { |row| $env.$row.key = $row.value } | ignore
