#!/bin/bash

set -ev

DIR=`pwd`;sudo docker run --privileged=true -it -v ${DIR}:/home/ci fibjs/build-env:clang /bin/sh -c "
        cd /home;
        sh init_arm64.sh;
        cp -f ./ci/fibjs ./arm64_root_fs/bin/fibjs;
        chroot ./arm64_root_fs fibjs -v"

exit 0;
