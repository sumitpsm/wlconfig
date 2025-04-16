## Install instructions
```
  git clone https://github.com/sumit-ftr/sysconf.git
```

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
