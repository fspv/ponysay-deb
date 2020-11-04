#!/bin/bash

set -uex

# Copy gnupg data into the right place
# NOTE: your local GPG keyring should be GPG2
cp -R /tmp/host_gnupg /root/.gnupg
chown -R root:root /root/.gnupg

# FIXME: use absolute paths
cd /build/ponysay-deb/

# Instal dependencies
/usr/lib/pbuilder/pbuilder-satisfydepends

# Create changelog
export CHANGELOG=/build/ponysay-deb/debian/changelog
export EDITOR=/bin/true

debchange --create \
          -v ${VER}-${DIST}${BUILD} \
          --package ponysay \
          -D ${DIST} \
          "Version ${VER} from upstream"

# Get source
debian/rules get-orig-source

# Build
debuild -S

# Upload to ppa
dput ${PPA} /build/ponysay_$(dpkg-parsechangelog -S Version)_source.changes
