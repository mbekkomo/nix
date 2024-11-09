### Nix config and dotfiles for my machines >:3

To use the config, run `git checkout <branch>` where `branch` is a branch that is listed below:
 - HP 240 G5 Notebook: `HP-240-G5-Notebook-PC`

The branch name is based on output of `sed 's| |-|g' /sys/devices/virtual/dmi/id/product_name` or if Android (nix-on-droid), `adb shell getprop ro.product.vendor.model`.
