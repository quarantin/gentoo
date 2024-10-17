#!/bin/bash

cd $(dirname "${0}")

./install/gentoo.sh
./install/localbin.sh
./install/openrgb.sh
