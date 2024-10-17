#!/bin/bash

cd $(dirname "${0}")

PWD="$(pwd)"
SCRIPTPATH="root/usr/local/bin"

for SCRIPT in $(ls "${SCRIPTPATH}"); do
	LINKPATH="/usr/local/bin/${SCRIPT}"
	LINKTARGET="../../..${PWD}/${SCRIPTPATH}/${SCRIPT}"
	rm -f "${LINKPATH}"
	ln -s "${LINKTARGET}" "${LINKPATH}"
done
