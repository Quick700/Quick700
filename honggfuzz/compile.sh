#!/bin/sh
cd apache
patch -p1 < ../hong-apache/httpd-master.honggfuzz.patch
../compile_and_install.asan.sh
cd -
./make-configs.sh
