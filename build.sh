#!/bin/bash

set -ev

DIR=`pwd`;sudo docker run --privileged=true -it -v ${DIR}:/home/ci fibjs/build-env:clang /bin/sh -c "
        cd /home;
        sh init_arm64.sh;
        sh init_armhf.sh;
        cp -f ./ci/fibjs64 ./arm64_root_fs/bin/fibjs;
        cp -f ./ci/fibjs ./arm_root_fs/bin/fibjs;
        ls -la ./arm_root_fs/bin/fibjs;
        chroot ./arm_root_fs fibjs -v;
        ls -la ./arm64_root_fs/bin/fibjs;
        chroot ./arm64_root_fs fibjs -v;"

exit 0;
