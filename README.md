## NixOS Install Instructions

```sh
nix-shell -p git nushell
```

```sh
git clone https://github.com/sumitftr/wlconfig.git <YOUR_CONFIG_DIRECTORY>/wlconfig
```

```sh
cd <YOUR_CONFIG_DIRECTORY>/wlconfig
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

## Install Instructions for other distributions

Supported: Ubuntu, Debian, Fedora, Arch, Alpine, openSUSE, FreeBSD, Gentoo, Void, Slackware, Solus, Ximper

> First Step: Install git (depends on distribution's package manager)

```sh
git clone https://github.com/sumitftr/wlconfig.git <YOUR_CONFIG_DIRECTORY>/wlconfig
```

```sh
cd <YOUR_CONFIG_DIRECTORY>/wlconfig
```

> Detects OS and installs the Nix package manager (if not installed)

```sh
./nix.sh
```

```sh
exit
```

> Configures Nix with flakes support;
> Installs all development tools from ./modules/development/terminal.nix;
> Installs and sets up kmonad for keyboard mapping (optional);
> Links your configuration files;
> Changes your default shell to nushell;

```sh
./setup.sh
```

```sh
exit
```

## Note:

> For updating package versions you have to update `flake.lock` file. To do that, run: `nix flake update`. Then stage the `flake.lock` file, using `git add -u`.

> **Moving Configuration**: Copy this flake to your preferred path. Run `./init.nu` to recreate symlinks to your present configuration path. You can then delete the original flake.

> Sometimes nixos doesn't allows user to rebuild your configuration due to ownership issues. To get around this problem, run: `sudo chown -R <USERNAME>:users .`
