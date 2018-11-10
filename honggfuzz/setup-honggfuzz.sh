#!/bin/sh
cd honggfuzz
make
cd ..

# Go into the apache directory
cd apache

# Apply the honggfuzz patch
patch -p1 < ../hong-apache/httpd-master.honggfuzz.patch

# Generate the configure script
./buildconf

# Install using the modified honggfuzz configure script...
# Make sure /usr/bin/env python launches python 2, otherwise this will fail.
./../compile_and_install.asan.sh

# go back to Quick700/honggfuzz
cd .. 
./make-configs.sh
