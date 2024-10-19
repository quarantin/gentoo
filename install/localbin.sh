#!/bin/bash

cd $(dirname "$(dirname "${0}")")

BINDIR="/usr/local/bin"
SCRIPTPATH="root${BINDIR}"

for SCRIPT in $(ls "${SCRIPTPATH}"); do
	LINKPATH="${BINDIR}/${SCRIPT}"
	LINKTARGET="../../..$(pwd)/${SCRIPTPATH}/${SCRIPT}"
	rm -f "${LINKPATH}"
	ln -s "${LINKTARGET}" "${LINKPATH}"
done
