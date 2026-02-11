## Install Instructions

### NixOS

```sh
nix-shell -p git nushell
```

```sh
git clone https://github.com/sumitftr/nixos-config.git <YOUR_CONFIG_DIRECTORY>/nixos-config
```

```sh
cd <YOUR_CONFIG_DIRECTORY>/nixos-config
```

> Add host by doing:

```sh
./host-add <HOSTNAME>
```

```sh
git add .
```

```sh
sudo nixos-rebuild switch --flake .#<HOSTNAME>
```

> Link your configs by doing:

```sh
./init.nu
```

### Other Linux Distributions

Supported: Arch, openSUSE, Fedora, Debian, Gentoo, FreeBSD, Ubuntu, Void, Slackware, Alpine, Ximper, Solus

```sh
git clone https://github.com/sumitftr/nixos-config.git <YOUR_CONFIG_DIRECTORY>/nixos-config
cd <YOUR_CONFIG_DIRECTORY>/nixos-config
./distro.sh
```

This will:

1. Install the Nix package manager (if not already installed)
2. Configure Nix with flakes support
3. Install all development tools (helix, yazi, git, rust toolchain, etc.)
4. Link your configuration files

After installation, restart your terminal or run:

```sh
source ~/.nix-profile/etc/profile.d/nix.sh
```

Then use nushell:

```sh
nu
```

## Note:

> For updating package versions you have to update `flake.lock` file. To do that, run: `nix flake update`. Then stage the `flake.lock` file, using `git add -u`.

> **Moving Configuration**: Copy this flake to your preferred path. Run `./init.nu` to recreate symlinks to your present configuration path. You can then delete the original flake.

> Sometimes nixos doesn't allows user to rebuild your configuration due to ownership issues. To get around this problem, run: `sudo chown -R <USERNAME>:users .`
