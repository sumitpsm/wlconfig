## Install Instructions
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

## Note:
> For updating package versions you have to update `flake.lock` file. To do that, run: `nix flake update`. Then stage the `flake.lock` file, using `git add -u`.

> **Moving Configuration**: Copy this flake to your preferred path. Run `./init.nu` to recreate symlinks to your present configuration path. You can then delete the original flake.

> Sometimes nixos doesn't allows user to rebuild your configuration due to ownership issues. To get around this problem, run: `sudo chown -R <USERNAME>:users .`
