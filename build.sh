#!/bin/bash

set -ev

sudo apt-get update
sudo apt-get install qemu qemu-user-static -y

sudo tar -zxf ./arm_rootfs.tar.gz

ls -la

ls -la ./arm_root_fs

DIR=`(pwd)`

echo $DIR

sudo mount -t proc proc     $DIR/arm_root_fs/proc/
sudo mount -t sysfs sys     $DIR/arm_root_fs/sys/
sudo mount -o bind /dev     $DIR/arm_root_fs/dev/
sudo mount -o bind /dev/pts $DIR/arm_root_fs/dev/pts

sudo chroot ./arm_root_fs fibjs /home/test/main.js

exit 0;
