#!/bin/bash

rm -f ./arm_root_fs/etc/hosts
rm -f ./arm_root_fs/etc/resolv.conf
rm -f ./arm_root_fs/etc/nsswitch.conf

cp -f /etc/resolv.conf ./arm_root_fs/etc/resolv.conf
cp -f /etc/hosts ./arm_root_fs/etc/hosts
cp -f /etc/nsswitch.conf ./arm_root_fs/etc/nsswitch.conf

mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc

# https://wiki.gentoo.org/wiki/Embedded_Handbook/General/Compiling_with_qemu_user_chroot
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register

mount -t proc proc     ./arm_root_fs/proc/
mount -t sysfs sys     ./arm_root_fs/sys/
mount -o bind /dev     ./arm_root_fs/dev/
mount -o bind /dev/pts ./arm_root_fs/dev/pts
