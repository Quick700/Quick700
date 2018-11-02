#!/bin/sh
cd apache
../compile_and_install.asan.sh
cd -
./make-configs.sh
