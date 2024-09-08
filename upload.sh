#!/bin/bash

set -uex

VER=$1
BUILD=$2
EXTRA_RUN_OPTS=$3

for DIST in bionic focal impish jammy noble
do
    sudo docker build \
        -t ponysay-deb:${DIST} \
        --build-arg DIST=${DIST} \
        --progress=plain \
        .

    # NOTE: your local GPG keyring should be GPG2
    sudo docker run \
        --network=host \
        -e DEBEMAIL="Pavel Safronov <pv.safronov@gmail.com>" \
        -e PPA=ppa:pv-safronov/ponysay \
        -e DIST=${DIST} \
        -e VER=${VER} \
        -e BUILD=${BUILD} \
        -v ${HOME}/.gnupg:/tmp/host_gnupg \
        -it ponysay-deb:${DIST} ${EXTRA_RUN_OPTS}
done
