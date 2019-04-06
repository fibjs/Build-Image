#!/bin/bash

set -ev

docker build -t fibjs/build-env:${TRAVIS_TAG} -f Dockerfile .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push fibjs/build-env:${TRAVIS_TAG}

exit 0;
