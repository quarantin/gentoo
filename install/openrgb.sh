#!/bin/bash

cd $(dirname "$(dirname "${0}")")

OPENRGB_HOME="/var/lib/openrgb"
mkdir -p "${OPENRGB_HOME}"
chown openrgb:openrgb "${OPENRGB_HOME}"
chmod 700 "${OPENRGB_HOME}"
useradd -M -d "${OPENRGB_HOME}" -s /bin/nologin openrgb

LINKPATH="/etc/udev/rules.d/60-openrgb.rules"
LINKTARGET="../../..$(pwd)/root${LINKPATH}"
rm -f "${LINKPATH}"
ln -s "${LINKTARGET}" "${LINKPATH}"
