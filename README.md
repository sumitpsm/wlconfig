## Install instructions
#### Step 1
```
  git clone https://github.com/sumit-ftr/nixos-config.git
```

#### Step 2
```
  cd nixos-config
  sudo ./init.sh
  sudo nixos-rebuild switch --flake .
```
or
```
  sudo ./nixos-config/init.sh <path/to/dir>
  sudo nixos-rebuild switch --flake <path/to/dir>
```
