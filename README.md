## Install Instructions
```
  nix-shell -p git
```
```
  git clone https://github.com/sumit-ftr/nixos-config.git
```
```
  cd nixos-config
```
```
  nixos-generate-config --show-hardware-config > ./nixos/hardware/<HOSTNAME>.nix
```
> Add the hostname to `flake.nix` by doing
```
  nano flake.nix
```
```
  ./init.sh
```
> This command is also used to rebuild your nixos system
```
  sudo nixos-rebuild switch --flake .#<HOSTNAME>
```

## Note:
> For updating package versions you have to update `flake.lock` file. To do that, run: `nix flake update`. Then stage the `flake.lock` file using `git add -u`.

> **Moving Configuration**: Copy this flake to your preferred path. Run `./init.sh` to recreate symlinks to your config. Then you can delete the original flake.

> Sometimes nixos doesn't allows user to rebuild from your configuration flake due to ownership problems. To get around this, run: `sudo chown -R <USERNAME>:users .`
