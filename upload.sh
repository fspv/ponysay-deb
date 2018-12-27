#!/bin/bash

set -uex

VER=$1
BUILD=$2
EXTRA_RUN_OPTS=$3

for DIST in xenial bionic cosmic
do
    docker build \
        -t ponysay-deb:${DIST} \
        --build-arg DIST=${DIST} \
        .
    docker run \
        -e DEBEMAIL="Pavel Safronov <pv.safronov@gmail.com>" \
        -e PPA=ppa:pv-safronov/ponysay \
        -e DIST=${DIST} \
        -e VER=${VER} \
        -e BUILD=${BUILD} \
        -v ${HOME}/.gnupg:/root/.gnupg \
        -it ponysay-deb:${DIST} ${EXTRA_RUN_OPTS}
done
