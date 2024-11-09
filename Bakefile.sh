task.checkout() {
  local name
  name="$(sed 's| |-|g' /sys/devices/virtual/dmi/id/product_name)" || \
    name="$(adb shell getprop ro.product.vendor.model)" || \
    bake.die "unknown machine, you're probably running the rich's os (macosx)"
  git checkout "${name}" || bake.die "couldn't find the config for your machine's model"
}
