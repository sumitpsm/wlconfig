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
> Below instructions are used to install and rebuild nixos system
```
  git add .
```
```
  sudo nixos-rebuild switch --flake .#<HOSTNAME>
```
> Optional: You can commit the changes by `git commit -m "message"`

## Note:
> For updating package versions you have to update `flake.lock` file. To do that run: `nix flake update`.

> Moving Configuration: Copy the directory to your preferred path. Run `./init.sh` to recreate symlinks to your config. Then you can delete the original directory.

> Sometimes nixos doesn't allow to rebuild from configuration flake due to ownership problems. To get around this use: `sudo chown -R <USERNAME>:users .`
