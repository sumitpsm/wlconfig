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
> Add the hostname to `flake.nix` by:
```
  nano flake.nix
```
> Below instructions are also used to rebuild nixos system eachtime
```
  git add .
```
```
  sudo nixos-rebuild-switch --flake .#<HOSTNAME>
```
> Optional: You can commit the changes by `git commit -m "message"`

## Note:
> If you move the repository to some other path run `sudo ./init.sh` to recreate symlinks to your config

> Sometimes nixos doesn't allow to rebuild from configuration flake due to ownership problems. To get around this use: `sudo chown -r <USERNAME>:users .`
