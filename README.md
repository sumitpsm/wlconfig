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
  nano /nixos/configuration.nix
```
```
  sudo ./run.sh -i
```

## Update Instructions
> If you move the repository to some other path run `sudo ./init.sh` to recreate symlinks to your config

> Note: No need to run `sudo nixos-rebuild switch --flake .` everytime. Instead use `sudo ./run.sh`, it will do all the necessary things for you
