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

qemu-arm ./arm_rootfs.tar.gz/arm_root_fs/bin/fibjs -v

mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc  
cat /proc/sys/fs/binfmt_misc/status
# echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register  

chroot ./arm_rootfs.tar.gz/arm_root_fs /bin/fibjs /home/test/main.js
