# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.

$env.config.show_banner = false
$env.config.table.mode = "rounded"
$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"

$env.PATH = $env.PATH | append $"($env.HOME)/.local/scripts"
$env.EDITOR = "hx"
$env.VISUAL = "hx"
$env.SUDO_EDITOR = "hx"
$env._ZO_DOCTOR = 0
