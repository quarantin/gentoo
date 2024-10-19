#!/bin/bash

cd $(dirname "$(dirname "${0}")")

GENTOO="/gentoo"
mkdir -p "${GENTOO}"

DISTFILES="${GENTOO}/distfiles"
rm -f "${DISTFILES}"
ln -s "/var/cache/distfiles" "${DISTFILES}"

PORTAGE="${GENTOO}/portage"
rm -f "${PORTAGE}"
ln -s "/etc/portage" "${PORTAGE}"

OVERLAYS="${GENTOO}/overlays"
rm -f "${OVERLAYS}"
ln -s "/var/db/repos" "${OVERLAYS}"

WORLD="${GENTOO}/world"
rm -f "${WORLD}"
ln -s "/var/lib/portage/world" "${WORLD}"
