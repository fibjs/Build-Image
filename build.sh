#!/bin/bash

set -ev

sudo docker run --rm --privileged multiarch/qemu-user-static:register

DIR=`pwd`;sudo docker run --privileged=true -it -v ${DIR}:/home/ci fibjs/build-env:clang /bin/sh -c "
        cd /home;
        sh init_armhf.sh;
        cat /proc/sys/fs/binfmt_misc/arm;
        cp -f ./ci/fibjs ./arm_root_fs/bin/fibjs;
        ls -la ./arm_root_fs/bin/fibjs;
        chroot ./arm_root_fs fibjs -v;"

DIR=`pwd`;sudo docker run --privileged=true -it -v ${DIR}:/home/ci fibjs/build-env:clang /bin/sh -c "
        cd /home;
        sh init_arm64.sh;
        cat /proc/sys/fs/binfmt_misc/aarch64;
        cp -f ./ci/fibjs64 ./arm64_root_fs/bin/fibjs;
        cp -rf ./ci/test ./arm64_root_fs/home/test;
        ls -la ./arm64_root_fs/bin/fibjs;
        ls -la ./arm64_root_fs;
        chroot ./arm64_root_fs /bin/fibjs -v"

exit 0;
