## Install instructions
#### Step 1
```
  git clone https://github.com/sumit-ftr/sysconf.git
```

#### Step 2
```
  cd sysconf
  sudo ./init.sh
  sudo nixos-rebuild switch --flake .
```
or
```
  sudo ./init.sh <path/to/dir>
  sudo nixos-rebuild switch --flake <path/to/dir>
```
