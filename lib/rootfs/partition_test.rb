# frozen_string_literal: true

require_relative "partition"

class MyClass
  extend RootFS::Partition
  include RootFS::Partition
end

m = MyClass.new

RASPI = "/home/ubuntu/vscode/ubuntu-24.04-preinstalled-desktop-arm64+raspi.img"
RK3588 = "/home/ubuntu/vscode/rk3588-sd-ubuntu-jammy-minimal-6.1-arm64-20240522.img"
LONG = "/home/ubuntu/vscode/abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz.img"
WHITE = "'/home/ubuntu/vscode/white space.img'"
SINGLE = "'/home/ubuntu/vscode/single par.img'"

ROOTFS = "/home/ubuntu/vscode/rootfs-tools/rootfs"
TEST = "/home/ubuntu/vscode/test"
SPACE = "'/home/ubuntu/vscode/white space'"

# m.ask_mount(LONG, ROOTFS)
# m.mount_dev(ROOTFS)
# m.unmount(ROOTFS)
# m.auto_unmount(RASPI)

# m.mount_combined(RASPI, 1, ROOTFS)
# m.mount_combined(RASPI, 2, ROOTFS)
# m.mount_combined(RK3588, 8, ROOTFS)
# m.mount_combined(RASPI, 2, TEST)
# m.auto_unmount(RASPI)
# m.auto_unmount(RK3588)
# m.unmount_dev(ROOTFS)
# m.unmount_dev(TEST)
# m.auto_unmount(ROOTFS)
# m.auto_unmount(TEST)

# m.mount_combined(RASPI, 2, ROOTFS)
# m.mount_dev(ROOTFS)
# m.mount_combined(WHITE, 2, SPACE)
# m.unmount_dev(TEST)
# m.mount_bind(TEST)
# m.auto_unmount(WHITE)
# m.auto_unmount(SPACE)

# m.auto_unmount(WHITE)

m.mount_single(SINGLE, SPACE)
