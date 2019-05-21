#!/bin/bash

set -ev

rm -rf ./arm_root_fs
tar -zxf ./arm_root_fs.tar.gz

rm -rf ./arm64_root_fs
tar -zxf ./arm64_root_fs.tar.gz

docker build -t fibjs/build-env:${TRAVIS_TAG} -f Dockerfile .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push fibjs/build-env:${TRAVIS_TAG}

exit 0;
