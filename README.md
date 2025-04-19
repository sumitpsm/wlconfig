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
  sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
```
  sudo nano /nixos/configuration.nix
```
```
  git add .
```
```
  sudo nixos-rebuild switch --flake .
```
```
  sudo ./init.sh
```

<!---
```
  sudo ./nixos-config/init.sh <path/to/dir>
  sudo nixos-rebuild switch --flake <path/to/dir>
```
-->
