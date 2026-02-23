def l [] {
  # Equivalent to: eza -a --group-directories-first --icons
  ls -a | sort-by type name
}
