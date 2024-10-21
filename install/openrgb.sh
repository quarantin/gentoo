#!/bin/bash

cd $(dirname "$(dirname "${0}")")

# openrgb user
OPENRGB_HOME="/var/lib/openrgb"
mkdir -p "${OPENRGB_HOME}"
chown openrgb:openrgb "${OPENRGB_HOME}"
chmod 700 "${OPENRGB_HOME}"
useradd -M -d "${OPENRGB_HOME}" -s /bin/nologin openrgb

# /etc/udev
LINKPATH="/etc/udev/rules.d/99-openrgb-override.rules"
LINKTARGET="../../..$(pwd)/root${LINKPATH}"
rm -f "${LINKPATH}"
ln -s "${LINKTARGET}" "${LINKPATH}"

# /etc/init.d/generic-daemon
LINKPATH="/etc/init.d/generic-daemon"
LINKTARGET="../..$(pwd)/root${LINKPATH}"
rm -f "${LINKPATH}"
ln -s "${LINKTARGET}" "${LINKPATH}"

# /etc/init.d/openrgb-server
rm -f /etc/init.d/openrgb-server
ln -s ./generic-daemon /etc/init.d/openrgb-server

# /etc/init.d/openrgb-client
rm -f /etc/init.d/openrgb-client
ln -s ./generic-daemon /etc/init.d/openrgb-client

# /etc/conf.d/{openrgb-common,openrgb-server,openrgb-client}
for FILE in openrgb-common openrgb-server openrgb-client; do
	LINKPATH="/etc/conf.d/${FILE}"
	LINKTARGET="../..$(pwd)/root${LINKPATH}"
	rm -f "${LINKPATH}"
	ln -s "${LINKTARGET}" "${LINKPATH}"
done
