## Install Instructions
```
  nix-shell -p git
```
```
  git clone --depth=1 https://github.com/sumit-ftr/nixos-config.git
```
```
  cd nixos-config
```
```
  sudo nixos-generate-config --show-hardware-config > ./nixos/hardware-configuration.nix
```
```
  sudo nano /nixos/configuration.nix
```
```
  git add .
```
```
  sudo ./init.sh
```
```
  sudo nixos-rebuild switch --flake .
```
```
  sudo ./post-update.sh
```
