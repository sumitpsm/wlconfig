## Install Instructions
```sh
  nix-shell -p git
```
```sh
  git clone https://github.com/sumit-ftr/nixos-config.git
```
```sh
  cd nixos-config
```
> Add host by doing:
```sh
  ./host add <HOSTNAME>
```
```sh
  git add .
```
```sh
  sudo nixos-rebuild switch --flake .#<HOSTNAME>
```
> Link your configs by doing:
```sh
  ./init.sh
```

## Note:
> For updating package versions you have to update `flake.lock` file. To do that, run: `nix flake update`. Then stage the `flake.lock` file using `git add -u`.

> **Moving Configuration**: Copy this flake to your preferred path. Run `./init.sh` to recreate symlinks to your present configuration path. Then you can delete the original flake.

> Sometimes nixos doesn't allows user to rebuild from configuration flake due to ownership problems. To get around this, run: `sudo chown -R <USERNAME>:users .`
