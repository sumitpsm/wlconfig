# re-renders all environment variables set by nixos-configuration (disabled by default)

# let $env_vars = [
#   EDITOR
#   VISUAL
#   SUDO_EDITOR
#   PKG_CONFIG_PATH
#   CARGO_HOME
#   RUST_SRC_PATH
#   RUST_BACKTRACE
# ];

# env | parse '{key}={value}' | where key in $env_vars | each { |row| $env.$row.key = $row.value } | ignore
