#!/bin/bash

rm -f ./arm_rootfs.tar.gz/arm_root_fs/etc/hosts
rm -f ./arm_rootfs.tar.gz/arm_root_fs/etc/resolv.conf
rm -f ./arm_rootfs.tar.gz/arm_root_fs/etc/nsswitch.conf

cp -f /etc/resolv.conf ./arm_rootfs.tar.gz/arm_root_fs/etc/resolv.conf
cp -f /etc/hosts ./arm_rootfs.tar.gz/arm_root_fs/etc/hosts
cp -f /etc/nsswitch.conf ./arm_rootfs.tar.gz/arm_root_fs/etc/nsswitch.conf

mount -t proc proc     ./arm_rootfs.tar.gz/arm_root_fs/proc/
mount -t sysfs sys     ./arm_rootfs.tar.gz/arm_root_fs/sys/
mount -o bind /dev     ./arm_rootfs.tar.gz/arm_root_fs/dev/
mount -o bind /dev/pts ./arm_rootfs.tar.gz/arm_root_fs/dev/pts

./arm_rootfs.tar.gz/arm_root_fs/bin/fibjs -v

chroot ./arm_rootfs.tar.gz/arm_root_fs fibjs /home/test/main.js
